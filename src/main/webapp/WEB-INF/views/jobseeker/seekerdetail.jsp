<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<%-- 타이틀 설정 --%>
<c:set var="pageTitle" value="StackUp | 구직자 프로필 상세" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.detail-box { border-radius: 12px; overflow: hidden; border: 1px solid #ddd; background-color: #fff; }
.table-detail th { background: #f8f9fa; border-bottom: 2px solid #81c408 !important; width: 180px; vertical-align: middle; }
.badge-blue { background-color: #007bff; color: #fff; padding: 6px 12px; font-weight: 500; border-radius: 999px; display: inline-block; }
</style>

<div class="container-fluid py-5" style="background-image: none; background-color: #FAF7F0; margin-top: 110px;">
    <h1 class="text-center display-6 pt-3" style="color: #333; font-weight: bold;">구직자 상세 정보</h1>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <%-- 상단 헤더 영역 --%>
		<div class="d-flex justify-content-between align-items-start mb-4">
    		<div>
        		<h3 class="fw-bold mb-1">${seeker.seekTitle}</h3>
        		<div class="text-muted">
            		<span class="me-2">작성자: ${seeker.userName}</span>
            		<c:if test="${not empty seeker.seekCategory}">
                		· <span>${seeker.seekCategory}</span>
            		</c:if>
        		</div>
    		</div>
    
    		<div class="d-flex gap-2">
        		<c:if test="${sessionScope.user != null && seeker.userId eq sessionScope.user.user_id}">
            		<a class="btn btn-warning rounded-pill px-4" 
               			href="<c:url value='/jobseeker/seekeredit.do?seekId=${seeker.seekId}'/>">수정</a>
            
            		<form method="post" action="<c:url value='/jobseeker/seekerdelete.do'/>" class="m-0">
                		<input type="hidden" name="seekId" value="${seeker.seekId}">
                		<button class="btn btn-danger rounded-pill px-4" type="submit" 
                        		onclick="return confirm('정말 삭제할까요?');">삭제</button>
            		</form>
        		</c:if>
        		<a class="btn btn-success rounded-pill px-4 text-white" href="<c:url value='/jobseeker/seekerlist.do'/>">목록으로</a>
    		</div>
		</div>
       
        <%-- 상세 정보 테이블 --%>
        <div class="bg-light rounded p-4 detail-box mb-5">
            <div class="table-responsive">
                <table class="table table-hover table-detail mb-0">
                    <tbody>
                        <tr>
                            <th>프로필 번호</th>
                            <td>${seeker.seekId}</td>
                        </tr>
                        <tr>
                            <th>아이디</th>
                            <td>${seeker.userName}</td>
                        </tr>
                        <tr>
                            <th>희망 카테고리</th>
                            <td><span class="badge-blue">${seeker.seekCategory}</span></td>
                        </tr>
                        <tr>
                            <th>보유 기술</th>
                            <td>${seeker.skills}</td>
                        </tr>
                        <tr>
                            <th>등록일</th>
                            <td>${seeker.createDate}</td>
                        </tr>
                        <tr>
                            <th>자기소개 및 내용</th>
                            <td style="white-space: pre-wrap; min-height: 200px;"><c:choose><c:when test="${not empty seeker.contents}">${seeker.contents}</c:when><c:otherwise><span class="text-muted">내용이 없습니다.</span></c:otherwise></c:choose></td>
                        </tr>
                        
                        <tr>
   <th>포트폴리오</th>
    <td>
        <c:choose>
            <c:when test="${not empty seeker.seekFile}">
                <div class="d-flex align-items-center gap-3">
                    <span class="text-dark"><i class="fas fa-file-alt me-2 text-primary"></i>${seeker.seekFile}</span>
                    <a href="<c:url value='/uploads/seeker/${seeker.seekFile}'/>" 
                       class="btn btn-outline-primary btn-sm rounded-pill px-3" 
                       target="_blank">
                        <i class="fas fa-search me-1"></i>열기 / 다운로드
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <span class="text-muted">첨부된 파일이 없습니다.</span>
            </c:otherwise>
        </c:choose>
    </td>
</tr> 
                    </tbody>
                </table>
            </div>
        </div>

		<c:if test="${not empty sessionScope.user && sessionScope.user.user_type eq 'COMPANY'}">
	        <%-- 🚩 채용 제안 폼 (에러 방지를 위해 조건문을 제거하여 무조건 노출됩니다) --%>
	        <div class="card border-success shadow-sm mb-5">
				<div class="card-header bg-success py-3 d-flex align-items-center">
				    <i class="fas fa-paper-plane me-2 text-white"></i>
				    <h5 class="mb-0 text-white fw-bold">이 인재에게 채용 제안하기</h5>
				</div>
	            <div class="card-body p-4">
	                <form action="<c:url value='/jobseeker/contactSave.do'/>" method="post" enctype="multipart/form-data">
	                    <%-- Hidden 필드: 받는사람 ID와 게시물 ID --%>
	                    <input type="hidden" name="userId" value="${seeker.userId}">
	                    <input type="hidden" name="seekId" value="${seeker.seekId}">
	                    
	                   <div class="row g-3">
	            			<%-- 1. 제안 제목 --%>
	            			<div class="col-md-12">
	                			<label class="form-label fw-bold">제안 제목</label>
	                			<input type="text" name="contactTitle" class="form-control" placeholder="예: [OO테크] 채용 제안드립니다." required>
	            			</div>
	
	            			<%-- 2. 회사명 (추가) --%>
	            			<div class="col-md-6">
	                			<label class="form-label fw-bold">회사명</label>
	                			<input type="text" name="companyInfo" class="form-control" placeholder="회사명을 입력하세요" required>
	            			</div>
	
	            			<%-- 3. 채용 직무 (추가) --%>
	            			<div class="col-md-6">
	                			<label class="form-label fw-bold">채용 직무</label>
	                			<input type="text" name="jobInfo" class="form-control" placeholder="예: Java 백엔드 개발자" required>
	            			</div>
	
	            			<%-- 4. 상세 제안 내용 --%>
	            			<div class="col-12">
	                			<label class="form-label fw-bold">상세 제안 내용</label>
	                			<textarea name="contactContent" class="form-control" rows="4" placeholder="회사 소개 및 제안 이유를 상세히 적어주세요." required></textarea>
	            			</div>
	
	            			<%-- 5. 파일 첨부 및 발송 버튼 --%>
	            			<div class="col-md-8">
	                			<label class="form-label fw-bold">명함 또는 관련 파일 첨부</label>
	                			<input type="file" name="uploadFile" class="form-control" accept="image/*">
	                			<div class="form-text">* 본인 확인을 위해 파일을 첨부해 주세요.</div>
	            			</div>
	            			<div class="col-md-4 d-flex align-items-end">
	                			<button type="submit" class="btn btn-success w-100 py-2 fw-bold text-white shadow">
	                    			<i class="fas fa-paper-plane me-2"></i>제안서 발송하기
	                            </button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div>
        </c:if>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />