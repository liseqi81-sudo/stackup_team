<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>



    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
        <div class="container py-5">
            <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
                <div class="row g-4">
                    <div class="col-lg-3">
                        <a href="main.do">
                            <h1 class="text-primary mb-0">StackUp</h1>
                            <p class="text-secondary mb-0">Build your career</p>
                        </a>
                    </div>

                  <!--   <div class="col-lg-6">
                        <div class="position-relative mx-auto">
                            <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="text" placeholder="이메일로 문의하기">
                            <button type="button"
                                    class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                                    style="top: 0; right: 0;">Help</button>
                        </div>
                    </div> -->

                    <!-- <div class="col-lg-3">
                        <div class="d-flex justify-content-end pt-3">
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-secondary btn-md-square rounded-circle" href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div> -->
                </div>
            </div>

            <div class="row g-5">
                <div class="col-lg-4 col-md-6">
                    <div class="footer-item">
                        <h4 class="text-light mb-3">StackUp은 이런 서비스예요</h4>
                        <p class="mb-4">
                            취업 준비에 필요한 공고/자격증/대외활동을 한 곳에 모아,
                            나에게 맞는 준비 루트를 설계하고 포트폴리오로 정리해요.
                        </p>
                        <a href="<c:url value='/purpose.do'/>" class="btn border-secondary py-2 px-4 rounded-pill text-primary">서비스 소개</a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="d-flex flex-column text-start footer-item">
                        <h4 class="text-light mb-3">바로가기</h4>
                        <a class="btn-link" href="<c:url value='/purpose.do'/>">웹페이지 목적</a>
                        <a class="btn-link" href="<c:url value='/portfolioGuide.do'/>">포트폴리오 가이드</a>
                        <a class="btn-link" href="/certification.do">자격증</a>
                        <a class="btn-link" href="/contest/contestlist.do">공모전/대외활동</a>

                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="footer-item">
                        <h4 class="text-light mb-3">Contact</h4>
                        <p>Email: support@stackup.com</p>
                        <p>Team: StackUp</p>
                        <p class="mb-0">© StackUp. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
        <i class="fa fa-arrow-up"></i>
    </a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/fruitables/lib/easing/easing.min.js'/>"></script>
    <script src="<c:url value='/fruitables/lib/waypoints/waypoints.min.js'/>"></script>
    <script src="<c:url value='/fruitables/lib/lightbox/js/lightbox.min.js'/>"></script>
    <script src="<c:url value='/fruitables/lib/owlcarousel/owl.carousel.min.js'/>"></script>

    <!-- Template Javascript -->
    <script src="<c:url value='/fruitables/js/main.js'/>"></script>
</body>
</html>