<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Resume - Start Bootstrap Theme</title>
<link rel="icon" type="image/x-icon"
	href="<c:url value='/portfolio/t1-tech/img/favicon.ico'/>" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link rel="stylesheet"
	href="<c:url value='/portfolio/t1-tech/css/styles.css'/>">
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top"
		id="sideNav">
		<a class="navbar-brand js-scroll-trigger" href="#page-top"> <span
			class="d-block d-lg-none"> ${resume.name} </span> <span
			class="d-none d-lg-block"> <img
				class="img-fluid img-profile rounded-circle mx-auto mb-2"
				src="<c:url value='${empty portfolio.portraitPath ? "/portfolio/t1-tech/img/profile.jpg" : portfolio.portraitPath}'/>"
				alt="profile" />
		</span>
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#about">About</a></li>

				<c:if test="${not empty resume.experience}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#experience">Experience</a></li>
				</c:if>

				<c:if test="${not empty resume.projects}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#projects">Projects</a></li>
				</c:if>

				<c:if test="${not empty resume.education}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#education">Education</a></li>
				</c:if>

				<c:if test="${not empty resume.skills}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#skills">Skills</a></li>
				</c:if>

				<c:if test="${not empty resume.interests}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#interests">Interests</a></li>
				</c:if>

				<c:if
					test="${not empty resume.certifications or not empty resume.contests}">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#awards">Awards</a></li>
				</c:if>
			</ul>
		</div>
	</nav>
	<!-- Page Content-->
	<div class="container-fluid p-0">
		<!-- About-->
		<section class="resume-section" id="about">
			<div class="resume-section-content">
				<h1 class="mb-0">
					<c:out value="${resume.name}" />
				</h1>

				<div class="subheading mb-5">
					<c:out value="${resume.location}" />
					·
					<c:out value="${resume.phone}" />
					· <a href="mailto:${resume.email}"><c:out
							value="${resume.email}" /></a>
				</div>

				<p class="lead mb-5">
					<c:out value="${resume.summary}" />
				</p>
				<c:if test="${not empty resume.socialLinks}">
					<div class="social-icons">
						<c:forEach var="sl" items="${resume.socialLinks}">
							<a class="social-icon" href="${sl.url}" target="_blank"
								rel="noopener noreferrer" title="${sl.label}"> <i
								class="${sl.icon}"></i>
							</a>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${not empty sessionScope.user}">
					<form method="post"
						action="<c:url value='/portfolio/snapshot/save.do'/>"
						style="margin-top: 20px;">
						<input type="hidden" name="id" value="${portfolio.portfolioId}" />
						<button type="submit" class="btn btn-primary">스냅샷 저장</button>

						<c:if test="${param.saved == '1'}">
							<span class="ms-2 text-success">저장 완료!</span>
						</c:if>
					</form>
				</c:if>
			</div>
		</section>
		<hr class="m-0" />
		<!-- Experience-->
		<c:if test="${not empty resume.experience}">
			<section class="resume-section" id="experience">
				<div class="resume-section-content">
					<h2 class="mb-5">Experience</h2>

					<c:forEach var="e" items="${resume.experience}">
						<div
							class="d-flex flex-column flex-md-row justify-content-between mb-5">
							<div class="flex-grow-1">
								<h3 class="mb-0">
									<c:out value="${e.title}" />
								</h3>
								<div class="subheading mb-3">
									<c:out value="${e.company}" />
								</div>

								<c:if test="${not empty e.description}">
									<ul>
										<c:forEach var="d" items="${e.description}">
											<li><c:out value="${d}" /></li>
										</c:forEach>
									</ul>
								</c:if>
							</div>

							<div class="flex-shrink-0">
								<span class="text-primary"><c:out value="${e.period}" /></span>
							</div>
						</div>
					</c:forEach>

				</div>
			</section>
			<hr class="m-0" />
		</c:if>
		<section class="resume-section" id="projects">
			<div class="resume-section-content">
				<h2 class="mb-5">Projects</h2>

				<c:choose>
					<c:when test="${empty resume.projects}">
						<p class="text-muted">아직 등록된 프로젝트가 없어요.</p>
					</c:when>

					<c:otherwise>
						<c:forEach var="p" items="${resume.projects}">
							<div
								class="d-flex flex-column flex-md-row justify-content-between mb-5">
								<div class="flex-grow-1">

									<h3 class="mb-0">
										<c:out value="${p.title}" />
									</h3>
									<div class="subheading mb-2">
										<c:out value="${p.role}" />
									</div>

									<!-- stack badges -->
									<c:if test="${not empty p.stack}">
										<div class="mb-3">
											<c:forEach var="t" items="${p.stack}">
												<span class="badge bg-secondary me-1 mb-1"><c:out
														value="${t}" /></span>
											</c:forEach>
										</div>
									</c:if>

									<!-- highlights -->
									<c:if test="${not empty p.highlights}">
										<ul class="mb-3">
											<c:forEach var="h" items="${p.highlights}">
												<li><c:out value="${h}" /></li>
											</c:forEach>
										</ul>
									</c:if>

									<!-- links -->
									<c:if test="${not empty p.links}">
										<div>
											<c:forEach var="l" items="${p.links}">
												<a class="me-3" href="${l.url}" target="_blank"
													rel="noopener noreferrer"> <c:out value="${l.label}" />
												</a>
											</c:forEach>
										</div>
									</c:if>

								</div>

								<div class="flex-shrink-0">
									<span class="text-primary"><c:out value="${p.period}" /></span>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>

			</div>
		</section>
		<hr class="m-0" />
		<!-- Education-->
		<c:if test="${not empty resume.education}">
			<section class="resume-section" id="education">
				<div class="resume-section-content">
					<h2 class="mb-5">Education</h2>

					<c:forEach var="ed" items="${resume.education}">
						<div
							class="d-flex flex-column flex-md-row justify-content-between mb-5">
							<div class="flex-grow-1">
								<h3 class="mb-0">
									<c:out value="${ed.school}" />
								</h3>
								<div class="subheading mb-3">
									<c:out value="${ed.major}" />
								</div>

								<c:if test="${not empty ed.etc}">
									<div>
										<c:out value="${ed.etc}" />
									</div>
								</c:if>
							</div>

							<div class="flex-shrink-0">
								<span class="text-primary"><c:out value="${ed.period}" /></span>
							</div>
						</div>
					</c:forEach>

				</div>
			</section>
			<hr class="m-0" />
		</c:if>

		<!-- Skills-->
		<section class="resume-section" id="skills">
			<div class="resume-section-content">
				<h2 class="mb-5">Skills</h2>

				<div class="subheading mb-3">Tech Stack</div>
				<div>
					<c:forEach var="s" items="${resume.skills}">
						<span class="badge bg-secondary me-1 mb-1"><c:out
								value="${s}" /></span>
					</c:forEach>
				</div>
			</div>
		</section>
		<!-- Awards-->
		<section class="resume-section" id="awards">
			<div class="resume-section-content">
				<h2 class="mb-5">Awards & Certifications</h2>
				<ul class="fa-ul mb-0">
					<c:forEach var="c" items="${resume.certifications}">
						<li><span class="fa-li"><i
								class="fas fa-certificate text-warning"></i></span> <c:out value="${c}" />
						</li>
					</c:forEach>

					<c:forEach var="a" items="${resume.contests}">
						<li><span class="fa-li"><i
								class="fas fa-trophy text-warning"></i></span> <c:out value="${a}" /></li>
					</c:forEach>
				</ul>
			</div>
		</section>
		<!--  interest -->
		<c:if test="${not empty resume.interests}">
			<section class="resume-section" id="interests">
				<div class="resume-section-content">
					<h2 class="mb-5">Interests</h2>

					<ul class="mb-0">
						<c:forEach var="i" items="${resume.interests}">
							<li><c:out value="${i}" /></li>
						</c:forEach>
					</ul>

				</div>
			</section>
			<hr class="m-0" />
		</c:if>
	</div>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="<c:url value='/portfolio/t1-tech/js/scripts.js'/>"></script>
</body>
</html>
