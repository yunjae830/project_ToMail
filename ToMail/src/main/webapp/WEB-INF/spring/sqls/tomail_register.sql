DROP SEQUENCE members_SEQ;
DROP TABLE members;
CREATE SEQUENCE members_SEQ
START WITH 1
INCREMENT BY 1;

CREATE TABLE members
(
    members_seq        INT             NOT NULL, 
    members_name       VARCHAR2(20)    NOT NULL, 
      members_email      VARCHAR2(20)    NOT NULL,
    members_pw         VARCHAR2(20)    NOT NULL,
    members_EmailChecked    VARCHAR2(5),
    CONSTRAINT MEMBERS_PK PRIMARY KEY (members_seq)
);

INSERT INTO MEMBERS VALUES(
	MEMBERS_SEQ.NEXTVAL, 'CHOI', 'mandoo180@gmail.com', '1234', 'true'
);

SELECT * FROM MEMBERS;

DELETE FROM MEMBERS WHERE MEMBERS_SEQ = 3;
