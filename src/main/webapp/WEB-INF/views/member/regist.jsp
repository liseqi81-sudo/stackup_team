<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 회원가입" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  /* Fruitables 스타일 커스텀 */
  .regist-wrapper { max-width: 960px; margin: 0 auto; }
  .step-box { display:none; }
  .step-box.active { display:block; }

  .type-btn {
    width: 100%; border: 1px solid #e6e6e6; background: #fff;
    border-radius: 16px; padding: 28px 22px; text-align: left;
    transition: .2s ease; cursor: pointer;
    cursor: pointer;
    /* 추가: 내부 요소가 넘칠 때 상자 크기 보존 */
    display: flex;
    flex-direction: column;
    height: 100%; /* 두 상자의 높이를 통일 */
  }
  .type-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0,0,0,.08);
    border-color: #81c408;
  }

  .type-icon {
    width: 56px; height: 56px; border-radius: 999px;
    display:flex; align-items:center; justify-content:center;
    background: rgba(129,196,8,.12); color: #81c408; font-size: 22px;
  }

  .form-control { border-radius: 999px !important; padding: 12px 18px; }
  .btn-pill { border-radius: 999px; padding: 12px 18px; }
  .essential { color:#dc3545; font-weight:700; }
  .table-form th { width: 140px; color:#333; font-weight:600; vertical-align: middle; }
  
  /* 네이버 버튼 스타일 보완 */
.btn-naver {
    background-color: #03C75A;
    color: #fff !important;
    border: none;
    max-width: 320px; /* 버튼이 너무 옆으로 퍼지지 않게 조절 */
    margin: 0 auto;   /* 중앙 정렬 보장 */
    transition: all 0.3s ease;
}

.btn-naver:hover {
    background-color: #02b350;
    color: #fff !important;
    box-shadow: 0 4px 12px rgba(3, 199, 90, 0.2); /* 은은한 그림자 효과 */
}

/* 구분선 텍스트 위치 보정 */
.position-relative hr {
    border-top: 1px solid #e0e0e0;
    opacity: 1;
}
</style>

<script>

	let isIdChecked = false; 
	let checkedId = "";
	
    // 1. 단계 전환 및 기업명 칸 제어
    function showNextStep(type) {
        document.getElementById("step1").classList.remove("active");
        document.getElementById("step2").classList.add("active");

        document.getElementById("user_type").value = type;
        const typeTitle = (type === 'USER') ? '취업준비생' : '기업회원';
        document.getElementById("selected-type-name").innerText = typeTitle;

        // 기업회원일 때만 기업명 행 노출
        const companyRow = document.getElementById("company-only-row");
        const companyInput = document.getElementById("company_name");
        const nameLabel = document.getElementById("name-label");
        const emailLabel = document.getElementById("email-label");
        const userNameInput = document.getElementsByName("user_name")[0];
        const userEmailInput = document.getElementsByName("user_email")[0];

        if(type === 'COMPANY') {
        	//1. 기업명 입력란 노출 (필수값 설정)
            companyRow.style.display = "table-row";
            companyInput.required = true;
            
         // 2. 기획에 맞게 라벨 텍스트 변경
        userNameInput.setAttribute("name", "manager_name"); // 담당자 이름
        userEmailInput.setAttribute("name", "company_email"); // 기업 이메일
        
        nameLabel.innerText = " 담당자 이름";
        emailLabel.innerText = " 기업 이메일";
        } 
        else {
            companyRow.style.display = "none";
            companyInput.required = false;
            
            
            userNameInput.setAttribute("name", "user_name");
            userEmailInput.setAttribute("name", "user_email");
            
            nameLabel.innerText = " 이름";
            emailLabel.innerText = " 이메일";
        }
    }

    // 2. 아이디 중복 확인 (AJAX)
    function idCheck() {
        const userId = document.getElementById("user_id").value;
        const msg = document.getElementById("id-msg");

        if(!userId) {
            alert("아이디를 입력해주세요.");
            return;
        }

        fetch('/checkId.do', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'user_id=' + encodeURIComponent(userId)
        })
        .then(res => res.text())
        .then(data => {
            if(data === "0") {
                msg.innerText = "사용 가능한 아이디입니다.";
                msg.style.color = "green";
                isIdChecked = true;
                checkedId = userId;
            } 
            else {
                msg.innerText = "이미 사용 중인 아이디입니다.";
                msg.style.color = "red";
                isIdChecked = false;  
            }
        })
        .catch(err => console.error("Error:", err));
    }
    
 // 3. [추가] 가입 전 최종 유효성 검사
    function validateForm() {
        const currentId = document.getElementById("user_id").value;

        // 중복 확인 버튼을 아예 안 눌렀을 때
        if(!isIdChecked) {
            alert("아이디 중복 확인을 해주세요.");
            return false;
        }

        // 중복 확인은 했지만, 그 이후에 아이디를 슬쩍 바꿨을 때 방지
        if(currentId !== checkedId) {
            alert("아이디가 변경되었습니다. 다시 중복 확인을 해주세요.");
            isIdChecked = false;
            return false;
        }

        return true; // 모든 검사 통과 시 전송
    }
    
</script>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">회원가입</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Regist</li>
        </ol>
        </div>

<div class="container-fluid py-5">
  <div class="container py-5">
    <div class="regist-wrapper">
      <div class="bg-light rounded p-4 p-lg-5 shadow-sm">

        <div id="step1" class="step-box active">
          <div class="text-center mb-4">
            <h2 class="text-dark mb-2">회원 유형을 선택해주세요</h2>
            <p class="text-muted mb-0">원하는 이용 목적에 맞게 선택하면, 다음 단계로 이동해요.</p>
          </div>

          <div class="row g-4">
            <div class="col-md-6">
              <button type="button" class="type-btn" onclick="showNextStep('USER')">
                <div class="d-flex gap-3 align-items-start">
                  <div class="type-icon"><i class="fas fa-user"></i></div>
                  <div>
                    <h4 class="mb-1 text-dark">취업준비생</h4>
                    <p class="mb-0 text-muted">개인 서비스 이용 (스킬업/포트폴리오)</p>
                  </div>
                </div>
              </button>
            </div>

            <div class="col-md-6">
              <button type="button" class="type-btn" onclick="showNextStep('COMPANY')">
                <div class="d-flex gap-3 align-items-start">
                  <div class="type-icon"><i class="fas fa-building"></i></div>
                  <div>
                    <h4 class="mb-1 text-dark">기업회원</h4>
                    <p class="mb-0 text-muted">채용 및 기업 서비스 이용</p>
                  </div>
                </div>
              </button>
            </div>
          </div>

          <div class="position-relative my-5">
              <hr>
              <span class="position-absolute top-50 start-50 translate-middle bg-light px-3 text-muted" style="font-size: 12px;">간편 회원가입/로그인</span>
          </div>

          <div class="d-flex justify-content-center mb-5"> <div style="width: 100%; max-width: 400px;">
        		<a href="<c:url value='/oauth2/authorization/naver'/>" 
           			class="btn btn-naver btn-pill d-flex align-items-center justify-content-center py-3">
            		<span class="fw-bold me-2" style="font-family: 'Arial Black', sans-serif; font-size: 20px;">N</span>
            		<span style="letter-spacing: -0.5px;">네이버로 시작하기</span>
        		</a>
    		</div>
		</div>
        </div>

          	
          </div>
        </div>

        <div id="step2" class="step-box">
          <div class="mb-4">
            <h2 class="text-dark">
              <span id="selected-type-name" class="text-primary"></span> 정보 입력
            </h2>
            <p class="text-muted mb-0">필수 항목(*)을 입력하고 가입을 완료해주세요.</p>
          </div>

          <form action="registProcess.do" method="post" onsubmit="return validateForm()">
            <input type="hidden" id="user_type" name="user_type" value="">

            <table class="table table-borderless align-middle table-form mb-4">
              <tr>
                <th><span class="essential">*</span> 이름</th>
                <td><input type="text" class="form-control" name="user_name" required></td>
              </tr>

              <tr id="company-only-row" style="display:none;">
                <th><span class="essential">*</span> 기업명</th>
                <td><input type="text" class="form-control" id="company_name" name="company_name"></td>
              </tr>

              <tr>
                <th><span class="essential">*</span> 아이디</th>
                <td>
                  <div class="d-flex gap-2 flex-wrap">
                    <input type="text" class="form-control" id="user_id" name="user_id" required style="max-width: 300px;">
                    <button type="button" class="btn btn-outline-primary btn-pill" onclick="idCheck()">중복확인</button>
                  </div>
                  <div id="id-msg" style="font-size:12px; margin-top:5px; height:15px;"></div>
                </td>
              </tr>

              <tr>
                <th><span class="essential">*</span> 비밀번호</th>
                <td><input type="password" class="form-control" name="user_pw" required></td>
              </tr>

              <tr>
                <th><span class="essential">*</span> 이메일</th>
                <td><input type="email" class="form-control" name="user_email" required></td>
              </tr>

              <tr>
                <th><span class="essential">*</span> 전화번호</th>
                <td><input type="text" class="form-control" name="user_phone" required placeholder="010-0000-0000"></td>
              </tr>
            </table>

            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-primary btn-pill py-3 text-white">가입 완료</button>
              <button type="button" class="btn btn-outline-secondary btn-pill py-3" onclick="location.reload()">처음으로 돌아가기</button>
            </div>
          </form>
        </div>

      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />