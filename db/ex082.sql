USE bookstore;
/*
-- 테이블 만들기 : member
-- 컬럼 : memberId(문자열, 20, pk), 
	passwd(문자열, 100, not null)
	email(문자열, 100, not null), 
	usertype(문자열, 기본값:user), 
	deleted(boolean, 기본값:false), 
	regdate(날짜, 기본값:now())
*/
CREATE TABLE member
(
	memberID CHAR(20) PRIMARY KEY,
    passwd VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    usertype VARCHAR(100) DEFAULT 'user',
    deleted BOOLEAN DEFAULT FALSE,
    regdate DATETIME DEFAULT NOW()
);

/*
-- 테이블 만들기 : board
-- 컬럼 : boardno(숫자, pk, 자동증가), 
	title(문자열, 100, not null)
	content(문자열, 2000, not null), 
	writer(문자열, 20, 외래키-member의 memberid 참조), 
	deleted(boolean, 기본값:false), 
	regdate(날짜, 기본값:now())
    */
create table board
(
	boardno integer primary key auto_increment,
	title varchar(100) not null,
	content varchar (2000) not null,
	writer varchar(20) not null,
	deleted boolean default (false),
	regdate date default (now()),
	constraint fk_board_member foreign key (writer) references member(memberID)
);

drop table board;
-- member 테이블에 데이터 삽입
DESC member;
-- INSERT INTO member
-- VALUES ('01', '0101', '01@01.com'); -- 위에 무슨 값을 쓸지 명시를 안 해줬으므로 다 써야하는데, 값을 모자르게 써서 에러남
-- VALUES ('01', '0101', '01@01.com', '', 0, ''); -- 혹시 ''로 하면 null로 취급할까 해 봤지만 그냥 에러남

INSERT INTO member(memberID, passwd, email)
VALUES ('01', '0101', '01@01.com'); 
INSERT INTO member(memberID, passwd, email, deleted)
VALUES ('02', '0202', '02@02.com', 1); 
INSERT INTO member(memberID, passwd, email, regdate)
VALUES ('03', '0303', '03@03.com', 20241024); 
INSERT INTO member(memberID, passwd, email, regdate)
VALUES ('04', '0404', '04@04.com', '2024-10-24'); 
INSERT INTO member(memberID, passwd, email, regdate)
VALUES ('05', '0404', '04@04.com', '2024-10-22'); 
INSERT INTO member(memberID, passwd, email)
VALUES ('06', '****', '05@04.com'),
	   ('07', '****', '06@04.com'),
	   ('08', '****', '07@04.com'),
	   ('09', '9999', '08@04.com'),
	   ('10', '1111', '08@04.com');

SELECT * FROM member;


-- board 테이블에 데이터 삽입
DESC board;
INSERT INTO board (title, content)
VALUES ('점프 투 파이썬', '파이썬');
INSERT INTO board (title, content)
VALUES ('점프 투 파이썬', '파이썬');
INSERT INTO board (title, content, writer)
VALUES ('점프 투 파이썬2', '파이썬2', );

SELECT * FROM board;

insert into member (memberid, passwd, email) values('johndoe', 'iamuserone', '');
insert into board (title, content, writer) values ('첫 번째 게시글', '처음 쓰는 게시글 연습', '01                  '); 
-- memberID가 CHAR(20)이라서 수를 맞추기위해 뒤를 스페이스로 채움 ㅜㅜ




