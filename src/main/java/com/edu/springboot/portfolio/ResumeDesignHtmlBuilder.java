package com.edu.springboot.portfolio;

import java.sql.Date;
import com.edu.springboot.jdbc.ContestDTO;
import java.util.List;

import com.edu.springboot.jdbc.CertifiDTO;
import com.edu.springboot.jdbc.EducationDTO;
import com.edu.springboot.jdbc.ExperienceDTO;
import com.edu.springboot.jdbc.ProjectDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.ResumeSkillDTO;
import com.edu.springboot.jdbc.SocialLinkDTO;

public class ResumeDesignHtmlBuilder {

	private static final int MAX_SKILLS = 8;
	private static final int MAX_PROJECTS = 2;
	private static final int MAX_EXP = 2;
	private static final int MAX_EDU = 2;
	private static final int MAX_CERT = 4;
	private static final int MAX_CONTEST = 4;

	public static String build(ResumeDTO r, String portraitUri) {
		StringBuilder sb = new StringBuilder(25000);

		sb.append("<!DOCTYPE html><html><head><meta charset='UTF-8'/>").append("<style>")
				.append("@page{size:A4;margin:0;}").append("html,body{margin:0;padding:0;}")
				.append("body{font-family:'Malgun Gothic', sans-serif;color:#1a1a1a;background:#ffffff;}")
				.append(".page{width:210mm;height:297mm;overflow:hidden;}")
				.append(".layout{display:table;width:100%;height:100%;table-layout:fixed;}")
				.append(".main{display:table-cell;width:67%;vertical-align:top;background:#ffffff;padding:18mm 14mm 14mm 16mm;}")
				.append(".side{display:table-cell;width:33%;vertical-align:top;background:#313a7d;color:#ffffff;padding:14mm 10mm 12mm 10mm;}")
				.append(".name{font-size:22pt;font-weight:800;letter-spacing:-0.8px;margin:0 0 2mm 0;color:#111;}")
				.append(".headline{font-size:12pt;font-weight:700;color:#4b4fd1;margin:0 0 5mm 0;}")
				.append(".contact-line{font-size:9.5pt;color:#222;margin:0 0 2mm 0;line-height:1.45;}")
				.append(".section{margin:0 0 7mm 0;}")
				.append(".section-title{font-size:12pt;font-weight:800;margin:0 0 2mm 0;letter-spacing:-0.2px;}")
				.append(".rule{height:1.5px;background:#d7d2f5;margin:0 0 3mm 0;}")
				.append(".summary{font-size:10pt;line-height:1.48;margin:0;}").append(".item{margin:0 0 5mm 0;}")
				.append(".item-title{font-size:11pt;font-weight:800;color:#1c1c1c;}")
				.append(".item-sub{font-size:10pt;font-weight:700;color:#4b4fd1;margin-top:1mm;}")
				.append(".meta{font-size:9pt;color:#666;margin-top:1mm;}")
				.append(".bullets{margin:2mm 0 0 0;padding-left:4.5mm;}")
				.append(".bullets li{font-size:9.5pt;line-height:1.42;margin:0 0 1mm 0;}")
				.append(".edu-desc{font-size:9.5pt;line-height:1.35;margin-top:1.5mm;}")
				.append(".side-photo{width:34mm;height:34mm;background:#dfe4ff;margin:0 0 8mm auto;border:2px solid rgba(255,255,255,0.25);}")
				.append(".side-title{font-size:11.5pt;font-weight:800;color:#fff;margin:0 0 2mm 0;letter-spacing:-0.1px;}")
				.append(".side-rule{height:1.5px;background:rgba(255,255,255,0.35);margin:0 0 4mm 0;}")
				.append(".side-text{font-size:9.2pt;line-height:1.45;color:#f1f3ff;}")
				.append(".skill{margin:0 0 4mm 0;}")
				.append(".skill-name{font-size:9.3pt;color:#fff;margin-bottom:1.2mm;}")
				.append(".bar{height:3.2mm;background:rgba(255,255,255,0.18);border-radius:999px;overflow:hidden;}")
				.append(".fill{height:100%;background:#c7d3ff;border-radius:999px;}")
				.append(".tag{display:inline-block;background:#ffffff;color:#313a7d;border-radius:3mm;padding:1.2mm 2.8mm;font-size:8.8pt;font-weight:700;margin:0 2mm 2mm 0;}")
				.append(".cert{margin:0 0 3mm 0;}").append(".cert-name{font-size:9.5pt;font-weight:700;color:#fff;}")
				.append(".cert-org{font-size:8.8pt;color:#e7eaff;margin-top:0.6mm;}")
				.append(".link-item{font-size:9pt;color:#fff;line-height:1.45;margin:0 0 2mm 0;word-break:break-all;}")
				.append(".side-photo{width:34mm;height:34mm;background:#dfe4ff;margin:0 auto 8mm auto;border:2px solid rgba(255,255,255,0.25);}")
				.append(".side-photo-img{display:block;width:34mm;height:34mm;object-fit:cover;margin:0 auto 8mm auto;border:2px solid rgba(255,255,255,0.25);}")
				.append(".small-muted{font-size:8.7pt;color:#d6dbff;}").append("</style></head><body>");

		sb.append("<div class='page'><div class='layout'>");

		// ===== MAIN =====
		sb.append("<div class='main'>");

		sb.append("<h1 class='name'>").append(esc(nvl(r.getName()).toUpperCase())).append("</h1>");
		if (notBlank(r.getHeadline())) {
			sb.append("<div class='headline'>").append(esc(r.getHeadline())).append("</div>");
		}

		if (notBlank(r.getEmail()) || notBlank(r.getPhone()) || notBlank(r.getLocation())) {
			sb.append("<div class='contact-line'>");
			if (notBlank(r.getEmail()))
				sb.append(esc(r.getEmail()));
			if (notBlank(r.getPhone()))
				sb.append(" | ").append(esc(r.getPhone()));
			if (notBlank(r.getLocation()))
				sb.append(" | ").append(esc(r.getLocation()));
			sb.append("</div>");
		}

		// Summary
		if (notBlank(r.getSummary())) {
			sb.append("<div class='section'>").append("<div class='section-title'>PROFESSIONAL SUMMARY</div>")
					.append("<div class='rule'></div>").append("<p class='summary'>").append(esc(r.getSummary()))
					.append("</p>").append("</div>");
		}

		// Projects
		List<ProjectDTO> projects = r.getProjects();
		if (projects != null && !projects.isEmpty()) {
			sb.append("<div class='section'>").append("<div class='section-title'>PROJECTS</div>")
					.append("<div class='rule'></div>");

			for (int i = 0; i < projects.size() && i < MAX_PROJECTS; i++) {
				ProjectDTO p = projects.get(i);
				sb.append("<div class='item'>").append("<div class='item-title'>").append(esc(nvl(p.getTitle())))
						.append("</div>");

				if (notBlank(p.getRole())) {
					sb.append("<div class='edu-desc'>").append(esc(p.getRole())).append("</div>");
				}

				if (notBlank(p.getPeriod())) {
					sb.append("<div class='edu-desc'>").append(esc(p.getPeriod())).append("</div>");
				}

				if (notBlank(p.getOneLine())) {
					sb.append("<div class='edu-desc' style='margin-top:1.5mm;'>").append(esc(p.getOneLine()))
							.append("</div>");
				}

				if (p.getHighlights() != null && !p.getHighlights().isEmpty()) {
					sb.append("<ul class='bullets'>");
					for (int h = 0; h < p.getHighlights().size() && h < 2; h++) {
						sb.append("<li>").append(esc(p.getHighlights().get(h))).append("</li>");
					}
					sb.append("</ul>");
				}

				sb.append("</div>");
			}

			sb.append("</div>");
		}

		// Experience
		List<ExperienceDTO> exps = r.getExperience();
		if (exps != null && !exps.isEmpty()) {
			sb.append("<div class='section'>").append("<div class='section-title'>WORK EXPERIENCE</div>")
					.append("<div class='rule'></div>");

			for (int i = 0; i < exps.size() && i < MAX_EXP; i++) {
				ExperienceDTO e = exps.get(i);

				sb.append("<div class='item'>").append("<div class='item-title'>").append(esc(nvl(e.getTitle())))
						.append("</div>");

				if (notBlank(e.getCompany())) {
					sb.append("<div class='edu-desc'>").append(esc(e.getCompany())).append("</div>");
				}

				String meta = "";
				if (notBlank(e.getPeriod()))
					meta += e.getPeriod();
				if (notBlank(e.getLocation()))
					meta += (meta.isEmpty() ? "" : " · ") + e.getLocation();

				if (!meta.isEmpty()) {
					sb.append("<div class='edu-desc'>").append(esc(meta)).append("</div>");
				}

				if (e.getDescription() != null && !e.getDescription().isEmpty()) {
					sb.append("<ul class='bullets'>");
					for (int d = 0; d < e.getDescription().size() && d < 4; d++) {
						sb.append("<li>").append(esc(e.getDescription().get(d))).append("</li>");
					}
					sb.append("</ul>");
				}

				sb.append("</div>");
			}

			sb.append("</div>");
		}

		// Education
		List<EducationDTO> edu = r.getEducation();
		if (edu != null && !edu.isEmpty()) {
			sb.append("<div class='section'>").append("<div class='section-title'>EDUCATION</div>")
					.append("<div class='rule'></div>");

			for (int i = 0; i < edu.size() && i < MAX_EDU; i++) {
				EducationDTO ed = edu.get(i);

				sb.append("<div class='item'>").append("<div class='item-title'>").append(esc(nvl(ed.getDegree())))
						.append("</div>");

				if (notBlank(ed.getSchool())) {
					sb.append("<div class='edu-desc'>").append(esc(ed.getSchool())).append("</div>");
				}

				String meta = "";
				if (notBlank(ed.getStartDate()))
					meta += ed.getStartDate();
				if (notBlank(ed.getEndDate()))
					meta += (meta.isEmpty() ? "" : " ~ ") + ed.getEndDate();

				if (!meta.isEmpty()) {
					sb.append("<div class='edu-desc'>").append(esc(meta)).append("</div>");
				}

				if (notBlank(ed.getMajor())) {
					sb.append("<div class='edu-desc'>").append(esc(ed.getMajor())).append("</div>");
				}

				sb.append("</div>");
			}

			sb.append("</div>");
		}

		sb.append("</div>"); // main

		// ===== SIDE =====
		sb.append("<div class='side'>");

		if (portraitUri != null && !portraitUri.isBlank()) {
		    sb.append("<img class='side-photo-img' src='")
		      .append(escAttr(portraitUri))
		      .append("' alt='portrait' />");
		} else {
		    sb.append("<div class='side-photo'></div>");
		}

		// Skills
		List<ResumeSkillDTO> skillItems = r.getSkillItems();

		if (skillItems != null && !skillItems.isEmpty()) {
		    sb.append("<div class='section'>")
		      .append("<div class='side-title'>SKILLS</div>")
		      .append("<div class='side-rule'></div>");

		    for (int i = 0; i < skillItems.size() && i < MAX_SKILLS; i++) {
		        ResumeSkillDTO item = skillItems.get(i);
				/*
				 * System.out.println("===DEBUG====");
				 * System.err.println("user level is : "+item.getUserLevel());
				 */   
		        int percent = normalizeLevel(item.getUserLevel());
		        System.out.println(percent);
		        sb.append("<div class='skill'>")
		          .append("<div class='skill-name'>")
		          .append(esc(nvl(item.getSkillName())))
		          .append("</div>")
		          .append("<div class='bar'>")
		          .append("<div class='fill' style='width:")
		          .append(percent)
		          .append("%;'></div>")
		          .append("</div>")
		          .append("</div>");
		    }

		    sb.append("</div>");
		}
		else if (r.getSkills() != null && !r.getSkills().isEmpty()) {
		    sb.append("<div class='section'>")
		      .append("<div class='side-title'>SKILLS</div>")
		      .append("<div class='side-rule'></div>");

		    for (int i = 0; i < r.getSkills().size() && i < MAX_SKILLS; i++) {
		        sb.append("<div class='skill'>")
		          .append("<div class='skill-name'>")
		          .append(esc(r.getSkills().get(i)))
		          .append("</div>")
		          .append("<div class='bar'>")
		          .append("<div class='fill' style='width:60%;'></div>")
		          .append("</div>")
		          .append("</div>");
		    }

		    sb.append("</div>");
		}

		// Links
		List<SocialLinkDTO> links = r.getSocialLinks();
		if (links != null && !links.isEmpty()) {
			sb.append("<div class='section'>").append("<div class='side-title'>LINKS</div>")
					.append("<div class='side-rule'></div>");

			for (int i = 0; i < links.size() && i < 3; i++) {
				SocialLinkDTO l = links.get(i);
				sb.append("<div class='link-item'>").append(esc(nvl(l.getLabel()))).append(" : ")
						.append(esc(nvl(l.getUrl()))).append("</div>");
			}

			sb.append("</div>");
		}

		// Certifications
		List<CertifiDTO> certs = r.getCertificationItems();
		if (certs != null && !certs.isEmpty()) {
			sb.append("<div class='section'>").append("<div class='side-title'>CERTIFICATIONS</div>")
					.append("<div class='side-rule'></div>");

			for (int i = 0; i < certs.size() && i < MAX_CERT; i++) {
				CertifiDTO c = certs.get(i);
				sb.append("<div class='cert'>").append("<div class='cert-name'>").append(esc(nvl(c.getCerti_name())))
						.append("</div>");
				if (notBlank(c.getOrganizer())) {
					sb.append("<div class='cert-org'>").append(esc(c.getOrganizer())).append("</div>");
				}
				if (c.getDeadline() != null) {
					sb.append("<div class='small-muted'>").append(esc(fmtDate(c.getDeadline()))).append("</div>");
				}
				sb.append("</div>");
			}

			sb.append("</div>");
		}
		// Contests
		// Contests
		List<ContestDTO> contests = r.getContestItems();
		if (contests != null && !contests.isEmpty()) {
			sb.append("<div class='section'>")
			  .append("<div class='side-title'>CONTESTS</div>")
			  .append("<div class='side-rule'></div>");

			for (int i = 0; i < contests.size() && i < MAX_CONTEST; i++) {
				ContestDTO c = contests.get(i);

				sb.append("<div class='cert'>")
				  .append("<div class='cert-name'>")
				  .append(esc(nvl(c.getContName())))
				  .append("</div>");

				if (notBlank(c.getOrganizer())) {
					sb.append("<div class='cert-org'>")
					  .append(esc(c.getOrganizer()))
					  .append("</div>");
				}

				if (c.getDeadline() != null) {
					sb.append("<div class='small-muted'>")
					  .append(esc(fmtDate(c.getDeadline())))
					  .append("</div>");
				}

				sb.append("</div>");
			}

			sb.append("</div>");
		}
		sb.append("</div>"); // side

		sb.append("</div></div>");
		sb.append("</body></html>");

		return sb.toString();
	}

	private static boolean notBlank(String s) {
		return s != null && !s.trim().isEmpty();
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}

	private static String fmtDate(Date d) {
		if (d == null)
			return "";
		return d.toString();
	}

	private static String esc(String s) {
		return nvl(s).replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
	}
	private static String escAttr(String s) {
	    return nvl(s)
	            .replace("&", "&amp;")
	            .replace("<", "&lt;")
	            .replace(">", "&gt;")
	            .replace("\"", "&quot;")
	            .replace("'", "&#39;");
	}
	private static int normalizeLevel(Integer level) {
	    if (level == null) return 60;

	    // 1~5 스케일이면 20배
	    if (level >= 1 && level <= 5) {
	        return level * 20;
	    }

	    return 60;
	}
}