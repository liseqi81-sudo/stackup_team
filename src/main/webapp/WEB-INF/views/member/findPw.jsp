<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 비밀번호 찾기" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
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
    <h1 class="text-center text-white display-6">비밀번호 찾기</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>" class="text-white">Home</a></li>
        <li class="breadcrumb-item active text-white">Find PW</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="find-wrapper">
            <div class="bg-light rounded p-5 shadow-sm">

                <h3 class="text-center mb-4 text-dark" style="font-weight: 700;">비밀번호 찾기</h3>
                
                <p class="text-center text-muted mb-4" style="font-size: 0.9rem;">
                    가입 정보(ID, 이름, 이메일)를 입력하시면<br>
                    등록된 메일로 <span class="text-primary fw-bold">임시 비밀번호</span>를 보내드립니다.
                </p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center mb-3" style="font-size: 0.85rem; border-radius: 10px;">
                        ${error}
                    </div>
                </c:if>

                <form action="<c:url value='/findPwProcess.do'/>" method="post">
                    <div class="mb-3">
                        <label class="label-custom">아이디</label>
                        <input type="text" name="user_id" class="form-control" placeholder="아이디를 입력하세요" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="label-custom">이름</label>
                        <input type="text" name="user_name" class="form-control" placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <div class="mb-4">
                        <label class="label-custom">이메일 주소</label>
                        <input type="email" name="user_email" class="form-control" placeholder="example@mail.com" required>
                    </div>

                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-primary btn-pill text-white fw-bold py-3">
                            임시 비밀번호 발송
                        </button>
                        <button type="button" onclick="history.back()" class="btn btn-outline-secondary btn-pill py-3">
                            이전으로 돌아가기
                        </button>
                    </div>
                </form>
                
                <div class="mt-4 text-center">
                    <small class="text-muted">아이디가 기억나지 않으세요? <a href="<c:url value='/findId.do'/>" class="text-primary text-decoration-none">아이디 찾기</a></small>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />