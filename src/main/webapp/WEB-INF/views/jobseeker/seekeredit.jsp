<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="pageTitle" value="StackUp | 인재정보 수정" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%
// 1. Java 로직 (기타 스킬 추출 - 필드명 맞춰서 수정)
com.edu.springboot.jdbc.JobSeekerDTO seeker = (com.edu.springboot.jdbc.JobSeekerDTO) request.getAttribute("seeker");
String skills = (seeker != null && seeker.getSkills() != null) ? seeker.getSkills() : "";

// 프리셋 정의 (기타 스킬 분류용)
java.util.Set<String> preset = new java.util.HashSet<>(java.util.Arrays.asList(
    "Java", "Spring", "Spring Boot", "JPA", "MyBatis", "Node.js", "Express", "Python", "Django", "FastAPI", "REST API", "GraphQL", 
    "HTML", "CSS", "JavaScript", "TypeScript", "React", "Next.js", "Vue", "Angular", "Bootstrap", "Tailwind CSS", 
    "SQL", "Oracle", "MySQL", "PostgreSQL", "MongoDB", "Redis", "Elasticsearch", 
    "AWS", "GCP", "Azure", "Docker", "Kubernetes", "Jenkins", "GitHub Actions", "Linux", "Nginx", 
    "TCP/IP", "HTTP/HTTPS", "DNS", "Load Balancing", "Security", 
    "Android", "Kotlin", "iOS", "Swift", "React Native", "Flutter", 
    "Git", "GitHub", "Jira", "Notion", "Slack", "Figma"
));

StringBuilder etc = new StringBuilder();
if (!skills.isEmpty()) {
    String[] parts = skills.split(",");
    for (String p : parts) {
        String token = p.trim();
        if (!token.isEmpty() && !preset.contains(token)) {
            if (etc.length() > 0) etc.append(", ");
            etc.append(token);
        }
    }
}
request.setAttribute("skillsEtcValue", etc.toString());
%>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">인재정보 수정</h1>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="bg-light rounded p-4 shadow-sm">
            <form method="post" action="<c:url value='/jobseeker/seekeredit.do'/>">
                <%-- PK와 작성자 정보 --%>
                <input type="hidden" name="seekId" value="${seeker.seekId}" />
                <input type="hidden" name="userId" value="${seeker.userId}" />

                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label fw-bold">희망 직무 분야</label> 
                        <%-- ✅ category -> seekCategory --%>
                        <select name="seekCategory" class="form-select" required>
                            <option value="Backend" <c:if test="${seeker.seekCategory eq 'Backend'}">selected</c:if>>Backend</option>
                            <option value="Frontend" <c:if test="${seeker.seekCategory eq 'Frontend'}">selected</c:if>>Frontend</option>
                            <option value="AI" <c:if test="${seeker.seekCategory eq 'AI'}">selected</c:if>>AI</option>
                            <option value="DevOps" <c:if test="${seeker.seekCategory eq 'DevOps'}">selected</c:if>>DevOps</option>
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold">프로필 제목</label> 
                        <%-- ✅ title -> seekTitle --%>
                        <input type="text" name="seekTitle" class="form-control" required value="${seeker.seekTitle}">
                    </div>

                    <div class="col-12 mt-4">
                        <h5 class="fw-bold mb-3">보유 기술 선택</h5>
                        
                        <div class="mb-4">
                            <div class="fw-semibold mb-2 text-primary">백엔드</div>
                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="s" items="${fn:split('Java,Spring,Spring Boot,JPA,MyBatis,Node.js,Express,Python,Django,FastAPI,REST API,GraphQL', ',')}">
                                    <label class="form-check">
                                        <input class="form-check-input skill-checkbox" type="checkbox" name="skillsArr" value="${s}">
                                        <span class="form-check-label">${s}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="fw-semibold mb-2 text-primary">프론트엔드</div>
                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="s" items="${fn:split('HTML,CSS,JavaScript,TypeScript,React,Next.js,Vue,Angular,Bootstrap,Tailwind CSS', ',')}">
                                    <label class="form-check">
                                        <input class="form-check-input skill-checkbox" type="checkbox" name="skillsArr" value="${s}">
                                        <span class="form-check-label">${s}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="mt-3">
                            <label class="form-label fw-bold mb-1">기타 스킬(직접 입력)</label> 
                            <input type="text" name="skillsEtc" class="form-control" value="${skillsEtcValue}">
                        </div>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold">자기소개 및 경력사항</label>
                        <%-- ✅ content -> contents --%>
                        <textarea name="contents" class="form-control" rows="10">${seeker.contents}</textarea>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="javascript:history.back();" class="btn btn-outline-secondary rounded-pill px-4">취소</a>
                        <button type="submit" class="btn btn-warning rounded-pill px-4 text-white">수정 저장</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
  (function () {
    // 서버에서 가져온 skills 문자열을 이용해 체크박스 자동 선택
    const skillsStr = "<c:out value='${seeker.skills}'/>";
    if (!skillsStr) return;
    
    const selected = skillsStr.split(",").map(s => s.trim()).filter(Boolean);
    document.querySelectorAll('.skill-checkbox').forEach(cb => {
      if (selected.includes(cb.value)) {
          cb.checked = true;
      }
    });
  })();
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />