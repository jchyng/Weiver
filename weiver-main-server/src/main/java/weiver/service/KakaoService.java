package weiver.service;

import java.util.HashMap;
import java.util.Map;

/**
 * 카카오 소셜 로그인 서비스를 비활성화합니다.
 * 더 이상 사용하지 않으므로 @Service 어노테이션과 외부 설정 참조를 제거했습니다.
 */
public class KakaoService {
    
    public String getKakaoAccessToken(String code) throws Exception {
        return "";
    }
    
    public Map<String, Object> getUserInfo(String token) throws Exception {
        return new HashMap<>();
    }
    
    public void kakaoLogout(String accessToken) {
        // 비활성화됨
    }
}
