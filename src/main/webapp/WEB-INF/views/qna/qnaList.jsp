<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="StackUp | Q&A 게시판" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    /* 1. 전체 규격 및 색상 */
    .board-container { max-width: 1000px; margin: 0 auto; }
    .table thead { background-color: rgba(129,196,8, 0.05); border-top: 2px solid #81c408; }
    .table th { color: #333; font-weight: 700; padding: 15px 0; border-bottom: none; }
    .table td { vertical-align: middle; padding: 15px 0; border-bottom: 1px solid #eee; }
    
    /* 2. 연두색 버튼 스타일링 */
    .btn-write { border-radius: 999px; padding: 10px 25px; background-color: #81c408; border: none; color: white; font-weight: 600; }
    .search-input { border-radius: 999px 0 0 999px !important; }
    .search-btn { border-radius: 0 999px 999px 0 !important; background-color: #81c408; color: white; border: none; }

    /* [추가] 취업공고 스타일 페이징 복제 */
    .dataTables_paginate {
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        margin: 50px auto !important;
        width: 100% !important;
        float: none !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button {
        display: inline-flex !important;
        align-items: center;
        justify-content: center;
        min-width: 45px !important;
        height: 45px !important;
        margin: 0 2px !important;
        border-radius: 10px !important;
        border: 1px solid #ffb524 !important; /* 노란 테두리 */
        color: #81c408 !important; /* 연두 글자 */
        background: white !important;
        font-weight: 700;
        cursor: pointer;
        transition: 0.3s;
        text-decoration: none !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.current {
        background: #81c408 !important;
        color: white !important;
        border: 1px solid #81c408 !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.disabled) {
        background: #ffb524 !important;
        color: white !important;
        border: 1px solid #ffb524 !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
        border: 1px solid #ddd !important;
        color: #ccc !important;
        opacity: 0.5;
        cursor: default;
    }
    
    /* 기본 DataTable 정보 숨기기 */
    .dataTables_info, .dataTables_length, .dataTables_filter { display: none !important; }
    
    /* 공지사항과 동일한 사각 테두리 스타일 */
.badge-notice {
    display: inline-block;
    padding: 2px 8px;
    font-size: 12px;
    font-weight: 600;
    border: 1px solid #81c408; /* 기본 초록 테두리 */
    color: #81c408;
    background-color: white;
    border-radius: 4px; /* 살짝 각진 사각형 */
    vertical-align: middle;
    margin-right: 5px;
}

/* 에러용 빨간 테두리 스타일 */
.badge-error {
    border: 1px solid #dc3545;
    color: #dc3545;
    background-color: white;
}
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">질문 및 답변</h1>

    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Q&A</li>
        </ol>
        </div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="board-container">
            <%-- 상단 검색창 & 버튼 배치 (수강후기와 동일 여백/크기) --%>
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div style="max-width: 350px;">
    				<%-- 1. form 태그에 연한 회색 테두리(#dee2e6) 추가 --%>
    				<form action="<c:url value='/qnaList.do'/>" method="get" 
          				  class="input-group shadow-sm" 
                          style="border-radius: 999px; border: 1px solid #dee2e6; overflow: hidden;">
          
        			<input type="hidden" name="searchField" value="title">
        
        			<%-- 2. border-0를 삭제하고 기본 스타일 유지 --%>
        			<input type="text" name="searchWord" id="customSearch" 
               			   class="form-control search-input px-4" 
               			   placeholder="질문 검색" 
               			   style="border: none; box-shadow: none; height: 45px;">
               
        			<%-- 3. 버튼 영역 --%>
        			<button class="btn search-btn px-4" type="submit">
            			<i class="fas fa-search"></i>
        			</button>
    			</form>
			</div>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="<c:url value='/qnaWrite.do'/>" class="btn btn-write shadow-sm">질문하기</a>
                    </c:when>
                    <c:otherwise>
                        <button type="button" onclick="alert('로그인 후 이용 가능합니다.'); location.href='<c:url value='/login.do'/>';" class="btn btn-write shadow-sm">질문하기</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 테이블 영역 --%>
            <div class="bg-white rounded shadow-sm p-4">
                <table class="table table-hover text-center" id="qnaTable">
                    <thead>
                        <tr>
                            <th style="width: 10%;">번호</th>
                            <th style="width: 40%;">제목</th>
                            <th style="width: 15%;">작성자</th>
                            <th style="width: 15%;">작성일</th>
                            <th style="width: 10%;">조회수</th>
                            <th style="width: 10%;">상태</th>
                            
                        </tr>
                    </thead>
                    <tbody>
    <c:choose>
        <c:when test="${empty qnaList}">
            <tr>
                <td colspan="6" class="py-5 text-muted">등록된 질문이 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${qnaList}" var="dto">
                <tr>
                    <td>${dto.qna_idx}</td>
                  <td class="text-start ps-4">
    <%-- 1. 제목에서 불필요한 머리말 제거 로직 --%>
    <c:set var="t" value="${fn:replace(dto.title, '[문의] ', '')}" />
    <c:set var="t" value="${fn:replace(dto.title, '[에러] ', '')}" />
    <c:set var="t" value="${fn:replace(dto.title, '[질문] ', '')}" />
    <c:set var="t" value="${fn:replace(dto.title, '[상담] ', '')}" />
    <c:set var="t" value="${fn:replace(dto.title, '[요청] ', '')}" />
    <c:set var="t" value="${fn:replace(t, '[문의]', '')}" />
    <c:set var="t" value="${fn:replace(t, '[에러]', '')}" />

    <%-- 2. 상자 스타일 (에러는 빨간색 배경 채우기 / 문의는 기존 녹색 테두리 유지) --%>
    <c:choose>
        <c:when test="${fn:contains(dto.title, '에러')}">
            <%-- 에러: 필독과 동일한 빨간색 배경, 글자 검정, 너비 고정 --%>
            <span class="badge-notice" style="display: inline-block; width: 45px; text-align: center; background-color: #dc3545; border: none; color: #000; padding: 2px 0; border-radius: 4px; font-weight: 600;">에러</span>
        </c:when>
        <c:otherwise>
           <%-- 문의: 초록색(연두) 배경 채우기 --%>
            <span class="badge-notice" style="display: inline-block; width: 45px; text-align: center; background-color: #81c408; border: none; color: #000; padding: 2px 0; border-radius: 4px; font-weight: 600; vertical-align: middle;">문의</span>
        </c:otherwise>
    </c:choose>

    <%-- 3. 깨끗해진 제목 --%>
    <a href="<c:url value='/qnaView.do?qna_idx=${dto.qna_idx}'/>" class="text-dark text-decoration-none fw-bold ms-2">
        ${fn:trim(t)}
    </a>
</td>
                    <td>${dto.user_name}</td>
                    <td class="text-muted">
                        <fmt:formatDate value="${dto.createdat}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>${dto.count}</td>
                    <td>
                        <c:choose>
                            <c:when test="${dto.qna_status == 'WAITING'}">
                                <span class="badge bg-warning text-dark" style="font-size: 11px;">답변대기</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-success" style="font-size: 11px;">답변완료</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>
    var $j = jQuery.noConflict();

    $j(document).ready(function() {
        // 1. 혹시라도 테이블이 두 번 잡히지 않도록 기존 설정을 파괴합니다.
        if ($j.fn.DataTable.isDataTable('#qnaTable')) {
            $j('#qnaTable').DataTable().destroy();
        }

        var table = $j('#qnaTable').DataTable({
            pageLength: 10,
            paging: true,
            searching: true,
            info: false,
            lengthChange: false,
            ordering: false,
            dom: 'rtp',
            language: {
                paginate: { next: "›", previous: "‹" },
                zeroRecords: "등록된 질문이 없습니다."
            },
            drawCallback: function(settings) {
                var api = this.api();
                var pageInfo = api.page.info();
                var $paginate = $j(settings.nTableWrapper).find('.dataTables_paginate');

                // [중요!] 주르륵 현상을 막는 핵심 코드: 기존 버튼을 싹 비웁니다.
                $paginate.empty(); 

                var start = Math.floor(pageInfo.page / 5) * 5;
                var end = Math.min(start + 5, pageInfo.pages);

                // 버튼들을 하나씩 다시 생성
                $j('<a class="paginate_button first">«</a>').appendTo($paginate).on('click', function() { table.page('first').draw('page'); });
                $j('<a class="paginate_button previous">‹</a>').appendTo($paginate).on('click', function() { table.page('previous').draw('page'); });

                for (var i = start; i < end; i++) {
                    (function(idx) {
                        $j('<a class="paginate_button' + (idx === pageInfo.page ? ' current' : '') + '">' + (idx + 1) + '</a>')
                            .appendTo($paginate).on('click', function() { table.page(idx).draw('page'); });
                    })(i);
                }

                $j('<a class="paginate_button next">›</a>').appendTo($paginate).on('click', function() { table.page('next').draw('page'); });
                $j('<a class="paginate_button last">»</a>').appendTo($paginate).on('click', function() { table.page('last').draw('page'); });

                // 활성화/비활성화 처리
                $paginate.find('.first, .previous').toggleClass('disabled', pageInfo.page === 0);
                $paginate.find('.last, .next').toggleClass('disabled', pageInfo.page >= pageInfo.pages - 1 || pageInfo.pages === 0);
            }
        });

        // 커스텀 검색창 연결
        $j('#customSearch').on('keyup', function() {
            table.search(this.value).draw();
        });
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />