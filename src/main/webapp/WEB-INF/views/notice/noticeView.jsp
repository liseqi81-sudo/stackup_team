<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- [수정] 상단 타이틀 배너: 목록 페이지(List)와 동일한 구조로 변경 --%>
<div class="container-fluid page-header py-5" style="background-image: none; background-color: white; margin-top: 110px;">
    <h1 class="text-center display-6 pt-3" style="color: #333; font-weight: bold;">공지사항</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>" style="color: #81c408;">Home</a></li>
        <li class="breadcrumb-item active" style="color: #777;">Notice</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="bg-white shadow-sm p-5 rounded" style="min-height: 600px; max-width: 1000px; margin: 0 auto; text-align: left !important;">
            
            <%-- 카테고리 배지 (왼쪽 정렬 확실히) --%>
            <div class="mb-3 text-start">
                <span class="badge bg-success px-3 py-2 rounded-pill shadow-sm" style="font-size: 0.9rem;">공지사항</span>
            </div>
            
            <%-- 제목 영역 (왼쪽 정렬) --%>
            <h2 class="fw-bold mb-3 text-start">${boardDTO.title}</h2>
            <hr>
            
            <%-- 게시물 정보 --%>
            <div class="d-flex justify-content-between text-muted mb-4 px-2">
                <span><strong>작성자:</strong> 관리자</span>
                <span>
                    <strong>조회수:</strong> ${boardDTO.count} | 
                    <strong>작성일:</strong> 
                    <c:choose>
                        <c:when test="${not empty boardDTO.createdat}">
                            <fmt:formatDate value="${boardDTO.createdat}" pattern="yyyy-MM-dd" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </span>
            </div>
            
            <%-- 본문 내용 (text-align: left !important 추가로 중앙 정렬 간섭 차단) --%>
            <div class="p-4 border-0 rounded bg-light text-start" style="min-height: 350px; line-height: 1.8; font-size: 1.05rem; white-space: pre-wrap; text-align: left !important;">${boardDTO.content}</div>
            
            <%-- 하단 버튼 영역 (여기는 중앙 정렬 유지) --%>
            <div class="text-center mt-5">
                <c:if test="${sessionScope.user.user_id == boardDTO.user_id || sessionScope.user.user_type == 'ADMIN'}">
                    <button class="btn btn-success rounded-pill px-4 py-2 me-2 shadow-sm" 
                            style="font-weight: 700;"
                            onclick="location.href='<c:url value="/noticeEdit.do?idx=${boardDTO.idx}"/>'">수정</button>
                    
                    <button class="btn btn-danger rounded-pill px-4 py-2 me-2 shadow-sm" 
                            style="font-weight: 700;"
                            onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='<c:url value="/noticeDelete.do?idx=${boardDTO.idx}"/>'">삭제</button>
                </c:if>

                <button class="btn btn-warning rounded-pill px-4 py-2 shadow-sm text-dark" 
                        style="font-weight: 700;"
                        onclick="location.href='<c:url value="/noticeList.do"/>'">목록으로</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />