import oracledb
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# 1. DB 연결 설정
conn_config = {
    "user": "admin",
    "password": "1234",
    "dsn": "192.168.0.20:1521/xe"
}

def get_next_id(cursor):
    """VARCHAR2 ID를 숫자로 계산해서 다음 번호 반환"""
    try:
        cursor.execute("SELECT MAX(TO_NUMBER(CONT_ID)) FROM CONTEST")
        max_id = cursor.fetchone()[0]
        return str(int(max_id) + 1) if max_id is not None else "1"
    except:
        return "1"

def start_scraper():
    conn = oracledb.connect(**conn_config)
    cursor = conn.cursor()
    driver = webdriver.Chrome()

    try:
        # 위비티 접속
        driver.get("https://www.wevity.com/?c=find&s=1&gub=1&cidx=21")
        print("\n🚀 [마감일 전용 모드] 상세페이지 이동 후 Enter를 누르세요.")

        while True:
            user_input = input("\n[대기] Enter:수집 / q:종료 > ")
            if user_input.lower() == 'q': break

            try:
                # 데이터 추출
                name = driver.find_element(By.CSS_SELECTOR, "h6.tit").text.strip()
                org = driver.find_element(By.XPATH, "//li[span[text()='주최/주관']]").text.replace("주최/주관", "").strip()
                
                # --- [날짜 처리 핵심 로직] ---
                # 1. 원본: "2026-02-06 ~ 2026-03-06 D-11"
                raw_date_text = driver.find_element(By.CSS_SELECTOR, "li.dday-area").text.replace("접수기간", "").strip()
                # 2. '~' 뒷부분만 자름: "2026-03-06 D-11"
                after_tilde = raw_date_text.split('~')[-1].strip()
                # 3. 공백 기준 첫 번째만 가져옴: "2026-03-06"
                deadline_only = after_tilde.split(' ')[0]
                # --------------------------

                logo = driver.find_element(By.CSS_SELECTOR, "div.thumb img").get_attribute("src")
                
                try:
                    site = driver.find_element(By.XPATH, "//li[span[text()='홈페이지']]//a").get_attribute("href")
                except:
                    site = "홈페이지 정보 없음"
                    
                cat = driver.find_element(By.XPATH, "//li[span[text()='분야']]").text.replace("분야", "").strip()
                next_id = get_next_id(cursor)

                # SQL 실행 (TO_DATE로 마감일 포맷팅)
                sql = """
                    INSERT INTO CONTEST (CONT_ID, CONT_NAME, ORGANIZER, DEADLINE, LOGO_IMG, SITE_URL, CATEGORY)
                    VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5, :6, :7)
                """
                cursor.execute(sql, [next_id, name, org, deadline_only, logo, site, cat])
                conn.commit()
                
                print(f"✅ [저장 성공] ID:{next_id} | 마감일:{deadline_only} | {name}")

            except Exception as e:
                print(f"❌ 수집 중 오류: {e}")

    finally:
        cursor.close()
        conn.close()
        driver.quit()

if __name__ == "__main__":
    start_scraper()