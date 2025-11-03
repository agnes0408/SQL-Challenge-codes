/*Define a primary key for Books(BookID) and a foreign key in Orders(BookID) referencing Books.*/

use onlinebookstore;
Create database onlinebookstore;

-- create primary key for books(bookID) --
create table Book (
BookID INT PRIMARY KEY,
Title VARCHAR (100),
Author VARCHAR(100),
ISBN VARCHAR(30)
);

-- Create  foreign key in orders (bookId) --
create table orders (
orderID INT PRIMARY KEY,
orderdate date,
Customer_name varchar(100),
BookID INT,
foreign key (BookID) references Book(BookID)
);

-- add  a unique constrint to the ISBN column in book --
alter table Book
add constraint unique_ISBN unique (ISBN);

INSERT INTO Book (BookID, Title, Author, ISBN)
VALUES (1, 'Everything I Never Told You', 'Celeste Ng', '02');

INSERT INTO Orders (OrderID, OrderDate, Customer_Name, BookID)
VALUES (456, '2025-10-19', 'John Doe', 1);

-- deletebremove selected rows --
Delete from orders
where orderID = 456;

-- Truncate remove all rows but keeps the table structure --
Truncate table orders;
