<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 게시글 작성" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
    .board-container { max-width: 900px; margin: 0 auto; }
    .form-control { border-radius: 12px; border: 1px solid #ebedf3; padding: 15px; transition: 0.3s; }
    .form-control:focus { border-color: #81c408; box-shadow: 0 0 0 0.2rem rgba(129, 196, 8, 0.25); }
    .btn-submit { background-color: #81c408; border: none; color: white; font-weight: 600; }
    .btn-submit:hover { background-color: #70ad07; color: white; transform: translateY(-1px); transition: 0.2s; }
    .form-label { font-weight: 700; color: #333; margin-bottom: 10px; }

    /* --- 머릿글 버튼 스타일 --- */
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
    .btn-check:checked + .btn-outline-notice { background-color: #ffc107 !important; color: #000 !important; }
    .btn-check:checked + .btn-outline-important { background-color: #dc3545 !important; color: #fff !important; }
</style>

<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">공지사항 작성</h1>
</div>

<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="board-container bg-white rounded shadow-sm p-5">
            <h4 class="fw-bold mb-4 text-dark">
                <i class="fas fa-pen-nib me-2 text-primary"></i>새로운 내용을 작성해 주세요
            </h4>
            
            <%-- 중요: onsubmit 함수를 추가하여 제목 결합 로직 실행 --%>
            <form action="<c:url value='/noticeWrite.do'/>" method="post" onsubmit="return combineTitle()">
                
                <%-- 머릿글 선택 영역 (가로 정렬) --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">게시글 설정</label>
                    <div class="d-flex gap-2 notice-select-group">
                        <input type="radio" class="btn-check" name="notice_type_select" id="type_notice" value="[공지]" checked>
                        <label class="btn btn-outline-notice" for="type_notice">공지</label>

                        <input type="radio" class="btn-check" name="notice_type_select" id="type_important" value="[필독]">
                        <label class="btn btn-outline-important" for="type_important">필독</label>
                    </div>
                </div>

                <%-- 제목 입력 필드 --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">제목</label>
                    <input type="text" id="board_title" name="title" class="form-control" placeholder="제목을 입력하세요" required>
                </div>
                
                <%-- 내용 입력 필드 --%>
                <div class="mb-4">
                    <label class="form-label fw-bold">내용</label>
                    <textarea name="content" class="form-control text-start" rows="12" placeholder="내용을 입력하세요" required></textarea>
                </div>
                
                <div class="text-center mt-5">
                    <button type="submit" class="btn btn-submit rounded-pill px-5 py-3 shadow-sm me-2">
                        <i class="fas fa-check me-2"></i>등록 완료
                    </button>
                    <button type="button" class="btn btn-secondary rounded-pill px-5 py-3 shadow-sm" 
                            onclick="location.href='<c:url value='/noticeList.do'/>'">
                        취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function combineTitle() {
    // 1. 선택된 라디오 버튼 값 가져오기
    const selectedType = document.querySelector('input[name="notice_type_select"]:checked').value;
    // 2. 제목 입력 필드 가져오기
    const titleInput = document.getElementById('board_title');
    
    if(!titleInput.value.trim()) {
        alert("제목을 입력해주세요.");
        return false;
    }

    // 3. 제목 앞에 [공지] 또는 [필독] 결합
    titleInput.value = selectedType + " " + titleInput.value.trim();
    return true;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />