<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="pageTitle" value="StackUp | My Portfolio" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:set var="selectedPortfolioId" value="" />
<c:forEach var="fp" items="${portfolios}" begin="0" end="0">
	<c:set var="selectedPortfolioId" value="${fp.portfolioId}" />
</c:forEach>

<style>
.portfolio-dashboard-wrap {
	max-width: 1400px;
	margin: 15px auto 60px auto;
}

.portfolio-grid {
	display: flex;
	gap: 24px;
	align-items: flex-start;
}

.portfolio-left {
	flex: 0 0 63.5%;
}

.portfolio-right {
	flex: 0 0 35%;
}

.panel-card {
	border: 1px solid #e5e5e5;
	border-radius: 14px;
	overflow: hidden;
	background: #fff;
	margin-bottom: 20px;
}

.panel-head {
	padding: 14px 16px;
	border-bottom: 1px solid #eee;
	background: #fafafa;
	font-weight: 700;
}

.resume-preview-wrap {
	padding: 22px 22px 28px 22px;
	overflow: visible;
}

.resume-preview-grid {
	display: flex;
	gap: 24px;
	align-items: flex-start;
}

.resume-left-col {
	width: 32%;
	border-right: 1px solid #ececec;
	padding-right: 18px;
}

.resume-right-col {
	width: 68%;
}

.resume-name {
	font-size: 2rem;
	font-weight: 800;
	line-height: 1.1;
	margin: 0 0 10px 0;
}

.resume-headline {
	font-size: 1.1rem;
	color: #555;
	margin-bottom: 24px;
}

.resume-block {
	margin-bottom: 24px;
}

.resume-label {
	font-size: 0.9rem;
	color: #777;
	font-weight: 700;
	letter-spacing: 0.08em;
	text-transform: uppercase;
	margin-bottom: 10px;
}

.resume-contact-item, .resume-link-item {
	margin-bottom: 8px;
	font-size: 0.95rem;
	color: #333;
	word-break: break-word;
}

.resume-badges {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
}

.resume-badge {
	display: inline-block;
	border: 1px solid #e2e2e2;
	border-radius: 999px;
	padding: 6px 12px;
	background: #fafafa;
	font-size: 0.9rem;
}

.resume-summary {
	font-size: 0.95rem;
	line-height: 1.65;
	color: #333;
	white-space: pre-line;
}

.resume-section-title {
	font-size: 1.35rem;
	font-weight: 800;
	margin: 0 0 14px 0;
}

.resume-item {
	border-bottom: 1px solid #f0f0f0;
	padding-bottom: 14px;
	margin-bottom: 14px;
}

.resume-item:last-child {
	border-bottom: none;
	margin-bottom: 0;
}

.resume-item-top {
	display: flex;
	justify-content: space-between;
	gap: 12px;
	align-items: flex-start;
}

.resume-item-title {
	font-weight: 800;
	font-size: 1rem;
}

.resume-item-meta {
	color: #777;
	font-size: 0.9rem;
	white-space: nowrap;
}

.resume-item-sub {
	margin-top: 4px;
	color: #666;
	font-size: 0.93rem;
}

.resume-item-desc {
	margin-top: 8px;
	color: #333;
	line-height: 1.55;
	font-size: 0.94rem;
	white-space: pre-line;
}

.resume-item-desc-line {
	margin-top: 8px;
	color: #333;
	line-height: 1.55;
	font-size: 0.94rem;
}

.resume-item-label {
	display: inline-block;
	min-width: 110px;
	font-weight: 700;
	color: #222;
	vertical-align: top;
}

.resume-item-value {
	display: inline-block;
	color: #333;
	word-break: break-word;
}

.resume-item-bullets {
	margin: 8px 0 0 18px;
	padding: 0;
}

.resume-item-bullets li {
	margin-bottom: 6px;
	line-height: 1.5;
	font-size: 0.93rem;
}

.resume-bottom-grid {
	display: flex;
	gap: 20px;
	margin-top: 10px;
}

.resume-bottom-col {
	flex: 1;
	min-width: 0;
}

.preview-tabs {
	display: flex;
	gap: 8px;
	margin-bottom: 14px;
}

.preview-tab-btn {
	border: 1px solid #d8d8d8;
	background: #fff;
	border-radius: 999px;
	padding: 7px 14px;
	font-size: 0.92rem;
	font-weight: 700;
	cursor: pointer;
}

.preview-tab-btn.active {
	background: #84c400;
	color: #fff;
	border-color: #84c400;
}

.preview-pane {
	display: none;
}

.preview-pane.active {
	display: block;
}

.thumb-frame {
	position: relative;
	width: 100%;
	max-width: 430px;
	min-height: 240px;
	margin-bottom: 14px;
}

.thumb-img {
	width: 100%;
	display: block;
	border: 1px solid #ddd;
	border-radius: 10px;
	background: #fff;
}

.thumb-fallback {
	display: none;
	width: 100%;
	min-height: 240px;
	border: 1px dashed #d0d0d0;
	border-radius: 10px;
	align-items: center;
	justify-content: center;
	text-align: center;
	padding: 18px;
	color: #777;
	background: #fafafa;
}

.portfolio-card-section {
	padding: 18px;
}

.portfolio-card-top {
	padding: 16px 18px;
	border-bottom: 1px solid #eee;
	background: #fafafa;
}

.portfolio-title {
	font-size: 1.1rem;
	font-weight: 800;
	margin-bottom: 4px;
}

.portfolio-meta {
	font-size: 0.92rem;
	color: #666;
}

.portfolio-version {
	margin-top: 10px;
	font-size: 0.9rem;
	color: #444;
}

.action-row {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

.resume-empty {
	color: #999;
	font-size: 0.94rem;
	line-height: 1.5;
	padding: 4px 0;
}

.edit-section-box {
	border: 1px solid #ededed;
	border-radius: 12px;
	padding: 14px;
	background: #fcfcfc;
	margin-bottom: 14px;
}

.edit-mode .form-control {
	font-size: 0.95rem;
}

.editor-add-btn {
	margin-top: 8px;
}

.editor-remove-btn {
	margin-top: 10px;
}

@media ( max-width : 1100px) {
	.portfolio-grid {
		flex-direction: column;
	}
	.portfolio-left, .portfolio-right {
		flex: 1 1 100%;
		width: 100%;
	}
	.resume-preview-grid {
		flex-direction: column;
	}
	.resume-left-col, .resume-right-col {
		width: 100%;
		padding-right: 0;
		border-right: none;
	}
	.resume-bottom-grid {
		flex-direction: column;
	}
}
</style>

<div class="container-fluid page-header py-5"
	style="background-image: none; background-color: #FAF7F0;">
	<h1 class="text-center display-6" style="color: #333;">포트폴리오</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="main.do">Home</a></li>
		<li class="breadcrumb-item active text-black">Portfolio</li>
	</ol>
</div>

<div class="portfolio-dashboard-wrap">

	<div
		style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
		<c:if test="${empty portfolios}">
			<form method="post"
				action="<c:url value='/portfolio/createResumePortfolio.do'/>"
				style="margin: 0;">
				<button type="submit" class="btn btn-primary">레쥬메 포트폴리오 만들기</button>
			</form>
		</c:if>
	</div>

	<div class="portfolio-grid">

		<div class="portfolio-left">
			<div class="panel-card">

				<div class="panel-head"
					style="display: flex; justify-content: space-between; align-items: center;">
					<span>레쥬메 정보 미리보기</span>

					<c:if test="${not empty resume and not empty selectedPortfolioId}">
						<div class="action-row" style="margin: 0;">
							<button type="button" class="btn btn-sm btn-outline-primary"
								id="editResumeBtn" onclick="toggleResumeEdit(true)">수정</button>

							<button type="button" class="btn btn-sm btn-success"
								id="saveResumeBtn" style="display: none;"
								onclick="saveResumeSnapshot(${selectedPortfolioId})">저장</button>

							<button type="button" class="btn btn-sm btn-outline-secondary"
								id="cancelResumeBtn" style="display: none;"
								onclick="cancelResumeEdit()">취소</button>
						</div>
					</c:if>
				</div>

				<c:choose>
					<c:when test="${empty resume}">
						<div style="padding: 28px 22px;">
							<h3
								style="margin: 0 0 10px 0; font-size: 1.4rem; font-weight: 800;">저장된
								레쥬메가 없어요</h3>
							<p style="margin: 0; color: #666; line-height: 1.6;">먼저 스냅샷
								데이터가 있어야 왼쪽에 레쥬메 정보가 표시돼요.</p>
						</div>
					</c:when>

					<c:otherwise>
						<div class="resume-preview-wrap">
							<div class="resume-preview-grid">

								<div class="resume-left-col">

									<h1 class="resume-name view-mode">
										<c:out value="${resume.name}" />
									</h1>
									<input type="text" class="form-control edit-mode"
										id="resume-name" value="${fn:escapeXml(resume.name)}"
										style="display: none; margin-bottom: 10px;" />

									<c:choose>
										<c:when test="${not empty resume.headline}">
											<div class="resume-headline view-mode">
												<c:out value="${resume.headline}" />
											</div>
										</c:when>
										<c:otherwise>
											<div class="resume-empty view-mode">등록된 헤드라인이 없습니다.</div>
										</c:otherwise>
									</c:choose>
									<input type="text" class="form-control edit-mode"
										id="resume-headline" value="${fn:escapeXml(resume.headline)}"
										style="display: none; margin-bottom: 24px;" placeholder="헤드라인" />

									<%-- 	<div class="resume-block">
										<div class="resume-label">Contact</div>

										<div class="view-mode">
											<c:choose>
												<c:when
													test="${not empty resume.email or not empty resume.phone or not empty resume.location}">
													<c:if test="${not empty resume.email}">
														<div class="resume-contact-item">
															<c:out value="${resume.email}" />
														</div>
													</c:if>
													<c:if test="${not empty resume.phone}">
														<div class="resume-contact-item">
															<c:out value="${resume.phone}" />
														</div>
													</c:if>
													<c:if test="${not empty resume.location}">
														<div class="resume-contact-item">
															<c:out value="${resume.location}" />
														</div>
													</c:if>
												</c:when>
												<c:otherwise>
													<div class="resume-empty">등록된 연락처가 없습니다.</div>
												</c:otherwise>
											</c:choose>
										</div>

										<div class="edit-mode" style="display:none;">
											<input type="text" class="form-control mb-2" id="resume-email"
												value="${fn:escapeXml(resume.email)}" placeholder="이메일" />
											<input type="text" class="form-control mb-2" id="resume-phone"
												value="${fn:escapeXml(resume.phone)}" placeholder="전화번호" />
											<input type="text" class="form-control"
												id="resume-location"
												value="${fn:escapeXml(resume.location)}" placeholder="위치" />
										</div>
									</div> --%>
						<div class="view-mode">
							<c:choose>
								<c:when test="${not empty resume.projects}">
									<c:forEach var="p" items="${resume.projects}">
										<div class="resume-item">
											<div class="resume-item-desc-line">
												<span class="resume-item-label">프로젝트명 :</span>
												<span class="resume-item-value"><c:out value="${p.title}" /></span>
											</div>

											<c:if test="${not empty p.period}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">기간 :</span>
													<span class="resume-item-value"><c:out value="${p.period}" /></span>
												</div>
											</c:if>

											<c:if test="${not empty p.role}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">역할 :</span>
													<span class="resume-item-value"><c:out value="${p.role}" /></span>
												</div>
											</c:if>

											<c:if test="${not empty p.oneLine}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">한 줄 소개 :</span>
													<span class="resume-item-value"><c:out value="${p.oneLine}" /></span>
												</div>
											</c:if>

											<c:if test="${not empty p.highlights}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">프로젝트 소개 :</span>
												</div>
												<ul class="resume-item-bullets">
													<c:forEach var="h" items="${p.highlights}">
														<li><c:out value="${h}" /></li>
													</c:forEach>
												</ul>
											</c:if>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="resume-empty">등록된 프로젝트가 없습니다.</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="edit-mode" id="projects-editor"
											style="display: none;">
											<c:choose>
												<c:when test="${not empty resume.projects}">
													<c:forEach var="p" items="${resume.projects}">
														<div class="edit-section-box project-row">
															<input type="text"
																class="form-control mb-2 project-title"
																value="${fn:escapeXml(p.title)}" placeholder="프로젝트명" />
															<input type="text"
																class="form-control mb-2 project-period"
																value="${fn:escapeXml(p.period)}" placeholder="기간" /> <input
																type="text" class="form-control mb-2 project-role"
																value="${fn:escapeXml(p.role)}" placeholder="역할" />
															<textarea class="form-control mb-2 project-oneline"
																rows="2" placeholder="한 줄 소개">${fn:escapeXml(p.oneLine)}</textarea>
															<textarea class="form-control mb-2 project-highlights"
																rows="4" placeholder="프로젝트 소개"><c:if
																	test="${not empty p.highlights}">
																	<c:forEach var="h" items="${p.highlights}"
																		varStatus="hst">${fn:escapeXml(h)}<c:if
																			test="${!hst.last}">
</c:if>
																	</c:forEach>
																</c:if></textarea>
															<button type="button"
																class="btn btn-sm btn-outline-danger editor-remove-btn"
																onclick="removeEditorRow(this)">삭제</button>
														</div>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<div class="edit-section-box project-row">
														<input type="text" class="form-control mb-2 project-title"
															placeholder="프로젝트명" /> <input type="text"
															class="form-control mb-2 project-period" placeholder="기간" />
														<input type="text" class="form-control mb-2 project-role"
															placeholder="역할" />
														<textarea class="form-control mb-2 project-oneline"
															rows="2" placeholder="한 줄 소개"></textarea>
														<textarea class="form-control mb-2 project-highlights"
															rows="4" placeholder="프로젝트 소개"></textarea>
														<button type="button"
															class="btn btn-sm btn-outline-danger editor-remove-btn"
															onclick="removeEditorRow(this)">삭제</button>
													</div>
												</c:otherwise>
											</c:choose>

											<button type="button"
												class="btn btn-sm btn-outline-secondary editor-add-btn"
												onclick="addProjectRow()">프로젝트 추가</button>
										</div>
									</div>

									<div class="resume-block">
										<h3 class="resume-section-title">Experience</h3>

										<%-- <div class="view-mode">
											<c:choose>
												<c:when test="${not empty resume.experience}">
													<c:forEach var="e" items="${resume.experience}">
														<div class="resume-item">
															<div class="resume-item-top">
																<div class="resume-item-title">
																	<c:out value="${e.title}" />
																</div>
																<div class="resume-item-meta">
																	<c:out value="${e.period}" />
																</div>
															</div>

															<c:if test="${not empty e.company}">
																<div class="resume-item-sub">
																	<c:out value="${e.company}" />
																</div>
															</c:if>

															<c:if test="${not empty e.description}">
																<ul class="resume-item-bullets">
																	<c:forEach var="d" items="${e.description}">
																		<li><c:out value="${d}" /></li>
																	</c:forEach>
																</ul>
															</c:if>
														</div>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<div class="resume-empty">등록된 경력이 없습니다.</div>
												</c:otherwise>
											</c:choose>
										</div> --%>
										<div class="view-mode">
							<c:choose>
								<c:when test="${not empty resume.experience}">
									<c:forEach var="e" items="${resume.experience}">
										<div class="resume-item">
											<div class="resume-item-desc-line">
												<span class="resume-item-label">직무명 :</span>
												<span class="resume-item-value"><c:out value="${e.title}" /></span>
											</div>

											<c:if test="${not empty e.company}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">회사명 :</span>
													<span class="resume-item-value"><c:out value="${e.company}" /></span>
												</div>
											</c:if>

											<c:if test="${not empty e.period}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">기간 :</span>
													<span class="resume-item-value"><c:out value="${e.period}" /></span>
												</div>
											</c:if>

											<c:if test="${not empty e.description}">
												<div class="resume-item-desc-line">
													<span class="resume-item-label">업무 내용 :</span>
												</div>
												<ul class="resume-item-bullets">
													<c:forEach var="d" items="${e.description}">
														<li><c:out value="${d}" /></li>
													</c:forEach>
												</ul>
											</c:if>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="resume-empty">등록된 경력이 없습니다.</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="edit-mode" id="experience-editor"
											style="display: none;">
											<c:choose>
												<c:when test="${not empty resume.experience}">
													<c:forEach var="e" items="${resume.experience}">
														<div class="edit-section-box experience-row">
															<input type="text" class="form-control mb-2 exp-title"
																value="${fn:escapeXml(e.title)}" placeholder="직무명" /> <input
																type="text" class="form-control mb-2 exp-company"
																value="${fn:escapeXml(e.company)}" placeholder="회사명" />
															<input type="text" class="form-control mb-2 exp-period"
																value="${fn:escapeXml(e.period)}" placeholder="기간" />
															<textarea class="form-control mb-2 exp-description"
																rows="4" placeholder="업무 내용(줄바꿈으로 구분)"><c:if
																	test="${not empty e.description}">
																	<c:forEach var="d" items="${e.description}"
																		varStatus="dst">${fn:escapeXml(d)}<c:if
																			test="${!dst.last}">
</c:if>
																	</c:forEach>
																</c:if></textarea>
															<button type="button"
																class="btn btn-sm btn-outline-danger editor-remove-btn"
																onclick="removeEditorRow(this)">삭제</button>
														</div>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<div class="edit-section-box experience-row">
														<input type="text" class="form-control mb-2 exp-title"
															placeholder="직무명" /> <input type="text"
															class="form-control mb-2 exp-company" placeholder="회사명" />
														<input type="text" class="form-control mb-2 exp-period"
															placeholder="기간" />
														<textarea class="form-control mb-2 exp-description"
															rows="4" placeholder="업무 내용(줄바꿈으로 구분)"></textarea>
														<button type="button"
															class="btn btn-sm btn-outline-danger editor-remove-btn"
															onclick="removeEditorRow(this)">삭제</button>
													</div>
												</c:otherwise>
											</c:choose>

											<button type="button"
												class="btn btn-sm btn-outline-secondary editor-add-btn"
												onclick="addExperienceRow()">경력 추가</button>
										</div>
									</div>

									<div class="resume-bottom-grid">

										<div class="resume-bottom-col">
											<div class="resume-block">
												<h3 class="resume-section-title">Education</h3>

												<%-- <div class="view-mode">
													<c:choose>
														<c:when test="${not empty resume.education}">
															<c:forEach var="ed" items="${resume.education}">
																<div class="resume-item">
																	<div class="resume-item-top">
																		<div class="resume-item-title">
																			<c:out value="${ed.degree}" />
																		</div>
																		<div class="resume-item-meta">
																			<c:out value="${ed.startDate}" />
																			<c:if test="${not empty ed.endDate}">
																				~ <c:out value="${ed.endDate}" />
																			</c:if>
																		</div>
																	</div>

																	<c:if test="${not empty ed.school}">
																		<div class="resume-item-sub">
																			<c:out value="${ed.school}" />
																		</div>
																	</c:if>

																	<c:if test="${not empty ed.major}">
																		<div class="resume-item-desc">
																			<c:out value="${ed.major}" />
																		</div>
																	</c:if>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="resume-empty">등록된 학력이 없습니다.</div>
														</c:otherwise>
													</c:choose>
												</div> --%>
												<div class="view-mode">
													<c:choose>
														<c:when test="${not empty resume.education}">
															<c:forEach var="ed" items="${resume.education}">
																<div class="resume-item">
																	<div class="resume-item-desc-line">
																		<span class="resume-item-label">학위 :</span>
																		<span class="resume-item-value"><c:out value="${ed.degree}" /></span>
																	</div>

																	<c:if test="${not empty ed.school}">
																		<div class="resume-item-desc-line">
																			<span class="resume-item-label">학교명 :</span>
																			<span class="resume-item-value"><c:out value="${ed.school}" /></span>
																		</div>
																	</c:if>

																	<c:if test="${not empty ed.major}">
																		<div class="resume-item-desc-line">
																			<span class="resume-item-label">전공 :</span>
																			<span class="resume-item-value"><c:out value="${ed.major}" /></span>
																		</div>
																	</c:if>

																	<c:if test="${not empty ed.startDate or not empty ed.endDate}">
																		<div class="resume-item-desc-line">
																			<span class="resume-item-label">기간 :</span>
																			<span class="resume-item-value"><c:if test="${not empty ed.startDate}"><c:out value="${ed.startDate}" /></c:if><c:if test="${not empty ed.endDate}"> ~ <c:out value="${ed.endDate}" /></c:if></span>
																		</div>
																	</c:if>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="resume-empty">등록된 학력이 없습니다.</div>
														</c:otherwise>
													</c:choose>
												</div>
												<div class="edit-mode" id="education-editor"
													style="display: none;">
													<c:choose>
														<c:when test="${not empty resume.education}">
															<c:forEach var="ed" items="${resume.education}">
																<div class="edit-section-box education-row">
																	<input type="text" class="form-control mb-2 edu-degree"
																		value="${fn:escapeXml(ed.degree)}" placeholder="학위" />
																	<input type="text" class="form-control mb-2 edu-school"
																		value="${fn:escapeXml(ed.school)}" placeholder="학교명" />
																	<input type="text" class="form-control mb-2 edu-major"
																		value="${fn:escapeXml(ed.major)}" placeholder="전공" />
																	<input type="text" class="form-control mb-2 edu-start"
																		value="${fn:escapeXml(ed.startDate)}"
																		placeholder="시작일" /> <input type="text"
																		class="form-control mb-2 edu-end"
																		value="${fn:escapeXml(ed.endDate)}" placeholder="종료일" />
																	<button type="button"
																		class="btn btn-sm btn-outline-danger editor-remove-btn"
																		onclick="removeEditorRow(this)">삭제</button>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="edit-section-box education-row">
																<input type="text" class="form-control mb-2 edu-degree"
																	placeholder="학위" /> <input type="text"
																	class="form-control mb-2 edu-school" placeholder="학교명" />
																<input type="text" class="form-control mb-2 edu-major"
																	placeholder="전공" /> <input type="text"
																	class="form-control mb-2 edu-start" placeholder="시작일" />
																<input type="text" class="form-control mb-2 edu-end"
																	placeholder="종료일" />
																<button type="button"
																	class="btn btn-sm btn-outline-danger editor-remove-btn"
																	onclick="removeEditorRow(this)">삭제</button>
															</div>
														</c:otherwise>
													</c:choose>

													<button type="button"
														class="btn btn-sm btn-outline-secondary editor-add-btn"
														onclick="addEducationRow()">학력 추가</button>
												</div>
											</div>
										</div>

										<div class="resume-bottom-col">
											<div class="resume-block">
												<h3 class="resume-section-title">Certifications</h3>

												<%-- <div class="view-mode">
													<c:choose>
														<c:when test="${not empty resume.certificationItems}">
															<c:forEach var="c" items="${resume.certificationItems}">
																<div class="resume-item">
																	<div class="resume-item-title">
																		<c:out value="${c.certi_name}" />
																	</div>
																	<c:if test="${not empty c.organizer}">
																		<div class="resume-item-sub">
																			<c:out value="${c.organizer}" />
																		</div>
																	</c:if>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="resume-empty">등록된 자격증이 없습니다.</div>
														</c:otherwise>
													</c:choose>
												</div>--%>
												
												<div class="view-mode">
													<c:choose>
														<c:when test="${not empty resume.certificationItems}">
															<c:forEach var="c" items="${resume.certificationItems}">
																<div class="resume-item">
																	<div class="resume-item-desc-line">
																		<span class="resume-item-label">자격증명 :</span>
																		<span class="resume-item-value"><c:out value="${c.certi_name}" /></span>
																	</div>

																	<c:if test="${not empty c.organizer}">
																		<div class="resume-item-desc-line">
																			<span class="resume-item-label">주최기관 :</span>
																			<span class="resume-item-value"><c:out value="${c.organizer}" /></span>
																		</div>
																	</c:if>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="resume-empty">등록된 자격증이 없습니다.</div>
														</c:otherwise>
													</c:choose>
												</div>
												<div class="edit-mode" id="certifications-editor"
													style="display: none;">
													<c:choose>
														<c:when test="${not empty resume.certificationItems}">
															<c:forEach var="c" items="${resume.certificationItems}">
																<div class="edit-section-box cert-row">
																	<input type="text" class="form-control mb-2 cert-name"
																		value="${fn:escapeXml(c.certi_name)}"
																		placeholder="자격증명" /> <input type="text"
																		class="form-control mb-2 cert-org"
																		value="${fn:escapeXml(c.organizer)}"
																		placeholder="주최기관" />
																	<button type="button"
																		class="btn btn-sm btn-outline-danger editor-remove-btn"
																		onclick="removeEditorRow(this)">삭제</button>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="edit-section-box cert-row">
																<input type="text" class="form-control mb-2 cert-name"
																	placeholder="자격증명" /> <input type="text"
																	class="form-control mb-2 cert-org" placeholder="주최기관" />
																<button type="button"
																	class="btn btn-sm btn-outline-danger editor-remove-btn"
																	onclick="removeEditorRow(this)">삭제</button>
															</div>
														</c:otherwise>
													</c:choose>

													<button type="button"
														class="btn btn-sm btn-outline-secondary editor-add-btn"
														onclick="addCertificationRow()">자격증 추가</button>
												</div>
											</div>
										</div>

									</div>

								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="portfolio-right">
			<c:choose>
				<c:when test="${empty portfolios}">
					<div class="panel-card">
						<div class="panel-head">포트폴리오 생성</div>

						<div style="padding: 24px 20px;">
							<div
								style="font-size: 1.15rem; font-weight: 800; margin-bottom: 8px;">
								아직 포트폴리오가 없어요</div>
							<p style="margin: 0 0 16px 0; color: #666; line-height: 1.6;">
								1장 레쥬메 포트폴리오를 먼저 생성하면, 여기서 미니멀/디자인 PDF를 만들 수 있어요.</p>

							<form method="post"
								action="<c:url value='/portfolio/createResumePortfolio.do'/>">
								<button type="submit" class="btn btn-primary">레쥬메 포트폴리오
									만들기</button>
							</form>
						</div>
					</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="p" items="${portfolios}">
						<div class="panel-card">

							<div class="portfolio-card-top">
								<div class="portfolio-title">${p.title}</div>
								<div class="portfolio-meta">
									template: <b>${p.templateCode}</b> | status: <b>${p.status}</b>
									<form method="post"
										action="<c:url value='/portfolio/snapshot/save.do'/>"
										style="margin-top: 12px;">
										<button type="submit" class="btn btn-sm btn-success">현재
											정보로 새 버전 저장</button>
									</form>
								</div>
								<div class="portfolio-version">
									버전: <b><c:out value="${versionCountMap[p.portfolioId]}" /></b>개
									<c:if test="${not empty latestMap[p.portfolioId]}">
										<span style="color: #666;">(최신:
											${latestMap[p.portfolioId].createdAt})</span>
									</c:if>
								</div>
								<div style="margin-top: 12px;">
									<form method="post"
										action="<c:url value='/portfolio/snapshot/save.do'/>"
										style="margin: 0;">
										<button type="submit" class="btn btn-sm btn-success">정보
											업데이트</button>
									</form>
								</div>
							</div>

							<div class="portfolio-card-section">
								<div class="preview-tabs">
									<button type="button" class="preview-tab-btn active"
										onclick="showPreview(${p.portfolioId}, 'minimal', this)">미니멀</button>
									<button type="button" class="preview-tab-btn"
										onclick="showPreview(${p.portfolioId}, 'design', this)">디자인</button>
								</div>

								<div id="preview-minimal-${p.portfolioId}"
									class="preview-pane active">
									<div class="thumb-frame">
										<img
											src="<c:url value='/portfolio/file/thumb.do?portfolioId=${p.portfolioId}&templateType=minimal'/>"
											alt="minimal thumb" class="thumb-img"
											onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
										<div class="thumb-fallback">
											<div>
												<div style="font-weight: 800; margin-bottom: 6px;">아직
													생성된 미니멀 PDF가 없어요</div>
												<div style="font-size: 0.92rem;">아래 버튼으로 먼저 생성해주세요.</div>
											</div>
										</div>
									</div>

									<div class="action-row">
										<form method="post"
											action="<c:url value='/portfolio/export/pdf.do'/>"
											style="margin: 0;">
											<input type="hidden" name="portfolioId"
												value="${p.portfolioId}" /> <input type="hidden"
												name="templateType" value="minimal" />
											<button type="submit" class="btn btn-sm btn-primary">미니멀
												PDF 생성</button>
										</form>

										<a class="btn btn-sm btn-outline-dark" target="_blank"
											href="<c:url value='/portfolio/file/pdf.do?portfolioId=${p.portfolioId}&templateType=minimal'/>">
											미니멀 PDF 보기 </a>
									</div>
								</div>

								<div id="preview-design-${p.portfolioId}" class="preview-pane">
									<div class="thumb-frame">
										<img
											src="<c:url value='/portfolio/file/thumb.do?portfolioId=${p.portfolioId}&templateType=design'/>"
											alt="design thumb" class="thumb-img"
											onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
										<div class="thumb-fallback">
											<div>
												<div style="font-weight: 800; margin-bottom: 6px;">아직
													생성된 디자인 PDF가 없어요</div>
												<div style="font-size: 0.92rem;">아래 버튼으로 먼저 생성해주세요.</div>
											</div>
										</div>
									</div>

									<div class="action-row">
										<form method="post"
											action="<c:url value='/portfolio/export/pdf.do'/>"
											style="margin: 0;">
											<input type="hidden" name="portfolioId"
												value="${p.portfolioId}" /> <input type="hidden"
												name="templateType" value="design" />
											<button type="submit" class="btn btn-sm btn-dark">디자인
												PDF 생성</button>
										</form>

										<a class="btn btn-sm btn-outline-dark" target="_blank"
											href="<c:url value='/portfolio/file/pdf.do?portfolioId=${p.portfolioId}&templateType=design'/>">
											디자인 PDF 보기 </a>
									</div>
								</div>

							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>

	</div>
</div>

<script>
	const initialResumeState = {};

	document.addEventListener('DOMContentLoaded', function() {
		cacheInitialResumeState();
	});

	function showPreview(portfolioId, type, btn) {
		const minimalPane = document.getElementById('preview-minimal-' + portfolioId);
		const designPane = document.getElementById('preview-design-' + portfolioId);

		if (!minimalPane || !designPane)
			return;

		minimalPane.classList.remove('active');
		designPane.classList.remove('active');

		if (type === 'minimal') {
			minimalPane.classList.add('active');
		} else {
			designPane.classList.add('active');
		}

		const btnGroup = btn.parentElement.querySelectorAll('.preview-tab-btn');
		btnGroup.forEach(function(el) {
			el.classList.remove('active');
		});
		btn.classList.add('active');
	}

	function toggleResumeEdit(editMode) {
		document.querySelectorAll('.view-mode').forEach(function(el) {
			el.style.display = editMode ? 'none' : '';
		});

		document.querySelectorAll('.edit-mode').forEach(function(el) {
			el.style.display = editMode ? '' : 'none';
		});

		const editBtn = document.getElementById('editResumeBtn');
		const saveBtn = document.getElementById('saveResumeBtn');
		const cancelBtn = document.getElementById('cancelResumeBtn');

		if (editBtn)
			editBtn.style.display = editMode ? 'none' : '';
		if (saveBtn)
			saveBtn.style.display = editMode ? '' : 'none';
		if (cancelBtn)
			cancelBtn.style.display = editMode ? '' : 'none';
	}

	function cacheInitialResumeState() {
		try {
			initialResumeState.value = JSON.stringify(collectResumeJson());
		} catch (e) {
			console.error(e);
		}
	}

	function cancelResumeEdit() {
		if (initialResumeState.value) {
			try {
				restoreResumeJson(JSON.parse(initialResumeState.value));
			} catch (e) {
				console.error(e);
			}
		}
		toggleResumeEdit(false);
	}

	function removeEditorRow(btn) {
		const row = btn.closest('.link-row, .project-row, .experience-row, .education-row, .cert-row');
		if (row)
			row.remove();
	}

	function escapeHtml(value) {
		return (value || '').replace(/&/g, '&amp;').replace(/</g, '&lt;')
				.replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g,
						'&#39;');
	}

	function splitLines(value) {
		if (!value)
			return [];
		return value.split('\n').map(function(v) {
			return v.trim();
		}).filter(function(v) {
			return v !== '';
		});
	}

	function splitLinesOrComma(value) {
		if (!value)
			return [];
		return value.split(/\n|,/).map(function(v) {
			return v.trim();
		}).filter(function(v) {
			return v !== '';
		});
	}

	function joinLines(arr) {
		return (arr || []).join('\n');
	}

	function addLinkRow() {
		const html = ''
				+ '<div class="edit-section-box link-row">'
				+ '<input type="text" class="form-control mb-2 link-label" placeholder="라벨" />'
				+ '<input type="text" class="form-control mb-2 link-url" placeholder="URL" />'
				+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
				+ '</div>';
		document.getElementById('links-editor').insertAdjacentHTML('beforeend',
				html);
	}

	function addProjectRow() {
		const html = ''
				+ '<div class="edit-section-box project-row">'
				+ '<input type="text" class="form-control mb-2 project-title" placeholder="프로젝트명" />'
				+ '<input type="text" class="form-control mb-2 project-period" placeholder="기간" />'
				+ '<input type="text" class="form-control mb-2 project-role" placeholder="역할" />'
				+ '<textarea class="form-control mb-2 project-oneline" rows="2" placeholder="한 줄 소개"></textarea>'
				+ '<textarea class="form-control mb-2 project-highlights" rows="4" placeholder="하이라이트(줄바꿈으로 구분)"></textarea>'
				+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
				+ '</div>';
		document.getElementById('projects-editor').insertAdjacentHTML(
				'beforeend', html);
	}

	function addExperienceRow() {
		const html = ''
				+ '<div class="edit-section-box experience-row">'
				+ '<input type="text" class="form-control mb-2 exp-title" placeholder="직무명" />'
				+ '<input type="text" class="form-control mb-2 exp-company" placeholder="회사명" />'
				+ '<input type="text" class="form-control mb-2 exp-period" placeholder="기간" />'
				+ '<textarea class="form-control mb-2 exp-description" rows="4" placeholder="업무 내용(줄바꿈으로 구분)"></textarea>'
				+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
				+ '</div>';
		document.getElementById('experience-editor').insertAdjacentHTML(
				'beforeend', html);
	}

	function addEducationRow() {
		const html = ''
				+ '<div class="edit-section-box education-row">'
				+ '<input type="text" class="form-control mb-2 edu-degree" placeholder="학위" />'
				+ '<input type="text" class="form-control mb-2 edu-school" placeholder="학교명" />'
				+ '<input type="text" class="form-control mb-2 edu-major" placeholder="전공" />'
				+ '<input type="text" class="form-control mb-2 edu-start" placeholder="시작일" />'
				+ '<input type="text" class="form-control mb-2 edu-end" placeholder="종료일" />'
				+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
				+ '</div>';
		document.getElementById('education-editor').insertAdjacentHTML(
				'beforeend', html);
	}

	function addCertificationRow() {
		const html = ''
				+ '<div class="edit-section-box cert-row">'
				+ '<input type="text" class="form-control mb-2 cert-name" placeholder="자격증명" />'
				+ '<input type="text" class="form-control mb-2 cert-org" placeholder="주최기관" />'
				+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
				+ '</div>';
		document.getElementById('certifications-editor').insertAdjacentHTML(
				'beforeend', html);
	}

	function collectResumeJson() {
		const socialLinks = [];
		const projects = [];
		const experience = [];
		const education = [];
		const certificationItems = [];

		const linksEditor = document.getElementById('links-editor');
		if (linksEditor) {
			linksEditor.querySelectorAll('.link-row').forEach(function(row) {
				const label = row.querySelector('.link-label')?.value?.trim() || '';
				const url = row.querySelector('.link-url')?.value?.trim() || '';
				if (label || url) {
					socialLinks.push({
						label : label,
						url : url
					});
				}
			});
		}

		const projectsEditor = document.getElementById('projects-editor');
		if (projectsEditor) {
			projectsEditor.querySelectorAll('.project-row').forEach(function(row) {
				const title = row.querySelector('.project-title')?.value?.trim()
						|| '';
				const period = row.querySelector('.project-period')?.value?.trim()
						|| '';
				const role = row.querySelector('.project-role')?.value?.trim() || '';
				const oneLine = row.querySelector('.project-oneline')?.value?.trim()
						|| '';
				const highlights = splitLines(row.querySelector('.project-highlights')?.value || '');
				if (title || period || role || oneLine || highlights.length > 0) {
					projects.push({
						title : title,
						period : period,
						role : role,
						oneLine : oneLine,
						highlights : highlights
					});
				}
			});
		}

		const experienceEditor = document.getElementById('experience-editor');
		if (experienceEditor) {
			experienceEditor.querySelectorAll('.experience-row').forEach(
					function(row) {
						const title = row.querySelector('.exp-title')?.value?.trim()
								|| '';
						const company = row.querySelector('.exp-company')?.value?.trim()
								|| '';
						const period = row.querySelector('.exp-period')?.value?.trim()
								|| '';
						const description = splitLines(row.querySelector('.exp-description')?.value || '');
						if (title || company || period || description.length > 0) {
							experience.push({
								title : title,
								company : company,
								period : period,
								description : description
							});
						}
					});
		}

		const educationEditor = document.getElementById('education-editor');
		if (educationEditor) {
			educationEditor.querySelectorAll('.education-row').forEach(function(row) {
				const degree = row.querySelector('.edu-degree')?.value?.trim() || '';
				const school = row.querySelector('.edu-school')?.value?.trim() || '';
				const major = row.querySelector('.edu-major')?.value?.trim() || '';
				const startDate = row.querySelector('.edu-start')?.value?.trim()
						|| '';
				const endDate = row.querySelector('.edu-end')?.value?.trim() || '';
				if (degree || school || major || startDate || endDate) {
					education.push({
						degree : degree,
						school : school,
						major : major,
						startDate : startDate,
						endDate : endDate
					});
				}
			});
		}

		const certEditor = document.getElementById('certifications-editor');
		if (certEditor) {
			certEditor.querySelectorAll('.cert-row').forEach(function(row) {
				const certi_name = row.querySelector('.cert-name')?.value?.trim()
						|| '';
				const organizer = row.querySelector('.cert-org')?.value?.trim()
						|| '';
				if (certi_name || organizer) {
					certificationItems.push({
						certi_name : certi_name,
						organizer : organizer
					});
				}
			});
		}

		return {
			name : document.getElementById('resume-name')?.value?.trim() || '',
			headline : document.getElementById('resume-headline')?.value?.trim()
					|| '',
			email : document.getElementById('resume-email')?.value?.trim() || '',
			phone : document.getElementById('resume-phone')?.value?.trim() || '',
			location : document.getElementById('resume-location')?.value?.trim()
					|| '',
			summary : document.getElementById('resume-summary')?.value?.trim()
					|| '',
			skills : splitLinesOrComma(document.getElementById('resume-skills')?.value || ''),
			socialLinks : socialLinks,
			projects : projects,
			experience : experience,
			education : education,
			certificationItems : certificationItems
		};
	}

	function restoreResumeJson(data) {
		if (document.getElementById('resume-name')) {
			document.getElementById('resume-name').value = data.name || '';
		}
		if (document.getElementById('resume-headline')) {
			document.getElementById('resume-headline').value = data.headline
					|| '';
		}
		if (document.getElementById('resume-email')) {
			document.getElementById('resume-email').value = data.email || '';
		}
		if (document.getElementById('resume-phone')) {
			document.getElementById('resume-phone').value = data.phone || '';
		}
		if (document.getElementById('resume-location')) {
			document.getElementById('resume-location').value = data.location
					|| '';
		}
		if (document.getElementById('resume-summary')) {
			document.getElementById('resume-summary').value = data.summary || '';
		}
		if (document.getElementById('resume-skills')) {
			document.getElementById('resume-skills').value = joinLines(data.skills
					|| []);
		}

		const linksEditor = document.getElementById('links-editor');
		if (linksEditor) {
			linksEditor.innerHTML = '';
			const items = (data.socialLinks && data.socialLinks.length) ? data.socialLinks
					: [ {} ];
			items.forEach(function(item) {
				const html = ''
						+ '<div class="edit-section-box link-row">'
						+ '<input type="text" class="form-control mb-2 link-label" value="'
						+ escapeHtml(item.label || '')
						+ '" placeholder="라벨" />'
						+ '<input type="text" class="form-control mb-2 link-url" value="'
						+ escapeHtml(item.url || '')
						+ '" placeholder="URL" />'
						+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
						+ '</div>';
				linksEditor.insertAdjacentHTML('beforeend', html);
			});
			linksEditor.insertAdjacentHTML('beforeend',
					'<button type="button" class="btn btn-sm btn-outline-secondary editor-add-btn" onclick="addLinkRow()">링크 추가</button>');
		}

		const projectsEditor = document.getElementById('projects-editor');
		if (projectsEditor) {
			projectsEditor.innerHTML = '';
			const items = (data.projects && data.projects.length) ? data.projects
					: [ {} ];
			items.forEach(function(item) {
				const html = ''
						+ '<div class="edit-section-box project-row">'
						+ '<input type="text" class="form-control mb-2 project-title" value="'
						+ escapeHtml(item.title || '')
						+ '" placeholder="프로젝트명" />'
						+ '<input type="text" class="form-control mb-2 project-period" value="'
						+ escapeHtml(item.period || '')
						+ '" placeholder="기간" />'
						+ '<input type="text" class="form-control mb-2 project-role" value="'
						+ escapeHtml(item.role || '')
						+ '" placeholder="역할" />'
						+ '<textarea class="form-control mb-2 project-oneline" rows="2" placeholder="한 줄 소개">'
						+ escapeHtml(item.oneLine || '')
						+ '</textarea>'
						+ '<textarea class="form-control mb-2 project-highlights" rows="4" placeholder="하이라이트(줄바꿈으로 구분)">'
						+ escapeHtml(joinLines(item.highlights || []))
						+ '</textarea>'
						+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
						+ '</div>';
				projectsEditor.insertAdjacentHTML('beforeend', html);
			});
			projectsEditor.insertAdjacentHTML('beforeend',
					'<button type="button" class="btn btn-sm btn-outline-secondary editor-add-btn" onclick="addProjectRow()">프로젝트 추가</button>');
		}

		const experienceEditor = document.getElementById('experience-editor');
		if (experienceEditor) {
			experienceEditor.innerHTML = '';
			const items = (data.experience && data.experience.length) ? data.experience
					: [ {} ];
			items.forEach(function(item) {
				const html = ''
						+ '<div class="edit-section-box experience-row">'
						+ '<input type="text" class="form-control mb-2 exp-title" value="'
						+ escapeHtml(item.title || '')
						+ '" placeholder="직무명" />'
						+ '<input type="text" class="form-control mb-2 exp-company" value="'
						+ escapeHtml(item.company || '')
						+ '" placeholder="회사명" />'
						+ '<input type="text" class="form-control mb-2 exp-period" value="'
						+ escapeHtml(item.period || '')
						+ '" placeholder="기간" />'
						+ '<textarea class="form-control mb-2 exp-description" rows="4" placeholder="업무 내용(줄바꿈으로 구분)">'
						+ escapeHtml(joinLines(item.description || []))
						+ '</textarea>'
						+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
						+ '</div>';
				experienceEditor.insertAdjacentHTML('beforeend', html);
			});
			experienceEditor.insertAdjacentHTML('beforeend',
					'<button type="button" class="btn btn-sm btn-outline-secondary editor-add-btn" onclick="addExperienceRow()">경력 추가</button>');
		}

		const educationEditor = document.getElementById('education-editor');
		if (educationEditor) {
			educationEditor.innerHTML = '';
			const items = (data.education && data.education.length) ? data.education
					: [ {} ];
			items.forEach(function(item) {
				const html = ''
						+ '<div class="edit-section-box education-row">'
						+ '<input type="text" class="form-control mb-2 edu-degree" value="'
						+ escapeHtml(item.degree || '')
						+ '" placeholder="학위" />'
						+ '<input type="text" class="form-control mb-2 edu-school" value="'
						+ escapeHtml(item.school || '')
						+ '" placeholder="학교명" />'
						+ '<input type="text" class="form-control mb-2 edu-major" value="'
						+ escapeHtml(item.major || '')
						+ '" placeholder="전공" />'
						+ '<input type="text" class="form-control mb-2 edu-start" value="'
						+ escapeHtml(item.startDate || '')
						+ '" placeholder="시작일" />'
						+ '<input type="text" class="form-control mb-2 edu-end" value="'
						+ escapeHtml(item.endDate || '')
						+ '" placeholder="종료일" />'
						+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
						+ '</div>';
				educationEditor.insertAdjacentHTML('beforeend', html);
			});
			educationEditor.insertAdjacentHTML('beforeend',
					'<button type="button" class="btn btn-sm btn-outline-secondary editor-add-btn" onclick="addEducationRow()">학력 추가</button>');
		}

		const certEditor = document.getElementById('certifications-editor');
		if (certEditor) {
			certEditor.innerHTML = '';
			const items = (data.certificationItems && data.certificationItems.length) ? data.certificationItems
					: [ {} ];
			items.forEach(function(item) {
				const html = ''
						+ '<div class="edit-section-box cert-row">'
						+ '<input type="text" class="form-control mb-2 cert-name" value="'
						+ escapeHtml(item.certi_name || '')
						+ '" placeholder="자격증명" />'
						+ '<input type="text" class="form-control mb-2 cert-org" value="'
						+ escapeHtml(item.organizer || '')
						+ '" placeholder="주최기관" />'
						+ '<button type="button" class="btn btn-sm btn-outline-danger editor-remove-btn" onclick="removeEditorRow(this)">삭제</button>'
						+ '</div>';
				certEditor.insertAdjacentHTML('beforeend', html);
			});
			certEditor.insertAdjacentHTML('beforeend',
					'<button type="button" class="btn btn-sm btn-outline-secondary editor-add-btn" onclick="addCertificationRow()">자격증 추가</button>');
		}
	}

	async function saveResumeSnapshot(portfolioId) {
		const payload = {
			portfolioId : portfolioId,
			snapshotJson : collectResumeJson()
		};

		try {
			const response = await fetch(
					'<c:url value="/portfolio/snapshot/update.do"/>', {
						method : 'POST',
						headers : {
							'Content-Type' : 'application/json'
						},
						body : JSON.stringify(payload)
					});

			const result = await response.json();

			if (result.success) {
				alert('레쥬메 정보가 저장되었습니다.');
				location.reload();
			} else {
				alert(result.message || '저장에 실패했습니다.');
			}
		} catch (e) {
			console.error(e);
			alert('저장 중 오류가 발생했습니다.');
		}
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />