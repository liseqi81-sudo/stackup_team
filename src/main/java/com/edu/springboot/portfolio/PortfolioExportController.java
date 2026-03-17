package com.edu.springboot.portfolio;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.edu.springboot.jdbc.UserDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class PortfolioExportController {

	private final PortfolioExportService service;

	public PortfolioExportController(PortfolioExportService service) {
		this.service = service;
	}

	@PostMapping("/portfolio/export/pdf.do")
	public String export(@RequestParam("portfolioId") long portfolioId,
	                     @RequestParam("templateType") String templateType,
	                     HttpSession session) throws Exception {

	    UserDTO user = (UserDTO) session.getAttribute("user");
	    if (user == null) return "redirect:/login.do";

	    service.exportLatestResumePdf(portfolioId, templateType, user);

	    return "redirect:/portfolio/dashboard.do";
	}
}