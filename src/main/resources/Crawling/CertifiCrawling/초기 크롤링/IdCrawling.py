import oracledb
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

driver = webdriver.Chrome()

def scrape_any_visible_certs():
    all_found = []
    
    # 1. 현재 메인 프레임 + 모든 iframe 조사
    iframes = driver.find_elements(By.TAG_NAME, "iframe")
    frames_to_check = [None] + iframes
    
    for frame in frames_to_check:
        try:
            if frame: driver.switch_to.frame(frame)
            
            # jmDetail 링크(일반 리스트)와 팝업 내의 자격증 이름들을 모두 수집
            # 큐넷 팝업 내 자격증은 보통 a 태그나 span 태그에 jmDetail 함수가 걸려있습니다.
            targets = driver.find_elements(By.XPATH, "//a[contains(@onclick, 'jmDetail')] | //ul[@class='result_list']//a")
            
            for t in targets:
                name = t.text.strip()
                # onclick 속성에서 숫자 ID 추출 (예: jmDetail('1320') -> 1320)
                onclick_val = t.get_attribute("onclick")
                cert_id = "".join(filter(str.isdigit, onclick_val)) if onclick_val else "0000"
                
                if name and cert_id:
                    all_found.append((cert_id, name))
            
            driver.switch_to.default_content()
        except:
            driver.switch_to.default_content()
            
    return list(set(all_found)) # 중복 제거

# 실행부
try:
    driver.get("https://www.q-net.or.kr/crf005.do?id=crf00501&gSite=Q")
    print("🚀 팝업이 뜨면 팝업창까지 다 띄워놓으세요! 15초 대기합니다.")
    time.sleep(7) # 이 사이에 타기관 클릭 -> 팝업 띄우기까지 완료하세요!

    results = scrape_any_visible_certs()
    
    with open("final_list_ta2.txt", "a", encoding="utf-8") as f:
        for cid, cname in results:
            f.write(f"{cid},{cname}\n")
            print(f"✅ 수집됨: {cname} ({cid})")

finally:
    driver.quit()