<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | 기업 정보 입력" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    .info-wrapper {
        max-width: 500px;
        margin: 0 auto;
    }

    .form-control {
        border-radius: 999px !important;
        padding: 12px 18px;
    }

    .btn-pill {
        border-radius: 999px;
        padding: 12px;
    }

    .info-text {
        font-size: 15px;
        color: #666;
        line-height: 1.6;
    }
</style>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">기업 정보 설정</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>">Home</a></li>
        <li class="breadcrumb-item active text-white">Company Info</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="info-wrapper">
            <div class="bg-light rounded p-5 shadow-sm">

                <h3 class="text-center mb-3 text-dark">환영합니다!</h3>
                <p class="text-center info-text mb-4">
                    <strong>${user.user_name}</strong>님, 회원가입을 축하드립니다.<br>
                    기업 서비스 이용을 위해 <strong>회사명</strong>을 입력해 주세요.
                </p>

                <form action="<c:url value='/companyExtra.do'/>" method="post">

                    <div class="mb-4">
                        <label class="form-label ms-3 text-secondary" style="font-size: 13px;">회사명 (필수)</label>
                        <input type="text"
                               name="company_name"
                               class="form-control"
                               placeholder="예: (주)스킬업컴퍼니"
                               required>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit"
                                class="btn btn-primary btn-pill">
                            정보 저장 후 시작하기
                        </button>
                    </div>

                </form>

                <div class="text-center mt-4">
                    <small class="text-muted">입력하신 정보는 마이페이지에서 수정 가능합니다.</small>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />