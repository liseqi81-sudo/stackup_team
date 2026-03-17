package com.edu.springboot.portfolio;

import java.sql.Date;
import java.util.List;

import com.edu.springboot.jdbc.CertifiDTO;
import com.edu.springboot.jdbc.ContestDTO;
import com.edu.springboot.jdbc.EducationDTO;
import com.edu.springboot.jdbc.ExperienceDTO;
import com.edu.springboot.jdbc.ProjectDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.ResumeSkillDTO;
import com.edu.springboot.jdbc.SocialLinkDTO;

public class ResumePrintHtmlBuilder {

    private static final int MAX_SKILLS = 18;
    private static final int MAX_PROJECTS = 3;
    private static final int MAX_EXP = 2;
    private static final int MAX_EDU = 2;
    private static final int MAX_CERT = 5;
    private static final int MAX_CONTEST = 4;

    public static String build(ResumeDTO r) {
        StringBuilder sb = new StringBuilder(22000);

        sb.append("<!DOCTYPE html><html><head><meta charset='UTF-8'/>")
          .append("<style>")
          .append("@page{size:A4;margin:12mm;}")
          .append("html,body{margin:0;padding:0;}")
          .append("body{font-family:Arial,'Malgun Gothic',sans-serif;color:#111;}")
          .append(".page{width:186mm;min-height:273mm;}")
          .append(".grid{display:table;width:100%;table-layout:fixed;}")
          .append(".left,.right{display:table-cell;vertical-align:top;}")
          .append(".left{width:34%;padding-right:8mm;border-right:1px solid #e6e6e6;}")
          .append(".right{width:66%;padding-left:8mm;}")
          .append(".two-col{display:table;width:100%;table-layout:fixed;}")
          .append(".two-left,.two-right{display:table-cell;vertical-align:top;}")
          .append(".two-left{width:50%;padding-right:6mm;}")
          .append(".two-right{width:50%;padding-left:6mm;}")
          .append(".name{font-size:22pt;font-weight:700;margin:0 0 4mm 0;letter-spacing:-0.4px;}")
          .append(".headline{font-size:11pt;color:#444;margin:0 0 6mm 0;}")
          .append("h2{font-size:12pt;margin:0 0 3mm 0;letter-spacing:-0.2px;}")
          .append(".section{margin:0 0 6mm 0;}")
          .append(".label{font-size:9pt;color:#666;letter-spacing:0.06em;text-transform:uppercase;margin:0 0 2mm 0;}")
          .append(".text{font-size:10pt;line-height:1.45;margin:0;}")
          .append(".list{margin:0;padding:0;list-style:none;}")
          .append(".list li{font-size:10pt;line-height:1.4;margin:0 0 1.5mm 0;}")
          .append(".badge{display:inline-block;border:1px solid #e6e6e6;background:#fafafa;border-radius:999px;padding:1.5mm 3mm;margin:0 2mm 2mm 0;font-size:9pt;}")
          .append(".item{margin:0 0 4mm 0;}")
          .append(".item-title{font-size:10.5pt;font-weight:700;line-height:1.35;}")
          .append(".item-sub{font-size:9.5pt;color:#444;line-height:1.4;margin-top:1mm;}")
          .append(".item-meta{font-size:9pt;color:#666;line-height:1.35;margin-top:1mm;}")
          .append(".item-soft{font-size:9.5pt;color:#333;line-height:1.42;margin-top:1mm;}")
          .append(".desc{font-size:10pt;line-height:1.42;margin:2mm 0 0 0;}")
          .append(".skill-list{margin:0;padding:0;list-style:none;}")
          .append(".skill-list li{font-size:9.5pt;line-height:1.4;margin:0 0 1.8mm 0;}")
          .append("ul.bullets{margin:2mm 0 0 0;padding-left:4mm;}")
          .append("ul.bullets li{font-size:9.5pt;line-height:1.42;margin:0 0 1mm 0;}")
          .append("</style></head><body>");

        sb.append("<div class='page'><div class='grid'>");

        // LEFT
        sb.append("<div class='left'>");

        sb.append("<h1 class='name'>").append(esc(nvl(r.getName()))).append("</h1>");
        if (notBlank(r.getHeadline())) {
            sb.append("<p class='headline'>").append(esc(r.getHeadline())).append("</p>");
        }

        // Contact
        sb.append("<div class='section'><p class='label'>Contact</p><ul class='list'>");
        if (notBlank(r.getEmail())) sb.append("<li>Email: ").append(esc(r.getEmail())).append("</li>");
        if (notBlank(r.getPhone())) sb.append("<li>Phone: ").append(esc(r.getPhone())).append("</li>");
        if (notBlank(r.getLocation())) sb.append("<li>Location: ").append(esc(r.getLocation())).append("</li>");
        sb.append("</ul></div>");

        // Links
        List<SocialLinkDTO> links = r.getSocialLinks();
        if (links != null && !links.isEmpty()) {
            sb.append("<div class='section'><p class='label'>Links</p><ul class='list'>");
            for (int i = 0; i < links.size() && i < 3; i++) {
                SocialLinkDTO l = links.get(i);
                sb.append("<li>")
                  .append(esc(nvl(l.getLabel())))
                  .append(" : ")
                  .append(esc(nvl(l.getUrl())))
                  .append("</li>");
            }
            sb.append("</ul></div>");
        }

        // Skills
        List<ResumeSkillDTO> skillItems = r.getSkillItems();
        if (skillItems != null && !skillItems.isEmpty()) {
            sb.append("<div class='section'><p class='label'>Skills</p><ul class='skill-list'>");
            for (int i = 0; i < skillItems.size() && i < MAX_SKILLS; i++) {
                ResumeSkillDTO item = skillItems.get(i);
                sb.append("<li>").append(esc(nvl(item.getSkillName()))).append("</li>");
            }
            sb.append("</ul></div>");
        } else if (r.getSkills() != null && !r.getSkills().isEmpty()) {
            sb.append("<div class='section'><p class='label'>Skills</p>");
            for (int i = 0; i < r.getSkills().size() && i < MAX_SKILLS; i++) {
                sb.append("<span class='badge'>")
                  .append(esc(r.getSkills().get(i)))
                  .append("</span>");
            }
            sb.append("</div>");
        }

        // Summary
        if (notBlank(r.getSummary())) {
            sb.append("<div class='section'><p class='label'>Summary</p><p class='text'>")
              .append(esc(r.getSummary()))
              .append("</p></div>");
        }

        sb.append("</div>"); // left

        // RIGHT
        sb.append("<div class='right'>");

        // Projects
        List<ProjectDTO> projects = r.getProjects();
        if (projects != null && !projects.isEmpty()) {
            sb.append("<div class='section'><h2>Projects</h2>");
            for (int i = 0; i < projects.size() && i < MAX_PROJECTS; i++) {
                ProjectDTO p = projects.get(i);
                sb.append("<div class='item'>");

                sb.append("<div class='item-title'>")
                  .append(esc(nvl(p.getTitle())))
                  .append("</div>");

                if (notBlank(p.getRole())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(p.getRole()))
                      .append("</div>");
                }

                if (notBlank(p.getPeriod())) {
                    sb.append("<div class='item-meta'>")
                      .append(esc(p.getPeriod()))
                      .append("</div>");
                }

                if (notBlank(p.getOneLine())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(p.getOneLine()))
                      .append("</div>");
                }

                if (p.getHighlights() != null && !p.getHighlights().isEmpty()) {
                    sb.append("<ul class='bullets'>");
                    for (int h = 0; h < p.getHighlights().size() && h < 3; h++) {
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
            sb.append("<div class='section'><h2>Experience</h2>");
            for (int i = 0; i < exps.size() && i < MAX_EXP; i++) {
                ExperienceDTO e = exps.get(i);
                sb.append("<div class='item'>");

                if (notBlank(e.getCompany())) {
                    sb.append("<div class='item-title'>")
                      .append(esc(e.getCompany()))
                      .append("</div>");
                }

                if (notBlank(e.getTitle())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(e.getTitle()))
                      .append("</div>");
                }

                String meta = "";
                if (notBlank(e.getPeriod())) meta += e.getPeriod();
                if (notBlank(e.getLocation())) meta += (meta.isEmpty() ? "" : " · ") + e.getLocation();

                if (!meta.isEmpty()) {
                    sb.append("<div class='item-meta'>")
                      .append(esc(meta))
                      .append("</div>");
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

        // Education + Certifications
        sb.append("<div class='section' style='border-top:1px solid #e6e6e6;padding-top:4mm;'>");
        sb.append("<div class='two-col'>");

        // Education
        sb.append("<div class='two-left'><h2>Education</h2>");
        List<EducationDTO> edu = r.getEducation();
        if (edu != null && !edu.isEmpty()) {
            for (int i = 0; i < edu.size() && i < MAX_EDU; i++) {
                EducationDTO ed = edu.get(i);
                sb.append("<div class='item'>");

                if (notBlank(ed.getSchool())) {
                    sb.append("<div class='item-title'>")
                      .append(esc(ed.getSchool()))
                      .append("</div>");
                }

                if (notBlank(ed.getDegree())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(ed.getDegree()))
                      .append("</div>");
                }

                if (notBlank(ed.getMajor())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(ed.getMajor()))
                      .append("</div>");
                }

                String meta = "";
                if (notBlank(ed.getStartDate())) meta += ed.getStartDate();
                if (notBlank(ed.getEndDate())) meta += (meta.isEmpty() ? "" : " ~ ") + ed.getEndDate();

                if (!meta.isEmpty()) {
                    sb.append("<div class='item-meta'>")
                      .append(esc(meta))
                      .append("</div>");
                }

                sb.append("</div>");
            }
        }
        sb.append("</div>");

        // Certifications
        sb.append("<div class='two-right'><h2>Certifications</h2>");
        List<CertifiDTO> certs = r.getCertificationItems();
        if (certs != null && !certs.isEmpty()) {
            for (int i = 0; i < certs.size() && i < MAX_CERT; i++) {
                CertifiDTO c = certs.get(i);
                sb.append("<div class='item'>");

                sb.append("<div class='item-title'>")
                  .append(esc(nvl(c.getCerti_name())))
                  .append("</div>");

                if (notBlank(c.getOrganizer())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(c.getOrganizer()))
                      .append("</div>");
                }

                if (c.getDeadline() != null) {
                    sb.append("<div class='item-meta'>")
                      .append(esc(fmtDate(c.getDeadline())))
                      .append("</div>");
                }

                sb.append("</div>");
            }
        }
        sb.append("</div>");

        sb.append("</div></div>"); // two-col + section

        // Contests
        List<ContestDTO> contests = r.getContestItems();
        if (contests != null && !contests.isEmpty()) {
            sb.append("<div class='section'><h2>Contests</h2>");
            for (int i = 0; i < contests.size() && i < MAX_CONTEST; i++) {
                ContestDTO c = contests.get(i);
                sb.append("<div class='item'>");

                sb.append("<div class='item-soft'>")
                  .append(esc(nvl(c.getContName())))
                  .append("</div>");

                if (notBlank(c.getOrganizer())) {
                    sb.append("<div class='item-soft'>")
                      .append(esc(c.getOrganizer()))
                      .append("</div>");
                }

                if (c.getDeadline() != null) {
                    sb.append("<div class='item-meta'>")
                      .append(esc(fmtDate(c.getDeadline())))
                      .append("</div>");
                }

                sb.append("</div>");
            }
            sb.append("</div>");
        }

        sb.append("</div>"); // right
        sb.append("</div></div>"); // grid + page
        sb.append("</body></html>");

        return sb.toString();
    }

    private static boolean notBlank(String s) {
        return s != null && !s.trim().isEmpty();
    }

    private static String nvl(String s) {
        return s == null ? "" : s;
    }

    private static String esc(String s) {
        return nvl(s)
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }

    private static String fmtDate(Date d) {
        if (d == null) return "";
        return d.toString();
    }
}