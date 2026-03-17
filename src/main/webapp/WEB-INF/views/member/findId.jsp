<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 아이디 찾기" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    /* 다른 페이지와 통일된 스타일 */
    .find-wrapper {
        max-width: 450px;
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

    .label-custom {
        font-weight: 600;
        color: #333;
        margin-left: 15px;
        margin-bottom: 8px;
    }
</style>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">아이디 찾기</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>" class="text-white">Home</a></li>
        <li class="breadcrumb-item active text-white">Find ID</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="find-wrapper">
            <div class="bg-light rounded p-5 shadow-sm">

                <h3 class="text-center mb-4 text-dark" style="font-weight: 700;">아이디 찾기</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center mb-3" role="alert" style="font-size: 0.9rem; border-radius: 10px;">
                        ${error}
                    </div>
                </c:if>

                <p class="text-center text-muted mb-4" style="font-size: 0.9rem;">
                    가입 시 등록하신 이름과 이메일을 입력해 주세요.
                </p>

                <form action="<c:url value='/findIdProcess.do'/>" method="post">
                    <div class="mb-3">
                        <label for="user_name" class="label-custom">이름</label>
                        <input type="text" class="form-control" id="user_name" name="user_name" 
                               placeholder="이름을 입력하세요" required>
                    </div>

                    <div class="mb-4">
                        <label for="user_email" class="label-custom">이메일</label>
                        <input type="email" class="form-control" id="user_email" name="user_email" 
                               placeholder="example@mail.com" required>
                    </div>

                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-primary btn-pill text-white fw-bold">
                            아이디 찾기
                        </button>
                        <button type="button" onclick="history.back()" class="btn btn-outline-secondary btn-pill">
                            이전으로 돌아가기
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />