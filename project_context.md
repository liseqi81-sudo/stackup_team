# 프로젝트 컨텍스트

## 프로젝트 이름
StackUp

## 프로젝트 목표
사용자의 보유 스킬을 기반으로 취업 공고를 추천하는 시스템을 개발한다.

## 기술 스택
Backend: Spring Boot  
Database: Oracle  
AI Model: SBERT (Sentence-BERT)  
Language: Java, Python  

---

# 데이터베이스 구조

## USER_ACCOUNT
사용자 계정 정보

| 컬럼 | 설명 |
|---|---|
| USER_ID | 사용자 아이디 |
| USER_PW | 비밀번호 |
| USER_NAME | 사용자 이름 |

---

## JOB_POSTING
취업 공고 정보

| 컬럼 | 설명 |
|---|---|
| POSTING_ID | 공고 ID |
| JOB_CATEGORY | 직무 |
| COMPANY_NAME | 회사명 |
| TITLE | 공고 제목 |
| DEADLINE | 마감일 |
| SKILLS | 필요한 기술 (콤마로 구분) |

---

## SKILL
기술 목록

| 컬럼 | 설명 |
|---|---|
| SKILL_ID | 스킬 ID |
| SKILL_NAME | 스킬 이름 |
| SKILL_CATEGORY | 스킬 카테고리 |

---

# 현재 진행 상황

1️⃣ JOB_POSTING 테이블에 취업 공고 데이터 저장 완료  
2️⃣ 공고의 SKILLS 컬럼을 파싱하여 SKILL 테이블에 저장 중  
3️⃣ USER_ACCOUNT test10 ~ test210 사용자 생성  
4️⃣ USER_SKILL 테이블 생성 예정  

---

# 추천 시스템 구조

추천 방식

SBERT 기반 추천

추천 과정

1. 사용자의 스킬 입력
2. SBERT로 스킬 임베딩 생성
3. JOB_POSTING의 스킬 임베딩과 cosine similarity 계산
4. 가장 유사한 공고 TOP N 추천

---

# API 구조

추천 요청

POST /recommend

입력

```json
{
  "skills": ["Python", "SQL", "Machine Learning"]
}

출력

{
  "recommendations": [
    {
      "job_id": "12345",
      "score": 0.92
    }
  ]
}

---

# 3️⃣ GPT 사용할 때 활용 방법

새 GPT에게 이렇게 보내면 된다.


이 프로젝트 컨텍스트를 기반으로 질문할게

[project_context.md 내용 붙여넣기]


그러면 GPT가 **프로젝트 전체 상황을 이해하고 답변**해준다.

---

# 4️⃣ 왜 이 문서가 중요하냐

이게 있으면

✔ 다른 GPT에서도 바로 대화 가능  
✔ 팀원들도 프로젝트 이해 가능  
✔ 발표 자료 만들 때도 편함  
✔ 개발 방향 정리됨

실무에서도 이런 걸 **Project README / Architecture Doc**로 만든다.

---

# ⭐ 내가 추천하는 추가 문서

프로젝트가 커지면 보통 이것도 만든다.


README.md
architecture.md
database_schema.md
api_spec.md


하지만 **팀 프로젝트라면**


project_context.md


하나만 있어도 충분하다.

---

원하면 내가 **너희 프로젝트 기준으로 완벽한 project_context 문서**를 만들어 줄게.

지금까지 대화 기반으로


DB 구조
추천 시스템
Spring + Python 연결
데이터 흐름


까지 포함해서 **GPT들이 바로 이해하는 문서**로 만들어줄게.