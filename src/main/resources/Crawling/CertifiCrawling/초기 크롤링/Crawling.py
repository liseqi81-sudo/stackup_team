import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

driver = webdriver.Chrome()
# 요소가 나타날 때까지 기다리는 시간을 넉넉히 15초로 설정
wait = WebDriverWait(driver, 15)

try:
    jm_cd = "1320"
    target_url = f"https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd={jm_cd}&gSite=Q"
    driver.get(target_url)

    print(f"--- 데이터 수집 시도 중... ---")

    # 1. 자격증 이름 찾기 (가장 확실한 방법: h4 태그 중 아무거나 텍스트가 있는 것)
    # 큐넷은 종목명이 주로 h4 또는 .alc em 태그에 들어있습니다.
    try:
        # 화면에 나타날 때까지 대기
        name_element = wait.until(EC.presence_of_element_located((By.XPATH, "//h4 | //em[@class='alc']")))
        certi_name = name_element.text.strip()
    except:
        # 만약 위 방법도 실패하면 페이지 제목에서 가져오기
        certi_name = driver.title.split('-')[0].strip()

    # 2. 시행기관 찾기 (텍스트 '시행기관' 바로 다음 요소 찾기)
    try:
        organizer = driver.find_element(By.XPATH, "//*[contains(text(),'시행기관')]/following::dd[1]").text.strip()
    except:
        organizer = "한국산업인력공단(추정)"

    # 3. 상시/정기 구분
    is_regular = 1 if "정기" in driver.page_source else 0

    print(f"✅ 수집 성공!")
    print(f"ID: {jm_cd} / 이름: {certi_name} / 주관: {organizer} / 구분: {is_regular}")

except Exception as e:
    # 에러가 나면 현재 페이지에 뭐가 떠있는지 텍스트만이라도 출력해봅니다 (디버깅용)
    print(f"❌ 오류 발생 상세: {e}")
    print("--- 현재 페이지 앞부분 텍스트 샘플 ---")
    print(driver.page_source[:500]) 

finally:
    time.sleep(3)
    driver.quit()