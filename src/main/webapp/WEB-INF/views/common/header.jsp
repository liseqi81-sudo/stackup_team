<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title><c:out value="${empty pageTitle ? 'StackUp' : pageTitle}" /></title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link
	href="<c:url value='/fruitables/lib/lightbox/css/lightbox.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/fruitables/lib/owlcarousel/assets/owl.carousel.min.css'/>"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="<c:url value='/fruitables/css/bootstrap.min.css'/>"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="<c:url value='/fruitables/css/style.css'/>" rel="stylesheet">
<style>
.company-block {
  text-decoration: line-through;
  opacity: 0.6;          /* 살짝 흐리게 */
  cursor: not-allowed;   /* 마우스 모양 변경 */
}
</style>
</head>

<body>
	<!-- Spinner Start -->
	<div id="spinner"
		class="w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->

	<!-- Navbar start -->
	<div class="container-fluid fixed-top">
		<div class="container topbar bg-primary d-none d-lg-block">
			<div class="d-flex justify-content-between">
				<div class="top-info ps-2">
					<small class="me-3"> <i
						class="fas fa-envelope me-2 text-secondary"></i> <a href="#"
						class="text-white">support@stackup.com</a>
					</small>
				</div>

				<div class="top-link pe-2">
					<c:choose>
						<c:when test="${empty sessionScope.user}">
							<a href="/login.do" class="text-white"><small
								class="text-white mx-2">로그인</small>/</a>
							<a href="/regist.do" class="text-white"><small
								class="text-white mx-2">회원가입</small></a>
						</c:when>
						<c:otherwise>
							<small class="text-white mx-2"> <c:out
									value="${sessionScope.user.user_name}" />님 환영해요!
							</small>
							<a href="/mypage.do" class="text-white"><small
								class="text-white mx-2">마이페이지</small> / </a>
							<a href="/logout.do" class="text-white"><small
								class="text-white mx-2">로그아웃</small></a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<div class="container px-0">
			<nav class="navbar navbar-light bg-white navbar-expand-xl">
				<a href="${pageContext.request.contextPath}/main.do"
					class="navbar-brand">
					<h1 class="text-primary display-6">StackUp</h1>
				</a>

				<button class="navbar-toggler py-2 px-3" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-primary"></span>
				</button>

				<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
					<div class="navbar-nav mx-auto">
						<a href="/airecommend.do"
						   class="nav-item nav-link ${sessionScope.user.user_type == 'COMPANY' ? 'company-block' : ''}"
						   onclick="return checkCompanyUser();">
						   AI추천
						</a>		
						<a href="/portfolio/dashboard.do" class="nav-item nav-link">포트폴리오</a> 
						<a href="/skillup.do"
						   class="nav-item nav-link ${sessionScope.user.user_type == 'COMPANY' ? 'company-block' : ''}"
						   onclick="return checkCompanyUser();">
						   스킬업
						</a>
						<div class="nav-item dropdown">
							<a href="#" class="nav-link dropdown-toggle"
								data-bs-toggle="dropdown">구해요</a>

							<div class="dropdown-menu m-0 bg-secondary rounded-0">
								<!-- ✅ 구인(전체 공개) : 지금 만든 jobposting -->
								<a href="<c:url value='/jobposting/joblist.do'/>"
									class="dropdown-item">구인</a>

								<!-- ✅ 구직(기업회원만) -->
								<%-- <c:if
									test="${not empty sessionScope.user && sessionScope.user.user_type eq 'COMPANY'}"> --%>
									<a href="<c:url value='/jobseeker/seekerlist.do'/>"
										class="dropdown-item">구직</a>
							<%-- 	</c:if> --%>
							</div>
						</div>

						<a href="/certification.do" class="nav-item nav-link">자격증</a> <a
							href="/contest/contestlist.do" class="nav-item nav-link">공모전/외부활동</a>

						<div class="nav-item dropdown">
							<a href="#" class="nav-link dropdown-toggle"
								data-bs-toggle="dropdown">게시판</a>
							<div class="dropdown-menu m-0 bg-secondary rounded-0">
								<a href="/noticeList.do" class="dropdown-item">공지사항</a> <a
									href="/qnaList.do" class="dropdown-item">문의게시판</a> <a
									href="/reviewList.do" class="dropdown-item">수강후기</a>
							</div>
						</div>

						<%--                         비로그인 사용자에게만 소개/가이드 노출 (원하면 이 블록 제거해도 됨)
                        <c:if test="${empty sessionScope.loginUser}">
                            <a href="<c:url value='/purpose.do'/>" class="nav-item nav-link">서비스소개</a>
                            <a href="<c:url value='/portfolioGuide.do'/>" class="nav-item nav-link">가이드</a>
                        </c:if> --%>
					</div>

					<div class="d-flex m-3 me-0">
						<!-- <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                                data-bs-toggle="modal" data-bs-target="#searchModal">
                            <i class="fas fa-search text-primary"></i>
                        </button> -->

						<c:choose>
						  <c:when test="${empty sessionScope.user}">
						    <a href="${pageContext.request.contextPath}/login.do" class="my-auto position-relative header-user-icon">
						      <i class="fas fa-user fa-2x"></i>
						    </a>
						  </c:when>
						  <c:otherwise>
						    <a href="${pageContext.request.contextPath}/mypage.do" class="my-auto position-relative header-user-icon">
						      <i class="fas fa-user fa-2x"></i>
						
						      <c:if test="${globalUnreadContactCount gt 0}">
						        <span class="header-noti-badge">
						          ${globalUnreadContactCount}
						        </span>
						      </c:if>
						    </a>
						  </c:otherwise>
						</c:choose>
					</div>
				</div>
			</nav>
		</div>
	</div>
	<script>
	function checkCompanyUser() {
	    var userType = "${sessionScope.user.user_type}";

	    if(userType === "COMPANY"){
	        alert("일반 회원만 이용 가능합니다.");
	        return false;
	    }

	    return true;
	}
	</script>
	<!-- Navbar End -->