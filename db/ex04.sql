/* 부속 질의 */

-- 작업 데이터베이스 변경
USE bookstore;

SELECT custid FROM customer WHERE name = '박지성';
SELECT '박지성' 고객, SUM(saleprice) 구매액  FROM orders WHERE custid = 1;

-- 박지성 고객의 총 구매액
SELECT '박지성' 고객, SUM(saleprice) 구매액 -- 메인쿼리
FROM orders
WHERE custid = (SElECT custid -- 서브쿼리
				FROM customer
				WHERE name = '박지성');

-- 구매 이력이있는 고객 정보 조회
SELECT * FROM customer; -- 모든 고객 정보
SELECT DISTINCT custid FROM orders;

SELECT * 
FROM customer 
-- WHERE custid in (1, 2, 3, 4);
WHERE custid IN (SELECT DISTINCT custid
				 FROM orders);
                 
SELECT * FROM book
UNION ALL
SELECT * FROM imported_book;

SELECT COUNT(bookid) FROM book
UNION ALL
SELECT COUNT(bookid) FROM imported_book;

-- SELECT SUM(COUNT(book.bookid), COUNT(imported_book)) FROM book, imported_book; -- 에러남
SELECT * FROM(SELECT * FROM book UNION ALL SELECT * FROM imported_book)a ;

-- book과 imported_book 테이블에 있는 도서 갯수 조회 1
SELECT COUNT(*) "전체 도서 권수"
FROM
(
SELECT * FROM book
UNION ALL
SELECT * FROM imported_book
)a ; -- 전체 도서 권수

-- book과 imported_book 테이블에 있는 도서 갯수 조회 2
SELECT 
	(SELECT count(*) FROM book) + (SELECT count(*) FROM imported_book) 도서갯수; -- 스칼라 부속 질의
