--- mailbox

DROP SEQUENCE SEQ_MAILBOX;
DROP TABLE TBL_MAILBOX;

CREATE SEQUENCE SEQ_MAILBOX;
CREATE TABLE TBL_MAILBOX(
	BNO NUMBER(10, 0),
	WRITER VARCHAR2(50),
	RECIPIENT VARCHAR2(50),
	TITLE VARCHAR2(200),
	CONTENT VARCHAR2(2000),
	REGDATE DATE DEFAULT SYSDATE
);

ALTER TABLE TBL_MAILBOX ADD MEMBERS_SEQ NUMBER;
ALTER TABLE TBL_MAILBOX ADD CONSTRAINT PK_MAILBOX PRIMARY KEY (BNO);

ALTER TABLE TBL_MAILBOX ADD CONSTRAINT FK_MAILBOX_MEMBERS FOREIGN KEY (MEMBERS_SEQ) REFERENCES MEMBERS(MEMBERS_SEQ);
ALTER TABLE TBL_MAILBOX DROP CONSTRAINT FK_MAILBOX_MEMBERS;

INSERT INTO TBL_MAILBOX VALUES(
	SEQ_MAILBOX.NEXTVAL, 'mandoo180@gmail.com', '수신인', '테스트 제목', '테스트 내용 하나둘세넷다섯여섯일곱여덟ㅇ이이이', SYSDATE
);

SELECT * FROM TBL_MAILBOX;


SELECT * FROM
(
SELECT /*+INDEX_DESC(TBL_MAILBOX PK_MAILBOX)*/
ROWNUM RN, BNO, WRITER, RECIPIENT, TITLE, CONTENT, REGDATE
FROM TBL_MAILBOX
WHERE (RECIPIENT LIKE '%'||'수신인'||'%')
AND ROWNUM <= 200 AND WRITER = 'sender'
)
WHERE RN > 0;


SELECT COUNT(*) FROM TBL_MAILBOX WHERE BNO > 0 AND WRITER = 'sender';

----file upload


DROP TABLE TBL_ATTACH;

CREATE TABLE TBL_ATTACH(
	UUID VARCHAR2(100) NOT NULL,
	UPLOADPATH VARCHAR2(200) NOT NULL,
	FILENAME VARCHAR2(100) NOT NULL,
	FILETYPE CHAR(1) DEFAULT 'I',
	BNO NUMBER(10, 0)
);

SELECT * FROM TBL_ATTACH;

ALTER TABLE TBL_ATTACH ADD CONSTRAINT PK_ATTACH PRIMARY KEY (UUID);

ALTER TABLE TBL_ATTACH ADD CONSTRAINT PK_MAILBOX_ATTACH FOREIGN KEY (BNO)
REFERENCES TBL_MAILBOX(BNO);

--회원가입 및 로그인
CREATE SEQUENCE members_SEQ
START WITH 1
INCREMENT BY 1;
--회원
DROP TABLE MEMEBERS;
CREATE TABLE members
(
    members_seq        INT             NOT NULL, 
    members_name       VARCHAR2(20)    NOT NULL, 
    members_email      VARCHAR2(20)    NOT NULL,
    members_pw         VARCHAR2(20)    NOT NULL,
    members_EmailChecked    VARCHAR2(5),
    CONSTRAINT MEMBERS_PK PRIMARY KEY (members_seq)
);

ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_PK PRIMARY KEY (MEMBERS_SEQ);
ALTER TABLE MEMBERS DROP CONSTRAINT MEMBERS_PK;
ALTER TABLE MEMBERS ADD UNIQUE (MEMBERS_EMAIL);

INSERT INTO MEMBERS VALUES(
	MEMBERS_SEQ.NEXTVAL, 'choi', 'highkick89@naver.com', '1234', 'true');

SELECT * FROM MEMBERS;
SELECT * FROM MEMBERS WHERE MEMBERS_EMAIL = 'mandoo180@gmail.com';



--그룹
CREATE SEQUENCE GROUP_ADDRESS_SEQ;

DROP TABLE GROUP_ADDRESS_TABLE;
CREATE TABLE GROUP_ADDRESS_TABLE(
   group_seq NUMBER PRIMARY KEY,
   group_title   VARCHAR2(30),
   group_date DATE DEFAULT SYSDATE,
   members_seq NUMBER NOT NULL,
    cnt NUMBER NOT NULL,
   CONSTRAINT GROUP_MEMBER_SEQ  FOREIGN KEY(MEMBERS_SEQ) REFERENCES members(MEMBERS_SEQ)
);

SELECT * FROM GROUP_ADDRESS_TABLE;

--주소록
CREATE SEQUENCE address_customer_seq INCREMENT BY 1 START WITH 1;

DROP TABLE ADDRESS_TABLE;
CREATE TABLE ADDRESS_TABLE(
   customer_seq NUMBER PRIMARY KEY,
   customer_name VARCHAR2(30),
   customer_email VARCHAR2(30),
   group_seq NUMBER NOT NULL,
    members_seq NUMBER NOT NULL,
   CONSTRAINT admin_group_seq  FOREIGN KEY(group_seq) REFERENCES GROUP_ADDRESS_TABLE(group_seq),
   CONSTRAINT ADDRESS_FK_MEMBER_ID  FOREIGN KEY(MEMBERS_SEQ) REFERENCES MEMBERS(MEMBERS_SEQ) 
);

SELECT * FROM ADDRESS_TABLE;
--도움말
CREATE SEQUENCE help_SEQ INCREMENT BY 1 START WITH 1;
drop table help_table;
CREATE TABLE HELP_TABLE(
   help_seq NUMBER primary key,
   help_title VARCHAR2(100),
   help_title_detail VARCHAR2(100),
   help_members_seq NUMBER NOT NULL,
   members_name VARCHAR2(20) NOT NULL
);

commit;