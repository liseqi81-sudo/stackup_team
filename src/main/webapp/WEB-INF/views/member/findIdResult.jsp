<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 아이디 찾기 결과" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    .result-wrapper {
        max-width: 500px;
        margin: 0 auto;
    }

    .id-display-box {
        background: rgba(129,196,8, 0.1); /* 테마색 투명도 조절 */
        border: 2px dashed #81c408;
        padding: 30px;
        border-radius: 20px;
        font-size: 1.8rem;
        color: #81c408;
        font-weight: 800;
        margin: 25px 0;
        letter-spacing: 1px;
    }

    .btn-pill {
        border-radius: 999px;
        padding: 12px 18px;
    }

    .icon-box {
        font-size: 3rem;
        margin-bottom: 20px;
    }
</style>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">아이디 찾기 결과</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>" class="text-white">Home</a></li>
        <li class="breadcrumb-item active text-white">Result</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="result-wrapper">
            <div class="bg-light rounded p-5 shadow-sm text-center">
                
                <c:choose>
                    <%-- 1. 아이디를 찾은 경우 --%>
                    <c:when test="${not empty foundId}">
                        <div class="icon-box text-primary">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h3 class="mb-3 text-dark" style="font-weight: 700;">아이디를 찾았습니다!</h3>
                        <p class="text-muted"><strong>${user_name}</strong>님의 소중한 정보와 일치하는 아이디입니다.</p>
                        
                        <div class="id-display-box">
                            ${foundId}
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <a href="<c:url value='/login.do'/>" class="btn btn-primary btn-pill text-white fw-bold py-3">로그인하러 가기</a>
                            <a href="<c:url value='/main.do'/>" class="btn btn-outline-secondary btn-pill py-3">홈으로 이동</a>
                        </div>
                    </c:when>

                    <%-- 2. 아이디를 못 찾은 경우 --%>
                    <c:otherwise>
                        <div class="icon-box text-danger">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <h3 class="text-dark mb-3" style="font-weight: 700;">아이디를 찾지 못했습니다</h3>
                        <p class="text-muted">입력하신 정보와 일치하는 계정이 존재하지 않습니다.</p>
                        
                        <div class="alert alert-secondary my-4" style="border-radius: 15px;">
                            입력하신 이름과 이메일을 다시 한번 확인해 주세요.
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <a href="<c:url value='/findId.do'/>" class="btn btn-primary btn-pill text-white fw-bold py-3">다시 시도하기</a>
                            <a href="<c:url value='/regist.do'/>" class="btn btn-outline-primary btn-pill py-3">회원가입 하기</a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />