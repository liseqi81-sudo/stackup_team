<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageTitle" value="StackUp | 공지사항" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* --- 공지사항 상단 기본 스타일 (그대로 유지) --- */
.board-container { max-width: 1000px; margin: 0 auto; }
.table thead { background-color: rgba(129,196,8, 0.05); border-top: 2px solid #81c408; }
.table th { color: #333; font-weight: 700; padding: 15px 0; }
.table td { vertical-align: middle; padding: 15px 0; }
.btn-write { border-radius: 999px; padding: 10px 25px; background-color: #81c408; border: none; color: white; font-weight: 600; }
.search-input { border-radius: 999px 0 0 999px !important; }
.search-btn { border-radius: 0 999px 999px 0 !important; background-color: #81c408; color: white; border: none; }
.badge-notice { background-color: #ffc107; color: #000; font-size: 11px; padding: 4px 8px; border-radius: 5px; margin-right: 5px; }

/* --- [완벽복제] 취업공고 리스트 페이징 스타일 --- */
.dataTables_paginate {
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    margin: 50px auto !important; /* 구인 페이지와 동일한 여백 */
    width: 100% !important;
    float: none !important; /* 왼쪽/오른쪽 쏠림 방지 */
}

.dataTables_wrapper .dataTables_paginate .paginate_button {
    display: inline-flex !important;
    align-items: center;
    justify-content: center;
    min-width: 45px !important; /* 구인 페이지 픽셀 그대로 */
    height: 45px !important;    /* 구인 페이지 픽셀 그대로 */
    padding: 0 !important;
    margin: 0 2px !important;   /* 좁은 버튼 간격 그대로 */
    border-radius: 10px !important; /* 둥근 사각형 각도 그대로 */
    border: 1px solid #ffb524 !important; /* 노란색 테두리 */
    color: #81c408 !important; /* 연두색 글자 */
    background: white !important;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
    text-decoration: none !important;
}

/* 현재 페이지 (연두색) */
.dataTables_wrapper .dataTables_paginate .paginate_button.current {
    background: #81c408 !important;
    color: white !important;
    border: 1px solid #81c408 !important;
}

/* 마우스 올렸을 때 (노란색) */
.dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.disabled) {
    background: #ffb524 !important;
    color: white !important;
    border: 1px solid #ffb524 !important;
}

/* 비활성화 버튼 */
.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
    border: 1px solid #ddd !important;
    color: #ccc !important;
    cursor: default;
    opacity: 0.5;
}

/* 기존 페이징 번호 숨기기 */
#old-paging { display: none; }
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">공지사항</h1>

    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Notice</li>
        </ol>
        </div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="board-container">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div style="max-width: 350px;">
                    <form action="/noticeList.do" method="get" class="input-group shadow-sm" style="border-radius: 999px;">
                        <input type="hidden" name="searchField" value="title">
                        <input type="text" name="searchWord" class="form-control search-input" placeholder="공지사항 검색">
                        <button class="btn search-btn px-4" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
                <c:if test="${user.user_type == 'ADMIN'}">
                    <a href="/noticeWrite.do?type=notice" class="btn btn-write shadow-sm">글쓰기</a>
                </c:if>
            </div>

            <div class="bg-white rounded shadow-sm p-4">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th style="width: 10%;">번호</th>
                            <th style="width: 55%;">제목</th>
                            <th style="width: 15%;">작성일</th>
                            <th style="width: 10%;">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty lists}">
                                <tr>
                                    <td colspan="4" class="py-5 text-muted">등록된 공지사항이 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
    							<c:forEach var="row" items="${lists}">
        							<tr>
            							<td>${row.idx}</td>
           								<td class="text-start ps-5">
    										<%-- 1. 제목에서 머리말 제거 로직 --%>
    										<c:set var="t" value="${fn:replace(row.title, '[공지] ', '')}" />
    										<c:set var="t" value="${fn:replace(t, '[안내] ', '')}" />
    										<c:set var="t" value="${fn:replace(t, '[필독] ', '')}" />
    										<c:set var="t" value="${fn:replace(t, '[공지]', '')}" />
    										<c:set var="t" value="${fn:replace(t, '[안내]', '')}" />
    										<c:set var="t" value="${fn:replace(t, '[필독]', '')}" />

    										<%-- 2. 상자 스타일 통일 (필독만 배경색 빨간색으로 변경) --%>
    										<c:choose>
        										<c:when test="${fn:contains(row.title, '필독')}">
            										<%-- 기존 클래스는 유지하고 배경색만 red 계열로 지정 --%>
            										<span class="badge-notice" style="background-color: #dc3545; border-color: #dc3545;">필독</span>
        										</c:when>
        										<c:otherwise>
            										<span class="badge-notice">공지</span>
        										</c:otherwise>
    										</c:choose>

    										<%-- 3. 깨끗해진 제목 --%>
    										<a href="/noticeView.do?idx=${row.idx}" class="text-dark text-decoration-none fw-bold ms-1">
        										${fn:trim(t)}
    										</a>
										</td>
            <td class="text-muted">
                <fmt:formatDate value="${row.createdat}" pattern="yyyy-MM-dd" />
            </td>
            <td>${row.count}</td>
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

<div id="old-paging">${pagingImg}</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
    var $j = jQuery.noConflict();

    $j(document).ready(function() {
        var table = $j('.board-container table').DataTable({
            pageLength: 10,
            paging: true,
            searching: false,
            info: false,
            lengthChange: false,
            ordering: false,
            dom: 'rtp',
            language: {
                paginate: {
                    next: "›",
                    previous: "‹"
                },
                zeroRecords: "등록된 공지사항이 없습니다."
            },
            drawCallback: function(settings) {
                var api = this.api();
                var pageInfo = api.page.info();
                var current = pageInfo.page;
                var total = pageInfo.pages;

                var $paginate = $j(settings.nTableWrapper).find('.dataTables_paginate');

                // 버튼 초기화
                $paginate.find('span, .paginate_button:not(.previous):not(.next):not(.first):not(.last)').remove();

                // 5개 단위 페이징 로직
                var start = Math.floor(current / 5) * 5;
                var end = Math.min(start + 5, total);

                var $prevBtn = $paginate.find('.previous');
                var $nextBtn = $paginate.find('.next');

                // 맨 앞으로 «
                if ($paginate.find('.first').length === 0) {
                    $j('<a/>', { 'class': 'paginate_button first', 'html': '«' })
                        .insertBefore($prevBtn)
                        .on('click', function() { api.page('first').draw('page'); });
                }

                // 숫자 버튼 5개 생성
                for (var i = start; i < end; i++) {
                    (function(idx) {
                        $j('<a/>', {
                            'class': 'paginate_button' + (idx === current ? ' current' : ''),
                            'html': idx + 1
                        })
                        .insertBefore($nextBtn)
                        .on('click', function(e) {
                            e.preventDefault();
                            if (api.page() !== idx) api.page(idx).draw('page');
                        });
                    })(i);
                }

                // 맨 뒤로 »
                if ($paginate.find('.last').length === 0) {
                    $j('<a/>', { 'class': 'paginate_button last', 'html': '»' })
                        .insertAfter($nextBtn)
                        .on('click', function() { api.page('last').draw('page'); });
                }

                // 상태에 따른 disabled 처리
                $paginate.find('.first, .previous').toggleClass('disabled', current === 0);
                $paginate.find('.last, .next').toggleClass('disabled', current >= total - 1);
            }
        });
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />