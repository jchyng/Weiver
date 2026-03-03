package weiver.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Slf4j
@Service
public class AwsS3Service {

    @Value("${upload.path}")
    private String uploadPath;

    /**
     * 로컬 파일 업로드 서비스
     * S3 대신 프로젝트 내부 static/upload 폴더에 파일을 저장합니다.
     */
    public String uploadFileV1(MultipartFile multipartFile) {
        if (multipartFile == null || multipartFile.isEmpty()) {
            return null;
        }

        // 1. 저장 디렉토리 생성
        File directory = new File(uploadPath);
        if (!directory.exists()) {
            directory.mkdirs();
            log.info("업로드 디렉토리 생성됨: {}", uploadPath);
        }

        // 2. 고유한 파일명 생성 (UUID)
        String originalFileName = multipartFile.getOriginalFilename();
        String extension = "";
        if (originalFileName != null && originalFileName.contains(".")) {
            extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        }
        String savedFileName = UUID.randomUUID().toString() + extension;

        // 3. 파일 저장
        try {
            Path targetPath = Paths.get(uploadPath + savedFileName);
            Files.write(targetPath, multipartFile.getBytes());
            log.info("파일 로컬 저장 완료: {}", targetPath);

            // 4. 웹 접근 가능한 경로 반환 (/upload/파일명)
            return "/upload/" + savedFileName;
        } catch (IOException e) {
            log.error("파일 저장 중 오류 발생: {}", e.getMessage());
            return null;
        }
    }
}
