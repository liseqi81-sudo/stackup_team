<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="pageTitle" value="StackUp | 인재정보 등록" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid py-5" style="background-image: none; background-color: white; margin-top: 110px;">
    <h1 class="text-center display-6 pt-3" style="color: #333; font-weight: bold;">인재정보 등록</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/main.do'/>" style="color: #81c408;">Home</a></li>
        <li class="breadcrumb-item"><a href="<c:url value='/jobseeker/seekerlist.do'/>" style="color: #81c408;">Seekers</a></li>
        <li class="breadcrumb-item active" style="color: #777;">Write</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="bg-light rounded p-4">
            <form method="post" action="<c:url value='/jobseeker/seekerwrite.do'/>">
                
                <%-- ✅ 세션에서 user_id 가져오기 (UserDTO 구조에 맞춤) --%>
                <input type="hidden" name="userId" value="${sessionScope.user.user_id}" />

                <div class="row g-3">
                		
                
                    <div class="col-md-12">
                        <label class="form-label fw-bold">희망 직무 분야</label> 
                        <%-- ✅ name="category" -> seekCategory --%>
                        <select name="seekCategory" class="form-select" required>
                            <option value="" selected disabled>분야를 선택해주세요</option>
                            <option value="Backend">Backend</option>
                            <option value="Frontend">Frontend</option>
                            <option value="AI">AI</option>
                            <option value="DevOps">DevOps</option>
                        </select>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold">프로필 제목</label> 
                        <%-- ✅ name="title" -> seekTitle --%>
                        <input type="text" name="seekTitle" class="form-control" placeholder="나를 한 줄로 표현해주세요" required>
                    </div>

                    <div class="col-12 mt-4">
                        <h5 class="fw-bold mb-3">보유 기술 선택</h5>
                        
                        <div class="mb-4">
                            <div class="fw-semibold mb-2 text-primary">백엔드</div>
                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="s" items="${fn:split('Java,Spring,Spring Boot,JPA,MyBatis,Node.js,Express,Python,Django,FastAPI,REST API,GraphQL', ',')}">
                                    <label class="form-check">
                                        <input class="form-check-input" type="checkbox" name="skillsArr" value="${s}">
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
                                        <input class="form-check-input" type="checkbox" name="skillsArr" value="${s}">
                                        <span class="form-check-label">${s}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="mt-3">
                            <label class="form-label fw-bold mb-1">기타 스킬(직접 입력)</label> 
                            <input type="text" name="skillsEtc" class="form-control" placeholder="목록에 없는 스킬은 쉼표(,)로 구분하여 입력해주세요">
                        </div>
                    </div>

                    <div class="col-12">
                        <label class="form-label fw-bold">자기소개 및 경력사항</label>
                        <%-- ✅ name="content" -> contents --%>
                        <textarea name="contents" class="form-control" rows="10" placeholder="본인의 기술적 강점이나 프로젝트 경험을 상세히 적어주세요"></textarea>
                    </div>
						
						<div class="col-12 mt-4">
            <label class="form-label fw-bold">포트폴리오 / 이력서 첨부</label>
            <div class="input-group">
                <input type="file" name="portfolioFile" class="form-control" id="portfolioFile" 
                       accept=".pdf,.doc,.docx,.zip,.jpg,.png">
                <label class="input-group-text" for="portfolioFile">파일 선택</label>
            </div>
            <div class="form-text text-muted">
                PDF, Word, 이미지 또는 압축파일(ZIP)을 업로드할 수 있습니다. (최대 10MB)
            </div>
        </div>
						
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a class="btn btn-outline-secondary rounded-pill px-4" href="<c:url value='/jobseeker/seekerlist.do'/>">취소</a>
                        <button type="submit" class="btn btn-primary rounded-pill px-4 text-white">등록하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />