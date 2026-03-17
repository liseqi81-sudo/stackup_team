<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 1. 상단 여백과 배경색을 기존 게시판과 맞춤 --%>
<div class="container-fluid py-5 bg-light"> 
    <div class="container">
        <%-- 2. 실제 게시판 박스 스타일링 (기존 성공한 템플릿의 클래스명을 확인하세요) --%>
        <div class="card border-0 shadow-sm p-4 p-md-5">
            <h2 class="fw-bold mb-4 text-center">문의사항 수정</h2>
            <hr class="mb-5">

            <form action="/qnaEdit.do" method="post">
                <%-- 3. 아까 에러 났던 부분: 반드시 qna_idx로 수정 --%>
                <input type="hidden" name="qna_idx" value="${board.qna_idx}" />
                <input type="hidden" name="board_type" value="qna" />
                
                <div class="table-responsive">
                    <table class="table align-middle">
                        <tbody>
                            <tr>
                                <th class="table-light text-secondary" style="width:150px;">제목</th>
                                <td>
                                    <input type="text" name="title" class="form-control form-control-lg" 
                                           value="${board.title}" placeholder="제목을 입력하세요" required />
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
                
                <%-- 4. 버튼 스타일링 (기존 템플릿 버튼 색상 확인) --%>
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