<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="StackUp | 채용 제안 상세" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-5" style="margin-top:180px; max-width:900px;">
  <div class="card border-success shadow-sm mb-5">
    <div class="card-header bg-success py-3">
	    <h5 class="mb-0 text-white">
	        <i class="fas fa-paper-plane me-2 text-white"></i>
	        받은 채용 제안 상세보기
	    </h5>
	</div>

    <div class="card-body p-4">
      <div class="row g-3">

        <!-- 제안 제목 -->
        <div class="col-md-12">
          <label class="form-label fw-bold">제안 제목</label>
          <div class="form-control bg-light">
            <c:choose>
              <c:when test="${not empty contact.remark}">
                ${contact.remark}
              </c:when>
              <c:otherwise>
                채용 제안
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- 회사명 -->
        <div class="col-md-6">
          <label class="form-label fw-bold">회사명</label>
          <div class="form-control bg-light">
            ${contact.companyInfo}
          </div>
        </div>

        <!-- 채용 직무 -->
        <div class="col-md-6">
          <label class="form-label fw-bold">채용 직무</label>
          <div class="form-control bg-light">
            ${contact.jobInfo}
          </div>
        </div>

        <!-- 상세 제안 내용 -->
        <div class="col-12">
          <label class="form-label fw-bold">상세 제안 내용</label>
          <div class="form-control bg-light" style="min-height:150px; white-space:pre-wrap;">
            ${contact.contactContent}
          </div>
        </div>

        <!-- 첨부 이미지 -->
        <div class="col-12">
          <label class="form-label fw-bold">첨부파일</label>

          <c:choose>
            <c:when test="${not empty contact.cardImg}">
              <div class="mt-2">
                <img src="${pageContext.request.contextPath}/uploads/job_cards/${contact.cardImg}"
                     class="img-fluid rounded border"
                     style="max-width:300px;">
              </div>
            </c:when>
            <c:otherwise>
              <div class="form-control bg-light text-muted">
                첨부된 파일이 없습니다.
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 발송일 -->
        <div class="col-md-6">
          <label class="form-label fw-bold">발송일</label>
          <div class="form-control bg-light">
            <c:choose>
              <c:when test="${not empty contact.createDate}">
                <fmt:formatDate value="${contact.createDate}" pattern="yyyy-MM-dd HH:mm"/>
              </c:when>
              <c:otherwise>
                -
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- 읽은 날짜 -->
        <div class="col-md-6">
          <label class="form-label fw-bold">읽은 날짜</label>
          <div class="form-control bg-light">
            <c:choose>
              <c:when test="${not empty contact.readDate}">
                <fmt:formatDate value="${contact.readDate}" pattern="yyyy-MM-dd HH:mm"/>
              </c:when>
              <c:otherwise>
                미열람
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- 버튼 -->
        <div class="col-12 text-end mt-4">
          <a href="${pageContext.request.contextPath}/mypage.do" class="btn btn-outline-secondary px-4">
            목록으로
          </a>
        </div>

      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />