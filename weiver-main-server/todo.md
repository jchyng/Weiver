# Weiver JSP Design Update Checklist

다음은 'Dramatic Theater' 디자인 시스템이 적용된 뷰 페이지들의 목록입니다. 모든 페이지에 Tailwind CSS 커스텀 속성, 글래스모피즘 네비게이션, 스포트라이트 호버 글로우, 그리고 `linear-gradient` 깊이감이 적용되었는지 확인하는 체크리스트입니다.

## User Pages (사용자 페이지)
- [x] main.jsp (메인 대시보드 - 리뉴얼 완료)
- [x] musicalDetail.jsp (뮤지컬 상세 - 리뉴얼 완료)
- [x] musicalSearch.jsp (뮤지컬 검색)
- [x] actorDetail.jsp (배우 상세)
- [x] login.jsp (로그인)
- [x] signup.jsp (회원가입)
- [x] mypage.jsp (마이페이지)
- [x] profileUpdate.jsp (프로필 수정)
- [x] passwordUpdate.jsp (비밀번호 변경)
- [x] setting.jsp (설정)
- [x] myBoard.jsp (내가 쓴 글)
- [x] myComment.jsp (내가 쓴 댓글)
- [x] myLike.jsp (좋아요한 글)
- [x] mySubscribe.jsp (내 작품 목록)

## Community Pages (커뮤니티)
- [x] communityMain.jsp (커뮤니티 메인)
- [x] communityDetail.jsp (게시글 상세)
- [x] communitySearchResult.jsp (게시글 검색)
- [x] registerPost.jsp (게시글 작성)
- [x] updatePost.jsp (게시글 수정)
- [x] rereplyDetail.jsp (대댓글 스레드)

## Inquiry Pages (문의)
- [x] inquiry.jsp (문의 메인)
- [x] inquiryDetail.jsp (문의 상세)
- [x] inquiryForm.jsp (문의 작성)

## Admin Pages (관리자 페이지)
- [x] adminLogin.jsp (관리자 로그인)
- [x] adminSignup.jsp (관리자 가입)
- [x] adminActors.jsp
- [x] adminAdmins.jsp
- [x] adminCrawling.jsp
- [x] adminInquiries.jsp
- [x] adminMusicals.jsp
- [x] adminPosts.jsp
- [x] adminUsers.jsp
- [x] answerInquiryForm.jsp (답변 작성)

## Excluded (적용 제외)
- [ ] config.jsp (변수 템플릿)
- [ ] index.jsp (카카오 로그인 템플릿)

*모든 뷰 페이지의 테마 색상(`#BE123C`, `#D4AF37`), 배경(`linear-gradient`), 폰트(`Cinzel`, `Pretendard`), 이펙트(`spotlight-glow`)가 일괄 적용되었습니다.*