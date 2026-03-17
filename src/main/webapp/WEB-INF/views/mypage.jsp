<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="StackUp | 마이페이지" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  .mypage-wrapper { max-width: 960px; margin: 0 auto; }
  .form-control { border-radius: 999px !important; padding: 12px 18px; }
  .btn-pill { border-radius: 999px; padding: 12px 18px; }
  .table-form th { width: 160px; color:#333; font-weight:600; vertical-align: middle; }
  .badge-pill {
    display: inline-block;
    padding: 8px 14px;
    border-radius: 999px;
    background: rgba(129,196,8,.12);
    color: #81c408;
    font-weight: 700;
    font-size: 13px;
  }
  .badge-gray {
    display: inline-block;
    padding: 8px 14px;
    border-radius: 999px;
    background: #f1f3f5;
    color: #495057;
    font-weight: 700;
    font-size: 13px;
  }
</style>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">마이페이지</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">My Page</li>
        </ol>
        </div>

<div class="container-fluid py-5">
  <div class="container py-5">
    <div class="mypage-wrapper">
      <div class="bg-light rounded p-4 p-lg-5 shadow-sm">

        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
          <div>
            <h2 class="text-dark mb-1">내 정보</h2>
            <p class="text-muted mb-0">가입 정보 확인 페이지입니다. (비밀번호는 표시되지 않습니다)</p>
          </div>

          <div class="d-flex gap-2">
            <!-- 필요하면 수정 페이지로 연결 -->
            <a href="mypageEdit.do" class="btn btn-outline-primary btn-pill">정보 수정</a>
            <a href="logout.do" class="btn btn-outline-secondary btn-pill">로그아웃</a>
          </div>
        </div>

        <c:if test="${empty user}">
          <div class="alert alert-danger mb-0">
            사용자 정보를 불러오지 못했습니다. 다시 로그인 후 시도해주세요.
          </div>
        </c:if>

        <c:if test="${not empty user}">
          <table class="table table-borderless align-middle table-form mb-0">
            <tr>
              <th>ID</th>
              <td>${user.user_id}</td>
            </tr>

            <tr>
              <th>이름</th>
              <td>${user.user_name}</td>
            </tr>

            <tr>
              <th>이메일</th>
              <td>${user.user_email}</td>
            </tr>

            <tr>
              <th>전화번호</th>
              <td>${user.user_phone}</td>
            </tr>

            <tr>
              <th>회원유형</th>
              <td>
                <c:choose>
                  <c:when test="${user.user_type eq 'COMPANY'}">
                    <span class="badge-pill">기업회원</span>
                  </c:when>
                  <c:when test="${user.user_type eq 'USER'}">
                    <span class="badge-gray">취업준비생</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge-gray">${user.user_type}</span>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>

            <tr>
              <th>가입일</th>
              <td>
                <!-- createdAt이 LocalDateTime/String 어떤 형태든 그냥 출력 -->
                ${user.created_at}
              </td>
            </tr>

            <tr>
              <th>기업명</th>
              <td>
                <c:choose>
                  <c:when test="${empty user.company_name}">
                    <span class="text-muted">해당없음</span>
                  </c:when>
                  <c:otherwise>
                    ${user.company_name}
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </table>
        </c:if>

      </div>
      
      </div>

      <!-- 받은 채용 제안 목록 시작 -->
      <c:choose>

		  <%-- 개인회원 화면 --%>
		  <c:when test="${user.user_type eq 'USER'}">
		    <div class="bg-light rounded p-4 p-lg-5 shadow-sm mt-4">
		      <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4">
		        <div>
		          <h2 class="text-dark mb-1">받은 채용 제안</h2>
		          <p class="text-muted mb-0">기업에서 보낸 채용 제안을 확인할 수 있습니다.</p>
		        </div>
		
		        <c:if test="${unreadContactCount gt 0}">
		          <span class="badge bg-danger rounded-pill px-3 py-2">
		            안읽은 제안 ${unreadContactCount}건
		          </span>
		        </c:if>
		      </div>
		
		      <div class="table-responsive">
		        <table class="table table-hover align-middle mb-0">
		          <thead class="table-light">
		            <tr>
		              <th style="width:10%;">번호</th>
		              <th style="width:20%;">회사명</th>
		              <th style="width:20%;">채용 직무</th>
		              <th style="width:25%;">제안 제목</th>
		              <th style="width:10%;">상태</th>
		              <th style="width:15%;">수신일</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		              <c:when test="${empty contactList}">
		                <tr>
		                  <td colspan="6" class="text-center text-muted py-4">
		                    받은 채용 제안이 없습니다.
		                  </td>
		                </tr>
		              </c:when>
		              <c:otherwise>
		                <c:forEach var="row" items="${contactList}" varStatus="status">
		                  <tr style="cursor:pointer;"
		                      onclick="location.href='${pageContext.request.contextPath}/jobseeker/contactDetail.do?contactId=${row.contactId}'">
		                    <td>${status.count}</td>
		                    <td>${row.companyInfo}</td>
		                    <td>${row.jobInfo}</td>
		                    <td>
		                      <c:if test="${row.readYn eq 'N'}">
		                        <span class="badge bg-danger me-2">NEW</span>
		                      </c:if>
		                      <c:choose>
		                        <c:when test="${not empty row.contactTitle}">
		                          ${row.contactTitle}
		                        </c:when>
		                        <c:otherwise>
		                          채용 제안
		                        </c:otherwise>
		                      </c:choose>
		                    </td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${row.readYn eq 'N'}">
		                          <span class="badge bg-warning text-dark">안읽음</span>
		                        </c:when>
		                        <c:otherwise>
		                          <span class="badge bg-secondary">읽음</span>
		                        </c:otherwise>
		                      </c:choose>
		                    </td>
		                    <td>
		                      <fmt:formatDate value="${row.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
		                    </td>
		                  </tr>
		                </c:forEach>
		              </c:otherwise>
		            </c:choose>
		          </tbody>
		        </table>
		      </div>
		    </div>
		  </c:when>
		
		  <%-- 기업회원 화면 --%>
		  <c:when test="${user.user_type eq 'COMPANY'}">
		    <div class="bg-light rounded p-4 p-lg-5 shadow-sm mt-4">
		      <div class="mb-4">
		        <h2 class="text-dark mb-1">입사지원자 목록</h2>
		        <p class="text-muted mb-0">내가 등록한 공고에 지원한 사용자 목록입니다.</p>
		      </div>
		
		      <div class="table-responsive">
		        <table class="table table-hover align-middle mb-0">
		          <thead class="table-light">
		            <tr>
		              <th style="width:8%;">번호</th>
		              <th style="width:20%;">공고명</th>
		              <th style="width:12%;">지원자</th>
		              <th style="width:18%;">아이디</th>
		              <th style="width:20%;">지원서 제목</th>
		              <th style="width:12%;">첨부파일</th>
		              <th style="width:10%;">지원일</th>
		            </tr>
		          </thead>
		          <tbody>
		            <c:choose>
		              <c:when test="${empty applicationList}">
		                <tr>
		                  <td colspan="7" class="text-center text-muted py-4">
		                    지원한 사용자가 없습니다.
		                  </td>
		                </tr>
		              </c:when>
		              <c:otherwise>
		                <c:forEach var="row" items="${applicationList}" varStatus="status">
		                  <tr>
		                    <td>${status.count}</td>
		                    <td>${row.postingTitle}</td>
		                    <td>${row.applicantName}</td>
		                    <td>${row.user_id}</td>
		                    <td>${row.apply_title}</td>
		                    <td>
		                      <c:choose>
		                        <c:when test="${not empty row.resume_file}">
		                          <a href="${pageContext.request.contextPath}/uploads/${row.resume_file}" target="_blank">보기</a>
		                        </c:when>
		                        <c:otherwise>
		                          <span class="text-muted">없음</span>
		                        </c:otherwise>
		                      </c:choose>
		                    </td>
		                    <td>
		                      <fmt:formatDate value="${row.created_at}" pattern="yyyy-MM-dd"/>
		                    </td>
		                  </tr>
		                </c:forEach>
		              </c:otherwise>
		            </c:choose>
		          </tbody>
		        </table>
		      </div>
		    </div>
		  </c:when>
		
		</c:choose>
      <!-- 받은 채용 제안 목록 끝 -->
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />