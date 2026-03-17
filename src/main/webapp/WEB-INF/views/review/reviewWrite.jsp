<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | 후기작성" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* 모든 게시판 공통 컨테이너 너비 */
.board-container {
	max-width: 900px;
	margin: 0 auto;
}

/* 입력창: 둥글고 부드러운 느낌으로 통일 */
.form-control {
	border-radius: 12px;
	border: 1px solid #ebedf3;
	padding: 15px;
	transition: 0.3s;
}

.form-control:focus {
	border-color: #81c408;
	box-shadow: 0 0 0 0.2rem rgba(129, 196, 8, 0.25);
}

/* 버튼: 메인 컬러(#81c408)와 알약 모양(rounded-pill) 통일 */
.btn-submit {
	background-color: #81c408;
	border: none;
	color: white;
	font-weight: 600;
}

.btn-submit:hover {
	background-color: #70ad07;
	color: white;
	transform: translateY(-1px);
	transition: 0.2s;
}

/* 레이블: 가독성을 위해 굵게 */
.form-label {
	font-weight: 700;
	color: #333;
	margin-bottom: 10px;
}

/* 별점 스타일: 오른쪽에서 왼쪽으로 채워지는 방식 */
.star-rating {
	display: flex;
	flex-direction: row-reverse;
	justify-content: flex-start;
	gap: 10px;
}

.star-rating input {
	display: none;
}

.star-rating label {
	font-size: 2.5rem;
	color: #ebedf3; /* 빈 별 색상 */
	cursor: pointer;
	transition: 0.2s;
}
/* 체크된 별과 그 앞의 별들을 노란색으로 */
.star-rating input:checked ~ label {
	color: #ffc107;
}
/* 마우스 호버 시 노란색으로 변화 */
.star-rating label:hover, .star-rating label:hover ~ label {
	color: #ffc107;
}

.star-rating label::before {
    content: '\f005'; /* FontAwesome 별 아이콘 유니코드 */
    font-family: "Font Awesome 5 Free";
    font-weight: 900;
}
</style>

<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">수강후기 작성</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="<c:url value='/'/>"
			class="text-white">Home</a></li>
		<li class="breadcrumb-item active text-white">Review Write</li>
	</ol>
</div>

<%-- 본문 섹션: Edit 페이지와 동일한 .board-container 스타일 적용 --%>
<div class="container-fluid py-5">
	<div class="container py-5">
		<div class="board-container bg-white rounded shadow-sm p-5">
			<h4 class="fw-bold mb-4 text-dark">
				<i class="fas fa-pen-nib me-2 text-primary"></i>새로운 내용을 작성해 주세요
			</h4>

			<form action="<c:url value='/${board_type}Write.do'/>" method="post">
				<%-- 공통 입력 필드 --%>
				<div class="mb-4">
					<label class="form-label fw-bold">제목</label> <input type="text"
						name="title" class="form-control" placeholder="제목을 입력하세요" required>
				</div>

				<div class="mb-4">
    				<label class="form-label fw-bold">수강 평점</label>
    				<div class="star-rating bg-light p-3 rounded-3 border d-flex align-items-center">
        
        				<input type="radio" id="5-stars" name="review_star" value="5" checked />
        				<label for="5-stars" class="fas fa-star"></label>

        				<input type="radio" id="4-stars" name="review_star" value="4" />
        				<label for="4-stars" class="fas fa-star"></label>

        				<input type="radio" id="3-stars" name="review_star" value="3" />
        				<label for="3-stars" class="fas fa-star"></label>

        				<input type="radio" id="2-stars" name="review_star" value="2" />
        				<label for="2-stars" class="fas fa-star"></label>

        				<input type="radio" id="1-star" name="review_star" value="1" />
        				<label for="1-star" class="fas fa-star"></label>

        			<%-- 안내 문구 --%>
        			<span class="ms-3 text-muted" style="font-size: 0.9rem;">
            		별을 클릭해 점수를 선택해주세요!
        			</span>
        
    				</div>
				</div>
				
				<div class="mb-4">
					<label class="form-label fw-bold">내용</label>
					<textarea name="content" class="form-control" rows="12"
						placeholder="내용을 입력하세요" required></textarea>
				</div>

				<%-- 버튼 영역: Edit와 동일하게 통일 --%>
				<div class="text-center mt-5">
					<button type="submit"
						class="btn btn-submit rounded-pill px-5 py-3 shadow-sm me-2">
						<i class="fas fa-check me-2"></i>등록 완료
					</button>
					<button type="button"
						class="btn btn-secondary rounded-pill px-5 py-3 shadow-sm"
						onclick="location.href='<c:url value='/${board_type}List.do'/>'">
						취소</button>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />