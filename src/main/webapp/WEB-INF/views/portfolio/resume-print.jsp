<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Resume Print</title>

<!-- ✅ 출력 최적화: 외부 CDN/폰트 의존하지 않기(팀/환경 차이 방지) -->
<style>
/* ====== A4 1페이지 고정 ====== */
@page {
	size: A4;
	margin: 12mm;
}

html, body {
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, "Malgun Gothic", sans-serif;
	color: #111;
}

/* 컨테이너는 A4 내에서만 사용 */
.page {
	width: 186mm; /* A4 210 - 좌우마진(12*2)=24 => 186 */
	min-height: 273mm; /* A4 297 - 상하마진(12*2)=24 => 273 */
}

/* ====== 레이아웃: 좌우 2단 ====== */
.grid {
	display: table;
	width: 100%;
	table-layout: fixed;
}

.left, .right {
	display: table-cell;
	vertical-align: top;
}

.left {
	width: 34%;
	padding-right: 8mm;
	border-right: 1px solid #e6e6e6;
}

.right {
	width: 66%;
	padding-left: 8mm;
}

/* ====== 타이포 ====== */
.name {
	font-size: 22pt;
	font-weight: 700;
	margin: 0 0 4mm 0;
	letter-spacing: -0.4px;
}

.headline {
	font-size: 11pt;
	color: #444;
	margin: 0 0 6mm 0;
}

h2 {
	font-size: 12pt;
	margin: 0 0 3mm 0;
	letter-spacing: -0.2px;
}

.section {
	margin: 0 0 6mm 0;
}

.label {
	font-size: 9pt;
	color: #666;
	letter-spacing: 0.06em;
	text-transform: uppercase;
	margin: 0 0 2mm 0;
}

.text {
	font-size: 10pt;
	line-height: 1.45;
	margin: 0;
}

.muted {
	color: #666;
}

a {
	color: #111;
	text-decoration: none;
}

/* ====== 리스트/뱃지 ====== */
.list {
	margin: 0;
	padding: 0;
	list-style: none;
}

.list li {
	font-size: 10pt;
	line-height: 1.4;
	margin: 0 0 1.5mm 0;
}

.badges {
	margin-top: 2mm;
}

.badge {
	display: inline-block;
	border: 1px solid #e6e6e6;
	background: #fafafa;
	border-radius: 999px;
	padding: 1.5mm 3mm;
	margin: 0 2mm 2mm 0;
	font-size: 9pt;
}

/* ====== 아이템(프로젝트/경력/학력) ====== */
.item {
	margin: 0 0 4mm 0;
}

.item-top {
	display: table;
	width: 100%;
}

.item-title {
	display: table-cell;
	font-size: 10.5pt;
	font-weight: 700;
}

.item-meta {
	display: table-cell;
	font-size: 9pt;
	color: #666;
	text-align: right;
	white-space: nowrap;
}

.item-sub {
	font-size: 9pt;
	color: #666;
	margin: 1mm 0 0 0;
}

.pill {
	display: inline-block;
	border: 1px solid #e6e6e6;
	border-radius: 999px;
	padding: 1mm 2.5mm;
	font-size: 8.5pt;
	margin-right: 2mm;
}

.desc {
	font-size: 10pt;
	line-height: 1.42;
	margin: 2mm 0 0 0;
}

.chips {
	margin-top: 2mm;
}

.chip {
	display: inline-block;
	border: 1px solid #e6e6e6;
	background: #fff;
	border-radius: 999px;
	padding: 1.2mm 2.8mm;
	font-size: 8.5pt;
	margin: 0 2mm 2mm 0;
}

ul.bullets {
	margin: 2mm 0 0 0;
	padding-left: 4mm;
}

ul.bullets li {
	font-size: 9.5pt;
	line-height: 1.42;
	margin: 0 0 1mm 0;
}

/* ====== 한 장에 들어오게 “컷” 전략 ======
     - 각 섹션 개수 제한은 JSP에서 이미 해도 되고,
     - 여기선 너무 길어질 때 줄바꿈을 예쁘게 하도록 설정 */
.clamp2 {
	display: block;
	overflow: hidden;
	max-height: 2.9em; /* 대략 2줄 */
}
</style>
</head>

<body>
	<c:choose>
		<c:when test="${empty resume}">
			<div class="page">
				<p class="text">저장된 레쥬메 스냅샷이 없습니다.</p>
			</div>
		</c:when>

		<c:otherwise>
			<div class="page">
				<div class="grid">
					<!-- ================= LEFT ================= -->
					<div class="left">
						<h1 class="name">${resume.name}</h1>
						<c:if test="${not empty resume.headline}">
							<p class="headline">${resume.headline}</p>
						</c:if>

						<div class="section">
							<p class="label">Contact</p>
							<ul class="list">
								<c:if test="${not empty resume.email}">
									<li>📩 ${resume.email}</li>
								</c:if>
								<c:if test="${not empty resume.phone}">
									<li>📞 ${resume.phone}</li>
								</c:if>
								<c:if test="${not empty resume.location}">
									<li>📍 ${resume.location}</li>
								</c:if>
							</ul>
						</div>

						<c:if test="${not empty resume.socialLinks}">
							<div class="section">
								<p class="label">Links</p>
								<ul class="list">
									<c:forEach var="l" items="${resume.socialLinks}" varStatus="st">
										<c:if test="${st.index lt 3}">
											<li>🔗 ${l.label} : ${l.url}</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</c:if>

						<c:if test="${not empty resume.skills}">
							<div class="section">
								<p class="label">Skills</p>
								<div class="badges">
									<c:forEach var="s" items="${resume.skills}" varStatus="st">
										<c:if test="${st.index lt 18}">
											<span class="badge">${s}</span>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</c:if>

						<c:if test="${not empty resume.summary}">
							<div class="section">
								<p class="label">Summary</p>
								<p class="text clamp2">${resume.summary}</p>
							</div>
						</c:if>
					</div>

					<!-- ================= RIGHT ================= -->
					<div class="right">

						<!-- ===== Projects ===== -->
						<c:if test="${not empty resume.projects}">
							<div class="section">
								<h2>Projects</h2>
								<c:forEach var="p" items="${resume.projects}" varStatus="pst">
									<c:if test="${pst.index lt 3}">
										<div class="item">
											<div class="item-top">
												<div class="item-title">${p.title}</div>
												<div class="item-meta">
													<c:if test="${not empty p.period}">${p.period}</c:if>
												</div>
											</div>

											<div class="item-sub">
												<c:if test="${not empty p.role}">
													<span class="pill">${p.role}</span>
												</c:if>
											</div>

											<c:if test="${not empty p.oneLine}">
												<p class="desc clamp2">${p.oneLine}</p>
											</c:if>

											<c:if test="${not empty p.stack}">
												<div class="chips">
													<c:forEach var="st" items="${p.stack}" varStatus="sst">
														<c:if test="${sst.index lt 6}">
															<span class="chip">${st}</span>
														</c:if>
													</c:forEach>
												</div>
											</c:if>

											<c:if test="${not empty p.highlights}">
												<ul class="bullets">
													<c:forEach var="h" items="${p.highlights}" varStatus="hst">
														<c:if test="${hst.index lt 2}">
															<li>${h}</li>
														</c:if>
													</c:forEach>
												</ul>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:if>

						<!-- ===== Experience ===== -->
						<c:if test="${not empty resume.experience}">
							<div class="section">
								<h2>Experience</h2>
								<c:forEach var="e" items="${resume.experience}" varStatus="est">
									<c:if test="${est.index lt 2}">
										<div class="item">
											<div class="item-top">
												<div class="item-title">
													${e.title}
													<c:if test="${not empty e.company}">
														<span class="muted"> @ ${e.company}</span>
													</c:if>
												</div>
												<div class="item-meta">
													<c:if test="${not empty e.period}">${e.period}</c:if>
												</div>
											</div>

											<div class="item-sub">
												<c:if test="${not empty e.type}">
													<span class="pill">${e.type}</span>
												</c:if>
												<c:if test="${not empty e.location}">
													<span class="muted">${e.location}</span>
												</c:if>
											</div>

											<c:if test="${not empty e.description}">
												<ul class="bullets">
													<c:forEach var="d" items="${e.description}" varStatus="dst">
														<c:if test="${dst.index lt 3}">
															<li>${d}</li>
														</c:if>
													</c:forEach>
												</ul>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:if>

						<!-- ===== Education + Certifications (2열) ===== -->
						<div class="section">
							<div class="grid"
								style="border-top: 1px solid #e6e6e6; padding-top: 4mm;">
								<div class="left"
									style="border-right: none; padding-right: 6mm;">
									<h2>Education</h2>
									<c:forEach var="ed" items="${resume.education}"
										varStatus="edst">
										<c:if test="${edst.index lt 2}">
											<div class="item">
												<div class="item-top">
													<div class="item-title">
														<c:out value="${ed.degree}" />
														<c:if test="${not empty ed.school}">
															<span class="muted"> · ${ed.school}</span>
														</c:if>
													</div>
													<div class="item-meta">
														<c:if test="${not empty ed.startDate}">
                            ${ed.startDate} ~
                            <c:choose>
																<c:when test="${not empty ed.endDate}">${ed.endDate}</c:when>
																<c:otherwise>현재</c:otherwise>
															</c:choose>
														</c:if>
													</div>
												</div>
												<c:if test="${not empty ed.major}">
													<p class="desc clamp2">${ed.major}</p>
												</c:if>
												<c:if test="${not empty ed.status}">
													<div class="item-sub">
														<span class="pill">${ed.status}</span>
													</div>
												</c:if>
											</div>
										</c:if>
									</c:forEach>
								</div>

								<div class="right" style="padding-left: 6mm;">
									<h2>Certifications</h2>
									<c:forEach var="c" items="${resume.certificationItems}"
										varStatus="cst">
										<c:if test="${cst.index lt 5}">
											<div class="item">
												<div class="item-top">
													<div class="item-title">${c.certi_name}</div>
													<div class="item-meta">
														<c:if test="${not empty c.deadline}">${c.deadline}</c:if>
													</div>
												</div>
												<c:if test="${not empty c.organizer}">
													<p class="desc clamp2">${c.organizer}</p>
												</c:if>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</body>
</html>