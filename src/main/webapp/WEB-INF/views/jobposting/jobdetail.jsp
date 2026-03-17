<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<c:set var="pageTitle" value="StackUp | 취업공고 상세" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.detail-box {
	border-radius: 12px;
	overflow: hidden;
}

.detail-label {
	font-weight: 700;
	color: #333;
	min-width: 120px;
}

.detail-value {
	color: #444;
}

.badge-green {
	background-color: #81c408;
	color: #fff;
	padding: 6px 12px;
	font-weight: 500;
	border-radius: 999px;
	display: inline-block;
}

.badge-yellow {
	background-color: #ffb524;
	color: #fff;
	padding: 6px 12px;
	font-weight: 500;
	border-radius: 999px;
	display: inline-block;
}

.table-detail th {
	background: #f8f9fa;
	border-bottom: 2px solid #81c408 !important;
	width: 180px;
	vertical-align: middle;
}

.table-detail td {
	vertical-align: middle;
}
</style>

<!-- 상단 페이지 헤더 (clist.jsp와 통일) -->
<div class="container-fluid py-5" style="background-image: none; background-color: #FAF7F0; margin-top: 110px;">
	<h1 class="text-center display-6pt-3" style="color: #333; font-weight: bold;">취업공고</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="<c:url value='/main.do'/>" style="color: #81c408;">Home</a></li>
		<li class="breadcrumb-item active" style="color: #777;">Job Postings</li>
	</ol>
</div>

<div class="container-fluid py-5">
	<div class="container py-5">

		<!-- 상단 타이틀 영역 -->
		<div class="d-flex justify-content-between align-items-start mb-3">
			<div>
				<h3 class="fw-bold mb-1">${job.title}</h3>
				<div class="text-muted">
					<span class="me-2">${job.companyName}</span>
					<c:if test="${not empty job.jobCategory}">
                        · <span>${job.jobCategory}</span>
					</c:if>
				</div>
			</div>

			<!-- 우측 버튼 영역 -->
<div class="d-flex justify-content-end gap-2 mt-4">

    <!-- 1️⃣ 기업회원 + 작성자일 때만 삭제/수정 -->
    <c:if test="${sessionScope.user != null 
    && sessionScope.user.user_type eq 'COMPANY'
    && job.writerId eq sessionScope.user.user_id}">

    <!-- 수정 -->
    <a class="btn btn-warning rounded-pill px-4"
       href="<c:url value='/jobposting/jobedit.do?postingId=${job.postingId}'/>">
        수정
    </a>

    <!-- 삭제 -->
    <form method="post"
          action="<c:url value='/jobposting/jobdelete.do'/>"
          class="m-0">
        <input type="hidden" name="postingId" value="${job.postingId}">
        <button class="btn btn-danger rounded-pill px-4"
                type="submit"
                onclick="return confirm('삭제할까요?');">
            삭제
        </button>
    </form>

</c:if>

    <!-- 2️⃣ 목록 버튼 (모든 사용자 공통) -->
    <a class="btn btn-success rounded-pill px-4"
       href="<c:url value='/jobposting/joblist.do'/>">
        목록
    </a>

</div>
		</div>

		<!-- 상세 정보 박스 -->
		<div class="bg-light rounded p-4 detail-box">

			<div class="table-responsive">
				<table class="table table-hover table-detail mb-0">
					<tbody>
						<tr>
							<th>공고 ID</th>
							<td class="detail-value">${job.postingId}</td>
						</tr>

						<tr>
							<th>회사명</th>
							<td class="detail-value">${job.companyName}</td>
						</tr>

						<tr>
							<th>직무 카테고리</th>
							<td class="detail-value"><c:choose>
									<c:when test="${not empty job.jobCategory}">
                                        ${job.jobCategory}
                                    </c:when>
									<c:otherwise>
										<span class="text-muted small">-</span>
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr>
							<th>고용 형태</th>
							<td class="detail-value"><c:choose>
									<c:when test="${not empty job.postType}">
										<span class="badge-green">${job.postType}</span>
									</c:when>
									<c:otherwise>
										<span class="text-muted small">-</span>
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr>
						  <th>마감일</th>
						  <td class="detail-value">
						    <c:choose>
						
						      <c:when test="${job.deadline != null}">
						        <fmt:formatDate value="${job.deadline}" pattern="yyyy-MM-dd"/>
						      </c:when>
						
						      <c:otherwise>
						        <span class="badge-yellow">상시</span>
						      </c:otherwise>
						
						    </c:choose>
						  </td>
						</tr>

						<tr>
							<th>필요 스킬</th>
							<td class="detail-value"><c:choose>
									<c:when test="${not empty job.skills}">
                                        ${job.skills}
                                    </c:when>
									<c:otherwise>
										<span class="text-muted small">-</span>
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr>
							<th>등록일</th>
							<td class="detail-value"><c:choose>
									<c:when test="${job.createdate != null}">
										<%-- <fmt:formatDate value="${job.createdate}" pattern="yyyy-MM-dd" /> --%>
										${job.createdate}
									</c:when>
									<c:otherwise>
										<span class="text-muted small">-</span>
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr>
							<th>공고 링크</th>
							<td class="detail-value"><c:choose>
									<c:when test="${not empty job.postingUrl}">
										<a href="${job.postingUrl}" target="_blank"
											class="btn btn-sm border border-secondary rounded-pill px-3 text-primary fw-bold">
											링크 열기 </a>
									</c:when>
									<c:otherwise>
										<span class="text-muted small">정보없음</span>
									</c:otherwise>
								</c:choose></td>

						</tr>
						<tr>
							<th>공고 내용</th>
							<td><c:choose>
									<c:when test="${not empty job.contents}">${job.contents}
            						</c:when>
									<c:otherwise>
										<span class="text-muted">내용 없음</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>

	<!-- 개인회원 전용 입사 지원 폼 -->
        <c:if test="${sessionScope.user != null && sessionScope.user.user_type eq 'USER'}">
            <div class="card border-primary shadow-sm mt-4">
                <div class="card-header bg-primary py-3 d-flex align-items-center">
                    <i class="fas fa-file-signature me-2 text-white"></i>
                    <h5 class="mb-0 text-white fw-bold">이 공고에 입사 지원하기</h5>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/jobapplication/apply.do'/>"
				      method="post"
				      enctype="multipart/form-data">

                        <!-- 숨김값 -->
                        <input type="hidden" name="postingId" value="${job.postingId}">

                        <div class="row g-3">
                            <!-- 지원 제목 -->
                            <div class="col-12">
                                <label class="form-label fw-bold">지원 제목</label>
                                <input type="text"
                                       name="applyTitle"
                                       class="form-control"
                                       placeholder="예: 백엔드 개발자 포지션에 지원드립니다."
                                       required>
                            </div>

                            <!-- 지원 내용 -->
                            <div class="col-12">
                                <label class="form-label fw-bold">지원 내용</label>
                                <textarea name="applyContent"
                                          class="form-control"
                                          rows="5"
                                          placeholder="자기소개, 지원 동기, 보유 기술, 포트폴리오 설명 등을 작성하세요."
                                          required></textarea>
                            </div>

                            <!-- 첨부파일 -->
                            <div class="col-md-8">
                                <label class="form-label fw-bold">이력서 또는 포트폴리오 첨부</label>
                                <input type="file"
                                       name="uploadFile"
                                       class="form-control"
                                       accept=".pdf,.doc,.docx,.png,.jpg,.jpeg">
                                <div class="form-text">
                                    PDF, DOC, DOCX, 이미지 파일 업로드 가능
                                </div>
                            </div>

                            <!-- 제출 버튼 -->
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit"
                                        class="btn btn-primary w-100 py-2 fw-bold text-white shadow">
                                    <i class="fas fa-paper-plane me-2"></i>입사 지원하기
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />