-- 뮤지컬 커뮤니티 'Weiver' 통합 목업 데이터 생성 스크립트
-- 이 스크립트는 실존하는 뮤지컬 데이터를 참조하여 100개의 리뷰 게시글을 생성합니다.

SET DEFINE OFF;

-- 1. 기초 시퀀스 생성 (이미 있으면 무시하고 진행)
BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE post_sequence START WITH 1 INCREMENT BY 1';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
    EXECUTE IMMEDIATE 'CREATE SEQUENCE review_sequence START WITH 1 INCREMENT BY 1';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- 2. 테스트용 사용자 10명 생성 (부모 데이터)
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO user_tb (id, user_pw, user_nickname, essential_agree, personal_agree, age_agree)
        SELECT 'user' || i, '1234', 
               CASE MOD(i, 10)
                 WHEN 1 THEN '뮤덕루피' WHEN 2 THEN '샤차르트' WHEN 3 THEN '조지킬' 
                 WHEN 4 THEN '옥러벳' WHEN 5 THEN '블퀘1열' WHEN 6 THEN '티켓팅장인'
                 WHEN 7 THEN '연뮤덕' WHEN 8 THEN '커튼콜요정' WHEN 9 THEN '회전문러' 
                 ELSE '지방공연러' END || i,
               'Y', 'Y', 'Y'
        FROM DUAL
        WHERE NOT EXISTS (SELECT 1 FROM user_tb WHERE id = 'user' || i);
    END LOOP;
    COMMIT;
END;
/

-- 3. 100개의 리얼한 리뷰 게시글 및 리뷰 연결 데이터 생성
DECLARE
    v_post_id NUMBER;
    v_user_id VARCHAR2(20);
    v_musical_id VARCHAR2(20);
    v_title VARCHAR2(300);
    v_content CLOB;
    
    -- 실존하는 뮤지컬 ID 배열 (방금 DB에서 확인한 실제 ID들)
    TYPE t_musical_ids IS TABLE OF VARCHAR2(20);
    v_m_ids t_musical_ids := t_musical_ids('226317', '221340', '222879', '223095', '222249');
    
BEGIN
    FOR i IN 1..100 LOOP
        -- 랜덤하게 사용자 및 실존 뮤지컬 ID 할당
        v_user_id := 'user' || (MOD(i, 10) + 1);
        v_musical_id := v_m_ids(MOD(i, v_m_ids.COUNT) + 1);
        
        -- 다양한 주제의 제목과 내용 조합 (20가지 패턴)
        CASE MOD(i, 20)
            WHEN 0 THEN v_title := '성량이 진짜 지붕 날아갈 뻔 했네요'; v_content := '오늘 자첫이었는데 배우님 성량 미쳤습니다. 블퀘 지붕 날아가는 줄... 무대 연출도 너무 세련됐네요.';
            WHEN 1 THEN v_title := '이 작품은 역시 전설이다... 대체불가'; v_content := '배우님들 호흡이 정말 좋았어요. 넘버 하나하나가 귀에서 계속 맴도네요. 소름 돋음.';
            WHEN 2 THEN v_title := '연기 디테일이 역시 클래스가 다르네요'; v_content := '기다리던 관극! 연기 디테일이 진짜 미쳤습니다. 컨프롱 넘버 부를 때 소름이 돋아서 혼났네요. 또 보고 싶어요.';
            WHEN 3 THEN v_title := '메인 배우 포스에 완전히 압도당함'; v_content := '보고 왔는데 배우 포스 장난 아니네요. 성량이 객석 끝까지 꽉 차는 느낌이었습니다. 전율 그 자체!';
            WHEN 4 THEN v_title := '1층 오피석 시야 후기 공유합니다'; v_content := '무대랑 너무 가까워서 목은 좀 아픈데 배우들 땀방울까지 다 보여요. 아이컨택 하는 기분이라 최고입니다.';
            WHEN 5 THEN v_title := '티켓팅 3만 번 받고 좌절했는데 산책 성공!'; v_content := '취소표 풀리는 시간 기다렸다가 겨우 한 자리 잡았네요. 역시 뮤지컬은 끝까지 포기하면 안 됩니다. 존버 승리!';
            WHEN 6 THEN v_title := '넘버 가사가 너무 시적이라 계속 곱씹게 되네요'; v_content := '집에 오는 길에 가사 찾아봤는데 어쩜 이렇게 마음을 울리는지... 작사가님 진짜 천재이신 듯. 여운이 길어요.';
            WHEN 7 THEN v_title := '뮤린이 자첫 후기: 왜 다들 뮤지컬에 빠지는지 알겠음'; v_content := '영화랑은 비교도 안 되는 현장감이 있네요. 오케스트라 라이브 연주에 전율이 느껴졌습니다. 이제 입덕합니다.';
            WHEN 8 THEN v_title := '오늘 커튼콜 데이였는데 사진 대박 건졌어요'; v_content := '배우님 정면 샷 찍었는데 화질 좋게 잘 나왔네요. 커뮤니티에 곧 사진 공유하겠습니다. 다시 봐도 멋있네요.';
            WHEN 9 THEN v_title := '음향 사고가 좀 있었지만 배우 투혼으로 살렸네요'; v_content := '마이크 지직거리는 소리가 났는데 배우들이 당황하지 않고 성량으로 다 채우는 거 보고 감동받았습니다. 역시 프로!';
            WHEN 10 THEN v_title := '지방러의 관극 원정기... KTX 비용 아깝지 않네요'; v_content := '당일치기로 서울 올라와서 봤는데 공연이 너무 좋아서 피곤함도 다 잊었습니다. 무조건 보세요. 추천합니다.';
            WHEN 11 THEN v_title := '배우님 퇴근길 짧았지만 눈인사해주셔서 행복'; v_content := '공연 끝나고 잠깐 뵈었는데 피곤하실 텐데도 웃어주시는 거 보고 다시 한번 반했습니다. 다음 공연도 예약!';
            WHEN 12 THEN v_title := '이번 시즌 의상 바뀐 거 너무 예쁘지 않나요?'; v_content := '지난 시즌보다 조금 더 화려해진 느낌이에요. 고증도 더 잘 된 것 같고 의상 구경하는 재미도 쏠쏠하네요.';
            WHEN 13 THEN v_title := '관극 매너(관크) 때문에 좀 짜증 났던 후기'; v_content := '옆자리 분이 계속 핸드폰 확인하셔서 집중이 좀 깨졌네요. 다들 제발 관람 매너 좀 지켰으면 좋겠어요.';
            WHEN 14 THEN v_title := '프로그램북 2차 버전 나왔는데 구성 좋네요'; v_content := '미공개 연습실 사진들이 많아서 소장 가치 충분합니다. 1차 버전 있으신 분들도 살만해요. 퀄리티 굿!';
            WHEN 15 THEN v_title := '무대 샹들리에 추락 씬은 볼 때마다 전율'; v_content := '무대 장치들이 정말 유기적으로 잘 움직이고 화려해서 눈이 너무 즐거운 공연이었습니다. 연출의 승리!';
            WHEN 16 THEN v_title := '부모님 모시고 가기 딱 좋은 뮤지컬인 것 같아요'; v_content := '예매해드렸는데 너무 좋아하시네요. 아는 노래들이 많이 나와서 신나셨대요. 효도 성공!';
            WHEN 17 THEN v_title := '주연 배우 가창력은 그냥 신입니다'; v_content := '설명이 필요 없습니다. 그냥 가서 보세요. 고음 올릴 때 카타르시스가 느껴져요. 티켓팅 힘들었지만 보람 최고!';
            WHEN 18 THEN v_title := '오글 8배율 vs 10배율 고민되시는 분들 필독'; v_content := '대극장은 10배율이 배우 표정 보기 확실히 좋네요. 무게가 좀 무겁지만 디테일 포기 못 하죠. 추천합니다.';
            ELSE v_title := '오늘 공연 한 줄 평: 완벽 그 자체였습니다'; v_content := '더 이상 할 말이 없네요. 안 본 사람 없게 해주세요. 제발 보세요. 제 인생 뮤지컬 등극입니다.';
        END CASE;

        -- Post 테이블 삽입
        INSERT INTO post (id, user_id, type, title, content, created_time, viewed) 
        VALUES (post_sequence.NEXTVAL, v_user_id, 'Review', v_title, v_content, sysdate - (100-i)/24, MOD(i*13, 350))
        RETURNING id INTO v_post_id;

        -- Review 테이블 삽입 (Post와 Musical 연결)
        INSERT INTO review (id, post_id, musical_id) 
        VALUES (review_sequence.NEXTVAL, v_post_id, v_musical_id);
        
        -- 20개마다 커밋
        IF MOD(i, 20) = 0 THEN
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- 최종 확인 쿼리
SELECT '최종 생성된 게시글 수: ' || COUNT(*) FROM post WHERE type = 'Review';
SELECT '최종 생성된 리뷰 연결 수: ' || COUNT(*) FROM review;
