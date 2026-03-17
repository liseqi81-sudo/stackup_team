<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<link rel="stylesheet" href="<c:url value='/css/resume.css' />" />

<div class="resume-wrap" style="padding:0;">
  <c:choose>
    <c:when test="${empty resume}">
      <div class="empty-state" style="margin:0; box-shadow:none; border:none;">
        <h2>저장된 레쥬메가 없어요</h2>
        <p>오른쪽에서 PDF를 생성하기 전에 먼저 스냅샷 데이터가 있어야 해요.</p>
      </div>
    </c:when>

    <c:otherwise>
      <div class="resume" style="max-width:none; padding:0; gap:0;">
        <aside class="left" style="width:32%; border-radius:0; box-shadow:none;">
          <div class="profile">
            <h1 class="name">${resume.name}</h1>
            <c:if test="${not empty resume.headline}">
              <p class="headline">${resume.headline}</p>
            </c:if>
          </div>

          <div class="section">
            <h3>Contact</h3>
            <ul class="list">
              <c:if test="${not empty resume.email}">
                <li>${resume.email}</li>
              </c:if>
              <c:if test="${not empty resume.phone}">
                <li>${resume.phone}</li>
              </c:if>
              <c:if test="${not empty resume.location}">
                <li>${resume.location}</li>
              </c:if>
            </ul>
          </div>

          <c:if test="${not empty resume.skills}">
            <div class="section">
              <h3>Skills</h3>
              <div class="badges">
                <c:forEach var="s" items="${resume.skills}" varStatus="st">
                  <c:if test="${st.index lt 12}">
                    <span class="badge">${s}</span>
                  </c:if>
                </c:forEach>
              </div>
            </div>
          </c:if>

          <c:if test="${not empty resume.summary}">
            <div class="section">
              <h3>Summary</h3>
              <p class="summary">${resume.summary}</p>
            </div>
          </c:if>
        </aside>

        <main class="right" style="width:68%; border-radius:0; box-shadow:none;">
          <c:if test="${not empty resume.projects}">
            <section class="section">
              <h2>Projects</h2>
              <c:forEach var="p" items="${resume.projects}" varStatus="pst">
                <c:if test="${pst.index lt 3}">
                  <div class="item">
                    <div class="item-top">
                      <div class="item-title">${p.title}</div>
                      <div class="item-meta">${p.period}</div>
                    </div>
                    <c:if test="${not empty p.oneLine}">
                      <p class="item-desc">${p.oneLine}</p>
                    </c:if>
                  </div>
                </c:if>
              </c:forEach>
            </section>
          </c:if>

          <c:if test="${not empty resume.experience}">
            <section class="section">
              <h2>Experience</h2>
              <c:forEach var="e" items="${resume.experience}" varStatus="est">
                <c:if test="${est.index lt 2}">
                  <div class="item">
                    <div class="item-top">
                      <div class="item-title">${e.title}</div>
                      <div class="item-meta">${e.period}</div>
                    </div>
                    <p class="item-desc">${e.company}</p>
                  </div>
                </c:if>
              </c:forEach>
            </section>
          </c:if>
        </main>
      </div>
    </c:otherwise>
  </c:choose>
</div>