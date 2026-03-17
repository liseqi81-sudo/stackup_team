<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="StackUp | 웹페이지 목적" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- Page Header Start -->
<div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">웹페이지 목적</h1>
    <ol class="breadcrumb justify-content-center mb-0">
        <li class="breadcrumb-item"><a href="main.do">Home</a></li>
        <li class="breadcrumb-item active text-white">Purpose</li>
    </ol>
</div>
<!-- Page Header End -->

<!-- Purpose Start -->
<div class="container-fluid py-5">
    <div class="container py-5">

        <div class="row g-5 align-items-center">
            <div class="col-lg-6">
                <h4 class="text-secondary">당신의 커리어를 StackUP 하세요.</h4>
                <h1 class="display-5 mb-4 text-primary">취업 준비, 이제 “흩어지지 않게”</h1>
                <p class="mb-4 text-muted">
                    공고를 보고, 자격증을 찾고, 대외활동을 뒤지고, 포트폴리오로 정리하는 과정이
                    매번 끊기지 않도록 StackUp이 한 흐름으로 이어드려요.
                </p>

                <div class="d-flex gap-2 flex-wrap">
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

            <div class="col-lg-6">
                <img src="<c:url value='/fruitables/img/hero-img-1.png'/>" class="img-fluid rounded" alt="StackUp purpose">
            </div>
        </div>

        <hr class="my-5"/>

        <!-- Feature Cards -->
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-briefcase fa-2x text-white"></i>
                    </div>
                    <h5>취업공고 모아보기</h5>
                    <p class="mb-0 text-muted">관심 직무 기반으로 공고를 한 곳에서 확인</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-certificate fa-2x text-white"></i>
                    </div>
                    <h5>자격증 로드맵</h5>
                    <p class="mb-0 text-muted">직무 요구역량과 연결된 자격증 추천</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-trophy fa-2x text-white"></i>
                    </div>
                    <h5>공모전/대외활동</h5>
                    <p class="mb-0 text-muted">경험을 “증명”으로 바꾸는 활동 큐레이션</p>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="featurs-item text-center rounded bg-light p-4 h-100">
                    <div class="featurs-icon btn-square rounded-circle bg-secondary mb-4 mx-auto">
                        <i class="fas fa-file-alt fa-2x text-white"></i>
                    </div>
                    <h5>포트폴리오 정리</h5>
                    <p class="mb-0 text-muted">결과물을 한 번에 포트폴리오 형태로 구성</p>
                </div>
            </div>
        </div>

        <hr class="my-5"/>

        <!-- How it works -->
        <div class="row g-4 align-items-center">
            <div class="col-lg-5">
                <img src="<c:url value='/fruitables/img/hero-img-2.jpg'/>" class="img-fluid rounded" alt="how it works">
            </div>
            <div class="col-lg-7">
                <h2 class="mb-4 text-primary">StackUp 흐름</h2>

                <div class="bg-light rounded p-4 mb-3">
                    <h5 class="mb-1">1) 목표 직무 선택</h5>
                    <p class="mb-0 text-muted">내가 가고 싶은 방향을 먼저 정해요.</p>
                </div>

                <div class="bg-light rounded p-4 mb-3">
                    <h5 class="mb-1">2) 요구역량 기반 준비 루트</h5>
                    <p class="mb-0 text-muted">공고에서 요구하는 역량을 기준으로 자격증/활동을 이어요.</p>
                </div>

                <div class="bg-light rounded p-4">
                    <h5 class="mb-1">3) 포트폴리오로 자동 정리</h5>
                    <p class="mb-0 text-muted">내가 한 걸 “보여줄 수 있게” 정리해요.</p>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- Purpose End -->

<jsp:include page="/WEB-INF/views/common/footer.jsp" />