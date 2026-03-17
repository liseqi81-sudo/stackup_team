import oracledb
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# 1. Oracle DB 연결 설정
conn_config = {
    "user": "admin", # 본인 계정으로 수정
    "password": "1234",
    "dsn": "192.168.0.20:1521/xe"
}

def start_integrated_license_scraper():
    conn = oracledb.connect(**conn_config)
    cursor = conn.cursor()
    driver = webdriver.Chrome()

    # 상시 시험 키워드 (기존 리스트 코드의 로직 활용)
    always_exam_keywords = ['굴착기운전', '지게차운전', '조리', '제과', '제빵', '미용사', '이용사', '건축도장', '방수', '한복', '세탁']

    try:
        # 큐넷 종목정보 페이지로 안내
        driver.get("https://www.q-net.or.kr/crf005.do?id=crf00501&gSite=Q")
        print("\n🚀 [자격증 통합 수집] 큐넷에서 상세 종목 정보를 띄운 뒤 Enter를 누르세요.")
        print("👉 종료하려면 'q' 입력")

        while True:
            user_input = input("\n[대기] Enter:수집 / q:종료 > ")
            if user_input.lower() == 'q': break

            try:
                # 1. URL에서 고유 종목코드 추출
                current_url = driver.current_url
                l_code = current_url.split("jmCd=")[-1].split("&")[0]

                # 2. 자격증 이름 추출 (h4 또는 em.alc)
                try:
                    l_name = driver.find_element(By.XPATH, "//h4 | //em[@class='alc']").text.strip()
                except:
                    l_name = driver.title.split('-')[0].strip()

                # 3. 시행기관 (주최)
                try:
                    organizer = driver.find_element(By.XPATH, "//*[contains(text(),'시행기관')]/following::dd[1]").text.strip()
                except:
                    organizer = "한국산업인력공단"

                # 4. 정기 / 상시 구분 (이름 키워드 + 페이지 텍스트 분석)
                is_regular = "상시" if any(k in l_name for k in always_exam_keywords) else "정기"
                if "정기" in driver.page_source and is_regular == "상시":
                    is_regular = "정기/상시 병행" # 둘 다 검색될 경우

                # 5. 국가기술 / 전문자격 / 타기관 구분
                if "국가전문자격" in driver.page_source or any(k in l_name for k in ['분석사', '상담사', '기획사']):
                    nat_type = "국가전문자격"
                elif "타기관" in current_url:
                    nat_type = "국가기술(타기관)"
                else:
                    nat_type = "국가기술자격"

                # 6. 카테고리 (대분류/소분류) - 페이지 내 경로(Breadcrumb) 활용
                # 보통 큐넷 상단에 '기술계 > 기사' 혹은 '직무분야' 텍스트를 찾아 추출합니다.
                try:
                    category_text = driver.find_element(By.CLASS_NAME, "path").text # 예: 홈 > 국가자격 > 종목정보
                    main_cat = category_text.split('>')[-2].strip() 
                    sub_cat = category_text.split('>')[-1].strip()
                except:
                    main_cat = "미분류"
                    sub_cat = "종목정보"

                # SQL 삽입 (순서: id/name/주최/정기or상시/국가구분/메인카테/서브카테)
                sql = """
                    INSERT INTO LICENSE (L_CODE, L_NAME, ORGANIZER, TYPE_REG, NATIONAL_TYPE, MAIN_CATEGORY, SUB_CATEGORY)
                    VALUES (:1, :2, :3, :4, :5, :6, :7)
                """
                cursor.execute(sql, [l_code, l_name, organizer, is_regular, nat_type, main_cat, sub_cat])
                conn.commit()
                
                print(f"✅ [저장완료] {l_name} ({l_code})")
                print(f"   분류: {nat_type} / {is_regular} / {main_cat}")

            except Exception as e:
                print(f"❌ 수집 오류: {e}")

    finally:
        cursor.close()
        conn.close()
        driver.quit()

if __name__ == "__main__":
    start_integrated_license_scraper()