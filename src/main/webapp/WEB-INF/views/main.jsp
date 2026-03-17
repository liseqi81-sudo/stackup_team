<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle" value="StackUp | 메인" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  .main-section-title {
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 20px;
  }

  .main-card {
    background: #fff;
    border: 1px solid #eee;
    border-radius: 16px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    padding: 20px;
    height: 100%;
  }

 
  .main-card.compact {
    padding: 16px;
  }

  .text-ellipsis-1 {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .text-ellipsis-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .job-title-sm,
  .contest-title-sm,
  .review-title-sm,
  .certi-name-sm {
    font-size: 16px;
    font-weight: 600;
    line-height: 1.4;
  }

  .job-meta-sm,
  .contest-meta-sm,
  .review-meta-sm {
    font-size: 13px;
    color: #777;
  }

  .main-btn-sm {
    font-size: 13px;
    padding: 6px 14px;
  }

  .section-gap {
    margin-bottom: 40px;
  }

  .job-list-compact .job-item,
  .contest-list-compact .contest-item {
    border-bottom: 1px solid #f1f1f1;
    padding: 14px 0;
  }

  .job-list-compact .job-item:last-child,
  .contest-list-compact .contest-item:last-child {
    border-bottom: none;
  }

  .cert-ranking-compact .row-container {
    height: 52px;
  }

  .cert-ranking-compact .face {
    padding: 0 14px;
  }

  .cert-ranking-compact .name {
    font-size: 14px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }

  .cert-ranking-compact .tag {
    font-size: 11px;
  }

  .single-review-box {
    min-height: 280px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .single-review-content {
    min-height: 96px;
    font-size: 14px;
    color: #666;
    line-height: 1.6;
  }

  @media (max-width: 991px) {
    .main-section-title {
      font-size: 24px;
    }
  }
  
  /* 베이지색 배경이 하단 컨텐츠까지 끊기지 않게 연결 */
.hero-header{
    background-color: #FAF7F0 !important;
}
/* 바로 아래에 오는 섹션들의 배경도 베이지로 통일 */
.container-fluid.py-5 {
    background-color: #FAF7F0; 
}
</style>
<!--         Modal Search Start
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        Modal Search End -->


<!-- Hero Start -->
<div class="container-fluid py-4 mb-0 hero-header" style="background-color: #fbfaf8;">
    <div class="container py-4">
        <c:choose>
            <%-- ✅ 1. 로그인 안했을 때: 기존처럼 중앙 정렬 유지 --%>
            <c:when test="${empty sessionScope.user}">
                <div class="row justify-content-center text-center">
                    <div class="col-lg-12">
                        <h4 class="mb-3 text-secondary">당신의 커리어를 StackUP 하세요.</h4>
                        <h1 class="mb-5 display-3 text-primary fw-bold">StackUp</h1>
                        <div class="d-flex gap-3 flex-wrap justify-content-center mb-5">
                            <a href="<c:url value='/purpose.do'/>" class="btn btn-primary rounded-pill px-5 py-3 fw-bold">StackUp 소개 보기</a>
                            <a href="<c:url value='login.do'/>" class="btn btn-secondary rounded-pill px-5 py-3 fw-bold">로그인하고 시작하기</a>
                        </div>
                        <p class="mt-4 mb-0 text-muted mx-auto" style="max-width: 700px;">
                            취업공고·자격증·공모전 정보를 모아, 나에게 맞는 준비 루트를 설계하고 포트폴리오로 정리해요.
                        </p>
                    </div>
                </div>
            </c:when>

            <%-- ✅ 2. 로그인 했을 때: 요청하신 좌측 정렬 (Skill UP 부분) --%>
            <c:otherwise>
    <div class="row align-items-center">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between flex-wrap" style="gap: 30px;">
                
                <div class="flex-shrink-0">
                    <h4 class="mb-1 text-secondary" style="font-size: 1.25rem;">${sessionScope.user.user_name} 님 환영합니다!</h4>
                    <h1 class="display-3 text-primary fw-bold mb-2" style="letter-spacing: -1.5px;">Skill UP</h1>
                    <p class="text-muted mb-0">오늘도 한 칸씩 쌓아보자 🔥</p>
                </div>

                <c:if test="${sessionScope.user.user_type eq 'USER'}">
					
					<div class="d-flex align-items-center flex-nowrap" style="gap: 20px;">
					                    
					    <div class="p-3 bg-white shadow-sm border d-flex flex-column align-items-start justify-content-center" 
					         style="width: 230px; height: 160px; border-radius: 20px !important;">
					        <span class="badge rounded-pill bg-danger px-2 py-1 mb-2" style="font-size: 0.75rem;">가장 빠른 일정</span>
					        <c:choose>
					            <c:when test="${not empty mainExam}">
					                <h6 class="fw-bold text-dark mb-1 text-truncate w-100" style="font-size: 1rem;">
					                    ${mainExam.examName}
					                </h6>
					                <h2 class="fw-bold text-primary mb-0" style="font-size: 2.2rem; letter-spacing: -1px;">
					                    ${mainExam.dayLeft == 0 ? 'D-Day' : 'D-' += mainExam.dayLeft}
					                </h2>
					                <span class="text-muted" style="font-size: 0.8rem;">
					                    시험일: <fmt:formatDate value="${mainExam.examDate}" pattern="yyyy-MM-dd"/>
					                </span>
					            </c:when>
					            <c:otherwise>
					                <p class="text-muted small mb-0">예정된 시험 일정이<br>없습니다.</p>
					            </c:otherwise>
					        </c:choose>
					    </div>
					
					    <div class="p-3 bg-white shadow-sm border d-flex flex-column align-items-start justify-content-center" 
					         style="width: 230px; height: 160px; border-radius: 20px !important;">
					        <span class="badge rounded-pill bg-success px-2 py-1 mb-2" style="font-size: 0.75rem;">평균 달성률</span>
					        
					        <c:set var="total" value="0" />
					        <c:set var="count" value="0" />
					        <c:forEach var="ing" items="${userIngList}">
					            <c:set var="total" value="${total + ing.status}" />
					            <c:set var="count" value="${count + 1}" />
					        </c:forEach>
					        
					        <h2 class="fw-bold text-success mb-0" style="font-size: 2.2rem;">
					            <fmt:formatNumber value="${count > 0 ? total / count : 0}" pattern="#"/>%
					        </h2>
					        
					        <div class="progress w-100 mt-2" style="height: 8px; border-radius: 10px; background-color: #f0f0f0;">
					            <div class="progress-bar progress-bar-striped progress-bar-animated bg-success" 
					                 role="progressbar" 
					                 style="width: ${count > 0 ? total / count : 0}%"></div>
					        </div>
					        <p class="mt-2 mb-0 text-muted" style="font-size: 0.75rem;">현재 <strong>${count}개</strong> 도전 중</p>
					    </div>
					
					</div>
					
					</c:if>	 </div> </div>
    </div>
</c:otherwise>
        </c:choose>
			</div>
			<div class="col-md-12 col-lg-5">
				<div id="carouselId" class="carousel slide position-relative"
					data-bs-ride="carousel">
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active rounded">
							<c:if test="${empty sessionScope.user}">
								<a href="<c:url value='/portfolioGuide.do'/>"
									class="btn px-4 py-2 text-white rounded"> 포트폴리오 만들기 가이드 </a>
							</c:if>
						</div> 

						<!--                             </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Hero End -->


	<!--         Featurs Section Start
        <div class="container-fluid featurs py-5">
            <div class="container py-5">
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-car-side fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                                <h5>Free Shipping</h5>
                                <p class="mb-0">Free on order over $300</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-user-shield fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                                <h5>Security Payment</h5>
                                <p class="mb-0">100% security payment</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-exchange-alt fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                                <h5>30 Day Return</h5>
                                <p class="mb-0">30 day money guarantee</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fa fa-phone-alt fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                                <h5>24/7 Support</h5>
                                <p class="mb-0">Support every time fast</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        Featurs Section End -->


	<%--  <!-- Fruits Shop Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="tab-class text-center">
                    <div class="row g-4">
                        <div class="col-lg-4 text-start">
                            <h1>Our Organic Products</h1>
                        </div>
                        <div class="col-lg-8 text-end">
                            <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#tab-1">
                                        <span class="text-dark" style="width: 130px;">All Products</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-2">
                                        <span class="text-dark" style="width: 130px;">Vegetables</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-3">
                                        <span class="text-dark" style="width: 130px;">Fruits</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-4">
                                        <span class="text-dark" style="width: 130px;">Bread</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill" data-bs-toggle="pill" href="#tab-5">
                                        <span class="text-dark" style="width: 130px;">Meat</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-5.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-5.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-2.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-4.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Apricots</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-3.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Banana</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-1.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Oranges</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-2.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-5.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-2" class="tab-pane fade show p-0">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-5.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-2.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-3" class="tab-pane fade show p-0">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-1.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Oranges</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-6.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Apple</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-4" class="tab-pane fade show p-0">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-5.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Grapes</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-4.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Apricots</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="tab-5" class="tab-pane fade show p-0">
                            <div class="row g-4">
                                <div class="col-lg-12">
                                    <div class="row g-4">
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-3.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Banana</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-2.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Raspberries</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                            <div class="rounded position-relative fruite-item">
                                                <div class="fruite-img">
                                                    <img src="<c:url value='/fruitables/img/fruite-item-1.jpg'/>" class="img-fluid w-100 rounded-top" alt="">
                                                </div>
                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">Fruits</div>
                                                <div class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                    <h4>Oranges</h4>
                                                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed do eiusmod te incididunt</p>
                                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                                        <p class="text-dark fs-5 fw-bold mb-0">$4.99 / kg</p>
                                                        <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>      
            </div>
        </div>
        <!-- Fruits Shop End--> --%>


	<%--    <!-- Featurs Start -->
        <div class="container-fluid service py-5">
            <div class="container py-5">
                <div class="row g-4 justify-content-center">
                    <div class="col-md-6 col-lg-4">
                        <a href="#">
                            <div class="service-item bg-secondary rounded border border-secondary">
                                <img src="<c:url value='/fruitables/img/featur-1.jpg'/>" class="img-fluid rounded-top w-100" alt="">
                                <div class="px-4 rounded-bottom">
                                    <div class="service-content bg-primary text-center p-4 rounded">
                                        <h5 class="text-white">Fresh Apples</h5>
                                        <h3 class="mb-0">20% OFF</h3>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a href="#">
                            <div class="service-item bg-dark rounded border border-dark">
                                <img src="<c:url value='/fruitables/img/featur-2.jpg'/>" class="img-fluid rounded-top w-100" alt="">
                                <div class="px-4 rounded-bottom">
                                    <div class="service-content bg-light text-center p-4 rounded">
                                        <h5 class="text-primary">Tasty Fruits</h5>
                                        <h3 class="mb-0">Free delivery</h3>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a href="#">
                            <div class="service-item bg-primary rounded border border-primary">
                                <img src="<c:url value='/fruitables/img/featur-3.jpg'/>" class="img-fluid rounded-top w-100" alt="">
                                <div class="px-4 rounded-bottom">
                                    <div class="service-content bg-secondary text-center p-4 rounded">
                                        <h5 class="text-white">Exotic Vegitable</h5>
                                        <h3 class="mb-0">Discount 30$</h3>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Featurs End --> --%>


<!-- 취업공고 + 자격증 Start -->
<div class="container-fluid py-5">
  <style>
    .main-section-box {
      background: #fff;
      border: 1px solid #eee;
      border-radius: 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 20px;
      height: 100%;
    }

    .main-section-title {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .main-section-desc {
      font-size: 14px;
      color: #777;
      margin-bottom: 20px;
    }

    .job-item {
      border-bottom: 1px solid #f1f1f1;
      padding: 14px 0;
    }

    .job-item:last-child {
      border-bottom: none;
      padding-bottom: 0;
    }

    .job-title {
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .job-company,
    .job-deadline {
      font-size: 13px;
      color: #777;
      margin-bottom: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .job-btn {
      font-size: 13px;
      padding: 6px 14px;
    }

    .ranking-wrapper {
      width: 100%;
    }

    .section-title {
      text-align: left;
      font-weight: 800;
      margin-bottom: 16px;
      font-size: 18px;
    }

    .ranking-list {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .row-container {
      height: 52px;
      perspective: 1000px;
      overflow: hidden;
      border-radius: 8px;
    }

    .cube {
      width: 100%;
      height: 100%;
      position: relative;
      transform-style: preserve-3d;
      transition: transform 0.6s ease-in-out;
    }

    .face {
      position: absolute;
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      padding: 0 14px;
      background: white;
      border-radius: 8px;
      backface-visibility: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .face:nth-child(1) { transform: rotateX(0deg) translateZ(26px); }
    .face:nth-child(2) { transform: rotateX(90deg) translateZ(26px); }
    .face:nth-child(3) { transform: rotateX(180deg) translateZ(26px); }
    .face:nth-child(4) { transform: rotateX(270deg) translateZ(26px); }

    .rank {
      font-weight: 900;
      color: #ffb524;
      margin-right: 12px;
      width: 18px;
      flex-shrink: 0;
    }

    .name {
      flex: 1;
      font-weight: 600;
      color: #444;
      font-size: 14px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      margin-right: 8px;
    }

    .tag {
      font-size: 11px;
      background: #f1f1f1;
      padding: 4px 8px;
      border-radius: 4px;
      flex-shrink: 0;
    }

    @media (max-width: 991px) {
      .main-section-title {
        font-size: 24px;
      }
    }
  </style>

  <div class="container py-5">
    <div class="row g-4">

      <!-- 왼쪽 : 취업공고 -->
      <div class="col-lg-6">
        <div class="main-section-box">
          <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
              <h1 class="main-section-title">취업공고</h1>
              <p class="main-section-desc mb-0">주요 채용 공고를 빠르게 확인해보세요</p>
            </div>
            <a href="<c:url value='/jobposting/joblist.do'/>"
               class="btn btn-outline-primary rounded-pill job-btn">전체 보기</a>
          </div>

          <div class="mt-3">
            <c:forEach var="job" items="${topJobs}" begin="0" end="2">
              <div class="job-item">
                <h5 class="job-title">${job.title}</h5>

                <div class="job-company">${job.companyName}</div>

                <div class="job-deadline">
                  마감일:
                  <c:choose>
                    <c:when test="${empty job.deadline}">
                      상시
                    </c:when>
                    <c:otherwise>
                      ${job.deadline}
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="d-flex justify-content-between align-items-center gap-2">
                  <span class="badge bg-success">${job.jobCategory}</span>

                  <a href="${job.postingUrl}" target="_blank"
                     class="btn border border-secondary rounded-pill text-primary job-btn">
                    상세보기
                  </a>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </div>

      <!-- 오른쪽 : 자격증 -->
      <div class="col-lg-6">
        <div class="main-section-box">
          <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
              <h1 class="main-section-title">자격증</h1>
              <p class="main-section-desc mb-0">마감 임박/인기 자격증을 한눈에 확인해요</p>
            </div>
            <a href="<c:url value='/certification.do'/>"
               class="btn btn-outline-primary rounded-pill job-btn">전체 보기</a>
          </div>

          <div class="ranking-wrapper mt-3">
            <div class="row g-3">

              <!-- 왼쪽 : 마감 임박 -->
              <div class="col-md-6">
                <div class="section-title">⏳ 마감 임박 TOP 5</div>

                <div class="ranking-list" id="list-left">
                  <c:forEach var="exam" items="${deadlineList}" varStatus="loop">
                    <div class="row-container">
                      <div class="cube">
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${exam.certi_name}</span>
                          <span class="tag">
                            <c:choose>
                              <c:when test="${exam.d_day == 0}">
                                <span style="color:red;">오늘 마감</span>
                              </c:when>
                              <c:when test="${exam.d_day <= 3}">
                                <span style="color:orange;">D-${exam.d_day}</span>
                              </c:when>
                              <c:otherwise>
                                <span>D-${exam.d_day}</span>
                              </c:otherwise>
                            </c:choose>
                          </span>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${exam.certi_name}</span>
                          <span class="tag">
                            <c:choose>
                              <c:when test="${exam.d_day == 0}">
                                <span style="color:red;">오늘 마감</span>
                              </c:when>
                              <c:when test="${exam.d_day <= 3}">
                                <span style="color:orange;">D-${exam.d_day}</span>
                              </c:when>
                              <c:otherwise>
                                <span>D-${exam.d_day}</span>
                              </c:otherwise>
                            </c:choose>
                          </span>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${exam.certi_name}</span>
                          <span class="tag">
                            <c:choose>
                              <c:when test="${exam.d_day == 0}">
                                <span style="color:red;">오늘 마감</span>
                              </c:when>
                              <c:when test="${exam.d_day <= 3}">
                                <span style="color:orange;">D-${exam.d_day}</span>
                              </c:when>
                              <c:otherwise>
                                <span>D-${exam.d_day}</span>
                              </c:otherwise>
                            </c:choose>
                          </span>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${exam.certi_name}</span>
                          <span class="tag">
                            <c:choose>
                              <c:when test="${exam.d_day == 0}">
                                <span style="color:red;">오늘 마감</span>
                              </c:when>
                              <c:when test="${exam.d_day <= 3}">
                                <span style="color:orange;">D-${exam.d_day}</span>
                              </c:when>
                              <c:otherwise>
                                <span>D-${exam.d_day}</span>
                              </c:otherwise>
                            </c:choose>
                          </span>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </div>

              <!-- 오른쪽 : 인기 자격증 -->
              <div class="col-md-6">
                <div class="section-title">🔥 인기 자격증 TOP 5</div>

                <div class="ranking-list" id="list-right">
                  <c:forEach var="popular" items="${popularList}" varStatus="loop">
                    <c:set var="change" value="${rankChange[loop.index]}" />

                    <div class="row-container">
                      <div class="cube">
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${popular.certi_name}</span>
                          <c:choose>
                            <c:when test="${change > 0}">
                              <span style="color:red;">▲${change}</span>
                            </c:when>
                            <c:when test="${change < 0}">
                              <span style="color:blue;">▼${-change}</span>
                            </c:when>
                            <c:otherwise>
                              <span style="color:gray;">–</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${popular.certi_name}</span>
                          <c:choose>
                            <c:when test="${change > 0}">
                              <span style="color:red;">▲${change}</span>
                            </c:when>
                            <c:when test="${change < 0}">
                              <span style="color:blue;">▼${-change}</span>
                            </c:when>
                            <c:otherwise>
                              <span style="color:gray;">–</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${popular.certi_name}</span>
                          <c:choose>
                            <c:when test="${change > 0}">
                              <span style="color:red;">▲${change}</span>
                            </c:when>
                            <c:when test="${change < 0}">
                              <span style="color:blue;">▼${-change}</span>
                            </c:when>
                            <c:otherwise>
                              <span style="color:gray;">–</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                        <div class="face">
                          <span class="rank">${loop.index + 1}</span>
                          <span class="name">${popular.certi_name}</span>
                          <c:choose>
                            <c:when test="${change > 0}">
                              <span style="color:red;">▲${change}</span>
                            </c:when>
                            <c:when test="${change < 0}">
                              <span style="color:blue;">▼${-change}</span>
                            </c:when>
                            <c:otherwise>
                              <span style="color:gray;">–</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      let currentAngle = 0;

      function rotateSequential(listId) {
        const cubes = document.querySelectorAll('#' + listId + ' .cube');

        cubes.forEach((cube, index) => {
          setTimeout(() => {
            cube.style.transform = "rotateX(" + currentAngle + "deg)";
          }, index * 150);
        });
      }

      setInterval(function() {
        currentAngle -= 90;
        rotateSequential("list-left");
        rotateSequential("list-right");
      }, 3000);
    });
  </script>
</div>
<!-- 취업공고 + 자격증 End -->
<!-- 공모전 + 후기게시판 Start -->
<div class="container-fluid py-5">
  <style>
    .main-section-box {
      background: #fff;
      border: 1px solid #eee;
      border-radius: 16px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      padding: 20px;
      height: 100%;
    }

    .main-section-title {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .main-section-desc {
      font-size: 14px;
      color: #777;
      margin-bottom: 20px;
    }

    .contest-item {
      border-bottom: 1px solid #f1f1f1;
      padding: 14px 0;
    }

    .contest-item:last-child {
      border-bottom: none;
      padding-bottom: 0;
    }

    .contest-thumb {
      width: 72px;
      min-width: 72px;
    }

    .contest-title {
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
      color: #222;
      text-decoration: none;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .contest-meta {
      font-size: 13px;
      color: #777;
      margin-bottom: 8px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .main-btn-sm {
      font-size: 13px;
      padding: 6px 14px;
    }

    .review-card-single {
      background: #fff;
      border: 1px solid #f3f3f3;
      border-radius: 14px;
      padding: 24px;
      min-height: 300px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .review-title {
      font-size: 20px;
      font-weight: 700;
      line-height: 1.5;
      margin-bottom: 16px;
    }

    .review-title a {
      color: #222;
      text-decoration: none;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .review-content {
      font-size: 14px;
      color: #666;
      line-height: 1.7;
      min-height: 120px;
      display: -webkit-box;
      -webkit-line-clamp: 5;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .review-date {
      font-size: 13px;
      color: #888;
      padding-top: 16px;
      margin-top: 16px;
      border-top: 1px solid #f1f1f1;
    }

	.review-single-carousel .owl-dots {
	  margin-top: 18px;
	  text-align: center;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  gap: 8px;
	}
	
	.review-single-carousel .owl-dot {
	  display: inline-block;
	}
	
	.review-single-carousel .owl-dot span {
	  width: 10px;
	  height: 10px;
	  margin: 0;
	  background: #ddd;
	  display: block;
	  border-radius: 50%;
	}
	
	.review-single-carousel .owl-dot.active span {
	  background: #81c408;
	}

    @media (max-width: 991px) {
      .main-section-title {
        font-size: 24px;
      }

      .review-card-single {
        min-height: 260px;
      }
    }
  </style>

  <div class="container py-5">
    <div class="row g-4">

      <!-- 왼쪽 : 공모전/대외활동 -->
      <div class="col-lg-6">
        <div class="main-section-box">
          <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
              <h1 class="main-section-title">공모전/대외활동</h1>
              <p class="main-section-desc mb-0">마감 임박 순으로 추천 공모전을 보여드려요</p>
            </div>
            <a href="<c:url value='/contest/contestlist.do'/>"
               class="btn btn-outline-primary rounded-pill main-btn-sm">전체 보기</a>
          </div>

          <c:set var="today" value="<%= new java.util.Date() %>" />

          <div class="mt-3">
            <c:forEach items="${contestList}" var="c" begin="0" end="2">
              <div class="contest-item">
                <div class="d-flex align-items-center gap-3">
                  <div class="contest-thumb">
                    <img src="${c.logoImg}"
                         class="img-fluid rounded-circle w-100"
                         alt="${c.contName}"
                         style="aspect-ratio: 1 / 1; object-fit: cover;">
                  </div>

                  <div class="flex-grow-1" style="min-width: 0;">
                    <a href="${c.siteUrl}" target="_blank" rel="noopener" class="contest-title">
                      ${c.contName}
                    </a>

                    <div class="contest-meta">${c.organizer}</div>

                    <c:if test="${not empty c.deadline}">
                      <c:set var="diff"
                             value="${(c.deadline.time - today.time) / (1000*60*60*24)}" />

                      <div class="mb-2">
                        <c:choose>
                          <c:when test="${diff == 0}">
                            <span class="badge bg-danger">오늘 마감</span>
                          </c:when>
                          <c:when test="${diff <= 3}">
                            <span class="badge bg-warning text-dark">
                              D-<fmt:formatNumber value="${diff}" maxFractionDigits="0"/>
                            </span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge bg-primary">
                              D-<fmt:formatNumber value="${diff}" maxFractionDigits="0"/>
                            </span>
                          </c:otherwise>
                        </c:choose>

                        <span class="text-dark ms-1 small">
                          <fmt:formatDate value="${c.deadline}" pattern="yyyy-MM-dd"/>
                        </span>
                      </div>
                    </c:if>

                    <a href="${c.siteUrl}" target="_blank" rel="noopener"
                       class="btn border border-secondary rounded-pill text-primary main-btn-sm">
                      바로가기
                    </a>
                  </div>
                </div>
              </div>
            </c:forEach>

            <c:if test="${empty contestList}">
              <div class="alert alert-light border text-center mb-0">
                아직 표시할 공모전 데이터가 없어요 🥲
              </div>
            </c:if>
          </div>
        </div>
      </div>

      <!-- 오른쪽 : 후기게시판 -->
     <div class="col-lg-6">
  <div class="main-section-box">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div>
        <h4 class="text-primary mb-1">후기 게시판</h4>
        <h1 class="main-section-title mb-0">이렇게 성공했어요!</h1>
      </div>
      <a href="/reviewList.do" class="btn btn-outline-primary rounded-pill main-btn-sm">전체 보기</a>
    </div>

    <div class="mt-3">
      <%-- Owl Carousel 슬라이더 시작 --%>
      <div class="owl-carousel review-single-carousel">
        <c:choose>
          <%-- 1. 데이터가 있을 때 --%>
          <c:when test="${not empty reviewList}">
            <c:forEach var="review" items="${reviewList}">
              <div class="review-card-single">
                <div>
                  <div class="review-title">
                    <a href="/reviewView.do?idx=${review.idx}">
                      ${review.title}
                    </a>
                  </div>
                  <%-- 2. 글자 수 제한 없이 전체 출력 --%>
                  <div class="review-content" ;>
                    ${review.content}
                  </div>
                </div>
                <div class="review-date">
                  <fmt:formatDate value="${review.createdat}" pattern="yyyy-MM-dd"/>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <%-- 3. 데이터가 없을 때 --%>
          <c:otherwise>
            <div class="review-card-single">
              <div class="d-flex align-items-center justify-content-center h-100">
                <h5 class="text-dark mb-0">등록된 후기가 없습니다.</h5>
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
</div>
</div>

  
</div>
<!-- 공모전 + 후기게시판 End -->
</div>



<!-- Back to Top -->
<a href="#"
	class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
	<i class="fa fa-arrow-up"></i>
</a>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
    $(document).ready(function() {
      $('.review-single-carousel').owlCarousel({
        items: 1,
        loop: true,
        margin: 20,
        nav: false,
        dots: true,
        autoplay: true,
        autoplayTimeout: 4000,
        smartSpeed: 700
      });
    });
  </script>