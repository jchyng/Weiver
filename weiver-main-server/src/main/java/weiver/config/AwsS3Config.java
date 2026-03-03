package weiver.config;

import org.springframework.context.annotation.Configuration;

/**
 * AWS S3 설정을 비활성화합니다.
 * 로컬 업로드 방식을 사용하므로 더 이상 S3 전용 Bean이 필요하지 않습니다.
 */
@Configuration
public class AwsS3Config {
    // S3 관련 빈 설정을 모두 제거했습니다.
}
