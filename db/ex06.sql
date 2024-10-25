/* 자동증가 컬럼 */

USE bookstore;

create table inc_test
(
	idx integer primary key auto_increment,
    c1 varchar(100)
);

insert into inc_test (c1) values('test 1');
insert into inc_test (c1) values('test 2');
insert into inc_test (c1) values('test 3');
insert into inc_test (c1) values('test 4');

select * from inc_test;