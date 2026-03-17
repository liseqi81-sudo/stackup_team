<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        color: #81c408; /* Fruitables 테마 색상 */
    }
    
    .btn-naver {
    	background-color: #03C75A;
    	color: #fff !important;
    	border: none;
	}
	.btn-naver:hover {
    	background-color: #02b350;
    	color: #fff !important;
	}
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">로그인</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Login</li>
        </ol>
        </div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="login-wrapper">
            <div class="bg-light rounded p-5 shadow-sm">

                <h3 class="text-center mb-4 text-dark" style="font-weight: 700;">StackUp 로그인</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center mb-3" style="font-size: 14px; border-radius: 10px;">
                        ${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty msg}">
                    <div class="alert alert-success text-center mb-3" style="font-size: 14px; border-radius: 10px;">
                        ${msg}
                    </div>
                </c:if>

                <form action="<c:url value='/login.do'/>" method="post">
                	<input type="hidden" name="backUrl" value="${param.backUrl}">
                
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
                                class="btn btn-primary btn-pill text-white fw-bold">
                            로그인
                        </button>
                    </div>
                </form>

                <div class="text-center mt-4 login-links">
                    <a href="<c:url value='/regist.do'/>">회원가입</a>
                    <span class="mx-2 text-muted">|</span>
                    <a href="<c:url value='/findId.do'/>">ID 찾기</a>
                    <span class="mx-2 text-muted">|</span>
                    <a href="<c:url value='/findPw.do'/>">PW 찾기</a>
                </div>

                <div class="position-relative my-4">
                    <hr>
                    <span class="position-absolute top-50 start-50 translate-middle bg-light px-3 text-muted" style="font-size: 12px;">OR</span>
                </div>

                <div class="d-grid">
                   <a href="<c:url value='/oauth2/authorization/naver'/>" 
   					  class="btn btn-naver btn-pill d-flex align-items-center justify-content-center">
    					<span class="fw-bold me-2" style="color: white; font-size: 18px;">N</span>
    					네이버 로그인
				   </a>
                </div>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />