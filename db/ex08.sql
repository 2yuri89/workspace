-- 작업 데이터베이스 변경
use bookstore;

DESC book;
-- 데이터 삽입(생성)
INSERT INTO book (bookid, bookname, publisher, price)
VALUES (101, '혼자 공부하는 데이터 분석', '한빛미디어', 26000);

SELECT * FROM book;

-- 데이터 삽입 (생성)2
INSERT INTO book
VALUES (102, '혼자 공부하는 머신러닝', '한빛미디어', 26000);

-- 데이터 삽입 (생성)3
INSERT INTO book (bookid, bookname)
VALUES (103, '수학으로 만드는 기초 AI');
SELECT * FROM book ORDER BY bookid DESC;

-- 데이터 삽입 (생성)4 한번에 여러개 입력 (벌크 인설트)
INSERT INTO book (bookid, bookname)
VALUES (104, '신규 도서 4'),
	   (105, '신규 도서 5'),
	   (106, '신규 도서 6'),
	   (107, '신규 도서 7'),
	   (108, '신규 도서 8');
SELECT * FROM book ORDER BY bookid DESC;

-- 데이터 삽입 (생성) 5
INSERT INTO book (bookid, bookname)
VALUES (109, '삽입 실패 도서111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
SELECT * FROM book ORDER BY bookid DESC;

-- 데이터 수정 1
UPDATE book
SET price = 50000;
select * from book;

-- 데이터 수정 2
UPDATE book
SET price = 70000
WHERE bookid > 100;
select * from book;

-- 데이터 수정 3
UPDATE book
SET price = 80000, bookname = '수정된 도서'
WHERE bookid = 101;
select * from book ORDER BY price DESC;

-- 데이터 삭제 1
DELETE FROM book
WHERE bookid > 100;
select * from book ORDER BY bookid DESC;

-----------------
-- 테이블 만들기 : book2 이름으로 book과 유사하게
CREATE TABLE book2
(
	bookid INTEGER PRIMARY KEY AUTO_INCREMENT,
    bookname VARCHAR(100) NOT NULL,
    publisher VARCHAR(100) NOT NULL,
    price INTEGER NOT NULL,
    pubdate DATE NOT NULL,
    regdate DATETIME default (now())
);

CREATE TABLE customer2
(
	custid INTEGER AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NULL,
    phone VARCHAR(20) NULL,
    -- PRIMARY KEY(custid) -- pk를 표현하는 정석적인 표현
    CONSTRAINT pk_customer2 PRIMARY KEY (custid)
);

CREATE TABLE orders2
(
	orderid INTEGER AUTO_INCREMENT,
    custid INTEGER NOT NULL,
    bookid INTEGER NOT NULL,
    saleprice INTEGER NOT NULL,
    orderdate DATE NOT NULL,
    
    CONSTRAINT pk_orders2 PRIMARY KEY (orderid),
    CONSTRAINT fk_orders2_customer2 FOREIGN KEY (custid) REFERENCES customer2(custid), -- fk 선언
    CONSTRAINT fk_orders2_book2 FOREIGN KEY (bookid) REFERENCES book2(bookid) -- fk 선언    
);

-- 테이블 수정
DESC book2;

ALTER TABLE book2 
ADD isbn CHAR(13) NULL; -- 항목 추가
DESC book2;

ALTER TABLE book2
MODIFY isbn VARCHAR(50) NULL; -- 있는 항목을 수정
DESC book2;

ALTER TABLE book2
DROP COLUMN isbn; -- 있는 항목을 삭제
DESC book2;

-- 테이블 삭제 - 자식이 있는 부모 테이블 삭제 불가
-- DROP TABLE book2; -- 다른 테이블에서 참조하는 항목이 있어서 삭제 불가 

-- 테이블 삭제 2
DROP TABLE orders2;
DROP TABLE book2;
DROP TABLE customer2;











