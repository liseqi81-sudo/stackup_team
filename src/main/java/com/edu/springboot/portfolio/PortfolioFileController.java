package com.edu.springboot.portfolio;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PortfolioFileController {

	@Value("${stackup.storage.root}")
	private String storageRoot;

	@GetMapping("/portfolio/file/pdf.do")
	public ResponseEntity<Resource> pdf(@RequestParam("portfolioId") long portfolioId,
			@RequestParam(value = "templateType", defaultValue = "minimal") String templateType) throws Exception {

		String relativePdf = "portfolio/" + portfolioId + "/resume_" + templateType + ".pdf";
		Path path = Paths.get(storageRoot).resolve(relativePdf);

		if (!Files.exists(path))
			return ResponseEntity.notFound().build();

		Resource res = new FileSystemResource(path.toFile());
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_PDF).header(HttpHeaders.CONTENT_DISPOSITION,
				"inline; filename=\"resume_" + portfolioId + "_" + templateType + ".pdf\"").body(res);
	}

	@GetMapping("/portfolio/file/thumb.do")
	public ResponseEntity<Resource> thumb(@RequestParam("portfolioId") long portfolioId,
			@RequestParam(value = "templateType", defaultValue = "minimal") String templateType) throws Exception {

		String relativePng = "portfolio/" + portfolioId + "/thumb_" + templateType + ".png";
		Path path = Paths.get(storageRoot).resolve(relativePng);

		if (!Files.exists(path))
			return ResponseEntity.notFound().build();

		Resource res = new FileSystemResource(path.toFile());
		return ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).header(HttpHeaders.CACHE_CONTROL, "no-cache")
				.body(res);
	}
}