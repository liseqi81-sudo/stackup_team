<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
    body { background-color: #f8f9fa; margin-top: 180px; }
    .ai-wrapper { max-width: 1400px; margin: 0 auto; padding: 0 40px; }

    /* 상단 섹션: 좌측 입력 + 우측 분석 버튼 */
    .ai-top-section {
        display: flex;
        align-items: stretch;
        gap: 40px;
        margin-bottom: 60px;
    }

    /* 1. 좌측: 스킬 역량 체크 박스 (연두색 테마) */
    .ai-card-container {
        flex: 1.2;
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        padding: 35px !important;
    }
    
    .ai-header-title {
        font-weight: 800; font-size: 1.4rem; color: #333;
        display: flex; align-items: center; gap: 10px; margin-bottom: 5px;
    }
    .ai-header-title i { color: #82b541; }
    .ai-sub-title { color: #888; font-size: 0.9rem; margin-bottom: 25px; }

    /* 입력창 및 추가/초기화 버튼 */
    .input-row { display: flex; gap: 10px; margin-bottom: 25px; }
    .btn-add { background-color: #82b541 !important; color: white !important; font-weight: bold; width: 80px; }
    .btn-reset { border: 1px solid #ffb524; color: #ffb524; background: white; font-weight: bold; width: 80px; border-radius: 5px; transition: 0.3s; }
    .btn-reset:hover { background: #fffaf0; }

    /* 스킬 리스트 아이템 (버튼형 숙련도 선택) */
    .skill-item-row {
        background: #fcfdfa;
        border: 1px solid #eef5e1;
        border-left: 5px solid #82b541;
        border-radius: 10px;
        padding: 15px 20px;
        margin-bottom: 12px;
        display: flex; align-items: center; justify-content: space-between;
    }
    .skill-name { font-weight: 700; min-width: 110px; font-size: 1.05rem; }

    /* 숙련도 버튼 그룹 */
    .level-btn-group { display: flex; gap: 6px; }
    .level-btn {
        padding: 6px 14px;
        border: 1px solid #e9ecef;
        background: #fff;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 600;
        color: #666;
        cursor: pointer;
        transition: all 0.2s;
    }
    .level-btn.active {
        background-color: #82b541;
        color: white;
        border-color: #82b541;
        box-shadow: 0 4px 8px rgba(130, 181, 65, 0.2);
    }
    .level-btn:hover:not(.active) { border-color: #82b541; color: #82b541; }

    /* 2. 우측: 분석 버튼 영역 [수정: 파란색 테마 적용] */
    .ai-analysis-zone {
        flex: 0.8;
        background: white;
        border-radius: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        border: 2px dashed #eee;
    }

    .btn-analysis {
        width: 210px; height: 210px; border-radius: 50%;
        background-color: white; border: 4px dashed #007bff; color: #007bff; /* ★ 파란색 점선/글씨 */
        font-size: 1.4rem; font-weight: 800; transition: all 0.4s;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        cursor: pointer; outline: none;
    }
    .btn-analysis:hover { background-color: #007bff; color: white; border-style: solid; transform: scale(1.05); } /* ★ 호버 시 파란색 채움 */
    .btn-analysis i { font-size: 3.5rem; margin-bottom: 12px; }

    /* 하단 결과 카드 (초기 숨김) */
    .job-container { 
        display: none; 
        grid-template-columns: repeat(5, 1fr); 
        gap: 15px; margin-bottom: 80px;
        animation: fadeInUp 0.8s;
    }
    .job-card {
        background: white; border-radius: 15px; padding: 25px 15px;
        text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        border-top: 5px solid #82b541; transition: 0.3s;
    }
    .job-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
    .job-card h3 { font-size: 1.15rem; font-weight: 800; margin-bottom: 20px; color: #333; }
    
    /* [수정: SkillUp 버튼 주황색 테마 적용] */
    .skillup-btn {
        width: 100%; border: 1.5px solid #ffb524; color: #ffb524; /* ★ 주황색 보더/글씨 */
        background: white; border-radius: 25px; padding: 8px 0; font-weight: bold; font-size: 13px;
        margin-top: 10px; transition: 0.3s;
    }
    .skillup-btn:hover { background: #ffb524; color: white; } /* ★ 호버 시 주황색 채움 */

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    /* 불러오기 버튼 추가 */
    .btn-load-skill {
	    background-color: #6c757d;
	    color: white;
	    border: none;
	    border-radius: 8px;
	    padding: 10px 18px;
	    font-weight: 700;
	    white-space: nowrap;
	    flex-shrink: 0;
	    transition: 0.2s;
	}
	
	.btn-load-skill:hover {
	    background-color: #5a6268;
	}
	
	.ai-header-row {
	    display: flex;
	    justify-content: space-between;
	    align-items: flex-start;
	    gap: 20px;
	    margin-bottom: 20px;
	}
	
	.ai-wrapper { 
        margin-top: 20px !important; /* 상단 헤더와의 간격을 최소화 */
        padding-top: 90px !important; 
        min-height: 500px; 
        position: relative; 
        z-index: 1; 
    }
</style>

<body>

<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">AI 추천</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
   
        <li class="breadcrumb-item active text-black">AI Recommend</li>
    </ol>
</div>


<div class="ai-wrapper">
    <c:choose>
        <%-- 로그인 상태 체크 --%>
        <c:when test="${not empty sessionScope.user}">
            <div class="ai-top-section">
                <div class="ai-card-container">
                <div class="ai-header-row">
					  <div class="ai-header-left">
					    <div class="ai-header-title">
					      <i class="fas fa-robot"></i> AI 추천 핵심역량
					    </div>
					    <p class="ai-sub-title">보유하신 스킬을 추가하고 레벨을 선택해보세요. (하 ~ 상)</p>
					  </div>
					
					  <button type="button" class="btn-load-skill" onclick="loadUserSkills()">
					    스킬 불러오기
					  </button>
					</div>
                    <div class="input-row">
					    <select id="aiNewSkillSelect" class="form-select">
					        <option value="">스킬을 선택하세요</option>
					        <c:forEach var="skill" items="${allSkills}">
					            <option value="${skill.SKILL_NAME}">${skill.SKILL_NAME}</option>
					        </c:forEach>
					    </select>
					    <button type="button" class="btn btn-add" onclick="aiAddSkill()">추가</button>
					    <button type="button" class="btn-reset" onclick="saveUserSkills()">저장</button>
					    <button type="button" class="btn-reset" onclick="location.reload()">초기화</button>
					</div>

                    <div id="aiEditList">
                        </div>
                </div>

                <div class="ai-analysis-zone">
                    <button type="button" class="btn-analysis" onclick="startAnalysis()">
                        <i class="fas fa-microchip"></i>
                        <span>AI 분석 시작</span>
                    </button>
                    <p class="mt-3 text-muted fw-bold small">스킬 추가 후 버튼을 클릭하세요</p>
                </div>
            </div>

            <div class="job-container" id="jobContainer"></div>
        </c:when>

        <%-- 비로그인 상태: 알림 후 리다이렉트 --%>
        <c:otherwise>
            <script>
                alert("로그인이 필요한 서비스입니다.");
                location.href = "${pageContext.request.contextPath}/login.do";
            </script>
        </c:otherwise>
    </c:choose>
</div>

<script>
let aiSkills = [];

// 1. 스킬 수동 추가
function aiAddSkill() {
    const select = document.getElementById('aiNewSkillSelect');
    const name = select.value;

    if (!name) {
        alert("스킬을 선택해주세요.");
        return;
    }

    if (aiSkills.some(skill => skill.name === name)) {
        alert("이미 추가된 스킬입니다.");
        return;
    }

    aiSkills.push({
        name: name,
        level: 3
    });

    renderAiEditList();
}

// 2. 유저 스킬 불러오기
function loadUserSkills() {
    fetch('${pageContext.request.contextPath}/loadUserSkills.do', {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status=' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log("받아온 데이터:", data);

        if (!data || data.length === 0) {
            alert("등록된 유저 스킬이 없습니다.");
            return;
        }

        let addedCount = 0;

        data.forEach(item => {
            const skillName = item.SKILLNAME;
            let skillLevel = Number(item.SKILLLEVEL);

            if (isNaN(skillLevel)) skillLevel = 0;

            if (skillName && !aiSkills.some(skill => skill.name === skillName)) {
                aiSkills.push({
                    name: skillName,
                    level: skillLevel
                });
                addedCount++;
            }
        });

        console.log("변환 후 aiSkills:", aiSkills);

        renderAiEditList();

        if (addedCount > 0) {
            alert(addedCount + "개의 스킬을 불러왔습니다.");
        } else {
            alert("이미 모두 추가된 스킬입니다.");
        }
    })
    .catch(error => {
        console.error("스킬 불러오기 오류:", error);
        alert("스킬 불러오기에 실패했습니다.");
    });
}

// 3. 리스트 렌더링
function renderAiEditList() {
    const editList = document.getElementById('aiEditList');
    let html = '';

    aiSkills.forEach((skill, i) => {
        html += `
            <div class="skill-item-row animate__animated animate__fadeIn">
                <div class="skill-name">\${skill.name}</div>
                <div class="level-btn-group">
                	<button type="button" class="level-btn \${skill.level === 0 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 0)">입문</button>
	                <button type="button" class="level-btn \${skill.level === 1 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 1)">하</button>
	                <button type="button" class="level-btn \${skill.level === 2 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 2)">중하</button>
	                <button type="button" class="level-btn \${skill.level === 3 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 3)">중</button>
	                <button type="button" class="level-btn \${skill.level === 4 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 4)">중상</button>
	                <button type="button" class="level-btn \${skill.level === 5 ? 'active' : ''}" onclick="selectAiLevel(\${i}, 5)">상</button>
                    <input type="hidden" name="skill_levels" value="\${skill.level}">
                </div>
                <i class="bi bi-x-circle-fill text-danger ms-3" style="cursor:pointer; font-size:1.2rem;" onclick="aiDeleteSkill(\${i})"></i>
            </div>
        `;
    });

    editList.innerHTML = html;
}

// 4. 숙련도 선택
function selectAiLevel(index, value) {
    aiSkills[index].level = value;
    renderAiEditList();
}

// 5. 스킬 삭제
function aiDeleteSkill(index) {
    aiSkills.splice(index, 1);
    renderAiEditList();
}

// 6. 분석 시작
function startAnalysis() {
    if (aiSkills.length === 0) {
        alert("최소 하나 이상의 스킬을 추가해주세요.");
        return;
    }

    if (!confirm("입력하신 데이터를 바탕으로 AI 직무 분석을 시작하시겠습니까?")) {
        return;
    }

    const btn = document.querySelector('.btn-analysis');
    const originalContent = btn.innerHTML;

    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i><span>분석 중...</span>';

    console.log("전송할 aiSkills:", aiSkills);

    fetch('${pageContext.request.contextPath}/analyzeJobs.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(aiSkills)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status=' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log("Spring에서 받은 추천 결과:", data);
        renderJobCards(data);
    })
    .catch(error => {
        console.error("AI 분석 오류:", error);
        alert("AI 분석에 실패했습니다.");
    })
    .finally(() => {
        btn.disabled = false;
        btn.innerHTML = originalContent;
    });
}


//결과
function renderJobCards(jobList) {
    const container = document.getElementById('jobContainer');
    let html = '';

    if (!jobList || jobList.length === 0) {
        container.style.display = 'grid';
        container.innerHTML = '<div class="col-12 text-center">추천 결과가 없습니다.</div>';
        return;
    }

    jobList.forEach(function(job) {
        const scoreText = (job.score != null) ? (job.score * 100).toFixed(1) : '0.0';
        const jobId = job.jobId ? String(job.jobId) : '';
        const jobName = job.jobName ? String(job.jobName) : '';
        const requiredSpec = job.requiredSpec ? String(job.requiredSpec) : '없음';
        const haveSpec = job.haveSpec ? String(job.haveSpec) : '없음';
        const lackSpec = job.lackSpec ? String(job.lackSpec) : '없음';
        const similarSpec = job.similarSpec ? String(job.similarSpec) : '없음';

        const safeJobId = jobId.replace(/'/g, "\\'");
        const safeJobName = jobName.replace(/'/g, "\\'");
        const safeLackSpec = lackSpec.replace(/'/g, "\\'");

        html += ''
          + '<div class="job-card">'
          +   '<h3>' + jobName + '</h3>'
          +   '<span style="font-size:0.8rem; font-weight:bold; color:#007bff;">유사도</span>'
          +   '<p style="font-size:0.95rem; color:#333; margin-bottom:15px;">' + scoreText + '%</p>'

          +   '<span style="font-size:0.8rem; font-weight:bold; color:#82b541;">필수 스택</span>'
          +   '<p style="font-size:0.85rem; color:#666; min-height:50px; margin-bottom:15px; padding:0 5px;">' + requiredSpec + '</p>'

          +   '<span style="font-size:0.8rem; font-weight:bold; color:#28a745;">보유 스택</span>'
          +   '<p style="font-size:0.85rem; color:#666; min-height:50px; margin-bottom:15px; padding:0 5px;">' + haveSpec + '</p>'

          +   '<span style="font-size:0.8rem; font-weight:bold; color:#17a2b8;">연관 스택</span>'
          +   '<p style="font-size:0.85rem; color:#666; min-height:50px; margin-bottom:15px; padding:0 5px;">' + similarSpec + '</p>'

          +   '<span style="font-size:0.8rem; font-weight:bold; color:#ff9800;">부족한 스택</span>'
          +   '<p style="font-size:0.85rem; color:#666; min-height:50px; margin-bottom:15px; padding:0 5px;">' + lackSpec + '</p>'

          +   '<button type="button" class="skillup-btn" onclick="confirmSkillUp(\''
          +   safeJobId + '\', \''
          +   safeJobName + '\', \''
          +   safeLackSpec + '\')">SkillUp !</button>'
          + '</div>';
    });

    container.innerHTML = html;
    container.style.display = 'grid';
    container.scrollIntoView({ behavior: 'smooth' });
}



function saveUserSkills() {
    if (!confirm("현재 스킬 정보를 저장하시겠습니까?")) {
        return;
    }

    fetch('${pageContext.request.contextPath}/saveUserSkills.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(aiSkills)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('HTTP error! status=' + response.status);
        }
        return response.text();
    })
    .then(result => {
        console.log("저장 결과:", result);

        if (result === "success") {
            alert("스킬 정보가 저장되었습니다.");
        } else if (result === "login") {
            alert("로그인이 필요합니다.");
            location.href = '${pageContext.request.contextPath}/login.do';
        } else {
            alert("저장 실패: " + result);
        }
    })
    .catch(error => {
        console.error("저장 오류:", error);
        alert("스킬 저장에 실패했습니다.");
    });
}

function confirmSkillUp(jobId, jobName, lackSpec) {
	  fetch('/checkUserJob.do', {
	    method: 'POST'
	  })
	  .then(function(response) {
	    return response.text();
	  })
	  .then(function(result) {
	    if (result === 'login') {
	      alert('로그인이 필요합니다.');
	      location.href = '/login.do?backUrl=/airecommend.do';
	      return;
	    }

	    let message = '';
	    let mode = 'insert';

	    if (result === 'exists') {
	      message = "이미 등록한 직업이 있습니다.\n\n'" + jobName + "' 직업으로 재확인하시겠습니까?";
	      mode = 'update';
	    } else if (result === 'not_exists') {
	      message = "'" + jobName + "' 직업을 추가하시겠습니까?";
	      mode = 'insert';
	    } else {
	      alert('직업 확인 중 오류가 발생했습니다.');
	      return;
	    }

	    if (!confirm(message)) {
	      return;
	    }

	    saveRecommendedJob(jobId, jobName, lackSpec, mode);
	  })
	  .catch(function(error) {
	    console.error(error);
	    alert('직업 확인 중 오류가 발생했습니다.');
	  });
	}
function saveRecommendedJob(jobId, jobName, lackSpec, mode) {
	  fetch('/saveRecommendedJob.do', {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/json'
	    },
	    body: JSON.stringify({
	      jobId: jobId,
	      jobName: jobName,
	      lackSpec: lackSpec,
	      mode: mode
	    })
	  })
	  .then(function(response) {
	    return response.text();
	  })
	  .then(function(result) {
	    alert(result);
	    location.reload();
	  })
	  .catch(function(error) {
	    console.error(error);
	    alert('직업 저장 중 오류가 발생했습니다.');
	  });
	}
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />