<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 회원정보 수정" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  .mypage-wrapper { max-width: 960px; margin: 0 auto; }
  .form-control { border-radius: 999px !important; padding: 12px 18px; }
  .btn-pill { border-radius: 999px; padding: 12px 18px; }
  .table-form th { width: 160px; color:#333; font-weight:600; vertical-align: middle; }
  .essential { color:#dc3545; font-weight:700; }
</style>

<div class="container-fluid page-header py-5">
  <h1 class="text-center text-white display-6">회원정보 수정</h1>
  <ol class="breadcrumb justify-content-center mb-0">
    <li class="breadcrumb-item"><a href="main.do">Home</a></li>
    <li class="breadcrumb-item"><a href="mypage.do">My Page</a></li>
    <li class="breadcrumb-item active text-white">Edit</li>
  </ol>
</div>

<div class="container-fluid py-5">
  <div class="container py-5">
    <div class="mypage-wrapper">
      <div class="bg-light rounded p-4 p-lg-5 shadow-sm">

        <div class="mb-4">
          <h2 class="text-dark mb-1">내 정보 수정</h2>
          <p class="text-muted mb-0">필수 항목(*)을 확인하고 수정하세요.</p>
        </div>

        <c:if test="${not empty msg}">
          <div class="alert alert-danger">${msg}</div>
        </c:if>

        <form action="mypageEdit.do" method="post">
          <table class="table table-borderless align-middle table-form mb-4">

            <tr>
              <th>ID</th>
              <td>
                <input type="text" class="form-control" value="${user.user_id}" readonly>
              </td>
            </tr>

            <tr>
              <th><span class="essential">*</span> 이름</th>
              <td>
                <input type="text" class="form-control" name="user_name" value="${user.user_name}" required>
              </td>
            </tr>

            <tr>
              <th><span class="essential">*</span> 이메일</th>
              <td>
                <input type="email" class="form-control" name="user_email" value="${user.user_email}" required>
              </td>
            </tr>

            <tr>
              <th><span class="essential">*</span> 전화번호</th>
              <td>
                <input type="text" class="form-control" name="user_phone" value="${user.user_phone}" required>
              </td>
            </tr>

            <tr>
              <th>회원유형</th>
              <td>
                <input type="text" class="form-control" value="${user.user_type}" readonly>
              </td>
            </tr>

            <tr>
              <th>가입일</th>
              <td>
                <input type="text" class="form-control" value="${user.created_at}" readonly>
              </td>
            </tr>

            <tr>
              <th>기업명</th>
              <td>
                <input type="text" class="form-control" name="company_name" value="${user.company_name}">
                <div class="text-muted" style="font-size:12px; margin-top:6px;">
                  기업회원이 아니면 비워도 됩니다.
                </div>
              </td>
            </tr>

          </table>

          <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary btn-pill py-3 text-white">수정 저장</button>
            <a href="mypage.do" class="btn btn-outline-secondary btn-pill py-3">취소</a>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />