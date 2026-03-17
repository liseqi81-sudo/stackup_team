package com.edu.springboot.utils;

public class PagingUtil {
    public static String pagingStr(int totalCount, int pageSize, int blockPage, int currentPage, String reqUrl) {
        String pagingStr = "<nav><ul class='pagination'>";

        int totalPages = (int) (Math.ceil(((double) totalCount / pageSize)));
        // 구인 페이지처럼 5개 단위 블록 계산
        int startPage = (((currentPage - 1) / blockPage) * blockPage) + 1;
        int endPage = Math.min(startPage + blockPage - 1, totalPages);

        // 맨 앞으로 (Double Left Arrow)
        pagingStr += "<li class='page-item " + (currentPage == 1 ? "disabled" : "") + "'>";
        pagingStr += "<a class='page-link' href='" + reqUrl + "?page=1'>&laquo;</a></li>";

        // 이전 블록 (Single Left Arrow)
        if (startPage > 1) {
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?page=" + (startPage - 1) + "'>&lsaquo;</a></li>";
        }

        // 숫자 버튼 생성
        for (int i = startPage; i <= endPage; i++) {
            if (i == currentPage) {
                pagingStr += "<li class='page-item active'><span class='page-link'>" + i + "</span></li>";
            } else {
                pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?page=" + i + "'>" + i + "</a></li>";
            }
        }

        // 다음 블록 (Single Right Arrow)
        if (endPage < totalPages) {
            pagingStr += "<li class='page-item'><a class='page-link' href='" + reqUrl + "?page=" + (endPage + 1) + "'>&rsaquo;</a></li>";
        }

        // 맨 뒤로 (Double Right Arrow)
        pagingStr += "<li class='page-item " + (currentPage == totalPages ? "disabled" : "") + "'>";
        pagingStr += "<a class='page-link' href='" + reqUrl + "?page=" + totalPages + "'>&raquo;</a></li>";

        pagingStr += "</ul></nav>";
        return pagingStr;
    }
}