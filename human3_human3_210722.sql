--이전 데이터 삭제 (순서대로!)
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

-- 관리자 
CREATE TABLE admin (
	adid VARCHAR2(50) NOT NULL, -- 관리자 ID 
	password VARCHAR2(50) -- 관리자 비밀번호 
);
ALTER TABLE admin
	ADD
		CONSTRAINT PK_admin
		PRIMARY KEY (
			adid
		);

-- 교육기관 
CREATE TABLE institution (
	inid VARCHAR2(50) NOT NULL, -- 교육기관 ID 
	password VARCHAR2(50), -- 교육기관 비밀번호 
	name VARCHAR2(50), -- 교육기관 이름 
	phone VARCHAR2(50), -- 교육기관 연락처 
	address VARCHAR2(200) -- 교육기관 주소 
);
ALTER TABLE institution
	ADD
		CONSTRAINT PK_institution
		PRIMARY KEY (
			inid
		);

-- 강사 
CREATE TABLE professor (
	prid VARCHAR2(50) NOT NULL, -- 강사 ID 
	password VARCHAR2(50), -- 강사 비밀번호 
	name VARCHAR2(50), -- 강사 이름 
	phone VARCHAR2(50), -- 강사 연락처 
	email VARCHAR2(50) -- 강사 이메일 
);
ALTER TABLE professor
	ADD
		CONSTRAINT PK_professor
		PRIMARY KEY (
			prid
		);

-- 학생 
CREATE TABLE student (
	stid VARCHAR2(50) NOT NULL, -- 학생 ID 
	password VARCHAR2(50), -- 학생 비밀번호 
	name VARCHAR2(50), -- 학생 이름 
	phone VARCHAR2(50), -- 학생 연락처 
	email VARCHAR2(50) -- 학생 이메일 
);
ALTER TABLE student
	ADD
		CONSTRAINT PK_student
		PRIMARY KEY (
			stid
		);

-----------------------------------------------------------

-- 강의과정 
create sequence course_cid_seq;
CREATE TABLE course (
	cid NUMBER(5) NOT NULL, -- 강의과정 ID 
	name VARCHAR2(200), -- 강의과정명 
	inid VARCHAR2(50), -- 교육기관 ID 
	prid VARCHAR2(50), -- 강사 ID 
	date_full VARCHAR2(100), -- 전체 교육기간 
	room_num VARCHAR2(20) -- 강의실 번호 
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

-- 수강생 
CREATE TABLE student_in_course (
	stid VARCHAR2(50) NOT NULL, -- 학생 ID 
	cid NUMBER(5) NOT NULL, -- 강의과정 ID 
	attend_rate VARCHAR2(10) -- 출석율 
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

-- 시험 
create sequence test_tid_seq;
CREATE TABLE test (
	tid NUMBER(5) NOT NULL, -- 시험 ID 
	type NUMBER(1), -- 사전/사후 
	cid NUMBER(5), -- 강의과정 ID 
	date_session VARCHAR2(100), -- 교육기간(해당능력단위학습기간) 
	date_test DATE, -- 평가일시(sysdate) 
	ncs_name VARCHAR2(50), -- 교과목 (능력단위명)
	ncs_num VARCHAR2(50) -- 능력단위코드 
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

-- 시험상세 
CREATE TABLE test_detail (
	ncs_num VARCHAR2(50) NOT NULL, -- 능력단위코드 
	ques_area VARCHAR2(100), -- 진단영역 
	ques_num VARCHAR2(10) NOT NULL, -- 진단문항번호 
	question VARCHAR2(200) -- 진단문항 
);
ALTER TABLE test_detail
	ADD
		CONSTRAINT PK_test_detail
		PRIMARY KEY (
			ncs_num,
			ques_num
		);

--시험지 (시험+시험상세 <-ncs_num가 같은 레코드로 조인)
--시험결과 (시험지+학생 테이블)

-----------------------------------------------------------

-- 공지사항 
create sequence b_noti_seq;
CREATE TABLE board_notice (
	bid NUMBER(5) NOT NULL, -- 공지사항 게시판 글번호 
	bname VARCHAR2(50), -- 공지사항 게시판 작성자 
	btitle VARCHAR2(100), -- 공지사항 게시판 글제목 
	bcontent VARCHAR2(1000), -- 공지사항 게시판 글내용 
	bdate DATE, -- 공지사항 게시판 게시일 
	bhit NUMBER(5), -- 공지사항 게시판 조회수 
	bgroup NUMBER(5), -- 공지사항 게시판 글그룹 
	bstep NUMBER(5), -- 공지사항 게시판 글스텝 
	bindent NUMBER(5) -- 공지사항 게시판 글인덴트 
);
ALTER TABLE board_notice
	ADD
		CONSTRAINT PK_board_notice
		PRIMARY KEY (
			bid
		);

-- 질의응답 
create sequence b_qna_seq;
CREATE TABLE board_qna (
	bid NUMBER(5) NOT NULL, -- 질의응답 게시판 글번호 
	bname VARCHAR2(50), -- 질의응답 게시판 작성자 
	btitle VARCHAR2(100), -- 질의응답 게시판 글제목 
	bcontent VARCHAR2(1000), -- 질의응답 게시판 글내용 
	bdate DATE, -- 질의응답 게시판 게시일 
	bhit NUMBER(5), -- 질의응답 게시판 조회수 
	bgroup NUMBER(5), -- 질의응답 게시판 글그룹 
	bstep NUMBER(5), -- 질의응답 게시판 글스텝 
	bindent NUMBER(5) -- 질의응답 게시판 글인덴트 
);
ALTER TABLE board_qna
	ADD
		CONSTRAINT PK_board_qna
		PRIMARY KEY (
			bid
		);
        
        
--관리자
insert into admin values ('admin','ncsadmin01');
--교육기관
insert into institution values ('humanedu','human0000','휴먼교육센터','041-561-1122','충남 천안시 동남구 대흥동');

--강사
insert into professor values ('faker1','1234','이상혁','010-3535-1212','faker@naver.com');
insert into professor values ('chovy1','1234','정지훈','010-7676-9809','chovy@naver.com');
insert into professor values ('kim81','1234','김민석','010-3434-7897','kim8@naver.com');

--학생
insert into student values ('kim','1234','김건모', '010-1111-1111','kim@naver.com');--1
insert into student values ('lee','1234','이현우', '010-1111-2222','lee@naver.com');--2
insert into student values ('iu','1234','이지은', '010-1111-3333','iu@naver.com');--3
insert into student values ('kim1','1234','김태형', '010-1111-4444','kim1@naver.com');--4
insert into student values ('min','1234','민윤기', '010-1111-5555','min@naver.com');--5
insert into student values ('kim2','1234','김정국', '010-1111-6666','kim3@naver.com');--6
insert into student values ('kim3','1234','김남준', '010-1111-7777','kim3@naver.com');--7
insert into student values ('park','1234','박지민', '010-1111-8888','park@naver.com');--8
insert into student values ('jung','1234','정호석', '010-1111-9999','jung@naver.com');--9
insert into student values ('kim4','1234','김석진', '010-2222-1111','kim4@naver.com');--10
insert into student values ('kim6','1234','김종대', '010-2222-6666','kim6@naver.com');--11
insert into student values ('park2','1234','박찬열', '010-2222-7777','park2@naver.com');--12
insert into student values ('kim7','1234','김준면', '010-2222-8888','kim7@naver.com');--13
insert into student values ('kim5','1234','김종인', '010-2222-2222','kim5@naver.com');--14
insert into student values ('tpgns','1234','오세훈', '010-2222-3333','tpgns@naver.com');--15
insert into student values ('rudtn','1234','도경수', '010-2222-4444','rudtn@naver.com');--16
insert into student values ('Byun','1234','변백현', '010-2222-5555','Byun@naver.com');--17

--강의
insert into course values (course_cid_seq.nextval,'java,python 기반의 ai활용 응용소프트웨어 개발자 양성과정','humanedu','faker1','2021.03.29~2021.10.01','7층 2교육실');
insert into course values (course_cid_seq.nextval,'정보처리기사 필기 4주완성','humanedu','chovy1','2021.07.15~2021.08.13','8층 6교육실');
insert into course values (course_cid_seq.nextval,'R언어와 프론트엔드 개발','humanedu','kim81','2020.06.24~2020.11.30','7층 3교육실');

--수강생
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

--시험
insert into test values (test_tid_seq.nextval,1,1,'2021.04.12~2021.04.16','2021.04.12','애플리케이션 테스트 수행','2001020227_16v4');
--시험상세
insert into test_detail values ('2001020227_16v4','애플리케이션 테스트 수행하기','1.1','애플리케이션 테스트 계획에 따라 서버모듈....');
insert into test_detail values ('2001020227_16v4','애플리케이션 테스트 수행하기','1.2','1영역 2번문항');
insert into test_detail values ('2001020227_16v4','애플리케이션 테스트 수행하기','1.3','1영역 3번문항'); 

insert into test_detail values ('2001020227_16v4','애플리케이션 결함 조치하기','2.1','2영역 1번문항');
insert into test_detail values ('2001020227_16v4','애플리케이션 결함 조치하기','2.2','2영역 2번문항');
insert into test_detail values ('2001020227_16v4','애플리케이션 결함 조치하기','2.3','2영역 3번문항');

commit;
