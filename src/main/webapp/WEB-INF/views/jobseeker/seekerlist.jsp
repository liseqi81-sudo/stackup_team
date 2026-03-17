<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="pageTitle" value="StackUp | 인재 정보 목록" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* 취업공고 CSS와 100% 동일 */
.dataTables_filter, .dataTables_length, .dataTables_info { display: none !important; }
#seekerTable { border-collapse: collapse !important; width: 100% !important; margin-top: 20px; border-radius: 10px; overflow: hidden; }
#seekerTable thead th { background-color: #f8f9fa; border-bottom: 2px solid #81c408; }
.dataTables_paginate { display: flex !important; justify-content: center !important; margin: 50px auto !important; width: 100% !important; }
.dataTables_wrapper .dataTables_paginate .paginate_button { display: inline-flex !important; align-items: center; justify-content: center; min-width: 45px !important; height: 45px !important; margin: 0 2px !important; border-radius: 10px !important; border: 1px solid #ffb524 !important; color: #81c408 !important; background: white !important; font-weight: 600; cursor: pointer; transition: 0.3s; }
.dataTables_wrapper .dataTables_paginate .paginate_button.current { background: #81c408 !important; color: white !important; border: 1px solid #81c408 !important; }
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">인재 정보</h1>

    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Job Seekers</li>
        </ol>
        </div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="bg-light rounded p-4 mb-5">
            <div class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label fw-bold">검색</label> 
                    <input type="text" id="customSearchInput" class="form-control" placeholder="제목/기술/작성자 검색">
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold">직무 카테고리</label> 
                    <select id="categorySelect" class="form-select">
                        <option value="">전체보기</option>
                        <option value="Backend">Backend</option>
                        <option value="Frontend">Frontend</option>
                        <option value="AI">AI</option>
                        <option value="DevOps">DevOps</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-bold">표시 개수</label> 
                    <select id="lengthSelect" class="form-select">
                        <option value="10">10개씩</option>
                        <option value="20">20개씩</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <div class="d-flex gap-2">
                        <button type="button" id="applyBtn" class="btn btn-primary rounded-pill py-2 text-white flex-grow-1">검색</button>
                        <button type="button" id="resetBtn" class="btn btn-outline-secondary rounded-pill py-2 px-3"><i class="fas fa-undo"></i></button>
                    </div>
                </div>
            </div>
        </div>
        
       <div class="d-flex justify-content-end mb-3">
    		<%-- 버튼은 항상 노출 --%>
    		<a href="javascript:void(0);" onclick="handleSeekerRegistration();"
       		   class="btn btn-primary border-2 py-2 px-4 rounded-pill text-white fw-bold">
        		<i class="fas fa-pencil-alt me-2"></i>인재 등록
    		</a>
		</div>

        <div class="table-responsive">
            <table id="seekerTable" class="table table-hover align-middle text-center" style="table-layout: fixed;">
                <thead>
                    <tr>
                        <th style="width: 70px;">즐겨찾기</th>
                        <th style="width: 90px;">번호</th>
                        <th style="width: 30%;">인재 정보 제목</th>
                        <th style="width: 18%;">작성자</th>
                        <th style="width: 110px;">카테고리</th>
                        <th style="width: 130px;">등록일</th>
                        <th style="display: none;">카테고리필터</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seeker" items="${seekerList}">
                        <tr>
                            <td>
                                <i class="${seeker.isFav == 'Y' ? 'fas' : 'far'} fa-star favorite-icon fs-5"
                                   style="color: #ffb524; cursor: pointer;"
                                   onclick="toggleFavorite(this, '${seeker.seekId}')"></i>
                            </td>
                            <td>${seeker.seekId}</td>
                            <td class="text-start">
                                <a class="fw-bold text-dark text-decoration-none"
                                   style="display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
                                   href="<c:url value='/jobseeker/seekerdetail.do?seekId=${seeker.seekId}'/>">
                                    ${seeker.seekTitle}
                                </a>
                            </td>
                            <td>${seeker.userName}</td>
                            <td><span class="badge" style="background-color: #81c408; color: white; padding: 6px 12px;">${seeker.seekCategory}</span></td>
                            <td>${seeker.createDate}</td>
                            <td style="display: none;">${seeker.seekCategory}<c:choose><c:when test="${seeker.seekCategory == 'Backend'}">백엔드</c:when><c:when test="${seeker.seekCategory == 'Frontend'}">프론트엔드</c:when><c:when test="${seeker.seekCategory == 'AI'}">인공지능</c:when><c:when test="${seeker.seekCategory == 'DevOps'}">데브옵스</c:when></c:choose></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
var $j = jQuery.noConflict();

$j(document).ready(function() {
    // [1] DataTable 초기화
    var table = $j('#seekerTable').DataTable({
        pageLength: 10,
        paging: true,
        searching: true,
        info: false,
        lengthChange: false,
        ordering: true,
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
                        'html': idx + 1,
                        'style': 'cursor:pointer'
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

    function performSearch() {
        var keyword = $j('#customSearchInput').val(); // 제목/기술 검색어
        var category = $j('#categorySelect').val(); // 선택한 카테고리 (Backend 등)

        // 한글 변환 맵핑
        var korName = "";
        if(category === "Backend") korName = "백엔드";
        else if(category === "Frontend") korName = "프론트엔드";
        else if(category === "AI") korName = "인공지능";
        else if(category === "DevOps") korName = "데브옵스";

        // 검색창 키워드와 카테고리(한글/영어 둘 다)를 합쳐서 전체 검색을 때려버립니다.
        // 공백으로 구분해서 넣으면 DataTable이 'AND' 검색처럼 동작합니다.
        var finalSearch = keyword + " " + category + " " + korName;

        // trim()으로 앞뒤 공백만 깎아서 검색!
        table.search(finalSearch.trim()).draw();
    }
    
    // [3] 이벤트 연결
    $j('#applyBtn').on('click', function() {
        performSearch();
    });
    
    $j('#categorySelect').on('change', function() {
        performSearch();
    });

    $j('#customSearchInput').on('keyup', function(e) {
        if (e.which === 13) performSearch();
    });

    $j('#lengthSelect').on('change', function() {
        table.page.len($j(this).val()).draw();
    });

    $j('#resetBtn').on('click', function() {
        $j('#customSearchInput').val('');
        $j('#categorySelect').val('');
        $j('#lengthSelect').val('10');
        table.search('').columns().search('').page.len(10).draw();
    });
});
</script>

<script>
function handleSeekerRegistration() {
    // 1. 세션에서 필요한 정보 추출 (따옴표 필수!)
    const userId = "${sessionScope.user.user_id}";
    const userType = "${sessionScope.user.user_type}";

    // 2. 로그인 여부 확인
    if (!userId || userId === "") {
        if (confirm("로그인 후 이용 가능합니다.\n로그인 페이지로 이동할까요?")) {
            location.href = "<c:url value='/login.do'/>";
        }
        return;
    }

    // 3. 기업 회원(CORP/COMPANY) 여부 확인
    // 사용자님의 기업 회원 타입명이 'CORP'인지 'COMPANY'인지 확인 후 맞춰주세요.
    if (userType.toUpperCase() === 'CORP' || userType.toUpperCase() === 'COMPANY') {
        alert("기업 회원입니다. 인재 정보 등록은 일반 회원만 가능합니다.");
        return;
    }

    // 4. 모든 조건 통과 시 등록 페이지로 이동
    location.href = "<c:url value='/jobseeker/seekerwrite.do'/>";
}
</script>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />