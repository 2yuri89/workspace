/* JOIN */

-- 작업 데이터베이스 변경
USE bookstore;

-- 박지성 고객의 구매 이력
SELECT * FROM customer;
SELECT * FROM orders;
-- customer테이블에서 고객의 이름을, orders에서 구매이력을 가져와야함

-- join 1번 방식 from절에 결합하고자하는 테이블을 다써주고, 조인 조건을 걸어서 양쪽 테이블에서 일치하는 것만 가지고 옴.
SELECT c.name, o.*
FROM orders o, customer c -- orders는 o로, customer는 c로 별명지어줌(앨리어싱)
WHERE o.custid = c.custid  -- join 조건
	  AND 
      c.name = '박지성'; -- 일반 조건

SELECT c.name, SUM(o.saleprice)
FROM orders o, customer c -- orders는 o로, customer는 c로 별명지어줌(앨리어싱)
WHERE o.custid = c.custid  -- join 조건
	  AND 
      c.name = '박지성'; -- 일반 조건

/* join의 정석적 표현 */
SELECT c.name, o.*
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid -- join 조건은 ON 절에
WHERE c.name = '박지성'; -- 일반 조건은 WHERE 절에

-- 고객과 고객의 주문에 정보 조회 (2개 테이블 조인)
SELECT c.custid, c.name, o.bookid, o.saleprice, o.orderdate
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid
ORDER BY c.custid;

-- 고객과 고객의 주문에 정보 조회 + 도서 이름(3개 테이블 조인)
SELECT c.custid, c.name, b.bookid, b.bookname, o.saleprice, o.orderdate
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid
INNER JOIN book b
ON o.bookid = b.bookid
ORDER BY c.custid;


-- CROSS JOIN
SELECT *
FROM customer c
CROSS JOIN orders o
ORDER BY c.custid;

-- 고객별 주문 총액 조회 (고객 이름 표시) - 구매 이력이 없는 고객은 조회가 안 됌
-- inner join은 양쪽에 다 있어야 조회 가능
SELECT c.custid, c.name, IFNULL(SUM(o.saleprice), 0)
-- 주문 총액이 NULL이라면 0으로 표시하라
FROM customer c
-- INNER JOIN orders o
LEFT OUTER JOIN orders o
-- 이건 left, right 지정해줘야함. 우리는 customer다 나와야함. 
-- 지금은 LEFT - 고객 전부 조회  RIGHTH는 주문 전부 조회
ON c.custid = o.custid
GROUP BY c.custid, c.name
ORDER BY c.custid;

/* subquery 또는 join을 사용해서 아래에 해당하는 sql을 작성하세요 */
-- 가장 비싼 도서의 이름을 보이시오 -- 서브쿼리 문제
-- SELECT b.bookname
-- FROM book b
-- FULL OUTER JOIN orders o
-- ON b.bookid = o.bookid
-- WHERE o.saleprice = (SELECT MAX(saleprice) FROM orders;

-- 판매 가격이 가장 높은 도서의 도서명
SELECT b.bookname
FROM book b
WHERE b.bookid = 
(SELECT bookid
FROM orders o
WHERE o.saleprice = (SELECT MAX(saleprice) FROM orders));

-- SELECT bookname, MAX(price) -- bookname에 해당하는 도서의 제일 비싼 가격을 조회하게되어서 에러남
SELECT * FROM book WHERE price = (SELECT MAX(price) FROM book);
-- 판매 가격이 가장 비싼 책
SELECT * FROM book WHERE price = (SELECT MAX(price) FROM book);

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오
SELECT *
FROM customer c
WHERE c.custid IN (SELECT distinct o.custid FROM orders o );

SELECT DISTINCT c.*
FROM orders o
INNER JOIN customer c
ON c.custid = o.custid;

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오
desc book;
desc orders;
desc customer;

SELECT c.name
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid
INNER JOIN book b
ON b.bookid = o.bookid
WHERE b.publisher LIKE '대한미디어';

select *
from customer c
inner join orders o
on c.custid = o.custid 
where o.bookid in ( select bookid 
                    from book 
                    where publisher = '대한미디어' );

-- 주문이 있는 고객의 이름과 주소를 보이시오
SELECT DISTINCT c.name, c.address
FROM customer c
INNER JOIN orders o
ON c.custid = o.custid;















