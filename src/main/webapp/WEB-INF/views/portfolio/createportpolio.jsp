<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | 포트폴리오 생성" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
  <h3 class="mb-3">포트폴리오 생성</h3>
  <div class="alert alert-light border">
    템플릿 선택 + 생성 로직은 다음 단계에서 붙일게요.
  </div>

  <a class="btn btn-outline-secondary" href="<c:url value='/portfolio/myportpolio.do'/>">목록으로</a>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />