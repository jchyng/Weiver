package weiver.service;

import org.springframework.stereotype.Service;

/**
 * @deprecated YouTube API 연동은 더 이상 사용하지 않습니다.
 * - 하드코딩된 API 키 보안 이슈
 * - musicalDetail.jsp에서 clips 데이터를 사용하지 않음
 * - API 400 에러 지속 발생
 */
@Deprecated
@Service
public class GoogleAPIService {
	// YouTube API 연동 코드 제거됨
}
