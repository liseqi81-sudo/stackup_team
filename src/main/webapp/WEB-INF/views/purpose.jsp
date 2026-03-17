<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 웹페이지 목적" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Page Header Start -->
<div class="container-fluid page-header py-5" style="background-image: none; background-color: #FAF7F0;">
    <h1 class="text-center display-6" style="color: #333;">웹페이지 목적</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-black">Purpose</li>
    </ol>
</div>
<!-- Page Header End -->

<!-- Purpose Start -->
<div class="container-fluid py-5">
    <div class="container py-5">

        <!-- Intro Section -->
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h4 class="text-secondary mb-3">당신의 커리어를 StackUp 하세요.</h4>
                <h1 class="display-5 mb-4 text-primary">취업 준비의 모든 과정을 하나의 흐름으로</h1>
                <p class="lead text-muted mb-3" style="line-height: 1.9;">
                    StackUp은 취업 준비 과정에서 흩어지기 쉬운 정보와 기록을 한 곳에 모아,
                    사용자가 더 체계적으로 성장할 수 있도록 돕는 커리어 준비 플랫폼입니다.
                </p>
                <p class="text-muted mb-4" style="line-height: 1.9;">
                    취업공고를 찾고, 필요한 자격증을 확인하고, 공모전·대외활동을 탐색하고,
                    그 결과를 포트폴리오로 정리하는 과정까지 끊기지 않도록 연결합니다.
                    단순히 정보를 보여주는 데서 끝나는 것이 아니라,
                    <strong class="text-dark">“무엇을 준비해야 하는지 → 어떻게 쌓아야 하는지 → 어떻게 보여줘야 하는지”</strong>
                    를 한 흐름으로 안내하는 것이 StackUp의 목적입니다.
                </p>

                <div class="d-flex gap-2 justify-content-center flex-wrap">
                    <a href="<c:url value='/portfolioGuide.do'/>" class="btn btn-primary rounded-pill px-4 py-2">
                        포트폴리오 가이드 보기
                    </a>

                    <c:choose>
                        <c:when test="${empty sessionScope.user_id}">
                            <a href="login.do" class="btn btn-secondary rounded-pill px-4 py-2">
                                로그인하고 시작하기
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="skillup.do" class="btn btn-secondary rounded-pill px-4 py-2">
                                내 진행률 보러가기
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Why StackUp -->
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">왜 필요한가요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        많은 취업 준비생들은 공고, 자격증, 활동, 포트폴리오를 각각 따로 관리합니다.
                        그러다 보면 준비 방향이 흐려지고, 내가 무엇을 얼마나 해왔는지 정리하기 어려워집니다.
                        StackUp은 이 분산된 준비 과정을 하나로 묶어, 더 명확한 목표와 기록을 만들 수 있게 합니다.
                    </p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">무엇을 해주나요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        사용자의 관심 직무와 준비 상황에 맞춰 필요한 정보들을 연결해 보여줍니다.
                        어떤 공고를 볼지, 어떤 역량을 보완할지, 어떤 활동을 통해 경험을 쌓을지,
                        그리고 그것을 어떻게 포트폴리오로 정리할지까지 이어서 생각할 수 있도록 도와줍니다.
                    </p>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="border rounded p-4 h-100 bg-light">
                    <h4 class="text-primary mb-3">무엇이 다른가요?</h4>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        StackUp은 단순한 정보 검색 사이트가 아닙니다.
                        준비해야 할 요소들을 따로따로 찾는 것이 아니라,
                        사용자의 커리어 목표를 중심으로 하나의 준비 흐름을 설계하는 데 초점을 둡니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Main Features -->
        <div class="text-center mb-5">
            <h2 class="text-primary">StackUp의 핵심 기능</h2>
            <p class="text-muted mb-0">취업 준비에 필요한 기능을 단계별로 연결했습니다.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100 border">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-briefcase fa-2x text-white"></i>
                    </div>
                    <h5>취업공고 탐색</h5>
                    <p class="mb-0 text-muted">
                        다양한 채용 정보를 확인하고, 내가 원하는 직무와 조건에 맞는 공고를 한눈에 살펴볼 수 있습니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100 border">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-certificate fa-2x text-white"></i>
                    </div>
                    <h5>자격증 로드맵</h5>
                    <p class="mb-0 text-muted">
                        관심 직무에 필요한 역량을 기준으로 어떤 자격증을 준비하면 좋은지 방향을 잡을 수 있습니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100 border">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-trophy fa-2x text-white"></i>
                    </div>
                    <h5>공모전/대외활동</h5>
                    <p class="mb-0 text-muted">
                        경험을 쌓을 수 있는 활동을 확인하고, 실질적인 결과물과 스토리를 만들 수 있도록 돕습니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100 border">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-file-alt fa-2x text-white"></i>
                    </div>
                    <h5>포트폴리오 정리</h5>
                    <p class="mb-0 text-muted">
                        준비한 내용을 한 곳에 정리해 포트폴리오 형태로 구성하고, 나만의 결과물로 남길 수 있습니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- User Flow -->
        <div class="text-center mb-5">
            <h2 class="text-primary">이용 흐름</h2>
            <p class="text-muted mb-0">StackUp은 아래와 같은 순서로 활용할 수 있습니다.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="rounded border p-4 h-100 bg-white">
                    <h4 class="text-secondary mb-3">STEP 1</h4>
                    <h5 class="mb-3">목표 설정</h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        내가 가고 싶은 직무와 방향을 먼저 정하고, 필요한 준비 요소를 파악합니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="rounded border p-4 h-100 bg-white">
                    <h4 class="text-secondary mb-3">STEP 2</h4>
                    <h5 class="mb-3">정보 탐색</h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        취업공고, 자격증, 대외활동 정보를 확인하면서 내 준비 방향에 맞는 자료를 모읍니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="rounded border p-4 h-100 bg-white">
                    <h4 class="text-secondary mb-3">STEP 3</h4>
                    <h5 class="mb-3">경험 축적</h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        필요한 역량을 쌓고, 활동과 결과물을 통해 실제 경험을 만들어 갑니다.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="rounded border p-4 h-100 bg-white">
                    <h4 class="text-secondary mb-3">STEP 4</h4>
                    <h5 class="mb-3">포트폴리오 완성</h5>
                    <p class="text-muted mb-0" style="line-height: 1.8;">
                        준비한 내용들을 정리해 나를 보여줄 수 있는 하나의 포트폴리오로 완성합니다.
                    </p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Final Message -->
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="bg-light rounded p-5 text-center border">
                    <h2 class="text-primary mb-3">StackUp이 지향하는 것</h2>
                    <p class="text-muted mb-4" style="line-height: 1.9;">
                        StackUp은 단순히 취업 정보를 제공하는 웹사이트가 아니라,
                        사용자가 자신의 목표를 설정하고, 필요한 준비를 이어가고,
                        그 과정을 눈에 보이는 결과로 정리할 수 있도록 돕는 커리어 성장 플랫폼입니다.
                    </p>
                    <p class="text-muted mb-0" style="line-height: 1.9;">
                        취업 준비가 더 이상 흩어지지 않도록,
                        그리고 사용자의 노력과 경험이 의미 있게 쌓일 수 있도록 돕는 것.
                        그것이 StackUp 웹페이지의 가장 중요한 목적입니다.
                    </p>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- Purpose End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />