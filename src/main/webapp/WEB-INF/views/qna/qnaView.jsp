<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="StackUp | Q&A 상세보기" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 상단 타이틀 배너 --%>
<div class="container-fluid page-header py-5" style="background-image: none; background-color: white; margin-top: 110px;">
    <h1 class="text-center display-6 pt-3" style="color: #333; font-weight: bold;">질문 상세보기</h1>
</div>

<div class="container py-5">
    <%-- 게시물 메인 박스: 너비 1000px 고정 및 중앙 정렬 --%>
    <div class="bg-white shadow-sm p-5 rounded" style="min-height: 600px; max-width: 1000px; margin: 0 auto;">
        
        <%-- 질문 헤더 영역 --%>
        <div class="qna-content mb-5">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <h3 class="fw-bold text-dark m-0">${qnaDTO.title}</h3>
                <span class="badge ${qnaDTO.qna_status == 'WAITING' ? 'bg-warning' : 'bg-success'} p-2 px-3">
                    ${qnaDTO.qna_status == 'WAITING' ? '답변대기' : '답변완료'}
                </span>
            </div>
            
            <%-- [정보 영역] 우측 상단 정렬 --%>
            <div class="text-end text-muted small mb-4 px-2">
                <span><strong>작성자:</strong> ${qnaDTO.user_name}</span>| 
                <span><strong>조회수:</strong> ${qnaDTO.count}</span> | 
                <span><strong>작성일:</strong> 
                    <c:choose>
                        <c:when test="${not empty qnaDTO.createdat}">
                            <fmt:formatDate value="${qnaDTO.createdat}" pattern="yyyy-MM-dd HH:mm" />
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </span>
            </div>

           
	<%-- [수정] 태그와 변수 사이의 엔터/공백을 아예 없애버립니다 (한 줄로 붙이기) --%>
		<%-- ⚠️ 주의: 반드시 아래처럼 한 줄로 딱 붙여서 쓰세요! 태그 사이의 엔터가 범인입니다. --%>
		<div class="p-4 border rounded bg-light" style="min-height: 250px; white-space: pre-wrap; word-break: break-all; text-align: left !important; line-height: 1.8;"><c:out value="${fn:trim(qnaDTO.content)}"/></div>

        <hr class="my-5">

        <%-- 답변 리스트 영역 --%>
        <div class="comment-list mb-5">
            <h5 class="fw-bold mb-4"><i class="fas fa-reply me-2 text-success"></i>관리자 답변</h5>
            <c:choose>
                <c:when test="${empty commentList}">
                    <p class="text-muted text-center py-4">아직 등록된 답변이 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${commentList}" var="comment">
                        <div class="card mb-3 border-0 shadow-sm bg-light">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <strong class="text-success">
                                        <i class="fas fa-user-check me-1"></i>${comment.user_id}
                                    </strong> 
                                    <small class="text-muted">
                                        <strong>답변일:</strong> 
                                        <fmt:formatDate value="${comment.createdat}" pattern="yyyy-MM-dd HH:mm" />
                                    </small>
                                </div>
                                <p class="card-text mb-0" style="line-height: 1.6; text-align: left;">${comment.content}</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- 답변 작성 폼 (관리자 전용) --%>
        <c:if test="${not empty sessionScope.user and sessionScope.user.user_type == 'ADMIN'}">
            <form action="<c:url value='/commentWrite.do'/>" method="post" class="mt-4">
                <input type="hidden" name="qna_idx" value="${qnaDTO.qna_idx}">
                <div class="input-group">
                    <textarea name="content" class="form-control" rows="3" placeholder="답변 내용을 입력하세요" required></textarea>
                    <button class="btn btn-success px-4" type="submit">답변등록</button>
                </div>
            </form>
        </c:if>
    </div>

    <%-- 하단 버튼 영역 --%>
    <div class="text-center mt-5">
        <c:if test="${sessionScope.user.user_id == qnaDTO.user_id || sessionScope.user.user_type == 'ADMIN'}">
            <button class="btn btn-success rounded-pill px-4 py-2 me-2 shadow-sm" 
                    style="font-weight: 700;"
                    onclick="location.href='<c:url value="/qnaEdit.do?qna_idx=${qnaDTO.qna_idx}"/>'">수정</button>
            
            <button class="btn btn-danger rounded-pill px-4 py-2 me-2 shadow-sm" 
                    style="font-weight: 700;"
                    onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='<c:url value="/qnaDelete.do?qna_idx=${qnaDTO.qna_idx}"/>'">삭제</button>
        </c:if>
        <button class="btn btn-warning rounded-pill px-4 py-2 shadow-sm text-dark" 
                style="font-weight: 700;"
                onclick="location.href='<c:url value="/qnaList.do"/>'">목록으로</button>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />