CREATE TABLE admin (
    id         VARCHAR2(30 BYTE) NOT NULL,
    admin_pw   VARCHAR2(200 BYTE) NOT NULL,
    admin_name VARCHAR2(20 BYTE) NOT NULL
);


CREATE UNIQUE INDEX pk_admin ON
    admin (
        id
    ASC );

ALTER TABLE admin
    ADD CONSTRAINT pk_admin PRIMARY KEY ( id )
        USING INDEX pk_admin;

CREATE TABLE answer (
    id           NUMBER NOT NULL,
    inquiry_id   NUMBER NOT NULL,
    admin_id     VARCHAR2(30) NOT NULL,
    answer       VARCHAR2(4000 BYTE) NOT NULL,
    created_time DATE NOT NULL
);

CREATE UNIQUE INDEX pk_answer ON
    answer (
        id
    ASC );

ALTER TABLE answer
    ADD CONSTRAINT pk_answer PRIMARY KEY ( id )
        USING INDEX pk_answer;

CREATE TABLE inquiry (
    id           NUMBER NOT NULL,
    user_id      VARCHAR2(30 BYTE) NOT NULL,
    title        VARCHAR2(500 BYTE) NOT NULL,
    content      VARCHAR2(4000 BYTE) NOT NULL,
    created_time DATE NOT NULL
);

CREATE UNIQUE INDEX pk_inquiry ON
    inquiry (
        id
    ASC );

ALTER TABLE inquiry
    ADD CONSTRAINT pk_inquiry PRIMARY KEY ( id )
        USING INDEX pk_inquiry;

CREATE TABLE actor (
    id            VARCHAR2(100 BYTE) NOT NULL,
    name          VARCHAR2(100 BYTE),
    profile_image VARCHAR2(1000 BYTE)
);

CREATE UNIQUE INDEX actor_pk ON
    actor (
        id
    ASC );

ALTER TABLE actor
    ADD CONSTRAINT actor_pk PRIMARY KEY ( id )
        USING INDEX actor_pk;

CREATE TABLE casting (
    id         NUMBER NOT NULL,
    actor_id   VARCHAR2(100 BYTE) NOT NULL,
    role       VARCHAR2(100 BYTE),
    musical_id VARCHAR2(100 BYTE) NOT NULL
);

CREATE UNIQUE INDEX casting_pk ON
    casting (
        id
    ASC );

ALTER TABLE casting
    ADD CONSTRAINT casting_pk PRIMARY KEY ( id )
        USING INDEX casting_pk;

CREATE TABLE image (
    id      NUMBER NOT NULL,
    post_id NUMBER NOT NULL,
    path    VARCHAR2(1000 BYTE) NOT NULL
);

CREATE UNIQUE INDEX pk_image ON
    image (
        id
    ASC );

ALTER TABLE image
    ADD CONSTRAINT pk_image PRIMARY KEY ( id )
        USING INDEX pk_image;

CREATE TABLE musical (
    id             VARCHAR2(100 BYTE) NOT NULL,
    stdate         DATE,
    eddate         DATE,
    title          VARCHAR2(100 BYTE),
    theater        VARCHAR2(100 BYTE),
    view_age       VARCHAR2(100 BYTE),
    running_time   VARCHAR2(100 BYTE),
    main_character VARCHAR2(100 BYTE),
    poster_image   VARCHAR2(1000 BYTE)
);

CREATE UNIQUE INDEX musical_pk ON
    musical (
        id
    ASC );

ALTER TABLE musical
    ADD CONSTRAINT musical_pk PRIMARY KEY ( id )
        USING INDEX musical_pk;

CREATE TABLE post (
    id           NUMBER NOT NULL,
    user_id      VARCHAR2(30 BYTE) NOT NULL,
    type         VARCHAR2(20 BYTE) NOT NULL,
    title        VARCHAR2(500 BYTE) NOT NULL,
    content      VARCHAR2(4000 BYTE) NOT NULL,
    created_time DATE NOT NULL,
    viewed       NUMBER(20) DEFAULT 0 NOT NULL
);

CREATE UNIQUE INDEX pk_post ON
    post (
        id
    ASC );

ALTER TABLE post
    ADD CONSTRAINT pk_post PRIMARY KEY ( id )
        USING INDEX pk_post;

CREATE TABLE post_like (
    id      NUMBER NOT NULL,
    user_id VARCHAR2(30 BYTE) NOT NULL,
    post_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX post_like_pk ON
    post_like (
        id
    ASC );

ALTER TABLE post_like
    ADD CONSTRAINT post_like_pk PRIMARY KEY ( id )
        USING INDEX post_like_pk;

CREATE TABLE re_reply (
    id           NUMBER NOT NULL,
    post_id      NUMBER NOT NULL,
    user_id      VARCHAR2(30 BYTE) NOT NULL,
    reply_id     NUMBER NOT NULL,
    content      VARCHAR2(2000 BYTE) NOT NULL,
    created_time DATE NOT NULL
);

CREATE UNIQUE INDEX pk_re_reply ON
    re_reply (
        id
    ASC );

ALTER TABLE re_reply
    ADD CONSTRAINT pk_re_reply PRIMARY KEY ( id )
        USING INDEX pk_re_reply;

CREATE TABLE re_reply_like (
    id          NUMBER NOT NULL,
    user_id     VARCHAR2(30 BYTE) NOT NULL,
    re_reply_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX re_reply_like_pk ON
    re_reply_like (
        id
    ASC );

ALTER TABLE re_reply_like
    ADD CONSTRAINT re_reply_like_pk PRIMARY KEY ( id )
        USING INDEX re_reply_like_pk;

CREATE TABLE reply (
    id           NUMBER NOT NULL,
    post_id      NUMBER NOT NULL,
    user_id      VARCHAR2(30 BYTE) NOT NULL,
    content      VARCHAR2(2000 BYTE) NOT NULL,
    created_time DATE NOT NULL
);

CREATE UNIQUE INDEX pk_reply ON
    reply (
        id
    ASC );

ALTER TABLE reply
    ADD CONSTRAINT pk_reply PRIMARY KEY ( id )
        USING INDEX pk_reply;

CREATE TABLE reply_like (
    id       NUMBER NOT NULL,
    user_id  VARCHAR2(30 BYTE) NOT NULL,
    reply_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX reply_like_pk ON
    reply_like (
        id
    ASC );

ALTER TABLE reply_like
    ADD CONSTRAINT reply_like_pk PRIMARY KEY ( id )
        USING INDEX reply_like_pk;

CREATE TABLE review (
    id         NUMBER NOT NULL,
    post_id    NUMBER NOT NULL,
    musical_id VARCHAR2(100 BYTE)
);

CREATE UNIQUE INDEX pk_review ON
    review (
        id
    ASC );

ALTER TABLE review
    ADD CONSTRAINT pk_review PRIMARY KEY ( id )
        USING INDEX pk_review;

CREATE TABLE subscribe (
    id         NUMBER NOT NULL,
    musical_id VARCHAR2(100 BYTE) NOT NULL,
    user_id    VARCHAR2(30 BYTE) NOT NULL,
    type       VARCHAR2(20 BYTE) NOT NULL
);

CREATE UNIQUE INDEX pk_subscribe ON
    subscribe (
        id
    ASC );

ALTER TABLE subscribe
    ADD CONSTRAINT pk_subscribe PRIMARY KEY ( id )
        USING INDEX pk_subscribe;

CREATE TABLE user_tb (
    id               VARCHAR2(30 BYTE) NOT NULL,
    user_pw          VARCHAR2(200 BYTE) NOT NULL,
    user_nickname    VARCHAR2(100 BYTE) NOT NULL,
    user_profile_img VARCHAR2(1000 BYTE),
    essential_agree  CHAR(1 BYTE) DEFAULT 'N' NOT NULL,
    personal_agree   CHAR(1 BYTE) DEFAULT 'N' NOT NULL,
    age_agree        CHAR(1 BYTE) DEFAULT 'N' NOT NULL
);

CREATE UNIQUE INDEX pk_user ON
    user_tb (
        id
    ASC );

ALTER TABLE user_tb
    ADD CONSTRAINT pk_user PRIMARY KEY ( id )
        USING INDEX pk_user;

ALTER TABLE casting
    ADD CONSTRAINT casting_actor_fk FOREIGN KEY ( actor_id )
        REFERENCES actor ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE casting
    ADD CONSTRAINT casting_musical_fk FOREIGN KEY ( musical_id )
        REFERENCES musical ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE image
    ADD CONSTRAINT image_post_fk FOREIGN KEY ( post_id )
        REFERENCES post ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE post_like
    ADD CONSTRAINT post_like_post_fk FOREIGN KEY ( post_id )
        REFERENCES post ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE post_like
    ADD CONSTRAINT post_like_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE post
    ADD CONSTRAINT post_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE re_reply_like
    ADD CONSTRAINT re_reply_like_re_reply_fk FOREIGN KEY ( re_reply_id )
        REFERENCES re_reply ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE re_reply_like
    ADD CONSTRAINT re_reply_like_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE re_reply
    ADD CONSTRAINT re_reply_post_fk FOREIGN KEY ( post_id )
        REFERENCES post ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE re_reply
    ADD CONSTRAINT re_reply_reply_fk FOREIGN KEY ( reply_id )
        REFERENCES reply ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE re_reply
    ADD CONSTRAINT re_reply_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE reply_like
    ADD CONSTRAINT reply_like_reply_fk FOREIGN KEY ( reply_id )
        REFERENCES reply ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE reply_like
    ADD CONSTRAINT reply_like_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE reply
    ADD CONSTRAINT reply_post_fk FOREIGN KEY ( post_id )
        REFERENCES post ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE reply
    ADD CONSTRAINT reply_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE review
    ADD CONSTRAINT review_musical_fk FOREIGN KEY ( musical_id )
        REFERENCES musical ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE review
    ADD CONSTRAINT review_post_fk FOREIGN KEY ( post_id )
        REFERENCES post ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE subscribe
    ADD CONSTRAINT subscribe_musical_fk FOREIGN KEY ( musical_id )
        REFERENCES musical ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE subscribe
    ADD CONSTRAINT subscribe_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;
ALTER TABLE answer
    ADD CONSTRAINT answer_admin_fk FOREIGN KEY ( admin_id )
        REFERENCES admin ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE answer
    ADD CONSTRAINT answer_inquiry_fk FOREIGN KEY ( inquiry_id )
        REFERENCES inquiry ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

ALTER TABLE inquiry
    ADD CONSTRAINT inquiry_user_fk FOREIGN KEY ( user_id )
        REFERENCES user_tb ( id )
            ON DELETE CASCADE
    NOT DEFERRABLE;

create SEQUENCE answer_sequence;
create SEQUENCE casting_sequence;
create SEQUENCE image_sequence;
create SEQUENCE inquiry_sequence;
create SEQUENCE post_sequence;
create SEQUENCE post_like_sequence;
create SEQUENCE reply_sequence;
create SEQUENCE reply_like_sequence;
create SEQUENCE re_reply_sequence;
create SEQUENCE re_reply_like_sequence;
create SEQUENCE SUBSCRIBE_sequence;
create SEQUENCE user_tb_sequence;
create SEQUENCE review_sequence;
