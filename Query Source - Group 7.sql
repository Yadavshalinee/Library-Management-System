create database E_bookstore

use E_bookstore

create table publisher_details(publisher_id int primary key, publisher_name varchar(20) not null, publisher_address varchar(30) not null,
 publisher_phone int unique not null, publisher_country varchar(30) not null)

 insert into publisher_details values(1,'Nepal','Kathmandu','1293819','Nepal')
 insert into publisher_details values(2,'Nepal','Kathmandu','12913819','Nepal')

create table book_details(book_id int primary key, publisher_id int, book_category varchar(10),book_name varchar(50), book_rate money,
 book_author varchar(30), ISBN int, foreign key(publisher_id) references publisher_details(publisher_id))
 select * from book_details
alter table book_details drop column rating
alter table book_details drop constraint CK__book_deta__ratin__34C8D9D1
sp_help book_details
from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='book_details'
 insert into book_details values(1,1,'Comedy','Grouwnups',200,'Nepali','1')
 insert into book_details values(2,1,'Comedy','Grouwnups1',200,'Nepali','2')
 insert into book_details values(3,1,'Horror','Grouwnups2',200,'Nepali','3')
 insert into book_details values(4,1,'Horror','Grouwnups3',200,'Nepali','4')

create table order_book(book_id int, publisher_id int, quantity int, invoice_no int, invoice_date date,
foreign key(publisher_id) references publisher_details(publisher_id), foreign key(book_id) references book_details(book_id))

insert into order_book values(1,1,2,101,'2/6/2017')
insert into order_book values(1,1,2,101,'2/7/2017')
insert into order_book values(1,2,2,103,'2/6/2017')
insert into order_book values(1,2,2,104,'2/7/2017')

create table member(member_id int primary key, member_name varchar(30), member_address varchar(30), member_telephone int, member_registerdate date)
insert into member values(1,'asdf','sdf',123123,'')


create table customer_order(invoice_no int primary key, book_id int, order_date date, quantity int,
 foreign key(book_id) references book_details(book_id))

 alter table customer_order add amount int

create table payment(tran_id int primary key, invoice_no int, tran_date date not null,
 total money not null, is_paid varchar(6) not null, payment_option varchar(4) not null,foreign key(invoice_no) references customer_order(invoice_no))

ALTER TABLE payment WITH CHECK 
ADD check ( 
    (is_paid = 'paid') 
    OR 
    (is_paid = 'unpaid') 
) 
ALTER TABLE payment WITH CHECK 
ADD check ( 
    (payment_option= 'visa') 
    OR 
    (payment_option= 'cash') 
)

create table delivery(book_id int, member_id int, export date not null,
 quantity int not null, delivery_status varchar(3), foreign key(book_id) references book_details(book_id),foreign key(member_id) references member(member_id))

alter table delivery add delivery_status varchar(3)

ALTER TABLE delivery WITH CHECK 
ADD check ( 
    (delivery_status= 'yes') 
    OR 
    (delivery_status= 'no') 
)

create table publisher_order(publisher_id int, book_id int,
 send_date date not null,foreign key(publisher_id) references publisher_details(publisher_id),foreign key(book_id) references book_details(book_id))

 insert into publisher_order values(1,1,'2/1/1212')
 insert into publisher_order values(1,1,'2/2/1212')
 insert into publisher_order values(1,1,'2/3/1212')
 insert into publisher_order values(1,1,'3/1/1212')
 insert into publisher_order values(1,1,'3/2/1212')
 insert into publisher_order values(1,1,'4/3/1212')
 insert into publisher_order values(1,1,'2/1/1212')
 insert into publisher_order values(1,1,'2/2/1212')
 insert into publisher_order values(1,1,'2/3/1212')

create table feedback(member_id int, book_id int, feedback varchar(200), rating varchar(2),foreign key(book_id) references book_details(book_id),
 foreign key(member_id) references member(member_id))

 insert into feedback values(1,1,'aslfjlsadf','1')


ALTER TABLE book_details WITH CHECK 
ADD check ( 
    (rating > 0) 
    OR 
    (rating >= 10) 
) 

/*question 1*/
select * from publisher_order order by send_date asc 

/*question 2*/
same as question 1

/*question 3*/
select invoice_no, publisher_id from order_book

select * from order_book

/*question 4*/
select * from member 

/*question 5*/
select * from delivery where delivery_status='yes'

/*question 6*/
select book_category,book_id, book_name from book_details order by  book_category

/*question 7*/
SELECT book_category, COUNT(*) as count FROM book_details GROUP BY book_category

/*question 8*/
select book_id, sum(amount) total from customer_order group by book_id

/*question 9*/

select book_id, avg(rating) score from feedback
order by score asc 