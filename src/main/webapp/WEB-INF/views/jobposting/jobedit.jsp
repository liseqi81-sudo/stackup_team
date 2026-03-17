<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="pageTitle" value="StackUp | 취업공고 수정" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%
// ===== "기타 스킬" 자동 추출 (job.skills에서 체크박스 목록 제외) =====
// job.skills가 "Java, Spring, Kotlin" 이런 형태라고 가정
com.edu.springboot.jdbc.JobPostingDTO job = (com.edu.springboot.jdbc.JobPostingDTO) request.getAttribute("job");

String skills = (job != null && job.getSkills() != null) ? job.getSkills() : "";
java.util.Set<String> preset = new java.util.HashSet<>(java.util.Arrays.asList("Java", "Spring", "Spring Boot", "JPA",
		"MyBatis", "Node.js", "Express", "Python", "Django", "FastAPI", "REST API", "GraphQL", "HTML", "CSS",
		"JavaScript", "TypeScript", "React", "Next.js", "Vue", "Angular", "Bootstrap", "Tailwind CSS", "SQL", "Oracle",
		"MySQL", "PostgreSQL", "MongoDB", "Redis", "Elasticsearch", "AWS", "GCP", "Azure", "Docker", "Kubernetes",
		"Jenkins", "GitHub Actions", "Linux", "Nginx", "TCP/IP", "HTTP/HTTPS", "DNS", "Load Balancing", "Security",
		"Android", "Kotlin", "iOS", "Swift", "React Native", "Flutter", "Git", "GitHub", "Jira", "Notion", "Slack",
		"Figma"));

StringBuilder etc = new StringBuilder();
if (!skills.isBlank()) {
	String[] parts = skills.split(",");
	for (String p : parts) {
		String token = p.trim();
		if (!token.isEmpty() && !preset.contains(token)) {
	if (etc.length() > 0)
		etc.append(", ");
	etc.append(token);
		}
	}
}
request.setAttribute("skillsEtcValue", etc.toString());
%>

<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">취업공고 수정</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="<c:url value='/main.do'/>">Home</a></li>
		<li class="breadcrumb-item"><a
			href="<c:url value='/jobposting/joblist.do'/>">Job Postings</a></li>
		<li class="breadcrumb-item active text-white">Edit</li>
	</ol>
</div>

<div class="container-fluid py-5">
	<div class="container py-5">

		<div class="bg-light rounded p-4">
			<form method="post"
				action="<c:url value='/jobposting/jobedit.do'/>">

				<!-- ✅ postingId는 hidden -->
				<input type="hidden" name="postingId" value="${job.postingId}" />
				<!-- writerId도 update에서 쓰고 싶으면 같이 보내도 됨 -->
				<input type="hidden" name="writerId" value="${job.writerId}" />

				<div class="row g-3">

					<div class="col-md-6">
						<label class="form-label fw-bold">회사명</label> <input type="text"
							name="companyName" class="form-control" required
							value="${job.companyName}">
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">직무 카테고리</label> <select
							name="jobCategory" class="form-select" required>
							<option value="">선택</option>
							<option value="Backend"
								<c:if test="${job.jobCategory eq 'Backend'}">selected</c:if>>Backend</option>
							<option value="Frontend"
								<c:if test="${job.jobCategory eq 'Frontend'}">selected</c:if>>Frontend</option>
							<option value="AI"
								<c:if test="${job.jobCategory eq 'AI'}">selected</c:if>>AI</option>
							<option value="DevOps"
								<c:if test="${job.jobCategory eq 'DevOps'}">selected</c:if>>DevOps</option>
						</select>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">공고 제목</label> <input type="text"
							name="title" class="form-control" required value="${job.title}">
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">고용 형태</label> <select
							name="postType" class="form-select">
							<option value="">선택</option>
							<option value="정규직"
								<c:if test="${job.postType eq '정규직'}">selected</c:if>>정규직</option>
							<option value="계약직"
								<c:if test="${job.postType eq '계약직'}">selected</c:if>>계약직</option>
							<option value="인턴"
								<c:if test="${job.postType eq '인턴'}">selected</c:if>>인턴</option>
							<option value="프리랜서"
								<c:if test="${job.postType eq '프리랜서'}">selected</c:if>>프리랜서</option>
						</select>
					</div>

					<div class="col-md-6">
						<label class="form-label fw-bold">마감일</label> <input type="date"
							name="deadline" class="form-control" value="${job.deadline}">
						<div class="text-muted small mt-1">비워두면 상세에서 “상시”로 보여요.</div>
					</div>

					<div class="col-12">
						<label class="form-label fw-bold">공고 링크(선택)</label> <input
							type="text" name="postingUrl" class="form-control"
							placeholder="https://..." value="${job.postingUrl}">
					</div>

					<!-- Skills -->
					<div class="mb-3">
						<h5 class="fw-bold mb-3">필요 스킬 선택</h5>

						<!-- Skills -->
						<div class="mb-3">
							<h5 class="fw-bold mb-3">필요 스킬 선택</h5>

							<!-- 백엔드 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">백엔드</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Java"> <span
										class="form-check-label">Java</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Spring"> <span
										class="form-check-label">Spring</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Spring Boot"> <span
										class="form-check-label">Spring Boot</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="JPA"> <span
										class="form-check-label">JPA</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="MyBatis"> <span
										class="form-check-label">MyBatis</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Node.js"> <span
										class="form-check-label">Node.js</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Express"> <span
										class="form-check-label">Express</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Python"> <span
										class="form-check-label">Python</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Django"> <span
										class="form-check-label">Django</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="FastAPI"> <span
										class="form-check-label">FastAPI</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="REST API"> <span
										class="form-check-label">REST API</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="GraphQL"> <span
										class="form-check-label">GraphQL</span>
									</label>
								</div>
							</div>

							<!-- 프론트엔드 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">프론트엔드</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="HTML"> <span
										class="form-check-label">HTML</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="CSS"> <span
										class="form-check-label">CSS</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="JavaScript"> <span
										class="form-check-label">JavaScript</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="TypeScript"> <span
										class="form-check-label">TypeScript</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="React"> <span
										class="form-check-label">React</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Next.js"> <span
										class="form-check-label">Next.js</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Vue"> <span
										class="form-check-label">Vue</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Angular"> <span
										class="form-check-label">Angular</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Bootstrap"> <span
										class="form-check-label">Bootstrap</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Tailwind CSS"> <span
										class="form-check-label">Tailwind CSS</span>
									</label>
								</div>
							</div>

							<!-- DB·데이터 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">DB · 데이터</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="SQL"> <span
										class="form-check-label">SQL</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Oracle"> <span
										class="form-check-label">Oracle</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="MySQL"> <span
										class="form-check-label">MySQL</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="PostgreSQL"> <span
										class="form-check-label">PostgreSQL</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="MongoDB"> <span
										class="form-check-label">MongoDB</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Redis"> <span
										class="form-check-label">Redis</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Elasticsearch"> <span
										class="form-check-label">Elasticsearch</span>
									</label>
								</div>
							</div>

							<!-- DevOps·클라우드 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">DevOps · 클라우드</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="AWS"> <span
										class="form-check-label">AWS</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="GCP"> <span
										class="form-check-label">GCP</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Azure"> <span
										class="form-check-label">Azure</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Docker"> <span
										class="form-check-label">Docker</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Kubernetes"> <span
										class="form-check-label">Kubernetes</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Jenkins"> <span
										class="form-check-label">Jenkins</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="GitHub Actions"> <span
										class="form-check-label">GitHub Actions</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Linux"> <span
										class="form-check-label">Linux</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Nginx"> <span
										class="form-check-label">Nginx</span>
									</label>
								</div>
							</div>

							<!-- 서버·네트워크 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">서버 · 네트워크</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="TCP/IP"> <span
										class="form-check-label">TCP/IP</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="HTTP/HTTPS"> <span
										class="form-check-label">HTTP/HTTPS</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="DNS"> <span
										class="form-check-label">DNS</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Load Balancing"> <span
										class="form-check-label">Load Balancing</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Security"> <span
										class="form-check-label">Security</span>
									</label>
								</div>
							</div>

							<!-- 모바일 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">모바일</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Android"> <span
										class="form-check-label">Android</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Kotlin"> <span
										class="form-check-label">Kotlin</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="iOS"> <span
										class="form-check-label">iOS</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Swift"> <span
										class="form-check-label">Swift</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="React Native"> <span
										class="form-check-label">React Native</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Flutter"> <span
										class="form-check-label">Flutter</span>
									</label>
								</div>
							</div>

							<!-- 협업·도구 -->
							<div class="mb-4">
								<div class="fw-semibold mb-2">협업 · 도구</div>
								<div class="d-flex flex-wrap gap-3">
									<label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Git"> <span
										class="form-check-label">Git</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="GitHub"> <span
										class="form-check-label">GitHub</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Jira"> <span
										class="form-check-label">Jira</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Notion"> <span
										class="form-check-label">Notion</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Slack"> <span
										class="form-check-label">Slack</span>
									</label> <label class="form-check"> <input
										class="form-check-input skill-checkbox" type="checkbox"
										name="skillsArr" value="Figma"> <span
										class="form-check-label">Figma</span>
									</label>
								</div>
							</div>



							<div class="mt-3">
								<label class="form-label fw-bold mb-1">기타 스킬(직접 입력)</label> <input
									type="text" name="skillsEtc" class="form-control"
									placeholder="예) Kotlin, Next.js, Kubernetes ..."
									value="${skillsEtcValue}">
							</div>
						</div>

						<div class="col-12">
							<label class="form-label fw-bold">공고 내용</label>
							<textarea name="contents" class="form-control" rows="10"
								placeholder="업무 내용, 자격 요건, 우대 사항, 복지 등">${job.contents}</textarea>
						</div>

					</div>

					<div class="d-flex justify-content-end gap-2 mt-4">
						<a class="btn btn-outline-secondary rounded-pill px-4"
							href="<c:url value='/jobposting/jobdetail.do?postingId=${job.postingId}'/>">취소</a>

						<button type="submit"
							class="btn btn-warning rounded-pill px-4 text-white">수정
							저장</button>
					</div>
			</form>
		</div>

	</div>
</div>
<script>
  (function () {
    // DB에 저장된 skills 문자열 (예: "Java, Spring Boot, AWS")
/*     const skillsStr = "${job.skills}".trim();
 */
	const skillsStr = "<c:out value='${job.skills}'/>";
    if (!skillsStr) return;

    // 쉼표 기준으로 split + trim
    const selected = skillsStr.split(",").map(s => s.trim()).filter(Boolean);

    // 체크박스 자동 체크
    document.querySelectorAll('input[name="skillsArr"]').forEach(cb => {
      if (selected.includes(cb.value)) {
        cb.checked = true;
      }
    });

    // (선택) 기타 스킬 자동 추출까지 JS로 하고 싶으면 여기서도 가능
    // 지금은 서버에서 skillsEtcValue로 내려주는 방식(내가 준 jobedit.jsp 방식) 유지!
  })();
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />