# 🎬 **Weiver**
### 🎬 Weiver는 뮤지컬 정보 제공, 후기 공유 커뮤니티입니다.
![logo](https://github.com/Weiver-project/Weiver/assets/116157924/af5207db-9c59-4600-a519-c42211897935)

<br>

## ✨Overview
뮤지컬 정보, 현재 진행중인 뮤지컬, 배우가 참여한 뮤지컬과 같은 정보를 얻을 수 있고

커뮤니티를 통해 후기를 공유하고 다른 사용자와 의견의 주고 나눌 수 있습니다.

**📆 프로젝트 기간 : 2023.06.15 ~ 2023.07.25**
 <hr style="border: 0px;">
<br>

## 🙂 업무분배 
|**이름**|**업무**|
|:---:|:---:|
|**이석현**|playDB 배우 정보 크롤링, Youtube API, 관리자 페이지 기능 담당|
|**정찬영**|playDB 뮤지컬 정보 크롤링, 뮤지컬 관련 기능, 배포 담당|
|**곽유섭**|마이 페이지(구독, 유저, 문의) 기능 담당, 관리자 페이지 기능 담당|
|**김현수**|커뮤니티 페이지(게시글, 상세게시글, 좋아요) 기능 담당, UI 디테일 담당|
|**이종형**|카카오 로그인 API, 유저 등록, 로그인 기능, 배우 정보 기능 담당|

### 주요기능
뮤지컬 정보 조회 : 검색어, 뮤지컬 포스터 클릭 시 해당 뮤지컬의 정보(공연 기간, 출연진 정보 등)를 조회합니다.
배우 정보 조회 : 배우 사진을 클릭 시 해당 배우가 참여한 뮤지컬을 조회합니다.
리뷰 작성 : 내가 본 뮤지컬을 검색하여 해당 뮤지컬에 대한 리뷰를 작성할 수 있습니다.
잡담(일반 게시글) 작성 : 

### 개발환경 :

## 서비스 아키텍처
![weiver](https://github.com/Weiver-project/Weiver/assets/78299214/c935142c-2614-42c6-bf99-f86af0143e62)
## ERD
![ERD](https://github.com/Weiver-project/Weiver/assets/78299214/d9689a4f-1e36-499f-beb1-9a8d57292528)
## 구현 결과
### 뮤지컬   
- [X] **메인 페이지**   
+ 인기 뮤지컬: '봤어요' 클릭이 가장 많은 뮤지컬 상위 3개 출력   
+ 커뮤니티 인기글: '조회수' 기준 상위 게시글 9개 출력   
+ 추천 배우: 랜덤으로 배우 프로필 사진과 출연작 출력, 클릭 시 배우 상세 페이지 이동, 새로고침 시 배우 정보 변동   
+ 공연 중인 뮤지컬: 공연 기간 기준 현재 공연 중인 뮤지컬 리스트 출력
   <p>
![뮤지컬 메인 페이지](https://github.com/Weiver-project/Weiver/assets/81962257/fbf2cc82-c97d-4032-8195-ba350ce451c4)
     </p>

- [X] **상세 페이지**   
+ 뮤지컬 기본 정보 조회   
+ '찜하기', '봤어요' 클릭   
+ 출연 배우 정보 조회   
+ Youtube API 통한 유튜브 클립 출력
     <p>    
![뮤지컬 상세 페이지](https://github.com/Weiver-project/Weiver/assets/81962257/2a88980a-3075-4e37-9507-e85e8976f389)
     </p>
   
### 커뮤니티  
- [X] **메인 페이지**   
+ 커뮤니티 인기글: '조회수' 기준 상위 게시글 9개 출력   
+ 게시글: 카테고리(리뷰, 잡담)에 따라 게시글 구분하여 출력   
+ 로그인 시, 유저 간략 정보 측면 nav바에 출력   
     <p>    
![커뮤니티 메인 페이지](https://github.com/Weiver-project/Weiver/assets/81962257/f6d4e069-5717-4d00-957b-99b3daa58e7d)
     </p>

- [X] **상세 페이지**   
+ 게시글 정보 상세 조회   
+ 댓글, 대댓글 작성   
+ 본인 작성에 한하여 게시글, 댓글, 대댓글 수정 및 삭제 가능   
     <p>    
![게시글 상세 페이지](https://github.com/Weiver-project/Weiver/assets/81962257/cb916d13-dbd6-4d7e-a8f8-6ef17936db47)
     </p>

- [X] **글 작성 페이지**   
+ 글 카테고리(잡담, 리뷰) 선택 가능   
+ 리뷰 선택 시, 뮤지컬 정보 연동   
+ 이미지 첨부 가능   
     <p>    
![제목 없는 동영상](https://github.com/Weiver-project/Weiver/assets/81962257/6fb59d44-8cba-4805-aedc-b767fa8a2023)
     </p>

    

## 트러블 슈팅

## 회고


## 수상내역
