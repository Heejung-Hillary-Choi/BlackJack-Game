--���� ������ ���� (�������!)
DROP sequence b_qna_seq;
DROP TABLE board_qna;
DROP sequence b_noti_seq;
DROP TABLE board_notice;
DROP TABLE test_detail;
DROP sequence test_tid_seq;
DROP TABLE test;
DROP TABLE student_in_course;
DROP sequence course_cid_seq;
DROP TABLE course;
DROP TABLE student;
DROP TABLE professor;
DROP TABLE institution;
DROP TABLE ADMIN;

-- ������ 
CREATE TABLE admin (
	adid VARCHAR2(50) NOT NULL, -- ������ ID 
	password VARCHAR2(50) -- ������ ��й�ȣ 
);
ALTER TABLE admin
	ADD
		CONSTRAINT PK_admin
		PRIMARY KEY (
			adid
		);

-- ������� 
CREATE TABLE institution (
	inid VARCHAR2(50) NOT NULL, -- ������� ID 
	password VARCHAR2(50), -- ������� ��й�ȣ 
	name VARCHAR2(50), -- ������� �̸� 
	phone VARCHAR2(50), -- ������� ����ó 
	address VARCHAR2(200) -- ������� �ּ� 
);
ALTER TABLE institution
	ADD
		CONSTRAINT PK_institution
		PRIMARY KEY (
			inid
		);

-- ���� 
CREATE TABLE professor (
	prid VARCHAR2(50) NOT NULL, -- ���� ID 
	password VARCHAR2(50), -- ���� ��й�ȣ 
	name VARCHAR2(50), -- ���� �̸� 
	phone VARCHAR2(50), -- ���� ����ó 
	email VARCHAR2(50) -- ���� �̸��� 
);
ALTER TABLE professor
	ADD
		CONSTRAINT PK_professor
		PRIMARY KEY (
			prid
		);

-- �л� 
CREATE TABLE student (
	stid VARCHAR2(50) NOT NULL, -- �л� ID 
	password VARCHAR2(50), -- �л� ��й�ȣ 
	name VARCHAR2(50), -- �л� �̸� 
	phone VARCHAR2(50), -- �л� ����ó 
	email VARCHAR2(50) -- �л� �̸��� 
);
ALTER TABLE student
	ADD
		CONSTRAINT PK_student
		PRIMARY KEY (
			stid
		);

-----------------------------------------------------------

-- ���ǰ��� 
create sequence course_cid_seq;
CREATE TABLE course (
	cid NUMBER(5) NOT NULL, -- ���ǰ��� ID 
	name VARCHAR2(200), -- ���ǰ����� 
	inid VARCHAR2(50), -- ������� ID 
	prid VARCHAR2(50), -- ���� ID 
	date_full VARCHAR2(100), -- ��ü �����Ⱓ 
	room_num VARCHAR2(20) -- ���ǽ� ��ȣ 
);
ALTER TABLE course
	ADD
		CONSTRAINT PK_course
		PRIMARY KEY (
			cid
		);
ALTER TABLE course
	ADD
		CONSTRAINT FK_professor_TO_course
		FOREIGN KEY (
			prid
		)
		REFERENCES professor (
			prid
		);
ALTER TABLE course
	ADD
		CONSTRAINT FK_institution_TO_course
		FOREIGN KEY (
			inid
		)
		REFERENCES institution (
			inid
		);

-- ������ 
CREATE TABLE student_in_course (
	stid VARCHAR2(50) NOT NULL, -- �л� ID 
	cid NUMBER(5) NOT NULL, -- ���ǰ��� ID 
	attend_rate VARCHAR2(10) -- �⼮�� 
);
ALTER TABLE student_in_course
	ADD
		CONSTRAINT PK_student_in_course
		PRIMARY KEY (
			stid,
			cid
		);
ALTER TABLE student_in_course
	ADD
		CONSTRAINT FK_student_TO_stinco
		FOREIGN KEY (
			stid
		)
		REFERENCES student (
			stid
		);

ALTER TABLE student_in_course
	ADD
		CONSTRAINT FK_course_TO_stinco
		FOREIGN KEY (
			cid
		)
		REFERENCES course (
			cid
		);

-----------------------------------------------------------

-- ���� 
create sequence test_tid_seq;
CREATE TABLE test (
	tid NUMBER(5) NOT NULL, -- ���� ID 
	type NUMBER(1), -- ����/���� 
	cid NUMBER(5), -- ���ǰ��� ID 
	date_session VARCHAR2(100), -- �����Ⱓ(�ش�ɷ´����н��Ⱓ) 
	date_test DATE, -- ���Ͻ�(sysdate) 
	ncs_name VARCHAR2(50), -- ������ (�ɷ´�����)
	ncs_num VARCHAR2(50) -- �ɷ´����ڵ� 
);
ALTER TABLE test
	ADD
		CONSTRAINT PK_test
		PRIMARY KEY (
			tid
		);
ALTER TABLE test
	ADD
		CONSTRAINT FK_course_TO_test
		FOREIGN KEY (
			cid
		)
		REFERENCES course (
			cid
		);

-- ����� 
CREATE TABLE test_detail (
	ncs_num VARCHAR2(50) NOT NULL, -- �ɷ´����ڵ� 
	ques_area VARCHAR2(100), -- ���ܿ��� 
	ques_num VARCHAR2(10) NOT NULL, -- ���ܹ��׹�ȣ 
	question VARCHAR2(200) -- ���ܹ��� 
);
ALTER TABLE test_detail
	ADD
		CONSTRAINT PK_test_detail
		PRIMARY KEY (
			ncs_num,
			ques_num
		);

--������ (����+����� <-ncs_num�� ���� ���ڵ�� ����)
--������ (������+�л� ���̺�)

-----------------------------------------------------------

-- �������� 
create sequence b_noti_seq;
CREATE TABLE board_notice (
	bid NUMBER(5) NOT NULL, -- �������� �Խ��� �۹�ȣ 
	bname VARCHAR2(50), -- �������� �Խ��� �ۼ��� 
	btitle VARCHAR2(100), -- �������� �Խ��� ������ 
	bcontent VARCHAR2(1000), -- �������� �Խ��� �۳��� 
	bdate DATE, -- �������� �Խ��� �Խ��� 
	bhit NUMBER(5), -- �������� �Խ��� ��ȸ�� 
	bgroup NUMBER(5), -- �������� �Խ��� �۱׷� 
	bstep NUMBER(5), -- �������� �Խ��� �۽��� 
	bindent NUMBER(5) -- �������� �Խ��� ���ε�Ʈ 
);
ALTER TABLE board_notice
	ADD
		CONSTRAINT PK_board_notice
		PRIMARY KEY (
			bid
		);

-- �������� 
create sequence b_qna_seq;
CREATE TABLE board_qna (
	bid NUMBER(5) NOT NULL, -- �������� �Խ��� �۹�ȣ 
	bname VARCHAR2(50), -- �������� �Խ��� �ۼ��� 
	btitle VARCHAR2(100), -- �������� �Խ��� ������ 
	bcontent VARCHAR2(1000), -- �������� �Խ��� �۳��� 
	bdate DATE, -- �������� �Խ��� �Խ��� 
	bhit NUMBER(5), -- �������� �Խ��� ��ȸ�� 
	bgroup NUMBER(5), -- �������� �Խ��� �۱׷� 
	bstep NUMBER(5), -- �������� �Խ��� �۽��� 
	bindent NUMBER(5) -- �������� �Խ��� ���ε�Ʈ 
);
ALTER TABLE board_qna
	ADD
		CONSTRAINT PK_board_qna
		PRIMARY KEY (
			bid
		);
        
        
--������
insert into admin values ('admin','ncsadmin01');
--�������
insert into institution values ('humanedu','human0000','�޸ձ�������','041-561-1122','�泲 õ�Ƚ� ������ ���ﵿ');

--����
insert into professor values ('faker1','1234','�̻���','010-3535-1212','faker@naver.com');
insert into professor values ('chovy1','1234','������','010-7676-9809','chovy@naver.com');
insert into professor values ('kim81','1234','��μ�','010-3434-7897','kim8@naver.com');

--�л�
insert into student values ('kim','1234','��Ǹ�', '010-1111-1111','kim@naver.com');--1
insert into student values ('lee','1234','������', '010-1111-2222','lee@naver.com');--2
insert into student values ('iu','1234','������', '010-1111-3333','iu@naver.com');--3
insert into student values ('kim1','1234','������', '010-1111-4444','kim1@naver.com');--4
insert into student values ('min','1234','������', '010-1111-5555','min@naver.com');--5
insert into student values ('kim2','1234','������', '010-1111-6666','kim3@naver.com');--6
insert into student values ('kim3','1234','�賲��', '010-1111-7777','kim3@naver.com');--7
insert into student values ('park','1234','������', '010-1111-8888','park@naver.com');--8
insert into student values ('jung','1234','��ȣ��', '010-1111-9999','jung@naver.com');--9
insert into student values ('kim4','1234','�輮��', '010-2222-1111','kim4@naver.com');--10
insert into student values ('kim6','1234','������', '010-2222-6666','kim6@naver.com');--11
insert into student values ('park2','1234','������', '010-2222-7777','park2@naver.com');--12
insert into student values ('kim7','1234','���ظ�', '010-2222-8888','kim7@naver.com');--13
insert into student values ('kim5','1234','������', '010-2222-2222','kim5@naver.com');--14
insert into student values ('tpgns','1234','������', '010-2222-3333','tpgns@naver.com');--15
insert into student values ('rudtn','1234','�����', '010-2222-4444','rudtn@naver.com');--16
insert into student values ('Byun','1234','������', '010-2222-5555','Byun@naver.com');--17

--����
insert into course values (course_cid_seq.nextval,'java,python ����� aiȰ�� �������Ʈ���� ������ �缺����','humanedu','faker1','2021.03.29~2021.10.01','7�� 2������');
insert into course values (course_cid_seq.nextval,'����ó����� �ʱ� 4�ֿϼ�','humanedu','chovy1','2021.07.15~2021.08.13','8�� 6������');
insert into course values (course_cid_seq.nextval,'R���� ����Ʈ���� ����','humanedu','kim81','2020.06.24~2020.11.30','7�� 3������');

--������
insert into student_in_course(stid,cid,attend_rate) values ('kim',1,'74/74');

insert into student_in_course values ('lee',1,'70/74');
insert into student_in_course values ('iu',1,'71/74');
insert into student_in_course values ('kim1',1,'74/74');

insert into student_in_course values ('lee',2,'24/28');
insert into student_in_course values ('iu',2,'26/28');
insert into student_in_course values ('kim1',2,'28/28');
insert into student_in_course values ('kim5',2,'28/28');
insert into student_in_course values ('tpgns',2,'27/28');
insert into student_in_course values ('rudtn',2,'23/28');
insert into student_in_course values ('Byun',2,'25/28');

insert into student_in_course values ('min',3,'80/80');
insert into student_in_course values ('kim2',3,'80/80');
insert into student_in_course values ('kim3',3,'80/80');
insert into student_in_course values ('park',3,'76/80');
insert into student_in_course values ('jung',3,'78/80');
insert into student_in_course values ('kim4',3,'76/80');
insert into student_in_course values ('kim6',3,'80/80');
insert into student_in_course values ('park2',3,'80/80');
insert into student_in_course values ('kim7',3,'80/80');
insert into student_in_course values ('kim5',3,'80/80');
insert into student_in_course values ('tpgns',3,'80/80');
insert into student_in_course values ('rudtn',3,'80/80');
insert into student_in_course values ('Byun',3,'80/80');

--����
insert into test values (test_tid_seq.nextval,1,1,'2021.04.12~2021.04.16','2021.04.12','���ø����̼� �׽�Ʈ ����','2001020227_16v4');
--�����
insert into test_detail values ('2001020227_16v4','���ø����̼� �׽�Ʈ �����ϱ�','1.1','���ø����̼� �׽�Ʈ ��ȹ�� ���� �������....');
insert into test_detail values ('2001020227_16v4','���ø����̼� �׽�Ʈ �����ϱ�','1.2','1���� 2������');
insert into test_detail values ('2001020227_16v4','���ø����̼� �׽�Ʈ �����ϱ�','1.3','1���� 3������'); 

insert into test_detail values ('2001020227_16v4','���ø����̼� ���� ��ġ�ϱ�','2.1','2���� 1������');
insert into test_detail values ('2001020227_16v4','���ø����̼� ���� ��ġ�ϱ�','2.2','2���� 2������');
insert into test_detail values ('2001020227_16v4','���ø����̼� ���� ��ġ�ϱ�','2.3','2���� 3������');

commit;
