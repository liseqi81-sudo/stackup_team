<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | QnA 작성" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    .board-container { max-width: 900px; margin: 0 auto; }
    .form-control { border-radius: 12px; border: 1px solid #ebedf3; padding: 15px; transition: 0.3s; }
    .form-control:focus { border-color: #81c408; box-shadow: 0 0 0 0.2rem rgba(129, 196, 8, 0.25); }
    .btn-submit { background-color: #81c408; border: none; color: white; font-weight: 600; }
    .btn-submit:hover { background-color: #70ad07; color: white; transform: translateY(-1px); transition: 0.2s; }
    .form-label { font-weight: 700; color: #333; margin-bottom: 10px; }

    /* --- QnA 머릿글 버튼 스타일 (초록 & 빨강) --- */
    .notice-select-group .btn-check + .btn {
        border: none !important;
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: 700;
        font-size: 14px;
        background-color: #f1f1f1;
        color: #888;
        cursor: pointer;
        transition: 0.1s;
        box-shadow: none !important;
    }
    /* 문의 버튼 (초록) */
    .btn-check:checked + .btn-outline-qna { background-color: #198754 !important; color: #fff !important; }
    /* 에러 버튼 (빨강) */
    .btn-check:checked + .btn-outline-error { background-color: #dc3545 !important; color: #fff !important; }
</style>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">Q&A 작성</h1>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="board-container bg-white rounded shadow-sm p-5">
            <h4 class="fw-bold mb-4 text-dark">
                <i class="fas fa-question-circle me-2 text-success"></i>궁금하신 내용을 남겨주세요
            </h4>
            
            <form action="<c:url value='/qnaWrite.do'/>" method="post" onsubmit="return combineTitle()">
                
                <%-- 문의 유형 선택 영역 --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">문의 유형</label>
                    <div class="d-flex gap-2 notice-select-group">
                        <input type="radio" class="btn-check" name="notice_type_select" id="type_qna" value="[문의]" checked>
                        <label class="btn btn-outline-qna" for="type_qna">문의</label>

                        <input type="radio" class="btn-check" name="notice_type_select" id="type_error" value="[에러]">
                        <label class="btn btn-outline-error" for="type_error">에러</label>
                    </div>
                </div>

                <%-- 제목 입력 --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">제목</label>
                    <input type="text" id="board_title" name="title" class="form-control" placeholder="문의 제목을 입력하세요" required>
                </div>
                
                <%-- 내용 입력 --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">내용</label>
                    <textarea name="content" class="form-control text-start" rows="12" placeholder="문의하실 내용을 상세히 적어주세요" required></textarea>
                </div>
                
                <div class="text-center mt-5">
                    <button type="submit" class="btn btn-submit rounded-pill px-5 py-3 shadow-sm me-2">
                        <i class="fas fa-check me-2"></i>등록 완료
                    </button>
                    <button type="button" class="btn btn-secondary rounded-pill px-5 py-3 shadow-sm" 
                            onclick="location.href='<c:url value='/qnaList.do'/>'">
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function combineTitle() {
    const selectedType = document.querySelector('input[name="notice_type_select"]:checked').value;
    const titleInput = document.getElementById('board_title');
    
    if(!titleInput.value.trim()) {
        alert("제목을 입력해주세요.");
        return false;
    }

    titleInput.value = selectedType + " " + titleInput.value.trim();
    return true;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />