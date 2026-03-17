<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 포트폴리오 가이드" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Page Header Start -->
<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center text-white display-6">포트폴리오 가이드</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-white">Portfolio Guide</li>
    </ol>
</div>
<!-- Page Header End -->

<div class="container-fluid py-5">
    <div class="container py-5">

        <!-- Intro -->
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h4 class="text-secondary mb-3">포트폴리오는 “기록”이 아니라 “증명”입니다.</h4>
                <h1 class="display-5 mb-4 text-primary">StackUp에서 포트폴리오를 만드는 방법</h1>
                <p class="lead text-muted mb-3" style="line-height: 1.9;">
                    StackUp의 포트폴리오는 단순히 스펙을 나열하는 문서가 아닙니다.
                    사용자가 어떤 목표를 가지고 무엇을 준비했고, 어떤 경험과 결과를 쌓았는지를
                    하나의 흐름으로 정리해 보여주는 구조를 지향합니다.
                </p>
                <p class="text-muted mb-4" style="line-height: 1.9;">
                    취업공고를 살펴보며 필요한 역량을 확인하고, 자격증·공모전·프로젝트 같은 준비 과정을 쌓아가고,
                    그 내용을 최종적으로 포트폴리오로 정리할 수 있도록 연결하는 것이
                    StackUp 포트폴리오 기능의 핵심입니다.
                </p>

                <div class="d-flex gap-2 justify-content-center flex-wrap">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="regist.do" class="btn btn-primary rounded-pill px-4 py-2">
                                회원가입하고 시작하기
                            </a>
                            <a href="login.do" class="btn btn-secondary rounded-pill px-4 py-2">
                                로그인
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/portfolio/myportfolio.do'/>" class="btn btn-primary rounded-pill px-4 py-2">
                                내 포트폴리오 보러가기
                            </a>
                            <a href="skillup.do" class="btn btn-secondary rounded-pill px-4 py-2">
                                진행률 확인
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Why this portfolio -->
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">왜 필요한가요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        취업 준비를 하다 보면 공고, 자격증, 프로젝트, 대외활동이 각각 따로 흩어져 관리되기 쉽습니다.
                        그러면 내가 어떤 방향으로 준비했고 어떤 강점을 가지고 있는지 스스로도 정리하기 어려워집니다.
                        포트폴리오는 이 흩어진 경험들을 하나의 이야기로 연결해 주는 도구입니다.
                    </p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">어떻게 다른가요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        StackUp은 단순히 텍스트를 입력해 문서를 만드는 방식이 아니라,
                        사용자가 사이트 안에서 탐색하고 준비한 활동들을 포트폴리오와 자연스럽게 연결할 수 있도록 구성합니다.
                        즉, 준비 과정과 결과물이 서로 이어지도록 만드는 데 초점을 둡니다.
                    </p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">무엇을 얻게 되나요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        최종적으로는 나의 목표 직무, 기술 역량, 프로젝트 경험, 활동 이력,
                        그리고 성장 과정이 정리된 포트폴리오를 만들 수 있습니다.
                        이는 단순한 정보 정리가 아니라, 나를 설명하고 보여줄 수 있는 결과물로 활용됩니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Process -->
        <div class="text-center mb-5">
            <h2 class="text-primary">StackUp에서 포트폴리오가 만들어지는 흐름</h2>
            <p class="text-muted mb-0">사용자는 아래와 같은 순서로 포트폴리오를 완성하게 됩니다.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="bg-light rounded p-4 h-100 border">
                    <div class="d-flex align-items-center mb-3">
                        <div class="btn-square rounded-circle bg-secondary me-3">
                            <i class="fas fa-bullseye text-white"></i>
                        </div>
                        <h5 class="mb-0">1. 목표 설정</h5>
                    </div>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        먼저 희망 직무나 관심 분야를 정하고,
                        내가 어떤 방향으로 취업 준비를 할 것인지 기준을 세웁니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="bg-light rounded p-4 h-100 border">
                    <div class="d-flex align-items-center mb-3">
                        <div class="btn-square rounded-circle bg-secondary me-3">
                            <i class="fas fa-search text-white"></i>
                        </div>
                        <h5 class="mb-0">2. 준비 요소 탐색</h5>
                    </div>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        취업공고, 자격증, 공모전, 대외활동 등의 정보를 확인하면서
                        내 목표에 맞는 준비 요소를 찾아봅니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="bg-light rounded p-4 h-100 border">
                    <div class="d-flex align-items-center mb-3">
                        <div class="btn-square rounded-circle bg-secondary me-3">
                            <i class="fas fa-route text-white"></i>
                        </div>
                        <h5 class="mb-0">3. 경험 축적</h5>
                    </div>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        프로젝트, 학습, 자격증 취득, 활동 참여 등을 통해
                        실제 경험과 결과물을 차곡차곡 쌓아 갑니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="bg-light rounded p-4 h-100 border">
                    <div class="d-flex align-items-center mb-3">
                        <div class="btn-square rounded-circle bg-secondary me-3">
                            <i class="fas fa-file-alt text-white"></i>
                        </div>
                        <h5 class="mb-0">4. 포트폴리오 정리</h5>
                    </div>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        준비한 내용을 템플릿과 항목에 맞게 정리해
                        나를 보여줄 수 있는 하나의 포트폴리오로 완성합니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Inside StackUp -->
        <div class="text-center mb-5">
            <h2 class="text-primary">홈페이지 안에서 어떻게 활용하나요?</h2>
            <p class="text-muted mb-0">StackUp은 포트폴리오 작성을 위한 재료를 사이트 안에서 연결해 줍니다.</p>
        </div>

        <div class="row g-4">
            <div class="col-lg-6">
                <div class="bg-white border rounded p-4 h-100">
                    <h4 class="text-primary mb-3">포트폴리오 작성에 들어가는 내용</h4>
                    <ul class="text-muted mb-0" style="line-height: 2;">
                        <li>희망 직무 및 관심 분야</li>
                        <li>보유 기술, 사용 가능 툴, 학습 내용</li>
                        <li>프로젝트 경험과 역할</li>
                        <li>자격증 및 수료 이력</li>
                        <li>공모전·대외활동 참여 경험</li>
                        <li>성과, 느낀 점, 성장 과정</li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="bg-white border rounded p-4 h-100">
                    <h4 class="text-primary mb-3">StackUp에서의 활용 방식</h4>
                    <ul class="text-muted mb-0" style="line-height: 2;">
                        <li>공고를 보며 필요한 역량을 확인합니다.</li>
                        <li>부족한 부분은 자격증·활동 정보로 보완 방향을 잡습니다.</li>
                        <li>프로젝트와 경험을 누적해 나만의 이력을 만듭니다.</li>
                        <li>준비한 내용을 포트폴리오 항목으로 정리합니다.</li>
                        <li>최종적으로 직무 맞춤형 결과물 형태로 활용합니다.</li>
                    </ul>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Result -->
        <div class="text-center mb-5">
            <h2 class="text-primary">완성된 포트폴리오는 이렇게 쓰입니다</h2>
            <p class="text-muted mb-0">단순 저장용 문서가 아니라, 나를 설명하는 결과물로 활용됩니다.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="bg-white border border-secondary rounded p-4 h-100">
                    <h5 class="mb-3">
                        <i class="fas fa-check text-primary me-2"></i>직무 맞춤 정리
                    </h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        희망 직무와 연결되는 프로젝트, 기술, 경험 중심으로 내용을 정리할 수 있습니다.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="bg-white border border-secondary rounded p-4 h-100">
                    <h5 class="mb-3">
                        <i class="fas fa-check text-primary me-2"></i>준비 과정 설명
                    </h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        무엇을 왜 준비했는지 흐름이 남기 때문에,
                        단순 나열보다 더 설득력 있게 나를 설명할 수 있습니다.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="bg-white border border-secondary rounded p-4 h-100">
                    <h5 class="mb-3">
                        <i class="fas fa-check text-primary me-2"></i>성과 중심 표현
                    </h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        경험 자체보다 문제 해결, 역할, 결과가 보이도록 정리해
                        더 완성도 있는 포트폴리오를 만들 수 있습니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Final message -->
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="bg-light rounded p-5 text-center border">
                    <h2 class="text-primary mb-3">StackUp 포트폴리오의 목적</h2>
                    <p class="text-muted mb-3" style="line-height: 1.9;">
                        StackUp은 사용자가 취업 준비 과정에서 쌓아 온 정보와 경험을
                        흩어지지 않게 모으고, 그것을 하나의 포트폴리오로 연결할 수 있도록 돕습니다.
                    </p>
                    <p class="text-muted mb-0" style="line-height: 1.9;">
                        즉, “무엇을 준비했는가”를 넘어
                        <strong class="text-dark">“어떤 목표를 가지고, 어떤 과정을 거쳐, 어떤 결과를 만들었는가”</strong>
                        를 보여주는 것이 StackUp 포트폴리오 가이드의 핵심입니다.
                    </p>
                </div>
            </div>
        </div>

        <div class="text-center mt-5">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="regist.do" class="btn btn-primary rounded-pill px-5 py-3">지금 시작하기</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/portfolio/myportfolio.do'/>" class="btn btn-primary rounded-pill px-5 py-3">내 포트폴리오 만들기</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />