from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from sentence_transformers import SentenceTransformer, util
import oracledb

app = FastAPI()

MODEL_PATH = "./sbert_specup_model"
model = SentenceTransformer(MODEL_PATH)

# Oracle DB 설정 (환경에 맞게 수정)
DB_USER = "ADMIN"
DB_PASSWORD = "1234"
DB_DSN = "192.168.0.20:1521/XE"

# 서버 시작 시 로드될 직업 리스트
jobs = []

class UserSkill(BaseModel):
  name: str
  level: int

class RecommendRequest(BaseModel):
  user_skills: List[UserSkill]


# DB 연결
def get_connection():
  return oracledb.connect(
    user=DB_USER,
    password=DB_PASSWORD,
    dsn=DB_DSN
  )


# JOB_ROLE 테이블 로드
def load_jobs_from_db():
  conn = get_connection()
  cursor = conn.cursor()

  sql = """
    SELECT JOB_ID, JOB_NAME, JOB_DESC
    FROM JOB_ROLE
    ORDER BY JOB_ID
  """

  cursor.execute(sql)

  job_list = []
  for job_id, job_name, job_desc in cursor.fetchall():
    job_list.append({
      "jobId": job_id,
      "jobName": job_name,
      "requiredSpec": job_desc if job_desc else ""
    })

  cursor.close()
  conn.close()

  return job_list


# 서버 시작 시 JOB_ROLE 로딩
@app.on_event("startup")
def startup():
  global jobs
  jobs = load_jobs_from_db()
  print(f"JOB_ROLE에서 {len(jobs)}개 직업 로드 완료")


# 유저 스킬 텍스트 생성
def build_user_text(user_skills: List[UserSkill]) -> str:
  tokens = []
  for skill in user_skills:
    level = max(0, skill.level)
    tokens.extend([skill.name] * level)
  return " ".join(tokens)


# 부족 스킬 찾기
def find_lack_skills(user_skills: List[UserSkill], required_spec: str) -> List[str]:
  user_set = {skill.name.strip().lower() for skill in user_skills}
  required_tokens = required_spec.split()

  lack_list = []
  for token in required_tokens:
    if token.strip().lower() not in user_set:
      lack_list.append(token)

  unique_lack = []
  seen = set()

  for skill in lack_list:
    key = skill.lower()
    if key not in seen:
      seen.add(key)
      unique_lack.append(skill)

  return unique_lack[:5]


@app.get("/")
def root():
  return {"message": "AI recommend server is running"}


@app.post("/recommend")
def recommend_jobs(req: RecommendRequest):

  global jobs

  if not req.user_skills:
    return []

  if not jobs:
    return []

  user_text = build_user_text(req.user_skills)
  job_texts = [job["requiredSpec"] for job in jobs]

  user_embedding = model.encode(user_text, convert_to_tensor=True)
  job_embeddings = model.encode(job_texts, convert_to_tensor=True)

  scores = util.cos_sim(user_embedding, job_embeddings)[0]

  results = []

  for i, score in enumerate(scores):

    lack_skills = find_lack_skills(
      req.user_skills,
      jobs[i]["requiredSpec"]
    )

    results.append({
      "jobId": jobs[i]["jobId"],
      "jobName": jobs[i]["jobName"],
      "requiredSpec": jobs[i]["requiredSpec"],
      "lackSpec": ", ".join(lack_skills),
      "score": float(score)
    })

  results.sort(key=lambda x: x["score"], reverse=True)

  return results[:5]