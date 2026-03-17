<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 회원가입" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  /* Fruitables 톤에 맞춘 step UI 커스텀 (필요 최소만) */
  .regist-wrapper { max-width: 960px; margin: 0 auto; }

  .step-box { display:none; }
  .step-box.active { display:block; }

  .type-btn {
    width: 100%;
    border: 1px solid #e6e6e6;
    background: #fff;
    border-radius: 16px;
    padding: 28px 22px;
    text-align: left;
    transition: .2s ease;
    cursor: pointer;
  }
  .type-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0,0,0,.08);
    border-color: rgba(129,196,8,.45); /* fruitables primary 느낌 */
  }

  .type-icon {
    width: 56px; height: 56px;
    border-radius: 999px;
    display:flex; align-items:center; justify-content:center;
    background: rgba(129,196,8,.12);
    color: #81c408;
    font-size: 22px;
  }

  .form-control, .form-select {
    border-radius: 999px !important;
    padding: 12px 18px;
  }

  .btn-pill { border-radius: 999px; padding: 12px 18px; }

  .essential { color:#dc3545; font-weight:700; }
  .table-form th { width: 140px; color:#333; font-weight:600; }
  .table-form td { width: auto; }

  @media (max-width: 576px) {
    .table-form th { width: 110px; }
  }
</style>

<!-- Page Header Start (Fruitables 스타일) -->
<div class="container-fluid page-header py-5">
  <h1 class="text-center text-white display-6">회원가입</h1>
  <ol class="breadcrumb justify-content-center mb-0">
    <li class="breadcrumb-item"><a href="main.do">Home</a></li>
    <li class="breadcrumb-item active text-white">Register</li>
  </ol>
</div>
<!-- Page Header End -->

<div class="container-fluid py-5">
  <div class="container py-5">

    <div class="regist-wrapper">
      <div class="bg-light rounded p-4 p-lg-5 shadow-sm">

        <script>
          function showNextStep(type) {
            document.getElementById("step1").classList.remove("active");
            document.getElementById("step2").classList.add("active");

            document.getElementById("user_type").value = type;
            const typeTitle = (type === 'USER') ? '취업준비생' : '기업회원';
            document.getElementById("selected-type-name").innerText = typeTitle;
          }
        </script>

        <!-- STEP 1 -->
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
                    <p class="mb-0 text-muted">개인 서비스 이용 (스킬업/포트폴리오/추천)</p>
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
        </div>

        <!-- STEP 2 -->
        <div id="step2" class="step-box">
          <div class="mb-4">
            <h2 class="text-dark">
              <span id="selected-type-name" class="text-primary"></span> 정보 입력
            </h2>
            <p class="text-muted mb-0">필수 항목(*)을 입력하고 가입을 완료해주세요.</p>
          </div>

          <form action="regist.do" method="post">
            <input type="hidden" id="user_type" name="user_type" value="">

            <table class="table table-borderless align-middle table-form mb-4">
              <tr>
                <th><span class="essential">*</span> 이름</th>
                <td><input type="text" class="form-control" name="user_name" required></td>
              </tr>

              <tr>
                <th><span class="essential">*</span> 아이디</th>
                <td>
                  <div class="d-flex gap-2 flex-wrap">
                    <input type="text" class="form-control" name="user_id" required style="max-width: 360px;">
                    <button type="button" class="btn btn-outline-primary btn-pill">
                      중복확인
                    </button>
                  </div>
                  <small class="text-muted d-block mt-2">영문/숫자 조합을 추천해요.</small>
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
              <button type="submit" class="btn btn-primary btn-pill py-3">
                가입 완료
              </button>

              <button type="button"
                      class="btn btn-outline-secondary btn-pill py-3"
                      onclick="location.reload()">
                처음으로 돌아가기
              </button>
            </div>
          </form>

        </div>

      </div>
    </div>

  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />