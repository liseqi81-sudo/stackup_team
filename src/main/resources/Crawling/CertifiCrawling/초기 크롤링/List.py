import oracledb

def upload_smart_data():
    always_exam_keywords = ['굴착기운전', '지게차운전', '조리', '제과', '제빵', '미용사', '이용사', '건축도장', '방수', '한복', '세탁']

    try:
        conn = oracledb.connect(user="my_project_user", password="password1234", dsn="localhost:1521/xe")
        cursor = conn.cursor()

        with open("collected_certs.txt", "r", encoding="utf-8") as f:
            lines = f.readlines()

        # 현재 님의 테이블 순서: ID, NAME, ORGANIZER, IS_REGULAR, URL, CATEGORY(새로추가)
        sql = """INSERT INTO CERTIFICATION (CERTI_ID, CERTI_NAME, ORGANIZER, IS_REGULAR, URL, CATEGORY) 
                 VALUES (:1, :2, :3, :4, :5, :6)"""
        
        insert_count = 0
        skip_count = 0

        for line in lines:
            line = line.strip()
            if not line or ',' not in line: continue
            
            cert_id, cert_name = line.split(',')

            # 분류 로직
            is_regular = 0 if any(k in cert_name for k in always_exam_keywords) else 1
            category = "국가전문자격" if any(k in cert_name for k in ['분석사', '상담사', '기획사', '관리사', '코디네이터']) else "국가기술자격"

            try:
                # 데이터 순서: ID, 이름, 기관, 상시여부, URL(null), 카테고리
                cursor.execute(sql, (cert_id, cert_name, "한국산업인력공단", is_regular, None, category))
                insert_count += 1
            except oracledb.IntegrityError:
                skip_count += 1
                continue 

        conn.commit()
        print(f"--- ✅ 작업 완료 ---")
        print(f"새로 저장: {insert_count}건 / 중복 제외: {skip_count}건")

    except Exception as e:
        print(f"❌ 오류 발생: {e}")
    finally:
        if conn: conn.close()

upload_smart_data()