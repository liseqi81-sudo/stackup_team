<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="StackUp | 수강 리뷰" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* --- 기본 스타일 (공지사항과 통일감 유지) --- */
.board-container { max-width: 1000px; margin: 0 auto; }
.table thead { background-color: rgba(129,196,8, 0.05); border-top: 2px solid #81c408; }
.table th { color: #333; font-weight: 700; padding: 15px 0; }
.table td { vertical-align: middle; padding: 15px 0; }
.btn-write { border-radius: 999px; padding: 10px 25px; background-color: #81c408; border: none; color: white; font-weight: 600; }
.search-input { border-radius: 999px 0 0 999px !important; }
.search-btn { border-radius: 0 999px 999px 0 !important; background-color: #81c408; color: white; border: none; }
/* 리뷰용 뱃지 색상 변경 */
.badge-review { background-color: #81c408; color: #fff; font-size: 11px; padding: 4px 8px; border-radius: 5px; margin-right: 5px; }

/* ⭐ 별점 스타일 추가 */
.list-star { color: #ffc107; font-size: 13px; margin-left: 5px; }
.list-score { color: #666; font-size: 12px; font-weight: 600; }

/* --- 페이징 스타일 --- */
.dataTables_paginate { display: flex !important; justify-content: center !important; align-items: center !important; margin: 50px auto !important; width: 100% !important; float: none !important; }
.dataTables_wrapper .dataTables_paginate .paginate_button { display: inline-flex !important; align-items: center; justify-content: center; min-width: 45px !important; height: 45px !important; padding: 0 !important; margin: 0 2px !important; border-radius: 10px !important; border: 1px solid #ffb524 !important; color: #81c408 !important; background: white !important; font-weight: 600; cursor: pointer; transition: 0.3s; text-decoration: none !important; }
.dataTables_wrapper .dataTables_paginate .paginate_button.current { background: #81c408 !important; color: white !important; border: 1px solid #81c408 !important; }
.dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.disabled) { background: #ffb524 !important; color: white !important; border: 1px solid #ffb524 !important; }
.dataTables_wrapper .dataTables_paginate .paginate_button.disabled { border: 1px solid #ddd !important; color: #ccc !important; cursor: default; opacity: 0.5; }

#old-paging { display: none; }
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">수강 리뷰</h1>

    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Review</li>
        </ol>
        </div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="board-container">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div style="max-width: 350px;">
                    <form action="/reviewList.do" method="get" class="input-group shadow-sm" style="border-radius: 999px;">
                        <input type="hidden" name="searchField" value="title">
                        <input type="text" name="searchWord" id="customSearch" class="form-control search-input" placeholder="리뷰 검색">
                        <button class="btn search-btn px-4" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="/reviewWrite.do?type=review" class="btn btn-write shadow-sm">리뷰 쓰기</a>
                    </c:when>
                    <c:otherwise>
                        <button type="button" onclick="alert('로그인 후 이용 가능합니다.'); location.href='<c:url value='/login.do'/>';" class="btn btn-write shadow-sm">리뷰 쓰기</button>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="bg-white rounded shadow-sm p-4">
                <table class="table table-hover text-center" id="reviewTable">
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
                                    <td colspan="4" class="py-5 text-muted">등록된 리뷰가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
    <c:forEach var="row" items="${lists}">
        <tr>
            <td>${row.idx}</td>
            <td class="text-start ps-4">
                <%-- 1. 별점을 제목보다 먼저 나오게 배치 (REVIEW 상자 자리) --%>
                <span class="list-star me-2" style="color: #ffc107;">
                    <i class="fas fa-star"></i>
                    <span class="list-score" style="color: #333; font-weight: bold;">${row.review_star}.0</span>
                </span>

                <%-- 2. 제목은 별점 뒤에 따라오게 배치 --%>
                <a href="/reviewView.do?idx=${row.idx}" class="text-dark text-decoration-none fw-bold">
                    ${row.title}
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
        var table = $j('#reviewTable').DataTable({
            pageLength: 10,
            paging: true,
            searching: true,
            info: false,
            lengthChange: false,
            ordering: false,
            dom: 'rtp',
            language: {
                paginate: { next: "›", previous: "‹" },
                zeroRecords: "검색 결과가 없습니다."
            },
            drawCallback: function(settings) {
                var api = this.api();
                var pageInfo = api.page.info();
                var current = pageInfo.page;
                var total = pageInfo.pages;
                var $paginate = $j(settings.nTableWrapper).find('.dataTables_paginate');

                $paginate.find('span, .paginate_button:not(.previous):not(.next):not(.first):not(.last)').remove();
                
                var start = Math.floor(current / 5) * 5;
                var end = Math.min(start + 5, total);

                var $prevBtn = $paginate.find('.previous');
                var $nextBtn = $paginate.find('.next');

                if ($paginate.find('.first').length === 0) {
                    $j('<a/>', { 'class': 'paginate_button first', 'html': '«' })
                        .insertBefore($prevBtn)
                        .on('click', function() { api.page('first').draw('page'); });
                }

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

                if ($paginate.find('.last').length === 0) {
                    $j('<a/>', { 'class': 'paginate_button last', 'html': '»' })
                        .insertAfter($nextBtn)
                        .on('click', function() { api.page('last').draw('page'); });
                }

                $paginate.find('.first, .previous').toggleClass('disabled', current === 0);
                $paginate.find('.last, .next').toggleClass('disabled', current >= total - 1 || total === 0);
            }
        });

        $j('#customSearch').on('keyup', function() {
            table.search(this.value).draw();
        });
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />