<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="pageTitle" value="StackUp | 내 포트폴리오" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">내 포트폴리오</h3>

    <!-- (선택) 새 포트폴리오 만들기 버튼 -->
    <a class="btn btn-outline-primary" href="<c:url value='/portfolio/createportfolio.do'/>">
      + 새 포트폴리오
    </a>
  </div>

  <c:choose>
    <c:when test="${empty list}">
  <div class="d-flex justify-content-center">
    <div class="card shadow-sm" style="max-width: 560px; width: 100%;">
      <div class="card-body text-center p-4">
        <h4 class="mb-2">아직 포트폴리오가 없어요</h4>
        <p class="text-muted mb-4">
          템플릿을 선택하고, 스냅샷으로 저장하면서 버전 관리도 할 수 있어요.
        </p>

        <a class="btn btn-primary btn-lg"
           href="<c:url value='/portfolio/createportfolio.do'/>">
          포트폴리오를 생성하시겠습니까?
        </a>
      </div>
    </div>
  </div>
</c:when>

    <c:otherwise>
      <div class="row g-3">
        <c:forEach var="p" items="${list}">
          <div class="col-12 col-md-6 col-lg-4">
            <div class="card h-100 shadow-sm">
              <c:choose>
                <c:when test="${not empty p.thumbnailPath}">
                  <img class="card-img-top" style="height:180px; object-fit:cover;"
                       src="<c:url value='${p.thumbnailPath}'/>" alt="thumbnail"/>
                </c:when>
                <c:otherwise>
                  <div class="bg-light d-flex align-items-center justify-content-center"
                       style="height:180px;">
                    <span class="text-muted">No Thumbnail</span>
                  </div>
                </c:otherwise>
              </c:choose>

              <div class="card-body">
                <h5 class="card-title mb-1">
                  <c:out value="${p.title}"/>
                </h5>

                <div class="text-muted small mb-2">
                  템플릿: <b><c:out value="${p.templateCode}"/></b>
                  · 상태: <b><c:out value="${p.status}"/></b>
                </div>

                <div class="text-muted small">
                  최근 수정:
                  <fmt:formatDate value="${p.updatedAt}" pattern="yyyy-MM-dd HH:mm"/>
                </div>
              </div>

              <div class="card-footer bg-white d-flex gap-2">
                <a class="btn btn-sm btn-primary"
                   href="<c:url value='/portfolio/view.do?id=${p.portfolioId}'/>">
                  보기
                </a>

                <a class="btn btn-sm btn-outline-secondary"
                   href="<c:url value='/portfolio/edit.do?id=${p.portfolioId}'/>">
                  수정
                </a>

                <form method="post" action="<c:url value='/portfolio/snapshot/save.do'/>" class="ms-auto">
                  <input type="hidden" name="id" value="${p.portfolioId}" />
                  <button type="submit" class="btn btn-sm btn-outline-success">
                    저장(스냅샷)
                  </button>
                </form>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />