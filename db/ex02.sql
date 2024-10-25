-- 데이터 베이스 목록 조회
SHOW DATABASES;

-- 작업 데이터베이스 선택(변경)
USE bookstore;

-- 테이블 목록 조회
SHOW TABLES;

-- 테이블 구조 조회
DESC book;

-- 모든 도서 조회
SELECT bookid, bookname, publisher, price
FROM book;

SELECT *
FROM book;

-- 모든 도서의 도서명, 출판사, 가격 조회
SELECT bookname, publisher, price
FROM book;

-- 출판사 조회 ( 중복 제거 )
-- select publisher
SELECT distinct publisher
FROM book;

-- 대한미디어에서 출간한 도서 조회
SELECT *
FROM book
WHERE publisher = '대한미디어';

-- 대한미디어에서 출간한 도서 중 가격이 30000원 이상인 도서 조회
SELECT *
FROM book
WHERE publisher = '대한미디어' AND price >= 30000;

-- 가격이 20000 ~ 30000인 도서 조회 1
SELECT *
FROM book
WHERE price >= 20000 AND price <= 30000;

-- 가격이 20000 ~ 30000인 도서 조회 2
SELECT *
FROM book
WHERE price BETWEEN 20000 AND 30000;

-- 가격이 20000이하 또는 30000이상인 도서 조회 1
SELECT *
FROM book
WHERE price <= 20000 OR price >= 30000;

-- 가격이 20000미만 또는 30000초과인 도서 조회 2
SELECT *
FROM book
WHERE price NOT BETWEEN 20000 AND 30000;

-- 도서를 가격순으로 조회 (낮은 가격 -> 높은 가격) -- ASC 오름차순 -- ASC는 default라 지정 안 해도 괜찮음
SELECT *
FROM book
ORDER BY price;

-- 도서를 가격순으로 조회 (높은 가격 -> 낮은 가격) -- DESC 내림차순
SELECT *
FROM book
ORDER BY price DESC;

-- 도서를 출판사 및 가격순으로 조회 우선 출판사순(오름) 그 다음 가격순(내림)
SELECT *
FROM book
ORDER BY publisher ASC, price DESC;

-- 주문 데이터 조회
SELECT *
FROM orders;

-- 매출액 조회 (주문 총액) -- SQL은 ''과 ""를 구분한다. ''는 데이터: 문자, 날짜 표현, ""는 이름 표시할때 사용
SELECT SUM(saleprice) AS "주문 총액"
FROM orders;

-- 매출액 조회 (평균 등)
SELECT 
	SUM(saleprice) AS "구매 총액", 
	AVG(saleprice) AS "구매 평균",
    MAX(saleprice) AS "최고구매액",
    MIN(saleprice) AS "최th구매액",
    COUNT(saleprice) AS "구매건수"
FROM orders;
-- 이런 집계함수들은 group by랑 잘 엮어서 쓴다

-- 고객별 구매액 (총액, 평균) 조회 -- AS 생략가능
SELECT 
	custid,
	SUM(saleprice) "총구매액", 
	AVG(saleprice) "평균구매액"
FROM orders
GROUP BY custid;

-- 고객별 구매액 (총액, 평균) 조회 -- AS 생략가능
SELECT 
	custid,
	SUM(saleprice) "총구매액", 
	AVG(saleprice) "평균구매액",
    COUNT(saleprice) "구매건수"
FROM orders
GROUP BY custid
ORDER BY SUM(saleprice) DESC;

-- 총구매액이 30000이상인 고객별 구매액 (총액, 평균) 조회
SELECT 
	custid,
	SUM(saleprice) "총구매액", 
	AVG(saleprice) "평균구매액"
FROM orders
-- WHERE SUM(saleprice) >=30000 -- 에러남 -- 집계는 group by 후에 하므로, 이 줄 말고 group by 다음에 having을 넣어 처리한다
GROUP BY custid
HAVING SUM(saleprice) >= 30000;

-- 총구매액이 30000이상인 고객별 구매액 (총액, 평균) 조회
SELECT 
	custid,
	SUM(saleprice) "총구매액", 
	AVG(saleprice) "평균구매액"
FROM orders
-- WHERE SUM(saleprice) >=30000 -- 에러남 -- 집계는 group by 후에 하므로, 이 줄 말고 group by 다음에 having을 넣어 처리한다
GROUP BY custid
HAVING SUM(saleprice) >= 30000
ORDER BY SUM(saleprice) DESC;

-- 축구 관련 도서 조회
SELECT *
FROM book
-- WHERE bookname = '축구';
WHERE bookname like '%축구%';
-- 앞의 %는 피할 수 있으면 피하는게 좋다. 왜냐면 성능이 너무 나빠져서

-- 전화번호를 등록하지 않은 고객 조회
SELECT * 
FROM customer
-- WHERE phone = NULL; -- 결과 안 나옴
WHERE phone IS NULL; -- 결과 안 나옴






