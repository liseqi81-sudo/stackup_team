<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="StackUp | 수강후기 상세" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    /* 별점 출력 스타일 */
    .star-display { color: #ffc107; font-size: 1.2rem; }
    .star-display .empty-star { color: #ebedf3; } /* 빈 별 색상 */
    
    /* 카드 컨테이너 최소 높이 및 정렬 */
    .view-card {
        min-height: 600px; 
        max-width: 1000px; 
        margin: 0 auto; 
        text-align: left !important;
    }
</style>

<%-- [통일] 상단 타이틀 배너 구조 맞춤 --%>
<div class="container-fluid page-header py-5" style="background-image: none; background-color: white; margin-top: 110px;">
    <h1 class="text-center display-6 pt-3" style="color: #333; font-weight: bold;">수강후기</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="<c:url value='/'/>" style="color: #81c408;">Home</a></li>
        <li class="breadcrumb-item active" style="color: #777;">Review</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <%-- [통일] 공지사항과 동일한 카드 스타일 레이아웃 --%>
        <div class="bg-white shadow-sm p-5 rounded view-card">
            
            <%-- 상단 영역: 배지(좌) + 별점(우) 한 줄 배치 --%>
            <div class="mb-3 d-flex align-items-center justify-content-between">
                <div>
                    <span class="badge bg-success px-3 py-2 rounded-pill shadow-sm" style="font-size: 0.9rem;">수강후기</span>
                </div>
                
                <%-- ⭐ 별점 영역 --%>
                <div class="star-display d-flex align-items-center">
                    <c:forEach var="i" begin="1" end="5">
                        <c:choose>
                            <c:when test="${i <= boardDTO.review_star}">
                                <i class="fas fa-star"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-star empty-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <span class="text-dark ms-2" style="font-weight: 700;">${boardDTO.review_star}.0</span>
                </div>
            </div>
            
            <%-- 제목 영역 --%>
            <h2 class="fw-bold mb-3 text-start text-dark">${boardDTO.title}</h2>
            <hr>
            
            <%-- 게시물 정보: 작성자, 조회수, 작성일 분산 배치 --%>
            <div class="d-flex justify-content-between text-muted mb-4 px-2">
                <span><strong>작성자:</strong> ${boardDTO.user_name}</span>
                <span>
                    <strong>조회수:</strong> ${boardDTO.count} | 
                    <strong>작성일:</strong> 
                    <c:choose>
                        <c:when test="${not empty boardDTO.createdat}">
                            <fmt:formatDate value="${boardDTO.createdat}" pattern="yyyy-MM-dd" />
                        </c:when>
                        <c:otherwise>${boardDTO.createdat}</c:otherwise>
                    </c:choose>
                </span>
            </div>
            
            <%-- 본문 내용 --%>
            <div class="p-4 border-0 rounded bg-light text-start" 
                 style="min-height: 350px; line-height: 1.8; font-size: 1.05rem; white-space: pre-wrap; text-align: left !important;">${boardDTO.content}</div>
            
            <%-- 하단 버튼 영역 --%>
            <div class="text-center mt-5">
                <c:if test="${sessionScope.userId == boardDTO.user_id || sessionScope.user.user_type == 'ADMIN'}">
                    <button class="btn btn-success rounded-pill px-4 py-2 me-2 shadow-sm" 
                            style="font-weight: 700;"
                            onclick="location.href='<c:url value="/reviewEdit.do?idx=${boardDTO.idx}"/>'">수정</button>
                    
                    <button class="btn btn-danger rounded-pill px-4 py-2 me-2 shadow-sm" 
                            style="font-weight: 700;"
                            onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='<c:url value="/reviewDelete.do?idx=${boardDTO.idx}"/>'">삭제</button>
                </c:if>

                <button class="btn btn-warning rounded-pill px-4 py-2 shadow-sm text-dark" 
                        style="font-weight: 700;"
                        onclick="location.href='<c:url value="/reviewList.do"/>'">목록으로</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />