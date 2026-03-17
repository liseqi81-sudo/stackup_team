<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<c:set var="pageTitle" value="StackUp | Resume" />
<c:if test="${not embed}">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
</c:if>
<link rel="stylesheet" href="<c:url value='/css/resume.css' />" />

<!-- ✅ 전체를 flex column으로 만들어 footer가 아래에 붙도록 -->
<div id="resumeRoot"
     style="min-height: calc(100vh - 0px); display: flex; flex-direction: column;">

  <!-- ✅ header가 fixed/sticky일 때 잘림 방지: 상단 여백 확보 -->
  <div class="resume-wrap" style="padding-top: 90px;">
    <div class="resume-topbar">
      <div class="topbar-left">
        <span class="badge-mini">One-page Resume</span>
      </div>
      <div class="topbar-right">
        <button type="button" class="btn-ghost" id="themeToggle">🌙 다크모드</button>
      </div>
    </div>

    <c:choose>
      <c:when test="${empty resume}">
        <div class="empty-state">
          <h2>아직 저장된 레쥬메 스냅샷이 없어요</h2>
          <p>포트폴리오 편집 화면에서 내용을 입력한 뒤 “저장(스냅샷 생성)”을 해주세요.</p>
        </div>
      </c:when>

      <c:otherwise>
        <div class="resume">

          <!-- ================= LEFT ================= -->
          <aside class="left">
            <div class="profile">
              <c:set var="displayName" value="${empty resume.name ? resume.userName : resume.name}" />
              <h1 class="name">
                <c:out value="${displayName}" />
              </h1>

              <c:if test="${not empty resume.headline}">
                <p class="headline"><c:out value="${resume.headline}" /></p>
              </c:if>
            </div>

            <div class="section">
              <h3>Contact</h3>
              <ul class="list">
                <c:if test="${not empty resume.email}">
                  <li>📩 <span><c:out value="${resume.email}" /></span></li>
                </c:if>
                <c:if test="${not empty resume.phone}">
                  <li>📞 <span><c:out value="${resume.phone}" /></span></li>
                </c:if>
                <c:if test="${not empty resume.location}">
                  <li>📍 <span><c:out value="${resume.location}" /></span></li>
                </c:if>
              </ul>
            </div>

            <c:if test="${not empty resume.socialLinks}">
              <div class="section">
                <h3>Links</h3>
                <ul class="list">
                  <c:forEach var="l" items="${resume.socialLinks}">
                    <c:if test="${not empty l.url}">
                      <li>
                        🔗
                        <a href="<c:out value='${l.url}'/>" target="_blank" rel="noopener">
                          <c:out value="${empty l.label ? l.url : l.label}" />
                        </a>
                      </li>
                    </c:if>
                  </c:forEach>
                </ul>
              </div>
            </c:if>

            <c:if test="${not empty resume.skills}">
              <div class="section">
                <h3>Skills</h3>
                <div class="badges">
                  <c:forEach var="s" items="${resume.skills}" varStatus="st">
                    <c:if test="${st.index lt 16 && not empty s}">
                      <span class="badge"><c:out value="${s}" /></span>
                    </c:if>
                  </c:forEach>
                </div>
              </div>
            </c:if>

            <c:if test="${not empty resume.summary}">
              <div class="section">
                <h3>Summary</h3>
                <p class="summary"><c:out value="${resume.summary}" /></p>
              </div>
            </c:if>
          </aside>

          <!-- ================= RIGHT ================= -->
          <main class="right">

            <!-- ===== Projects ===== -->
            <c:if test="${not empty resume.projects}">
              <section class="section">
                <div class="section-title">
                  <h2>Projects</h2>
                  <span class="hint">대표 3~4개</span>
                </div>

                <c:forEach var="p" items="${resume.projects}" varStatus="pst">
                  <c:if test="${pst.index lt 4}">
                    <div class="item">
                      <div class="item-top">
                        <div class="item-title"><c:out value="${p.title}" /></div>
                        <div class="item-meta">
                          <c:if test="${not empty p.period}"><c:out value="${p.period}" /></c:if>
                        </div>
                      </div>

                      <div class="item-sub">
                        <c:if test="${not empty p.role}">
                          <span class="pill"><c:out value="${p.role}" /></span>
                        </c:if>

                        <c:if test="${not empty p.links}">
                          <span class="dot">•</span>
                          <c:forEach var="lk" items="${p.links}" varStatus="lst">
                            <c:if test="${lst.index lt 2 && not empty lk.url}">
                              <a class="link" href="<c:out value='${lk.url}'/>" target="_blank" rel="noopener">
                                <c:out value="${empty lk.label ? lk.url : lk.label}" />
                              </a>
                              <c:if test="${lst.index lt 1}">
                                <span class="sep">/</span>
                              </c:if>
                            </c:if>
                          </c:forEach>
                        </c:if>
                      </div>

                      <c:choose>
                        <c:when test="${not empty p.oneLine}">
                          <p class="item-desc"><c:out value="${p.oneLine}" /></p>
                        </c:when>
                        <c:when test="${not empty p.highlights}">
                          <p class="item-desc"><c:out value="${p.highlights[0]}" /></p>
                        </c:when>
                      </c:choose>

                      <c:if test="${not empty p.stack}">
                        <div class="chips">
                          <c:forEach var="stItem" items="${p.stack}" varStatus="sst">
                            <c:if test="${sst.index lt 6 && not empty stItem}">
                              <span class="chip"><c:out value="${stItem}" /></span>
                            </c:if>
                          </c:forEach>
                        </div>
                      </c:if>

                      <c:if test="${not empty p.highlights}">
                        <ul class="bullets">
                          <c:forEach var="h" items="${p.highlights}" varStatus="hst">
                            <c:if test="${hst.index lt 2 && not empty h}">
                              <li><c:out value="${h}" /></li>
                            </c:if>
                          </c:forEach>
                        </ul>
                      </c:if>
                    </div>
                  </c:if>
                </c:forEach>
              </section>
            </c:if>

            <!-- ===== Experience ===== -->
            <c:if test="${not empty resume.experience}">
              <section class="section">
                <div class="section-title">
                  <h2>Experience</h2>
                  <span class="hint">핵심 활동</span>
                </div>

                <c:forEach var="e" items="${resume.experience}" varStatus="est">
                  <c:if test="${est.index lt 3}">
                    <div class="item slim">
                      <div class="item-top">
                        <div class="item-title">
                          <c:out value="${e.title}" />
                          <c:if test="${not empty e.company}">
                            <span class="at">@ <c:out value="${e.company}" /></span>
                          </c:if>
                        </div>
                        <div class="item-meta">
                          <c:if test="${not empty e.period}"><c:out value="${e.period}" /></c:if>
                        </div>
                      </div>

                      <c:if test="${not empty e.type || not empty e.location}">
                        <div class="item-sub">
                          <c:if test="${not empty e.type}">
                            <span class="pill"><c:out value="${e.type}" /></span>
                          </c:if>
                          <c:if test="${not empty e.location}">
                            <span class="muted"><c:out value="${e.location}" /></span>
                          </c:if>
                        </div>
                      </c:if>

                      <c:if test="${not empty e.description}">
                        <ul class="bullets">
                          <c:forEach var="d" items="${e.description}" varStatus="dst">
                            <c:if test="${dst.index lt 3 && not empty d}">
                              <li><c:out value="${d}" /></li>
                            </c:if>
                          </c:forEach>
                        </ul>
                      </c:if>
                    </div>
                  </c:if>
                </c:forEach>
              </section>
            </c:if>

            <!-- ===== Education + Certifications ===== -->
            <section class="section grid2">
              <!-- Education -->
              <div>
                <h2>Education</h2>
                <c:choose>
                  <c:when test="${empty resume.education}">
                    <p class="muted">학력 정보가 없습니다.</p>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="ed" items="${resume.education}" varStatus="edst">
                      <c:if test="${edst.index lt 2}">
                        <div class="item slim">
                          <div class="item-top">
                            <div class="item-title">
                              <c:if test="${not empty ed.degree}"><c:out value="${ed.degree}" /></c:if>
                              <c:if test="${not empty ed.school}">
                                <span class="at">· <c:out value="${ed.school}" /></span>
                              </c:if>
                            </div>
                            <div class="item-meta">
                              <c:if test="${not empty ed.startDate}">
                                <c:out value="${ed.startDate}" />
                                <span class="sep">~</span>
                                <c:choose>
                                  <c:when test="${not empty ed.endDate}"><c:out value="${ed.endDate}" /></c:when>
                                  <c:otherwise>현재</c:otherwise>
                                </c:choose>
                              </c:if>
                            </div>
                          </div>

                          <c:if test="${not empty ed.major}">
                            <p class="item-desc"><c:out value="${ed.major}" /></p>
                          </c:if>

                          <c:if test="${not empty ed.status}">
                            <div class="item-sub">
                              <span class="pill"><c:out value="${ed.status}" /></span>
                            </div>
                          </c:if>
                        </div>
                      </c:if>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </div>

              <!-- Certifications -->
              <div>
                <h2>Certifications</h2>
                <c:choose>
                  <c:when test="${empty resume.certificationItems}">
                    <p class="muted">자격증 정보가 없습니다.</p>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="c" items="${resume.certificationItems}" varStatus="cst">
                      <c:if test="${cst.index lt 6}">
                        <div class="item slim">
                          <div class="item-top">
                            <c:set var="certName" value="${not empty c.certi_name ? c.certi_name : c.certiName}" />
                            <div class="item-title"><c:out value="${certName}" /></div>

                            <div class="item-meta">
                              <c:if test="${not empty c.deadline}">
                                <c:out value="${c.deadline}" />
                              </c:if>
                            </div>
                          </div>

                          <c:if test="${not empty c.organizer}">
                            <p class="item-desc"><c:out value="${c.organizer}" /></p>
                          </c:if>
                        </div>
                      </c:if>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </div>
            </section>

          </main>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />


<script>
  const root = document.getElementById('resumeRoot');
  const btn = document.getElementById('themeToggle');

  const saved = localStorage.getItem('resumeTheme');
  if (saved === 'dark') root.classList.add('dark');

  function syncBtn(){
    const isDark = root.classList.contains('dark');
    btn.textContent = isDark ? '☀️ 라이트모드' : '🌙 다크모드';
    localStorage.setItem('resumeTheme', isDark ? 'dark' : 'light');
  }
  syncBtn();

  btn.addEventListener('click', () => {
    root.classList.toggle('dark');
    syncBtn();
  });
</script>