<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<c:set var="pageTitle" value="StackUp | 공모전/대외활동" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>StackUp - 공모전/대외활동 목록</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<!-- 
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/style.css"
	rel="stylesheet"> -->

<style>
.dataTables_filter, .dataTables_length, .dataTables_info {
	display: none !important;
}

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
	padding: 0 !important;
	margin: 0 2px !important;
	border-radius: 10px !important;
	border: 1px solid #ffb524 !important;
	color: #81c408 !important;
	background: white !important;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.dataTables_wrapper .dataTables_paginate .paginate_button.current {
	background: #81c408 !important;
	color: white !important;
	border: 1px solid #81c408 !important;
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.disabled)
	{
	background: #ffb524 !important;
	color: white !important;
	border: 1px solid #ffb524 !important;
}

.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
	border: 1px solid #ddd !important;
	color: #ccc !important;
	cursor: default;
	opacity: 0.5;
}

.contest-thumb {
	width: 100px;
	height: 135px; /* ← 직사각형 비율 */
	overflow: hidden;
	border-radius: 10px; /* 살짝 둥근 네모 */
	flex-shrink: 0;
}

.contest-thumb img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 비율 유지하면서 꽉 채움 */
}

.h5 a:hover {
    color:#82b541;
}

.skillup-btn {
  border: 1px solid #f57c00;
  color: #f57c00;
  background-color: white;
  padding: 4px 14px;
  border-radius: 20px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.skillup-btn:hover {
  background-color: #f57c00;
  color: white;
}

.skillup-btn.active {
  background-color: #f57c00;
  color: white;
}
</style>
</head>
<body>


<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">공모전 / 대외활동</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Contest</li>

		</ol>
	</div>

	<div class="container-fluid py-5">
		<div class="container py-5">

			<!-- 검색/필터 -->
			<form method="get" action="<c:url value='/contest/list.do'/>"
				class="bg-light rounded p-4 mb-4">
				<div class="row g-3 align-items-end">
					<div class="col-md-5">
						<label class="form-label">검색</label> <input type="text"
							id="customSearchInput" name="keyword" value="${keyword}"
							class="form-control" placeholder="공모전명 또는 주최기관">
					</div>
					<div class="col-md-3">
						<label class="form-label">카테고리</label> <select id="categorySelect"
							name="category" class="form-select">
							<option value="ALL" ${category=='ALL'?'selected':''}>전체</option>

							<c:forEach items="${categoryList}" var="cat">
								<option value="${cat}" ${category==cat?'selected':''}>${cat}</option>
							</c:forEach>
						</select>
					</div>
					<%--         <div class="col-md-3">
          <label class="form-label">카테고리</label>
          <select id="categorySelect" name="category" class="form-select">
            <option value="ALL" ${category=='ALL'?'selected':''}>전체</option>
            <option value="공모전" ${category=='공모전'?'selected':''}>공모전</option>
            <option value="대외활동" ${category=='대외활동'?'selected':''}>대외활동</option>
          </select>
        </div> --%>

					<div class="col-md-2">
						<label class="form-label">정렬</label> 
						<select id="sortSelect" name="sort" class="form-select">
						  <option value="deadline" ${sort=='deadline'?'selected':''}>마감임박순</option>
						  <option value="new" ${sort=='new'?'selected':''}>최신등록순</option>
						</select>
					</div>
					<div class="col-md-2">
						<label class="form-label d-none d-md-block">&nbsp;</label>
						<div class="d-flex gap-2">
							<button type="button" id="applyBtn"
								class="btn btn-primary rounded-pill py-2 text-white flex-grow-1">
								검색</button>
							<button type="button" id="resetBtn"
								class="btn btn-outline-secondary rounded-pill py-2 px-3"
								title="초기화">
								<i class="fas fa-undo"></i>
							</button>
						</div>
					</div>
					<!-- <div class="col-md-2 d-grid">
						<button class="btn btn-primary rounded-pill py-2">적용</button>
						<button type="button" id="resetBtn"
							class="btn btn-outline-secondary rounded-pill py-2 px-3"
							title="초기화">
							<i class="fas fa-undo"></i>
						</button>
					</div> -->
				</div>
			</form>

			<%-- <div class="text-muted mb-2">총 데이터(현재 내려온 개수):
				${fn:length(contestList) }</div> --%>
			<!-- 카드 목록 -->
			<div class="row g-4">
				<c:forEach items="${contestList}" var="c">
					<div class="col-lg-4 col-md-6 contest-card" data-id="${c.contId}">
						<div class="bg-light rounded p-4 h-100">
							<div class="d-flex gap-3 align-items-center">
								<div class="contest-thumb">
									<img src="${c.logoImg}" alt="${c.contName}">
								</div>
								<div class="flex-grow-1">
									<a href="${c.siteUrl}" target="_blank" class="h5 mb-1 text-dark text-decoration-none">
									    ${c.contName}
									</a>
									<div class="text-muted small mb-1">${c.organizer}</div>

									<div class="small">
										<b>마감</b> :
										<fmt:formatDate value="${c.deadline}" pattern="yyyy-MM-dd" />
									</div>

									<div class="d-flex align-items-center gap-2 mt-2">

								    <c:choose>
									    <c:when test="${empty sessionScope.user}">
									        <a href="javascript:void(0);"
									           onclick="alert('로그인이 필요한 서비스입니다.'); location.href='<c:url value='/login.do'/>?backUrl=/contest/contestlist.do';">
									            <span class="skillup-btn">SkillUp!</span>
									        </a>
									    </c:when>
									    <c:otherwise>
									        <button class="skillup-btn ${c.is_skillup == 'Y' ? 'active' : ''}"
									              style="cursor:pointer;"
									              onclick="toggleSkillUpContest(this, '${c.contId}')">
									            ${c.is_skillup == 'Y' ? '등록됨' : 'SkillUp!'}
									        </button>
									    </c:otherwise>
									</c:choose>
								
								    <!-- 즐겨찾기 -->
								    <c:choose>
								        <c:when test="${empty sessionScope.user}">
								            <button type="button"
								                class="btn btn-sm border border-secondary rounded-pill px-3"
								                onclick="alert('로그인이 필요한 서비스입니다.'); location.href='<c:url value='/login.do'/>?backUrl=/contest/contestlist.do';">
								                <i class="far fa-star" style="color: #ffb524;"></i>
								            </button>
								        </c:when>
								
								        <c:otherwise>
								            <button type="button"
								                class="btn btn-sm border border-secondary rounded-pill px-3"
								                onclick="toggleFavoriteContest(this, '${c.contId}')">
								                <i class="${c.is_fav == 'Y' ? 'fas' : 'far'} fa-star"
								                    style="color: #ffb524;"></i>
								            </button>
								        </c:otherwise>
								    </c:choose>
								
								</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>

				<c:if test="${empty contestList}">
					<div class="col-12 text-center text-muted py-5">조건에 맞는
						공모전/대외활동이 없어요.</div>
				</c:if>
			</div>

			<!-- DataTables용 테이블 (숨김) -->
			<table id="contestTable" class="table table-striped" style="display: none;">
			  <thead>
			    <tr>
			      <th>CONT_ID</th>
			      <th>CONT_NAME</th>
			      <th>ORGANIZER</th>
			      <th>DEADLINE</th>
			      <th>CATEGORY</th>
			      <th>CREATEDATE</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:forEach items="${contestList}" var="c">
			      <tr data-id="${c.contId}">
			        <td>${c.contId}</td>
			        <td>${c.contName}</td>
			        <td>${c.organizer}</td>
			        <td><fmt:formatDate value="${c.deadline}" pattern="yyyy-MM-dd" /></td>
			        <td>${c.category}</td>
			        <td><fmt:formatDate value="${c.createdate}" pattern="yyyy-MM-dd" /></td>
			      </tr>
			    </c:forEach>
			  </tbody>
			</table>

			<!-- 실제 커스텀 페이징 -->
			<!-- <div id="customPagination" class="d-flex justify-content-center mt-5"></div>
 -->
		</div>
	</div>

	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
		<i class="fa fa-arrow-up"></i>
	</a>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	<!-- <script
		src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script> -->

<script>
$(document).ready(	function() {

	// ✅ DataTables: 숨겨진 테이블을 "검색/페이지 계산 엔진"으로 사용
	var table = $('#contestTable').DataTable({
		pageLength : 12, // ✅ 카드도 12개씩
		lengthChange : false,
		info : false,
		searching : true,
		paging : true,
		ordering : true	,
		pagingType : "simple_numbers",
		dom : 'tp', // ✅ table(t)는 숨겨져 있으니 paginate만 쓰기
		language : {
			paginate : {
				next : "›",
				previous : "‹"
			},
			zeroRecords : "조건에 맞는 공모전/대외활동이 없어요."
		},
		drawCallback: function(settings) {
			  var api = this.api();
			  var pageInfo = api.page.info();
			  var current = pageInfo.page;
			  var total = pageInfo.pages;

			  var idsToShow = [];
			  api.rows({
			    page: 'current',
			    search: 'applied'
			  }).every(function() {
			    var contId = String($(this.node()).attr('data-id') || '').trim();
			    if (contId) {
			      idsToShow.push(contId);
			    }
			  });

			  $('.contest-card').hide();
			  idsToShow.forEach(function(id) {
			    $('.contest-card[data-id="' + id + '"]').show();
			  });

			  $('.contest-card').each(function() {
			    var cardId = String($(this).attr('data-id') || '').trim();
			    if (idsToShow.includes(cardId)) {
			      $(this).show();
			    }
			  });

			  var $paginate = $(settings.nTableWrapper).find('.dataTables_paginate');

			  $paginate.find('span').remove();
			  $paginate.find('.ellipsis').remove();
			  $paginate.find('.paginate_button:not(.previous):not(.next):not(.first):not(.last)').remove();

			  var start = Math.floor(current / 5) * 5;
			  var end = Math.min(start + 5, total);

			  var $prevBtn = $paginate.find('.previous');
			  var $nextBtn = $paginate.find('.next');

			  if ($paginate.find('.first').length === 0) {
			    $('<a/>', {
			      'class': 'paginate_button first',
			      'html': '«'
			    }).insertBefore($prevBtn).on('click', function(e) {
			      e.preventDefault();
			      api.page('first').draw('page');
			    });
			  }

			  for (var i = start; i < end; i++) {
			    (function(idx) {
			      $('<a/>', {
			        'class': 'paginate_button' + (idx === current ? ' current' : ''),
			        'html': idx + 1
			      }).insertBefore($nextBtn).on('click', function(e) {
			        e.preventDefault();
			        if (api.page() !== idx) {
			          api.page(idx).draw('page');
			        }
			      });
			    })(i);
			  }

			  if ($paginate.find('.last').length === 0) {
			    $('<a/>', {
			      'class': 'paginate_button last',
			      'html': '»'
			    }).insertAfter($nextBtn).on('click', function(e) {
			      e.preventDefault();
			      api.page('last').draw('page');
			    });
			  }

			  $paginate.find('.first, .previous').toggleClass('disabled', current === 0);
			  $paginate.find('.last, .next').toggleClass('disabled', current >= total - 1);
			}
	});
	
	function performSearch() {
		  var keyword = $('#customSearchInput').val().trim();
		  var category = $('#categorySelect').val();
		  var categoryCol = table.column(4);
		  var sort = $('#sortSelect').val();
		  
			// 전체 검색
		  table.search(keyword);

		// 카테고리 검색
		  if (category === 'ALL' || category === '') {
		    table.column(4).search('');
		  } else {
		    table.column(4).search(category, false, false);
		  }
		
		// 정렬
		  if (sort === 'deadline') {
		    table.order([3, 'asc']);   // DEADLINE
		  } else if (sort === 'new') {
		    table.order([5, 'desc']);  // CREATEDATE
		  }

		  table.page(0).draw();
		}
	
	// 검색창
	$('#customSearchInput').on('keyup search', performSearch);
	$('#categorySelect').on('change', performSearch);
	$('#sortSelect').on('change', performSearch);

	$('#applyBtn').on('click', function() {
	  performSearch();
	});

	$('#resetBtn').on('click', function() {
	  $('#customSearchInput').val('');
	  $('#categorySelect').val('ALL');
	  $('#sortSelect').val('deadline');
	  performSearch();
	});
});
</script>
<script>
function toggleFavoriteContest(btn, contId) {
    const icon = btn.querySelector("i");
    const isAdded = icon.classList.contains("fas");
    const action = isAdded ? "remove" : "add";

    const path = "${pageContext.request.contextPath}/favorite.do"
        + "?action=" + action
        + "&targetId=" + contId
        + "&type=CONTEST";

    fetch(path)
    .then(res => {
        if (!res.ok) throw new Error("response not ok");
        if (isAdded) icon.classList.replace("fas", "far");
        else icon.classList.replace("far", "fas");
    })
    .catch(err => {
        console.error(err);
        alert("즐겨찾기 처리 중 오류가 발생했습니다.");
    });
}

function toggleSkillUpContest(element, contId) {
	  const isAdded = element.classList.contains('active');
	  const action = isAdded ? 'remove' : 'add';
	  const path = "${pageContext.request.contextPath}/contest/skillup.do?action="
	            + action + "&targetId=" + contId + "&type=CONTEST";

	  fetch(path)
	    .then(response => response.text())
	    .then(result => {
	      if (result === "addSuccess") {
	        element.classList.add('active');
	        element.textContent = '등록됨';
	      } else if (result === "removeSuccess") {
	        element.classList.remove('active');
	        element.textContent = 'SkillUp!';
	      } else if (result === "dup") {
	        alert("이미 등록된 항목입니다.");
	        element.classList.add('active');
	        element.textContent = '등록됨';
	      } else if (result === "login") {
	        alert('로그인이 필요한 서비스입니다.');
	        location.href = '<c:url value="/login.do"/>?backUrl=/contest/contestlist.do';
	      } else {
	        alert("등록 실패: " + result);
	      }
	    })
	    .catch(error => {
	      console.error("에러:", error);
	      alert("서버 연결 실패");
	    });
}
</script>
</body>
</html>