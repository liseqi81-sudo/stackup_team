<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="pageTitle" value="StackUp | Snapshots" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container" style="max-width: 900px; margin: 30px auto;">
	<h2 style="margin-bottom: 8px;">버전 목록</h2>
	<p style="margin-top: 0; color: #666;">${portfolio.title}(템플릿:
		${portfolio.templateCode})</p>

	<div class="card"
		style="border: 1px solid #e5e5e5; border-radius: 12px; overflow: hidden;">
		<table class="table" style="margin: 0;">
			<thead style="background: #fafafa;">
				<tr>
					<th style="padding: 12px;">Snapshot ID</th>
					<th style="padding: 12px;">생성일</th>
					<th style="padding: 12px;">액션</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="s" items="${snapshots}">
					<tr>
						<td style="padding: 12px;">${s.snapshotId}</td>
						<td style="padding: 12px;">${s.createdAt}</td>
						<td style="padding: 12px;">
							<!-- 현재는 /resume.do 가 유저 최신 스냅샷만 보여줌.
                   다음 단계로 /resume/view.do?snapshotId=... 를 만들어서 “특정 버전 보기” 제공하면 완벽 -->
							<a class="btn btn-sm btn-outline-primary"
							href="<c:url value='/resume.do'/>">최신보기</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div style="margin-top: 14px;">
		<a class="btn btn-outline-secondary"
			href="<c:url value='/portfolio/dashboard.do'/>">← 돌아가기</a>
	</div>
</div>