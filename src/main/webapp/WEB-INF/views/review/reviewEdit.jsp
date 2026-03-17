<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
/* 별점 스타일: 오른쪽에서 왼쪽으로 채워지는 방식 */
.star-rating {
    display: flex;
    flex-direction: row-reverse; /* 별의 순서를 거꾸로 배치 (중요) */
    justify-content: flex-end;   /* 왼쪽부터 정렬되도록 */
    gap: 5px;
}

/* 라디오 버튼은 숨김 */
.star-rating input {
    display: none;
}

/* 기본 별 색상 (회색) */
.star-rating label {
    font-size: 1.8rem;
    color: #ebedf3; 
    cursor: pointer;
    transition: 0.2s;
}

/* 체크된 라디오 버튼 이후의 라벨(별)들을 노란색으로 */
.star-rating input:checked ~ label {
    color: #ffc107;
}

/* 마우스 호버 시 노란색 효과 */
.star-rating label:hover, 
.star-rating label:hover ~ label {
    color: #ffc107;
}

/* FontAwesome 별 모양 강제 적용 (아이콘이 안 보일 경우 대비) */
.star-rating label::before {
    content: '\f005';
    font-family: "Font Awesome 5 Free";
    font-weight: 900;
}
</style>

<div class="container-fluid py-5 bg-light"> 
    <div class="container">
        <div class="card border-0 shadow-sm p-4 p-md-5">
            <h2 class="fw-bold mb-4 text-center">수강후기 수정</h2>
            <hr class="mb-5">

            <form action="/reviewEdit.do" method="post">
                <%-- 후기 게시판 PK 이름인 idx 사용 --%>
                <input type="hidden" name="idx" value="${board.idx}" />
                <input type="hidden" name="board_type" value="review" />
                
                <div class="table-responsive">
                    <table class="table align-middle">
                        <tbody>
                            <tr>
                                <th class="table-light text-secondary" style="width:150px;">제목</th>
                                <td>
                                    <input type="text" name="title" class="form-control form-control-lg" 
                                           value="${board.title}" placeholder="후기 제목을 입력하세요" required />
                                </td>
                            </tr>
                            
                            <%-- 기존 제목 행 아래에 추가하세요 --%>
							<tr>
    							<th class="table-light text-secondary">수강 평점</th>
    							<td>
        					<div class="star-rating bg-light p-2 rounded border d-flex align-items-center">
            					<%-- 5점 --%>
            					<input type="radio" id="5-stars" name="review_star" value="5" 
                   						${board.review_star == 5 ? 'checked' : ''} />
            					<label for="5-stars" class="fas fa-star"></label>

            					<%-- 4점 --%>
            					<input type="radio" id="4-stars" name="review_star" value="4" 
                   						${board.review_star == 4 ? 'checked' : ''} />
           						<label for="4-stars" class="fas fa-star"></label>

           						<%-- 3점 --%>
           						<input type="radio" id="3-stars" name="review_star" value="3" 
                  						${board.review_star == 3 ? 'checked' : ''} />
           						<label for="3-stars" class="fas fa-star"></label>

            					<%-- 2점 --%>
            					<input type="radio" id="2-stars" name="review_star" value="2" 
                   						${board.review_star == 2 ? 'checked' : ''} />
            					<label for="2-stars" class="fas fa-star"></label>

            					<%-- 1점 --%>
            					<input type="radio" id="1-star" name="review_star" value="1" 
                   						${board.review_star == 1 ? 'checked' : ''} />
            					<label for="1-star" class="fas fa-star"></label>
            
            					<span class="ms-3 text-muted" style="font-size: 0.85rem;">평점을 수정하려면 별을 클릭하세요.</span>
        					</div>
    						</td>
						</tr>
                            <tr>
                                <th class="table-light text-secondary">내용</th>
                                <td>
                                    <textarea name="content" class="form-control" 
                                              style="height:400px; resize: none;" 
                                              required>${board.content}</textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-center gap-3 mt-5">
                    <button type="submit" class="btn btn-dark btn-lg px-5">수정 완료</button>
                    <button type="button" class="btn btn-outline-secondary btn-lg px-5" 
                            onclick="history.back();">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />