<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | 취업공고 작성" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid py-5" style="background-image: none; background-color: white; margin-top: 110px;">
	<h1 class="text-center display-6pt-3" style="color: #333; font-weight: bold;">취업공고 작성</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="<c:url value='/main.do'/>" style="color: #81c408;">Home</a></li>
		<li class="breadcrumb-item"><a
			href="<c:url value='/jobposting/joblist.do'/>" style="color: #81c408;">Job Postings</a></li>
		<li class="breadcrumb-item active" style="color: #777;">Write</li>
	</ol>
</div>

<div class="container-fluid py-5">
	<div class="container py-5">

		<div class="bg-light rounded p-4">
			<form method="post" action="<c:url value='/jobposting/write.do'/>">

				<div class="row g-3">

					<div class="col-md-6">
						<label class="form-label fw-bold">회사명</label> <input type="text"
							name="companyName" class="form-control" required>
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">직무 카테고리</label> <select
							name="jobCategory" class="form-select" required>
							<option value="">선택</option>
							<option value="Backend">Backend</option>
							<option value="Frontend">Frontend</option>
							<option value="AI">AI</option>
							<option value="DevOps">DevOps</option>
						</select>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">공고 제목</label> <input type="text"
							name="title" class="form-control" required>
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">고용 형태</label> <select
							name="postType" class="form-select">
							<option value="">선택</option>
							<option value="정규직">정규직</option>
							<option value="계약직">계약직</option>
							<option value="인턴">인턴</option>
							<option value="프리랜서">프리랜서</option>
						</select>
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">마감일</label> <input type="date"
							name="deadline" class="form-control">
						<div class="text-muted small mt-1">비워두면 상세에서 “상시”로 보여요.</div>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">공고 링크(선택)</label> <input
							type="text" name="postingUrl" class="form-control"
							placeholder="https://...">
					</div>

					<!-- Skills -->
					<div class="mb-3">
						<h5 class="fw-bold mb-3">필요 스킬 선택</h5>

						<!-- 백엔드 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">백엔드</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Java"> <span class="form-check-label">Java</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Spring"> <span class="form-check-label">Spring</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Spring Boot"> <span class="form-check-label">Spring
										Boot</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="JPA"> <span class="form-check-label">JPA</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="MyBatis"> <span class="form-check-label">MyBatis</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Node.js"> <span class="form-check-label">Node.js</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Express"> <span class="form-check-label">Express</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Python"> <span class="form-check-label">Python</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Django"> <span class="form-check-label">Django</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="FastAPI"> <span class="form-check-label">FastAPI</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="REST API"> <span class="form-check-label">REST
										API</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="GraphQL"> <span class="form-check-label">GraphQL</span>
								</label>
							</div>
						</div>

						<!-- 프론트엔드 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">프론트엔드</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="HTML"> <span class="form-check-label">HTML</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="CSS"> <span class="form-check-label">CSS</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="JavaScript"> <span class="form-check-label">JavaScript</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="TypeScript"> <span class="form-check-label">TypeScript</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="React"> <span class="form-check-label">React</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Next.js"> <span class="form-check-label">Next.js</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Vue"> <span class="form-check-label">Vue</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Angular"> <span class="form-check-label">Angular</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Bootstrap"> <span class="form-check-label">Bootstrap</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Tailwind CSS"> <span class="form-check-label">Tailwind
										CSS</span>
								</label>
							</div>
						</div>

						<!-- DB·데이터 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">DB · 데이터</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="SQL"> <span class="form-check-label">SQL</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Oracle"> <span class="form-check-label">Oracle</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="MySQL"> <span class="form-check-label">MySQL</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="PostgreSQL"> <span class="form-check-label">PostgreSQL</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="MongoDB"> <span class="form-check-label">MongoDB</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Redis"> <span class="form-check-label">Redis</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Elasticsearch"> <span class="form-check-label">Elasticsearch</span>
								</label>
							</div>
						</div>

						<!-- DevOps·클라우드 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">DevOps · 클라우드</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="AWS"> <span class="form-check-label">AWS</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="GCP"> <span class="form-check-label">GCP</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Azure"> <span class="form-check-label">Azure</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Docker"> <span class="form-check-label">Docker</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Kubernetes"> <span class="form-check-label">Kubernetes</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Jenkins"> <span class="form-check-label">Jenkins</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="GitHub Actions"> <span class="form-check-label">GitHub
										Actions</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Linux"> <span class="form-check-label">Linux</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Nginx"> <span class="form-check-label">Nginx</span>
								</label>
							</div>
						</div>

						<!-- 서버·네트워크 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">서버 · 네트워크</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="TCP/IP"> <span class="form-check-label">TCP/IP</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="HTTP/HTTPS"> <span class="form-check-label">HTTP/HTTPS</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="DNS"> <span class="form-check-label">DNS</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Load Balancing"> <span class="form-check-label">Load
										Balancing</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Security"> <span class="form-check-label">Security</span>
								</label>
							</div>
						</div>

						<!-- 모바일 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">모바일</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Android"> <span class="form-check-label">Android</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Kotlin"> <span class="form-check-label">Kotlin</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="iOS"> <span class="form-check-label">iOS</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Swift"> <span class="form-check-label">Swift</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="React Native"> <span class="form-check-label">React
										Native</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Flutter"> <span class="form-check-label">Flutter</span>
								</label>
							</div>
						</div>

						<!-- 협업·도구 -->
						<div class="mb-4">
							<div class="fw-semibold mb-2">협업 · 도구</div>
							<div class="d-flex flex-wrap gap-3">
								<label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Git"> <span class="form-check-label">Git</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="GitHub"> <span class="form-check-label">GitHub</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Jira"> <span class="form-check-label">Jira</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Notion"> <span class="form-check-label">Notion</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Slack"> <span class="form-check-label">Slack</span>
								</label> <label class="form-check"> <input
									class="form-check-input" type="checkbox" name="skillsArr"
									value="Figma"> <span class="form-check-label">Figma</span>
								</label>
							</div>
						</div>



						<div class="mt-3">
							<label class="form-label fw-bold mb-1">기타 스킬(직접 입력)</label> <input
								type="text" name="skillsEtc" class="form-control"
								placeholder="예) Kotlin, Next.js, Kubernetes ...">
						</div>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">공고 내용</label>
						<textarea name="contents" class="form-control" rows="10"
							placeholder="업무 내용, 자격 요건, 우대 사항, 복지 등"></textarea>
					</div>

				</div>

				<div class="d-flex justify-content-end gap-2 mt-4">
					<a class="btn btn-outline-secondary rounded-pill px-4"
						href="<c:url value='/jobposting/joblist.do'/>">취소</a>
					<button type="submit"
						class="btn btn-primary rounded-pill px-4 text-white">등록</button>
				</div>

			</form>
		</div>

	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />