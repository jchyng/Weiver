package weiver.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import weiver.config.interceptor.SessionInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    
    @Autowired
    private SessionInterceptor sessionInterceptor;

    @Value("${upload.path}")
    private String uploadPath;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(sessionInterceptor)
                    .addPathPatterns("/community/postlike/**")
                    .addPathPatterns("/mypage/**")
                    .addPathPatterns("/setting/**")
                    .addPathPatterns("/logout/**")
                    .addPathPatterns("/admin/**")
                    .excludePathPatterns("/admin/login")
                    .excludePathPatterns("/admin/signup")
                    .excludePathPatterns("/ad/**")
                    .excludePathPatterns("/main/**")
                    .excludePathPatterns("/login/**")
                    .excludePathPatterns("/signup/**")
                    .excludePathPatterns("/community/**")
                    .excludePathPatterns("/musical/**")
                    .excludePathPatterns("/actor/**");
    }

    /**
     * 로컬 파일 업로드 경로를 웹 리소스로 매핑
     * /upload/** 경로로 들어오는 요청을 실제 로컬 디렉토리와 연결합니다.
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:" + uploadPath);
    }
}
