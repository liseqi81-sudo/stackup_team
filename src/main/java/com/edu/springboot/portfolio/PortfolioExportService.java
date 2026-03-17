package com.edu.springboot.portfolio;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.edu.springboot.jdbc.PortfolioNewDTO;
import com.edu.springboot.jdbc.PortfolioSnapshotDTO;
import com.edu.springboot.jdbc.ResumeDTO;
import com.edu.springboot.jdbc.UserDTO;
import com.edu.springboot.mapper.PortfolioMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;

@Service
public class PortfolioExportService {

	private final PortfolioMapper portfolioMapper;
	private final ObjectMapper objectMapper = new ObjectMapper();

	@Value("${stackup.storage.root}")
	private String storageRoot;

	public PortfolioExportService(PortfolioMapper portfolioMapper) {
		this.portfolioMapper = portfolioMapper;
	}

	public void exportLatestResumePdf(long portfolioId, String templateType, UserDTO user) throws Exception {
		PortfolioSnapshotDTO snapshot = portfolioMapper.selectLatestSnapshot(portfolioId);
		if (snapshot == null || snapshot.getSnapshotJson() == null) {
			throw new IllegalStateException("스냅샷이 없습니다. 먼저 snapshot을 생성하세요.");
		}

		PortfolioNewDTO portfolio = portfolioMapper.selectPortfolioById(portfolioId);
		if (portfolio == null) {
			throw new IllegalStateException("포트폴리오가 없습니다.");
		}

		ResumeDTO resume = objectMapper.readValue(snapshot.getSnapshotJson(), ResumeDTO.class);

		resume.setName(user.getUser_name());

		if ((resume.getEmail() == null || resume.getEmail().isBlank()) && user.getUser_email() != null) {
		    resume.setEmail(user.getUser_email());
		}
		if ((resume.getPhone() == null || resume.getPhone().isBlank()) && user.getUser_phone() != null) {
		    resume.setPhone(user.getUser_phone());
		}
		String portraitUri = null;
		if (portfolio.getPortraitPath() != null && !portfolio.getPortraitPath().isBlank()) {
			Path portraitPath = Paths.get(storageRoot).resolve(portfolio.getPortraitPath());
			if (Files.exists(portraitPath)) {
				portraitUri = portraitPath.toUri().toString();
			}
		}

		String html;
		if (ResumePdfTemplate.DESIGN.equalsIgnoreCase(templateType)) {
			html = ResumeDesignHtmlBuilder.build(resume, portraitUri);
			templateType = ResumePdfTemplate.DESIGN;
		} else {
			html = ResumePrintHtmlBuilder.build(resume);
			templateType = ResumePdfTemplate.MINIMAL;
		}

		String relativeDir = "portfolio/" + portfolioId;
		String relativePdf = relativeDir + "/resume_" + templateType + ".pdf";
		String relativePng = relativeDir + "/thumb_" + templateType + ".png";

		Path pdfPath = Paths.get(storageRoot).resolve(relativePdf);
		Path pngPath = Paths.get(storageRoot).resolve(relativePng);

		Files.createDirectories(pdfPath.getParent());

		try (FileOutputStream fos = new FileOutputStream(pdfPath.toFile())) {
			PdfRendererBuilder builder = new PdfRendererBuilder();
			builder.withHtmlContent(html, null);

			File malgun = new File("C:/Windows/Fonts/malgun.ttf");
			if (malgun.exists()) {
				builder.useFont(malgun, "Malgun Gothic");
			}

			File malgunbd = new File("C:/Windows/Fonts/malgunbd.ttf");
			if (malgunbd.exists()) {
				builder.useFont(malgunbd, "Malgun Gothic");
			}

			builder.toStream(fos);
			builder.run();
		}

		try (PDDocument doc = PDDocument.load(pdfPath.toFile())) {
			PDFRenderer renderer = new PDFRenderer(doc);
			BufferedImage image = renderer.renderImageWithDPI(0, 180);
			ImageIO.write(image, "png", pngPath.toFile());
		}

		// 마지막 생성본 기준으로 DB 갱신
		portfolioMapper.updatePortfolioOutput(portfolioId, relativePdf, relativePng);
	}
}