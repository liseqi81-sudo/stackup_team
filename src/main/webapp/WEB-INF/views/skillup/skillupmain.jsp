<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StackUp</title>
<style>
    .content-wrapper { margin-top: 30px !important; padding-top: 60px !important; min-height: 800px; position: relative; z-index: 1; }
    h2.fw-bold { color: #333 !important; margin-bottom: 30px !important; display: block !important; }
    #skillChart { max-height: 400px !important; }
    .card { margin-bottom: 25px; border: none; border-radius: 15px; }
    .gear-icon { transition: transform 0.5s ease-in-out; color: #adb5bd; }
    .gear-icon.active { transform: rotate(180deg); color: #82b541 !important; }
    #editView { animation: fadeIn 0.3s; }
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    .auth-badge { font-size: 0.75rem; vertical-align: middle; }
 
</style>
</head>
<body>
<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">스킬업</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Skill Up</li>
        </ol>
        </div>
        

    <div class="container content-wrapper">
        <h2 class="mb-4 fw-bold ">
        	<span style="color: #82b541;">${userName}</span>님의 스킬업 대시보드
       	</h2>
   	<div class="card shadow-sm mb-4 border-0" style="border-radius: 12px; background: #ffffff;">
	  <div class="card-body d-flex justify-content-between align-items-center py-3 px-4">
	    <div class="d-flex align-items-center">
	      <h4 class="fw-bold mb-0 me-4" style="color: #333;">시험일정</h4>
	      <c:choose>
			  <c:when test="${not empty mainExam}">
			    <span class="fs-5 fw-bold">
			      ${mainExam.examName}
			      <small class="text-muted ms-2">(<fmt:formatDate value="${mainExam.examDate}" pattern="yyyy-MM-dd"/>)</small>
			      <span class="text-danger ms-2">${mainExam.dayLeft == 0 ? 'D-Day' : 'D-' += mainExam.dayLeft}</span>
			    </span>
			  </c:when>
			  <c:otherwise><span class="text-muted">예정된 일정이 없습니다.</span></c:otherwise>
			</c:choose>
	      <div id="main-exam-display"></div>
	    </div>
	  </div>
	</div>
		    	
    <div class="row">
        <div class="col-md-6">
        <div class="card p-4 shadow-sm mb-4">
        <div class="d-flex align-items-center mb-3">
            <h4 class="fw-bold mb-0"><i class="bi bi-robot text-success me-2"></i>AI 직업 추천</h4>
        </div>
        <div class="p-3 bg-light rounded border">
            <h5 class="fw-bold text-dark mb-2">추천 직업: <span id="recJobName">${userJob.jobName}</span></h5>
            <p class="mb-1 small text-muted">필요 역량:</p>
            <div id="neededSkills" class="d-flex flex-wrap gap-1">
                <c:forEach var="skill" items="${jobSkillList}">
				    <span class="badge bg-white text-dark border px-3 py-2">
				        ${skill.skillName}
				    </span>
				</c:forEach>
            </div>
        </div>
    </div>

    <div class="card p-4 shadow-sm mb-4">
        <h4 class="fw-bold mb-3"><span style="color: #82b541;">${userName}</span>님의 스킬 역량</h4>
        <div style="position: relative; height: 250px;">
            <canvas id="gapChart"></canvas>
        </div>
    </div>
            <div class="card p-4 shadow-sm" style="min-height: 520px;">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold mb-0"><span style="color: #82b541;">${userName}</span>의 핵심역량</h4>
                    <i class="bi bi-gear-fill gear-icon" id="settingsBtn" style="font-size: 1.5rem; cursor:pointer;" onclick="toggleSettings()"></i>
                </div>

                <div id="chartView">
                    <div style="position: relative; height: 350px;">
                        <canvas id="skillChart"></canvas>
                    </div>
                </div>
                
                <form id="skillForm" action="/skill/update.do" method="post" onkeydown="if(event.keyCode === 13) return false;">
                    <input type="hidden" name="user_id" value="${userId}">
                    <div id="editView" style="display:none;">
                        <div class="input-group mb-3">
                            <select id="newSkillSelect" class="form-select">
                                <option value="">스킬 선택</option>
                                <c:forEach var="skill" items="${allSkills}">
                                    <option value="${skill.SKILL_ID}">${skill.SKILL_NAME}</option>
                                </c:forEach>
                            </select>
                            <button type="button" class="btn btn-success" onclick="addSkill()">추가</button>
                        </div>
                        <div id="editList" class="mb-4"></div> 
                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-warning" onclick="location.reload()">취소</button>
                            <button type="submit" class="btn btn-success">그래프 적용 (저장)</button>
                        </div>
                    </div>
                </form>
    		</div>
        </div>

        <div class="col-md-6">
            <div class="card p-3 shadow-sm mb-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold mb-0">진행 중인 자격증/공모전</h4>
        <i class="bi bi-gear-fill gear-icon" id="ingSettingsBtn" 
           style="font-size: 1.2rem; cursor:pointer;" onclick="toggleIngEditMode()"></i>
    </div>
    
    <div id="progress-list">
    <c:choose>
        <c:when test="${not empty userIngList}">
            <c:forEach var="ing" items="${userIngList}">
                <div class="item-row mb-4 p-3 border rounded shadow-sm d-flex justify-content-between align-items-center"
                     data-id="${ing.ingId}" style="background-color: #f8f9fa;">
                    
                    <%-- 1. 체크박스 영역 --%>
                    <div class="ing-checkbox-wrapper me-3" style="display:none;">
                        <input type="checkbox" class="form-check-input ing-check" value="${ing.ingId}">
                    </div>

                    <%-- 2. 정보 및 진행바 영역 --%>
                    <div style="flex-grow: 1;">
                        <div class="d-flex align-items-center mb-2">
                            <span class="badge ${ing.targetType == 'CERTI' ? 'bg-primary' : 'bg-success'}">
                                ${ing.targetType == 'CERTI' ? '자격증' : '공모전'}
                            </span>
                            <span class="ms-2 fw-bold" style="font-size: 1.1rem;">${ing.targetName}</span>
                            
                            <%-- 날짜 비교 로직 --%>
                            <c:set var="now" value="<%=new java.util.Date()%>" />
                            <fmt:formatDate var="todayStr" value="${now}" pattern="yyyy-MM-dd" />
                            <fmt:formatDate var="lastAuthStr" value="${ing.lastAuthDate}" pattern="yyyy-MM-dd" />
                            
                            <c:if test="${not empty ing.lastAuthDate && lastAuthStr eq todayStr}">
                                <span class="badge rounded-pill bg-success ms-2 auth-badge">
                                    <i class="bi bi-check-circle-fill"></i> 오늘 인증 완료
                                </span>
                            </c:if>
                        </div>
                        
                        <div class="d-flex align-items-center">
                            <div class="progress" style="height: 12px; flex-grow: 1; background-color: #e9ecef; border-radius: 10px;">
                                <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" 
                                     role="progressbar" 
                                     style="width: ${ing.status}%;">
                                </div>
                            </div>
                            <span class="ms-3 fw-bold text-success">${ing.status}%</span>
                        </div>
                        
                        <small class="text-muted d-block mt-1">목표일: ${empty ing.examDate ? '미정' : ing.examDate}</small>
                    </div>
                    
                    <%-- 3. 버튼 영역 (인증하기 상시 노출) --%>
                    <div class="ms-4 d-flex flex-column gap-2" style="min-width: 100px;">
                        <c:choose>
                            <c:when test="${empty ing.lastAuthDate || lastAuthStr ne todayStr}">
                                <button class="btn btn-success btn-sm fw-bold" type="button" 
                                        onclick="triggerAuthUpload('${ing.ingId}')">
                                     인증하기
                                </button>
                                <input type="file" id="authFile_${ing.ingId}" multiple style="display:none;" 
                                       accept="image/*" onchange="handleAuthImages('${ing.ingId}', this)">
                            </c:when>
                            <c:otherwise>
                                <%-- 인증 완료 시 보여줄 것 (비워두거나 안내 메시지) --%>
                            </c:otherwise>
                        </c:choose>
                        
                        <button class="btn btn-outline-danger btn-sm ing-edit-item" type="button" 
                                style="display:none;"
                                onclick="openDeleteModal('${ing.ingId}', '${ing.targetName}')">일정 해제</button>
                    </div>
                </div>
            </c:forEach>
            
            <div id="ingEditActions" class="mt-3 text-end" style="display:none;">
                <button type="button" class="btn btn-sm btn-outline-secondary me-2" onclick="toggleIngEditMode()">취소</button>
                <button type="button" class="btn btn-sm btn-danger" onclick="deleteSelectedIngs()">선택 해제</button>
            </div>
        </c:when> <%-- ✅ 에러 포인트: 여기가 잘 닫혀있는지 확인 --%>
        <c:otherwise>
            <div class="text-center py-3">
                <p class="mb-2 text-muted" style="font-size: 14px;">현재 도전 중인 자격증/공모전이 없습니다.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</div>
            <div class="card p-3 shadow-sm border-0">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold mb-0">즐겨찾기 목록</h4>
        <i class="bi bi-gear-fill gear-icon" id="favSettingsBtn" 
           style="font-size: 1.2rem; cursor:pointer;" onclick="toggleFavEditMode()"></i>
    </div>
    
    <div class="list-group list-group-flush" id="favorite-list">
        <c:choose>
            <c:when test="${not empty savedItemList}">
                <c:forEach var="item" items="${savedItemList}">
                    <div class="list-group-item d-flex align-items-center px-0">
                        <div class="fav-checkbox-wrapper me-3" style="display:none;">
                            <input type="checkbox" class="form-check-input fav-check" value="${item.targetId}">
                        </div>
                        
                        <div class="flex-grow-1">
                            <span class="badge ${item.targetType == 'CERTI' ? 'bg-primary' : 'bg-success'}">
                                ${item.targetType == 'CERTI' ? '자격증' : '공모전'}
                            </span>
                            <span class="fw-bold ms-2">${item.targetName}</span>
                        </div>
                    </div>
                </c:forEach>
                
                <div id="favEditActions" class="mt-3 text-end" style="display:none;">
                    <button type="button" class="btn btn-sm btn-outline-secondary me-2" onclick="toggleFavEditMode()">취소</button>
                    <button type="button" class="btn btn-sm btn-danger" onclick="deleteSelectedFavorites()">선택 삭제</button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-4 text-muted">
                    <p>즐겨찾기 목록이 비어 있습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">일정 해제 확인</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center py-4">
        <p class="mb-1"><strong id="deleteTargetName" class="fs-5"></strong></p>
        <p class="mb-0 text-muted">진행 중 목록에서 해제하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">해제 안함</button>
        <form id="deleteIngForm" method="post" action="${pageContext.request.contextPath}/skillup/ing/delete.do" class="d-inline">
          <input type="hidden" name="ingId" id="deleteIngId">
          <button type="submit" class="btn btn-danger">해제</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
let skillIds = [<c:forEach var="s" items="${userSkillList}" varStatus="st">"${s.skillId}"${!st.last ? ',' : ''}</c:forEach>];
let skillValues = [<c:forEach var="s" items="${userSkillList}" varStatus="st">${s.userLevel * 20}${!st.last ? ',' : ''}</c:forEach>];
let isNoData = skillIds.length === 0;

let coreChart; // 원형 그래프 전용 변수명 변경
let gapChart;  // 막대 그래프 전용 변수

const colorPalette = ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#6f42c1', '#fd7e14', '#20c997', '#007bff', '#ffc107'];
function getDynamicColors(count) {
    let colors = [];
    for (let i = 0; i < count; i++) {
        if (i < colorPalette.length) colors.push(colorPalette[i]);
        else colors.push('#' + Math.floor(Math.random()*16777215).toString(16).padStart(6, '0'));
    }
    return colors;
}

function initChart() {
    const ctx = document.getElementById('skillChart').getContext('2d');
    if (coreChart) coreChart.destroy(); // 전용 변수 파괴 후 재생성
    
    const currentColors = isNoData ? ['#f0f0f0'] : getDynamicColors(skillValues.length);
    
    coreChart = new Chart(ctx, { // coreChart에 할당
        type: 'doughnut',
        data: {
            labels: isNoData ? ["데이터 없음"] : skillIds.map(id => getSkillNameById(id)),
            datasets: [{
                data: isNoData ? [100] : skillValues,
                backgroundColor: currentColors,
                borderWidth: 2,
                borderColor: '#ffffff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { 
                    position: 'right',
                    labels: {
                        generateLabels: (chart) => {
                            const data = chart.data;
                            return data.labels.map((label, i) => ({
                                text: isNoData ? label : `\${label} (\${data.datasets[0].data[i]}%)`,
                                fillStyle: data.datasets[0].backgroundColor[i],
                                index: i
                            }));
                        }
                    }
                },
                tooltip: { enabled: false }
            }
        }
    });
}

function updateChartOnly() {
    if (isNoData) {
        initChart();
        initGapChart();
        return;
    }

    if (coreChart) {
        coreChart.data.labels = skillIds.map(id => getSkillNameById(id));
        coreChart.data.datasets[0].data = skillValues;
        coreChart.data.datasets[0].backgroundColor = getDynamicColors(skillValues.length);
        coreChart.update();
    }

    if (gapChart) {
        gapChart.data.labels = skillIds.map(id => getSkillNameById(id));
        gapChart.data.datasets[0].data = skillValues;
        gapChart.update();
    }
}

function toggleSettings() {
    const btn = document.getElementById('settingsBtn');
    const cv = document.getElementById('chartView');
    const ev = document.getElementById('editView');
    btn.classList.toggle('active');
    if (ev.style.display === 'none' || ev.style.display === '') {
        renderEditList(); cv.style.display = 'none'; ev.style.display = 'block';
    } else {
        cv.style.display = 'block'; ev.style.display = 'none';
    }
}

function addSkill() {
    const id = document.getElementById('newSkillSelect').value;
    if (!id || skillIds.includes(id)) return;
    if (isNoData) { skillIds = []; skillValues = []; isNoData = false; }
    skillIds.push(id); skillValues.push(50); 
    renderEditList(); updateChartOnly();
}

function renderEditList() {
    const editList = document.getElementById('editList');
    let html = '';
    skillIds.forEach((id, i) => {
        html += `
            <div class="d-flex justify-content-between align-items-center mb-2 p-3 bg-light rounded border shadow-sm">
                <span class="fw-bold">\${getSkillNameById(id)}</span>
                <input type="hidden" name="skill_id" value="\${id}">
                <div class="d-flex align-items-center">
                    <input type="number" name="user_level" class="form-control form-control-sm text-center" 
                           value="\${skillValues[i]}" style="width:70px;" 
                           min="0" max="100" step="20" oninput="handleManualInput(\${i}, this)">
                    <span class="ms-1">%</span>
                    <button type="button" class="btn btn-link text-danger ms-2" onclick="deleteSkill(\${i})"><i class="bi bi-x-circle-fill"></i></button>
                </div>
            </div>`;
    });
    editList.innerHTML = html;
}

function handleManualInput(index, input) {
    let val = Math.min(Math.max(parseInt(input.value) || 0, 0), 100);
    input.value = val;
    skillValues[index] = val; 
    updateChartOnly();
}

function deleteSkill(index) {
    skillIds.splice(index, 1); skillValues.splice(index, 1);
    if (skillIds.length === 0) isNoData = true;
    renderEditList(); isNoData ? initChart() : updateChartOnly();
}

function getSkillNameById(id) {
    const select = document.getElementById('newSkillSelect');
    for (let i = 0; i < select.options.length; i++) {
        if (select.options[i].value === id) return select.options[i].text;
    }
    return "알 수 없는 스킬";
}

function openDeleteModal(ingId, targetName) {
  document.getElementById("deleteIngId").value = ingId;
  document.getElementById("deleteTargetName").textContent = targetName;
  new bootstrap.Modal(document.getElementById("deleteConfirmModal")).show();
}

function deleteSelectedIngs() {
    const selected = document.querySelectorAll('.ing-check:checked');
    if (selected.length === 0) {
        alert("해제할 항목을 선택해주세요.");
        return;
    }
    if (confirm("선택한 " + selected.length + "개의 일정을 목록에서 해제하시겠습니까?")) {
        const ids = Array.from(selected).map(cb => cb.value).join(",");
        $.ajax({
            url: "${pageContext.request.contextPath}/skillup/ing/deleteMultiple.do",
            type: "POST",
            data: { ingIds: ids },
            success: function(res) {
                alert("해제되었습니다.");
                location.reload();
            },
            error: function() { alert("삭제 처리 중 오류 발생"); }
        });
    }
}

// 2. 편집 모드 토글 (버튼 밖으로 뺀 후 UI 제어)
function toggleIngEditMode() {
    const btn = document.getElementById('ingSettingsBtn');
    const checkboxes = document.querySelectorAll('.ing-checkbox-wrapper');
    const editItems = document.querySelectorAll('.ing-edit-item'); // 일정 해제 버튼들
    const actions = document.getElementById('ingEditActions');     // 하단 취소/삭제 버튼 영역
    
    btn.classList.toggle('active');
    const isEditMode = (actions.style.display === 'none' || actions.style.display === '');
    
    // 체크박스와 개별 삭제 버튼은 '설정'을 눌렀을 때만 노출
    checkboxes.forEach(cb => cb.style.display = isEditMode ? 'block' : 'none');
    editItems.forEach(item => item.style.display = isEditMode ? 'block' : 'none');
    actions.style.display = isEditMode ? 'block' : 'none';
}

// 학습 인증 관련 스크립트
function triggerAuthUpload(ingId) {
    document.getElementById('authFile_' + ingId).click();
}

function handleAuthImages(ingId, input) {
    const files = input.files;
    if (files.length === 0) return;
    
    // 메시지를 '학습 인증'으로 변경
    if (confirm(files.length + "장의 사진으로 오늘의 학습을 인증하시겠습니까?")) {
        const formData = new FormData();
        formData.append("ingId", ingId);
        for (let i = 0; i < files.length; i++) {
            formData.append("uploadFiles", files[i]);
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/skillup/auth/simpleUpload.do", // 경로 변경 제안
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(res) {
                if (res.success) { 
                    alert("인증 완료! 진행률이 상승했습니다."); 
                    location.reload(); 
                }
                else { alert("실패: " + res.msg); }
            },
            error: function() { alert("서버 통신 에러가 발생했습니다."); }
        });
    }
}

function toggleFavEditMode() {
    const btn = document.getElementById('favSettingsBtn');
    const checkboxes = document.querySelectorAll('.fav-checkbox-wrapper');
    const actions = document.getElementById('favEditActions');
    btn.classList.toggle('active');
    const isEditMode = actions.style.display === 'none';
    checkboxes.forEach(cb => cb.style.display = isEditMode ? 'block' : 'none');
    actions.style.display = isEditMode ? 'block' : 'none';
    if (!isEditMode) document.querySelectorAll('.fav-check').forEach(c => c.checked = false);
}

function deleteSelectedFavorites() {
    const selected = document.querySelectorAll('.fav-check:checked');
    if (selected.length === 0) { alert("항목을 선택해주세요."); return; }
    const targetIds = Array.from(selected).map(cb => cb.value).join(",");
    if (confirm("삭제하시겠습니까?")) {
        $.ajax({
            url: "${pageContext.request.contextPath}/skillup/favorite/delete.do",
            type: "POST",
            data: { favIds: targetIds },
            success: function() { alert("삭제 완료"); location.reload(); }
        });
    }
}

// 부족한 역량 막대 그래프 함수 (하드코딩 버전)
function initGapChart() {
    const ctx = document.getElementById('gapChart').getContext('2d');
    if (gapChart) gapChart.destroy(); // 기존 막대 차트 파괴

    // 데이터는 원형 그래프 데이터(skillValues)에서 역으로 계산 (100 - 현재치 = 부족분)
    const gapLabels = isNoData ? ["데이터 없음"] : skillIds.map(id => getSkillNameById(id));
    const gapValues = isNoData ? [0] : skillValues; // user_level 그대로 사용

    gapChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: gapLabels,
            datasets: [
                {
                    label: '부족한 역량',
                    data: gapValues,
                    backgroundColor: '#ff8c00', // 요청하신 주황색만 사용
                    borderWidth: 0,
                    borderRadius: 5,
                    barPercentage: 0.5
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: { callback: (val) => val + '%' }
                },
                x: { grid: { display: false } }
            },
            plugins: {
                legend: { display: false } // 단일 색상이므로 범례 숨김
            }
        }
    });
}

// 초기화 통합 실행
window.addEventListener('load', function() {
    initChart();
    initGapChart();
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />