USE bookstore;
SHOW tables;
DESC book;
DESC customer;
DESC orders;

-- 판매가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.  
-- 단, 두 권 이상 구매한 고객만 구한다
/* book의 price와 orders의 saleprice가 다르다! 
그래서 조인 조건절에서 book.price할 때와 orders.saleprice할때의 결과가 달라짐! */
SELECT 
	custid,
    COUNT(orderid)
FROM orders, book
WHERE orders.bookid = book.bookid AND orders.saleprice >= 8000
GROUP BY custid
HAVING COUNT(orderid) >= 2;

SELECT * 
FROM orders
ORDER BY bookid;
SELECT * 
FROM book
ORDER BY bookid;

-- join 안 쓰는 방법(사실 join 필요 없음ㅋㅋ)
SELECT custid, COUNT(orderid)
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(orderid) >= 2;

select * from orders where saleprice < 8000; -- bookid 1, 6, 10이 8천 미만
select * from book where bookid in(1, 6, 10); -- 실제로 10번은 13000 즉 pirce <> saleprice

-- 박지성의 총 구매액
SELECT customer.name, SUM(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid AND name = '박지성';

-- 방법 2 (JOIN 없이)
SELECT custid
FROM customer
WHERE name = '박지성';
-- 박지성의 custid = 1
SELECT custid, '박지성' 고객, SUM(saleprice) -- '박지성' 고객 해서 임의의 데이터를 넣어 표시할때 꽂히게끔 함
FROM orders
WHERE custid = 1;

-- 박지성이 구매한 도서의 수
SELECT customer.name, count(saleprice)
FROM customer, orders
WHERE customer.custid = orders.custid AND name = '박지성';

-- 방법 2
SELECT custid
FROM customer
WHERE name = '박지성';
-- custid = 1
SELECT custid, '박지성' 고객, count(saleprice)
FROM orders
WHERE custid = 1;

-- 도서의 총 개수
SELECT COUNT(DISTINCT bookid) AS "도서의 총 개수"
FROM book;

-- 도서를 출고하는 출판사의 총 개수
SELECT COUNT(DISTINCT publisher) "출판사의 총 개수"
FROM book;


-- [번외]
SELECT * FROM book;
- -- 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname, price FROM book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT bookid, bookname, publisher, price FROM book;

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT DISTINCT publisher FROM book;

-- 가격이 20,000원 미만인 도서를 검색하시오.
SELECT * FROM book WHERE price < 20000;

-- 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT * FROM book WHERE price BETWEEN 10000 AND 20000;

-- 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT * FROM book WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

-- ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher FROM book WHERE bookname = '축구의 역사';

-- 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT bookname, publisher FROM book WHERE bookname LIKE '%축구%';

-- 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname FROM book WHERE bookname LIKE '_구%';

-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname, price FROM book WHERE bookname LIKE'%축구%' AND price >= 20000;

-- 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname, publisher FROM book WHERE publisher = '굿스포츠'
UNION
SELECT bookname, publisher FROM book WHERE publisher = '대한미디어';

-- 도서를 이름순으로 검색하시오. 
SELECT * FROM book ORDER BY bookname;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT * FROM book ORDER BY price, bookname;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT * FROM book ORDER BY price DESC, publisher ASC;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가
SELECT SUM(saleprice) "총 판매액", AVG(saleprice) "평균값", MIN(saleprice) "최저가", MAX(saleprice) "최고가" FROM orders;

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오
SELECT custid, COUNT(saleprice) "주문 수량", SUM(saleprice) "총 판매액" FROM orders GROUP BY custid;