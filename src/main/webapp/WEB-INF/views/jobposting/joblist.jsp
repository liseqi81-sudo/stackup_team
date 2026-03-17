<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="pageTitle" value="StackUp | 취업공고 목록" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.dataTables_filter, .dataTables_length, .dataTables_info {
	display: none !important;
}

#jobTable {
	border-collapse: collapse !important;
	width: 100% !important;
	margin-top: 20px;
	border-radius: 10px;
	overflow: hidden;
}

#jobTable thead th {
	background-color: #f8f9fa;
	border-bottom: 2px solid #81c408;
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

.content-wrapper { margin-top: 30px !important; padding-top: 60px !important; min-height: 800px; position: relative; z-index: 1; }
</style>
<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">취업공고</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Job Postings</li>

	</ol>
</div>


<div class="container-fluid py-5">
	<div class="container py-5">

		<!-- 상단 검색/필터 박스 -->
		<div class="bg-light rounded p-4 mb-5">
			<div class="row g-3 align-items-end">

				<div class="col-md-5">
					<label class="form-label fw-bold">검색</label> <input type="text"
						id="customSearchInput" class="form-control"
						placeholder="제목/회사/스킬 검색">
				</div>

				<div class="col-md-3">
					<label class="form-label fw-bold">직무 카테고리</label> <select
						id="categorySelect" class="form-select">
						<option value="">전체보기</option>
						<option value="Backend">Backend</option>
						<option value="Frontend">Frontend</option>
						<option value="AI">AI</option>
						<option value="DevOps">DevOps</option>
					</select>
				</div>

				<div class="col-md-2">
					<label class="form-label fw-bold">표시 개수</label> <select
						id="lengthSelect" class="form-select">
						<option value="10">10개씩</option>
						<option value="20">20개씩</option>
						<option value="50">50개씩</option>
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

			</div>
		</div>

		<!-- 기업회원만 작성 버튼 -->
		<div class="d-flex justify-content-end mb-3">
			<c:if
				test="${sessionScope.user != null && sessionScope.user.user_type eq 'COMPANY'}">
				<a class="btn btn-primary rounded-pill px-4"
					href="<c:url value='/jobposting/write.do'/>"> 공고 작성 </a>
			</c:if>
		</div>

		<!-- 테이블 -->
		<div class="row">
			<div class="col-12">
				<div class="table-responsive">
					<table id="jobTable" class="table table-hover align-middle text-center" style="table-layout: fixed;">
						<thead>
							<tr class="text-center">
								<th style="width: 70px;">즐겨찾기</th>
								<th style="width: 90px;">번호</th>
								<th style="width: 30%;">공고 제목</th>
								<th style="width: 18%;">회사명</th>
								<th style="width: 110px;">근무형태</th>
								<th style="width: 130px;">마감일</th>
								<th style="width: 110px;">링크</th>
								<th style="display: none;">카테고리</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="job" items="${list}">
								<tr class="text-center align-middle">

									<!-- ⭐ 즐겨찾기 -->
									<td style="white-space: nowrap;"><c:choose>
											<c:when test="${empty sessionScope.user}">
												<a href="javascript:void(0);"
													onclick="alert('로그인이 필요한 서비스입니다.'); location.href='<c:url value='/login.do'/>?backUrl=/jobposting/joblist.do';">
													<i class="far fa-star favorite-icon fs-5"
													style="color: #ffb524;"></i>
												</a>
											</c:when>

											<c:otherwise>
												<i
													class="${job.is_fav == 'Y' ? 'fas' : 'far'} fa-star favorite-icon fs-5"
													style="color: #ffb524; cursor: pointer;"
													onclick="toggleFavorite(this, '${job.postingId}')"></i>
											</c:otherwise>
										</c:choose></td>

									<!-- 번호 -->
									<td>${job.postingId}</td>

									<!-- 제목 -->
									<td class="text-start"><a
										class="fw-bold text-dark text-decoration-none"
										style="display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 300px;"
										href="<c:url value='/jobposting/jobdetail.do?postingId=${job.postingId}'/>">
											${job.title} </a></td>

									<!-- 회사명 -->
									<td style="white-space: nowrap;">${job.companyName}</td>

									<!-- 근무형태 -->
									<td><c:choose>
											<c:when test="${not empty job.postType}">
												<span class="badge"
													style="background-color: #81c408; color: white; padding: 6px 12px;">
													${job.postType} </span>
											</c:when>
											<c:otherwise>
												<span class="text-muted small">-</span>
											</c:otherwise>
										</c:choose></td>

									<!-- 마감일 -->
									<td style="white-space: nowrap;">
									  <c:choose>
									
									    <c:when test="${empty job.deadline}">
									      상시
									    </c:when>
									
									    <c:otherwise>
									      <fmt:formatDate value="${job.deadline}" pattern="yyyy-MM-dd"/>
									    </c:otherwise>
									
									  </c:choose>
									</td>

									<!-- 링크 -->
									<td><c:choose>
											<c:when test="${not empty job.postingUrl}">
												<a href="${job.postingUrl}" target="_blank"
													class="btn btn-sm border border-secondary rounded-pill px-3 text-primary fw-bold">
													보기 </a>
											</c:when>
											<c:otherwise>
												<span class="text-muted small">-</span>
											</c:otherwise>
										</c:choose></td>

									<!-- 숨김 필터 -->
									<td style="display: none;">${job.jobCategory}</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<c:if test="${empty list}">
					<div class="text-center text-muted py-5">등록된 취업공고가 없습니다.</div>
				</c:if>
			</div>
		</div>

	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>
function toggleFavorite(element, postingId) {
    const isAdded = element.classList.contains('fas');
    const action = isAdded ? 'remove' : 'add';

    const path = "${pageContext.request.contextPath}/favorite.do"
        + "?action=" + action
        + "&targetId=" + postingId
        + "&type=JOB";

    fetch(path)
    .then(response => {
        if (response.ok) {
            if (isAdded) element.classList.replace('fas', 'far');
            else element.classList.replace('far', 'fas');
        } else {
            alert("서버 연결에 실패했습니다. (응답 오류)");
        }
    })
    .catch(error => {
        console.error("에러 발생:", error);
        alert("통신 중 에러가 발생했습니다.");
    });
}
</script>
<script>
	$(document)
			.ready(
					function() {

						// DataTable 초기화 (검색 UI 숨기고 기능만 사용)
						var table = $('#jobTable')
								.DataTable(
										{
											pageLength : 10,
											paging : true,
											searching : true,
											info : false,
											lengthChange : false,
											ordering : true,
											dom : 'rtp',
											language : {
												paginate : {
													next : "›",
													previous : "‹"
												},
												zeroRecords : "검색 결과가 없습니다."
											},
											drawCallback : function(settings) {
												var api = this.api();
												var pageInfo = api.page.info();
												var current = pageInfo.page;
												var total = pageInfo.pages;

												var $paginate = $(
														settings.nTableWrapper)
														.find(
																'.dataTables_paginate');

												// 숫자/ellipsis 제거
												$paginate
														.find(
																'span, .ellipsis, .paginate_button:not(.previous):not(.next):not(.first):not(.last)')
														.remove();

												// 5개 단위 페이징
												var start = Math
														.floor(current / 5) * 5;
												var end = Math.min(start + 5,
														total);

												var $prevBtn = $paginate
														.find('.previous');
												var $nextBtn = $paginate
														.find('.next');

												// 맨 앞으로 «
												if ($paginate.find('.first').length === 0) {
													$(
															'<a/>',
															{
																'class' : 'paginate_button first',
																'html' : '«'
															})
															.insertBefore(
																	$prevBtn)
															.on(
																	'click',
																	function() {
																		api
																				.page(
																						'first')
																				.draw(
																						'page');
																	});
												}

												// 숫자 버튼 5개 생성
												for (var i = start; i < end; i++) {
													(function(idx) {
														$(
																'<a/>',
																{
																	'class' : 'paginate_button'
																			+ (idx === current ? ' current'
																					: ''),
																	'html' : idx + 1
																})
																.insertBefore(
																		$nextBtn)
																.on(
																		'click',
																		function(
																				e) {
																			e
																					.preventDefault();
																			if (api
																					.page() !== idx)
																				api
																						.page(
																								idx)
																						.draw(
																								'page');
																		});
													})(i);
												}

												// 맨 뒤로 »
												if ($paginate.find('.last').length === 0) {
													$(
															'<a/>',
															{
																'class' : 'paginate_button last',
																'html' : '»'
															})
															.insertAfter(
																	$nextBtn)
															.on(
																	'click',
																	function() {
																		api
																				.page(
																						'last')
																				.draw(
																						'page');
																	});
												}

												// 버튼 활성/비활성
												$paginate.find(
														'.first, .previous')
														.toggleClass(
																'disabled',
																current === 0);
												$paginate
														.find('.last, .next')
														.toggleClass(
																'disabled',
																current >= total - 1);
											}
										});

						function performSearch() {
							var keyword = $('#customSearchInput').val();
							var category = $('#categorySelect').val();

							// 숨김 컬럼 인덱스(6) = 카테고리필터
							table.column(6).search(
									category ? '^'
											+ $.fn.dataTable.util
													.escapeRegex(category)
											+ '$' : '', true, false);

							table.search(keyword).draw();
						}

						$('#applyBtn').on('click', function() {
							performSearch();
						});

						$('#resetBtn').on('click', function() {
							$('#customSearchInput').val('');
							$('#categorySelect').val('');
							table.search('').columns().search('').draw();
						});

						$('#customSearchInput').on('keydown', function(e) {
							if (e.keyCode === 13) {
								e.preventDefault();
								performSearch();
							}
						});

						$('#categorySelect').on('change', function() {
							performSearch();
						});

						$('#lengthSelect').on('change', function() {
							table.page.len($(this).val()).draw();
						});

					});
</script>