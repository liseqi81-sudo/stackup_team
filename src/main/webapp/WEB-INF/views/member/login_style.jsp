<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | 로그인" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    .login-wrapper {
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

    .login-links a {
        font-size: 14px;
        color: #555;
        text-decoration: none;
    }

    .login-links a:hover {
        text-decoration: underline;
    }
</style>

<!-- Page Header -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">로그인</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>">Home</a></li>
        <li class="breadcrumb-item active text-white">Login</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="login-wrapper">
            <div class="bg-light rounded p-5 shadow-sm">

                <h3 class="text-center mb-4 text-dark">StackUp 로그인</h3>

                <form action="<c:url value='/login.do'/>" method="post">

                    <div class="mb-3">
                        <input type="text"
                               name="user_id"
                               class="form-control"
                               placeholder="아이디"
                               required>
                    </div>

                    <div class="mb-4">
                        <input type="password"
                               name="user_pw"
                               class="form-control"
                               placeholder="비밀번호"
                               required>
                    </div>

                    <div class="d-grid">
                        <button type="submit"
                                class="btn btn-primary btn-pill">
                            로그인
                        </button>
                    </div>

                </form>

                <!-- 추가 링크 -->
                <div class="text-center mt-4 login-links">
                    <a href="<c:url value='/regist.do'/>">회원가입</a> |
                    <a href="<c:url value='/findId.do'/>">ID 찾기</a> |
                    <a href="<c:url value='/findPw.do'/>">PW 찾기</a>
                </div>

                <!-- 소셜 로그인 -->
                <div class="mt-4">
                    <div class="d-grid">
                        <a href="<c:url value='/oauth2/authorization/google'/>"
                           class="btn btn-outline-secondary btn-pill">
                            <i class="fab fa-google me-2"></i> 구글 로그인
                        </a>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />