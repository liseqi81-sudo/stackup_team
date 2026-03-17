<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="pageTitle" value="StackUp | 자격증 목록" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
        .dataTables_filter, .dataTables_length, .dataTables_info { display: none !important; }
        #certiTable { border-collapse: collapse !important; width: 100% !important; margin-top: 20px; border-radius: 10px; overflow: hidden; }
        /* 1. 헤더 중앙 정렬 추가 */
	    #certiTable thead th { 
	        background-color: #f8f9fa; 
	        border-bottom: 2px solid #81c408; 
	        text-align: center !important; /* 추가 */
	    }
	
	    /* 2. 본문 중앙 및 세로 중앙 정렬 추가 */
	    #certiTable tbody td { 
	        text-align: center !important; /* 추가 */
	        vertical-align: middle !important; /* 추가 */
	    }

        /* 페이징 버튼 디자인 */
        .dataTables_paginate {
		    display: flex !important;
		    justify-content: center !important; /* 가로 중앙 정렬 */
		    align-items: center !important;
		    margin: 50px auto !important; /* 상하 여백 50px, 좌우 자동(중앙) */
		    width: 100% !important; /* 전체 너비를 차지하게 해서 중앙 정렬 보장 */
		    float: none !important; /* 혹시 모를 float 속성 제거 */
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
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover:not(.disabled) {
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
        	    
	    .certi-link {
	        color: #333;
	        font-weight: bold;
	        text-decoration: none;
	        transition: 0.2s;
	        border-bottom: 1px dashed transparent;
	    }
	    .certi-link:hover {
	        color: #81c408; /* 사이트 포인트 컬러 */
	        border-bottom: 1px dashed #81c408;
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
		
		/* 등록된 상태 */
		.skillup-btn.active {
		  background-color: #f57c00;
		  color: white;
		}
		
    </style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">자격증 정보</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Certifications</li>
    </ol>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="bg-light rounded p-4 mb-5">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold">검색</label>
                    <input type="text" id="customSearchInput" class="form-control" placeholder="자격증명 또는 시행처 입력">
                </div>

               <div class="col-md-2">
		            <label class="form-label fw-bold">대분류</label>
		            <select id="categorySelect" class="form-select">
		                <option value="">전체보기</option>
		                <c:forEach var="cat" items="${catList}">
		                    <option value="${cat.CERTI_TYPE}">${cat.CERTI_TYPE}</option>
		                </c:forEach>
		            </select>
		        </div>
		
		        <div class="col-md-2">
		            <label class="form-label fw-bold">중분류</label>
		            <select id="subCategorySelect" class="form-select" disabled>
		                <option value="">대분류를 선택하세요</option>
		            </select>
		        </div>
		        
                <div class="col-md-2">
                    <label class="form-label fw-bold">표시 개수</label>
                    <select id="lengthSelect" class="form-select">
                        <option value="10">10개씩</option>
                        <option value="20">20개씩</option>
                        <option value="50">50개씩</option>
                    </select>
                </div>
                
                <div class="col-md-2">
				    <label class="form-label d-none d-md-block">&nbsp;</label> <div class="d-flex gap-2">
				        <button type="button" id="applyBtn" class="btn btn-primary rounded-pill py-2 text-white flex-grow-1">
				            검색
				        </button>
				        <button type="button" id="resetBtn" class="btn btn-outline-secondary rounded-pill py-2 px-3" title="초기화">
				            <i class="fas fa-undo"></i>
				        </button>
				    </div>
				</div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
            	<div class="d-flex justify-content-start mb-2 mt-3">
    <span class="text-muted" style="font-size: 0.85rem; letter-spacing: -0.5px;">
        <i class="fas fa-info-circle me-1" style="color: #81c408;"></i> 
        자격증명을 클릭하면 해당 접수 사이트로 이동합니다.
    </span>
</div>
            
                <div class="table-responsive">
                    <table id="certiTable" class="table table-hover">
                        <thead>
                            <tr>
                            	<th style="width: 10%;">즐겨찾기</th>
                                <th style="width: 10%;">번호</th>
                                <th style="width: 20%;">자격증명</th>
                                <th style="width: 20%;">시행처</th>
                                <th style="width: 10%;">구분</th>
                                <th style="width: 15%;">접수마감일자</th>                               
                                <th style="width: 10%;">SkillUp 등록</th> 
                                <th style="display:none;">대분류필터</th> 
                                <th style="display:none;">중분류필터</th>
                            </tr>
                        </thead>
                      <tbody>
    <c:forEach var="dto" items="${cList}">
        <tr>
            <td>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="javascript:void(0);" onclick="alert('로그인이 필요한 서비스입니다.'); location.href='<c:url value='/login.do'/>?backUrl=certification.do';">
                            <i class="far fa-star favorite-icon" style="color: #ffb524;"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <i class="${dto.is_fav == 'Y' ? 'fas' : 'far'} fa-star favorite-icon" 
                           style="color: #ffb524; cursor: pointer;"
                           onclick="toggleFavorite(this, '${dto.certi_id}')"></i>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${dto.certi_id}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty dto.url}">
                        <a href="${dto.url}" target="_blank" class="certi-link">${dto.certi_name}</a>
                    </c:when>
                    <c:otherwise><strong>${dto.certi_name}</strong></c:otherwise>
                </c:choose>
            </td>
            <td>${dto.organizer}</td>
            <td>
                <span class="badge" style="background-color: ${dto.is_regular == 1 ? '#81c408' : '#ffb524'}; color: white; padding: 6px 12px; font-weight: 500;">
                    ${dto.is_regular == 1 ? '정기' : '상시'}
                </span>
            </td>
            <td>
    <div style="font-size: 0.9rem;">
        <%-- 필기 날짜 출력 --%>
        <c:if test="${not empty dto.deadline_written}">
            <div>
                <strong>필기:</strong> 
                <c:catch var="ex">
                    <fmt:formatDate value="${dto.deadline_written}" pattern="yy/MM/dd" />
                </c:catch>
                <c:if test="${not empty ex}">${dto.deadline_written}</c:if> <span class="text-danger">(${dto.d_day_written}일)</span>
            </div>
        </c:if>

        <%-- 실기 날짜 출력 --%>
        <c:if test="${not empty dto.deadline_practical}">
            <div>
                <strong>실기:</strong> 
                <fmt:formatDate value="${dto.deadline_practical}" pattern="yy/MM/dd" /> 
                <span class="text-danger">(${dto.d_day_practical}일)</span>
            </div>
        </c:if>

        <c:if test="${empty dto.deadline_written && empty dto.deadline_practical}">
            <span class="text-muted">일정 없음</span>
        </c:if>
    </div>
</td>
            
            <td>
			  <button type="button"
				          class="skillup-btn ${dto.is_skillup == 'Y' ? 'active' : ''}"
				          onclick="toggleSkillUp(this, '${dto.certi_id}')">
				    ${dto.is_skillup == 'Y' ? '등록됨' : 'SkillUp!'}
				  </button>
			</td>
            <%-- 필터용 데이터 (반드시 클래스 버전만 2개 남겨야 함)--%>
            <td class="filter-main" style="display:none;">${dto.certi_type}</td> 
            <td class="filter-sub" style="display:none;">${dto.main_category}</td> 
        </tr>
    </c:forEach>
</tbody>
                    </table>
                </div>
                	
                <c:if test="${empty cList}">
                    <div class="text-center text-muted py-5">등록된 자격증 정보가 없습니다.</div>
                </c:if>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
// 정규식 특수문자 escape
function escapeRegex(value) {
  return value.replace(/[-\/\\^*+?.()|[\]{}]/g, '\\$&');
}

// [1] 즐겨찾기 비동기 함수
function toggleFavorite(element, certiId) {
  const isAdded = element.classList.contains('fas');
  const action = isAdded ? 'remove' : 'add';
  const path = "${pageContext.request.contextPath}/favorite.do?action=" + action + "&targetId=" + certiId + "&type=CERTI";

  fetch(path)
    .then(response => {
      if (response.ok) {
        if (isAdded) {
          element.classList.remove('fas');
          element.classList.add('far');
        } else {
          element.classList.remove('far');
          element.classList.add('fas');
        }
      } else {
        alert("서버 연결 실패");
      }
    })
    .catch(error => {
      console.error("에러:", error);
      alert("서버 연결 실패");
    });
}

// skillup 등록
function toggleSkillUp(element, certi_id) {
  console.log("certi_id =", certi_id);

  const isAdded = element.classList.contains('active');
  const action = isAdded ? 'remove' : 'add';
  const path = "${pageContext.request.contextPath}/skillupexamadd.do?action="
            + action + "&targetId=" + certi_id + "&type=CERTI";

  fetch(path)
    .then(response => response.text())
    .then(result => {
      console.log("server result =", result);

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
        location.href = '<c:url value="/login.do"/>?backUrl=certification.do';
      } else {
        alert("등록 실패: " + result);
      }
    })
    .catch(error => {
      console.error("에러:", error);
      alert("서버 연결 실패");
    });
}

$(document).ready(function() {
  // [2] DataTable 초기화
  var table = $('#certiTable').DataTable({
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

      var $paginate = $(settings.nTableWrapper).find('.dataTables_paginate');
      $paginate.find('span, .ellipsis, .paginate_button:not(.previous):not(.next):not(.first):not(.last)').remove();

      var start = Math.floor(current / 5) * 5;
      var end = Math.min(start + 5, total);

      var $prevBtn = $paginate.find('.previous');
      var $nextBtn = $paginate.find('.next');

      if ($paginate.find('.first').length === 0) {
        $('<a/>', {
          'class': 'paginate_button first',
          'href': '#',
          'html': '«'
        })
          .insertBefore($prevBtn)
          .on('click', function(e) {
            e.preventDefault();
            if (current > 0) api.page('first').draw('page');
          });
      }

      for (var i = start; i < end; i++) {
        (function(idx) {
          $('<a/>', {
            'class': 'paginate_button' + (idx === current ? ' current' : ''),
            'href': '#',
            'html': idx + 1
          })
            .insertBefore($nextBtn)
            .on('click', function(e) {
              e.preventDefault();
              api.page(idx).draw('page');
            });
        })(i);
      }

      if ($paginate.find('.last').length === 0) {
        $('<a/>', {
          'class': 'paginate_button last',
          'href': '#',
          'html': '»'
        })
          .insertAfter($nextBtn)
          .on('click', function(e) {
            e.preventDefault();
            if (current < total - 1) api.page('last').draw('page');
          });
      }

      $paginate.find('.first, .previous').toggleClass('disabled', current === 0);
      $paginate.find('.last, .next').toggleClass('disabled', current >= total - 1);
    }
  });

  // [3] 통합 검색 함수
  function performSearch() {
    var keyword = $.trim($('#customSearchInput').val());
    var mainVal = $.trim($('#categorySelect').val());
    var subVal = $.trim($('#subCategorySelect').val());
    

    // 컬럼 인덱스 확인 필수
    var mainCol = table.column(7); // 대분류
    var subCol = table.column(8);  // 중분류

    // 기존 컬럼 검색 초기화
    mainCol.search('');
    subCol.search('');

    // 대분류 정확히 일치 검색
    if (mainVal) {
	  mainCol.search(mainVal, false, false);
	}
	
	if (subVal && subVal !== '중분류 전체' && subVal !== '대분류를 선택하세요') {
	  subCol.search(subVal, false, false);
	}
    // 전체 키워드 검색
    table.search(keyword).page(0).draw();
  }

  // [4] 대분류 변경 시 중분류 옵션 동적 생성
  $('#categorySelect').on('change', function() {
    var selectedCat = $.trim($(this).val());
    var $subCat = $('#subCategorySelect');

    $subCat.empty();

    if (!selectedCat) {
      $subCat
        .append('<option value="">대분류를 선택하세요</option>')
        .prop('disabled', true);
    } else {
      $subCat
        .append('<option value="">중분류 전체</option>')
        .prop('disabled', false);

      var mainColData = table.column(7).data().toArray();
      var subColData = table.column(8).data().toArray();

      var subSet = new Set();

      for (var i = 0; i < mainColData.length; i++) {
        if ($.trim(mainColData[i]) === selectedCat) {
          var sVal = $.trim(subColData[i]);
          if (sVal) {
            subSet.add(sVal);
          }
        }
      }

      Array.from(subSet).sort().forEach(function(item) {
        $subCat.append(new Option(item, item));
      });
    }

    performSearch();
  });

  $('#subCategorySelect').on('change', function() {
    performSearch();
  });

  $('#applyBtn').on('click', function() {
    performSearch();
  });

  $('#customSearchInput').on('keyup', function(e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
      performSearch();
    }
  });

  $('#lengthSelect').on('change', function() {
    table.page.len(parseInt($(this).val(), 10)).draw();
  });

  $('#resetBtn').on('click', function() {
    $('#customSearchInput').val('');
    $('#categorySelect').val('');
    $('#subCategorySelect')
      .html('<option value="">대분류를 선택하세요</option>')
      .prop('disabled', true);

    table.search('');
    table.column(7).search('');
    table.column(8).search('');
    table.page(0).draw();
  });
});
</script>