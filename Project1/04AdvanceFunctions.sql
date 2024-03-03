/*new books*/
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

/* Distinct */
SELECT DISTINCT(author_lname) FROM books;


/*What About DISTINCT Full Names??????*/
SELECT DISTINCT(CONCAT(author_fname,' ',author_lname))
FROM books;

/*---------------------------------------*/

/* Order By*/
SELECT author_lname FROM books ORDER BY author_lname DESC;

SELECT released_year FROM books
ORDER BY released_year DESC;

SELECT title,author_fname,author_lname
FROM books
ORDER BY 3;

/*---------------------------------------*/

SELECT title,author_fname,author_lname
FROM books
ORDER BY author_fname,author_lname
LIMIT 5;


/* LIMIT starting_point, how many records*/
/*get two records start from 1st row*/
/*index start from 0 for row 1... etc*/
SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 0,2;

/*limit starting point, till end of records*/
SELECT * FROM tbl LIMIT 95,18446744073709551615;

/*---------------------------------------*/

SELECT * FROM books
WHERE author_fname LIKE '%da%';


/*MySQL like search is case insensitive.
+--------------------+
| name               |
+--------------------+
| Test               |
| test               |
+--------------------+*/
SELECT name FROM users WHERE name LIKE 't%';



/*To make case sensitive search, use BINARY
+--------------------+
| name               |
+--------------------+
| test               |
+--------------------+*/
SELECT name FROM users WHERE name LIKE BINARY 't%';


/*underscore for each character*/
/*start with D with 2 charcters followed by*/
SELECT * FROM books
WHERE author_fname LIKE 'D__' 

# book_id, title, author_fname, author_lname, released_year, stock_quantity, pages
17, ten percent Happier, Dan, Harris, 2014, 29, 256
13, White Noise, Don, DeLillo, 1985, 49, 320


/*four digit stock quanity*/
SELECT *
FROM books
WHERE stock_quantity LIKE '____';


/*escaping special character*/
SELECT * FROM books
WHERE title LIKE '%\%%';

/*=====================EXERCISES ===============================*/

/*Titles  That contain 'stories'*/

SELECT * FROM books
WHERE title LIKE '%stories%';


/*Find The Longest Book
Print Out the Title and Page Count*/
SELECT title,pages
FROM books
ORDER BY pages DESC
LIMIT 1;


/*Print a summary containing the title and year, for the 3 most recent books
+-----------------------------+
| summary                     |
+-----------------------------+
| Lincoln In The Bardo - 2017 |
| Norse Mythology - 2016      |
| 10% Happier - 2014          |
+-----------------------------+
*/

SELECT CONCAT(title,' ',released_year) AS 'summary'
FROM books
ORDER BY released_year DESC
LIMIT 3;


/*Find all books with an author_lname that contains a space(" ")
+----------------------+----------------+
| title                | author_lname   |
+----------------------+----------------+
| Oblivion: Stories    | Foster Wallace |
| Consider the Lobster | Foster Wallace |
+----------------------+----------------+
*/

SELECT title,author_lname
FROM books
WHERE author_lname LIKE '% %';


/*Find The 3 Books With The Lowest Stock Select title, year, and stock
+-----------------------------------------------------+---------------+----------------+
| title                                               | released_year | stock_quantity |
+-----------------------------------------------------+---------------+----------------+
| American Gods                                       |          2001 |             12 |
| Where I'm Calling From: Selected Stories            |          1989 |             12 |
| What We Talk About When We Talk About Love: Stories |          1981 |             23 |
+-----------------------------------------------------+---------------+----------------+
*/
SELECT title,released_year,stock_quantity
FROM books
ORDER BY stock_quantity
LIMIT 3;


/*Print title and author_lname, sorted first by author_lname and then by title*/
SELECT title,author_lname
FROM books
ORDER BY 2,1;


/*Sorted Alphabetically By Last Name*/
SELECT CONCAT('MY FAVOURITE AUTHOR IS ',UPPER(author_fname),' ',UPPER(author_lname)) AS 'YELL'
FROM books
ORDER BY author_lname;
/*
+---------------------------------------------+
| yell                                        |
+---------------------------------------------+
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS MICHAEL CHABON!       |
| MY FAVORITE AUTHOR IS DON DELILLO!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS FREIDA HARRIS!        |
| MY FAVORITE AUTHOR IS DAN HARRIS!           |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS GEORGE SAUNDERS!      |
| MY FAVORITE AUTHOR IS PATTI SMITH!          |
| MY FAVORITE AUTHOR IS JOHN STEINBECK!       |
+---------------------------------------------+
*/

/*How many books are in the database???!*/
SELECT COUNT(*) FROM books;

/*How many author_fnames?*/
SELECT COUNT(DISTINCT(author_fname))
FROM books;

/*How many author_lfnames?*/
SELECT COUNT(DISTINCT(author_lname))
FROM books;

/*How many titles contain "the"?*/
SELECT COUNT(*) FROM books
WHERE title LIKE '%the%';

/*COUNT how many books each author has written*/
SELECT CONCAT(author_fname,' ',author_lname) AS 'author name',COUNT(*) AS 'number of books'
FROM books
GROUP BY 1
ORDER BY 2 DESC;


/*books count by released years*/
SELECT released_year, COUNT(*) AS 'number of books'
FROM books
GROUP BY released_year
ORDER BY released_year DESC;


/*Find the minimum released_year*/
SELECT MIN(released_year) FROM books;

/*Find the longest book (but took long as 2 quries have to run)*/
SELECT *
FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

/* Faster way */
SELECT * FROM books
ORDER BY pages DESC
LIMIT 1;


/*Find the year each author published their first book*/
SELECT author_fname,author_lname,MIN(released_year)
FROM books
GROUP BY 1,2;

/*Find the longest page count for each author*/
SELECT author_fname,author_lname,MAX(pages)
FROM books
GROUP BY 1,2;


/*Sum all pages in the entire database*/
SELECT SUM(pages) FROM books;

/*Sum all pages each author has written*/
SELECT author_fname,author_lname,SUM(pages)
FROM books
GROUP BY author_fname,author_lname;


/*Calculate the average released_year across all books*/
SELECT AVG(released_year) FROM books;


/*Calculate the average stock quantity for books released in the same year*/
SELECT released_year, AVG(stock_quantity)
FROM books
GROUP BY released_year;

/*-----------------------------------------------------------*/

/*-------------- Challenges --------------------------------*/
/*Print the number of books in the database*/
SELECT COUNT(*) AS 'number of books' FROM books;


/*Print out how many books were released in each year*/
SELECT released_year, COUNT(*) as 'number of books'
FROM books
GROUP BY released_year;


/*Print out the total number of books in stock*/
SELECT SUM(stock_quantity) AS 'total number books in stock'
FROM books;


/*Find the average released_year for each author*/
SELECT author_fname,author_lname,AVG(released_year)
FROM books
GROUP BY author_fname,author_lname;


/*Find the full name of the author who wrote the longest book*/
SELECT CONCAT(author_fname,' ',author_lname) AS 'Author Full Name', title, pages
FROM books
ORDER BY pages DESC
LIMIT 1;

/*
+------+---------+-----------+
| year | # books | avg pages |
+------+---------+-----------+
| 1945 |       1 |  181.0000 |
| 1981 |       1 |  176.0000 |
| 1985 |       1 |  320.0000 |
| 1989 |       1 |  526.0000 |
| 1996 |       1 |  198.0000 |
| 2000 |       1 |  634.0000 |
| 2001 |       3 |  443.3333 |
| 2003 |       2 |  249.5000 |
| 2004 |       1 |  329.0000 |
| 2005 |       1 |  343.0000 |
| 2010 |       1 |  304.0000 |
| 2012 |       1 |  352.0000 |
| 2013 |       1 |  504.0000 |
| 2014 |       1 |  256.0000 |
| 2016 |       1 |  304.0000 |
| 2017 |       1 |  367.0000 |
+------+---------+-----------+
*/
SELECT released_year AS 'year' ,COUNT(*) AS '# books', AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year;

/* data prep */
CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');

SELECT * FROM people;


/*-----------------------------------*/
/*
Date time functions

CURDATE()	- gives current date

CURTIME()	- gives current time

NOW()		- gives current datetime

Date time format


DAY()

DAYNAME()

DAYOFWEEK()

DAY OF YEAR()
*/


/*MM-dd-YY*/
select birthdate, DATE_FORMAT(birthdate,'%m-%d-%y at %h:%m') AS 'after formatted'
FROM people;
/*
# birthdate, after formatted
'2020-03-01', '03-01-20 at 12:03'
'1943-12-25', '12-25-43 at 12:12'
'1943-12-25', '12-25-43 at 12:12'

*/

SELECT birthdate, DATEDIFF(NOW(), birthdate) AS 'number of days between today and birthdate'
FROM people;

/*-----------------------------------*/

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Richard', CURDATE(), CURTIME(), NOW());

SELECT birthdate, DAYOFYEAR('2020-03-01')
FROM people;

/*-----------------------------------*/


/*Date Time Specifier*/
/*Sunday October 2009*/
SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y');

/*MM-dd-YY	=> '2020-03-01'	=> '03-01-20 at 12:03'*/
select birthdate, DATE_FORMAT(birthdate,'%m-%d-%y at %h:%m') AS 'after formatted'
FROM people;


/*-----------------------------------*/
/*
** DATE Math / Arithmetic **

DATEDIFF()
DATE_ADD()
+ or -
*/

/* result : 1 */
SELECT DATEDIFF('2007-12-31 23:59:59','2007-12-30');

/* '2020-03-01 19:28:23' =>  '2020-03-31 19:28:23'*/
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 30 DAY) AS 'after adding 30days'
FROM people;

/*'2020-03-01 19:28:23' => '2020-03-11 19:28:23'*/
SELECT birthdt, birthdt + INTERVAL 10 DAY AS 'after adding 10days'
FROM people;

/*'2020-03-01 19:28:23' => '2020-02-01 19:28:23'*/
SELECT birthdt, birthdt - INTERVAL 1 MONTH AS 'after subtracting 1 month'
FROM people;


/*-------------------------------------*/
/*--- Timestamp -----------*/

CREATE TABLE comments(
	comment VARCHAR(150) NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	change_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO comments(comment)
VALUES('I like cats'),
	('today is pretty hot'),
	('I can\'t stop watching movies :)');


UPDATE comments
SET comment = 'I like cats and dogs'
WHERE comment = 'I like cats';

/*-------------------------------------*/

/*-------------- Challenges -----------------------*/

/*What's a good use case for CHAR?
It can be used for text which we know in advance that it will have fixed length.
Example: gender (M/F) for CHAR(1)
*/

/*
Fill In The Blanks
CREATE TABLE inventory (
    item_name ____________,
    price ________________,
    quantity _____________
);
(price is always < 1,000,000)
*/
CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);

/*Print Out The Current Time*/
SELECT CURTIME();

/*Print Out The Current Date (but not time)*/
SELECT CURDATE();

/*Print Out The Current Day Of The Week (the number)*/
SELECT DAY(NOW());
SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;

/*Print Out The Current Day Of The Week (The Day Name)*/
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');

/*Print out the current day and time using this format:mm/dd/yyyy*/
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

/*Print out the current day and time using this format:
January 2nd at 3:15 O/ April 1st at 10:18
https://www.w3resource.com/mysql/date-and-time-functions/mysql-date_format-function.php
*/
SELECT DATE_FORMAT(NOW(),'%M %D at %H:%m');
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');

/*Create a tweets table that stores:
The Tweet content
A Username
Time it was created*/
CREATE TABLE tweets(
	tweet VARCHAR(140) NOT NULL,
	username VARCHAR(100) NOT NULL,
	created_at	TIMESTAMP DEFAULT NOW()
);

/*"Select all books NOT published in 2017"*/
SELECT * FROM books
WHERE released_year NOT IN(2017);

SELECT title FROM books WHERE released_year != 2017;


/*Select all birthdays between 1990 and 1992*/
SELECT name,birthdate
FROM people
WHERE YEAR(birthdate) NOT BETWEEN 1990 AND 1992;


/*Select books with titles that don't start with 'W'*/
SELECT * FROM books
WHERE title NOT LIKE 'W%';


/*Select books released after the year 2000*/
SELECT * FROM books
WHERE released_year > 2000;


/*result: 1*/
SELECT 99 > 1;


/*Select books released before the year 2000*/
SELECT * FROM books
WHERE released_year < 2000;


/*SELECT books written by Dave Eggers, published after the year 2010*/
SELECT * FROM books
WHERE author_fname = 'Dave'
AND author_lname = 'Eggers'
AND released_year > 2010;


/* AND equals && */
SELECT * FROM books
WHERE author_fname = 'Dave'
&& author_lname = 'Eggers'
&& released_year > 2010;


/* OR equals || */
SELECT * FROM books
WHERE author_lname='Eggers' ||
released_year > 2010;


/*Select all books written by...
Carver
Lahiri
Smith*/
SELECT * FROM books
WHERE author_lname IN ('Carver','Lahiri','Smith');

SELECT * FROM books
WHERE author_lname = 'Carver' OR author_lname = 'Lahiri' OR author_lname = 'Smith';


/*Select all books not published in
2000,
2002,
2004,
2006,
2008,
2010,
2012,
2014,
2016*/
SELECT * FROM books
WHERE released_year NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);


/*I only want books released after 2000 and year is even number*/
SELECT * FROM books
WHERE released_year > 2000
AND released_year % 2 = 0;


/*
+-----------------------------------------------------+---------------+------------------+
| title                                               | released_year | GENRE            |
+-----------------------------------------------------+---------------+------------------+
| The Namesake                                        |          2003 | Modern Lit       |
| Norse Mythology                                     |          2016 | Modern Lit       |
| American Gods                                       |          2001 | Modern Lit       |
| Interpreter of Maladies                             |          1996 | 20th Century Lit |
| A Hologram for the King: A Novel                    |          2012 | Modern Lit       |
+-----------------------------------------------------+--------------------------+-------+*/
SELECT title,released_year,
	CASE
		WHEN released_year >= 2000 THEN 'Modren Lit'
		ELSE '20th Century Lit'
	END AS 'GENRE'
FROM books;



/*
0 - 50 	 : 1 star
51 - 100 : 2 stars
> 100	 : 3 stars
+-----------------------------------------------------+----------------+-------+
| title                                               | stock_quantity | STOCK |
+-----------------------------------------------------+----------------+-------+
| The Namesake                                        |             32 | *     |
| Norse Mythology                                     |             43 | *     |
| American Gods                                       |             12 | *     |
| Interpreter of Maladies                             |             97 | **    |
| A Hologram for the King: A Novel                    |            154 | ***   |
| The Circle                                          |             26 | *     |
| The Amazing Adventures of Kavalier & Clay           |             68 | **    |
| Just Kids                                           |             55 | **    |
| A Heartbreaking Work of Staggering Genius           |            104 | ***   |
| Coraline                                            |            100 | **    |
| What We Talk About When We Talk About Love: Stories |             23 | *     |
| Where I'm Calling From: Selected Stories            |             12 | *     |
| White Noise                                         |             49 | *     |
| Cannery Row                                         |             95 | **    |
| Oblivion: Stories                                   |            172 | ***   |
| Consider the Lobster                                |             92 | **    |
| 10% Happier                                         |             29 | *     |
| fake_book                                           |            287 | ***   |
| Lincoln In The Bardo                                |           1000 | ***   |
+-----------------------------------------------------+----------------+-------+
*/

SELECT title, stock_quantity, 
	CASE
		WHEN stock_quantity > 100 THEN '***'
		WHEN stock_quantity >= 50 AND stock_quantity <= 100 THEN '**'
		ELSE '*'
	END AS STOCK
FROM books;

-- OR --

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;   

-- OR --
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;   


/*-------------------------------------------------*/

/*-------- Challenges ---------------------------*/

-- Result : 0 (False)
SELECT 10 != 10;

-- Result: 1 (True)
SELECT 15 > 14 && 99 - 5 <= 94;

-- Result: 1 (True)
SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10;


/*Select All Books Written Before 1980 (non inclusive)*/
SELECT * FROM books
WHERE released_year < 1980;


/*Select All Books Written By Eggers Or Chabon*/
SELECT * FROM books
WHERE author_lname IN ('Eggers', 'Chabon');


/*Select All Books Written By Lahiri, Published after 2000*/
SELECT * FROM books
WHERE author_lname = 'Lahiri' AND released_year > 2000;

/*Select All Books Written By Lahiri, Published after 2000*/
SELECT * FROM books
WHERE author_lname = 'Lahiri' && released_year > 2000;


/*Select All books with page counts between 100 and 200*/
SELECT * FROM books
WHERE pages BETWEEN 100 AND 200;


/*Select all books where author_lname  starts with a 'C' or an 'S''*/
SELECT * FROM books
WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

-- OR
/*Select all books where author_lname  starts with a 'C' or an 'S''*/
SELECT * FROM books
WHERE SUBSTR(author_lname,1,1) IN ('C','S');


/*If title contains 'stories'   -> Short Stories
Just Kids and A Heartbreaking Work  -> Memoir
Everything Else -> Novel

+-----------------------------------------------------+----------------+---------------+
| title                                               | author_lname   | TYPE          |
+-----------------------------------------------------+----------------+---------------+
| The Namesake                                        | Lahiri         | Novel         |
| Norse Mythology                                     | Gaiman         | Novel         |
| American Gods                                       | Gaiman         | Novel         |
| Interpreter of Maladies                             | Lahiri         | Novel         |
| A Hologram for the King: A Novel                    | Eggers         | Novel         |
| The Circle                                          | Eggers         | Novel         |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | Novel         |
| Just Kids                                           | Smith          | Memoir        |
| A Heartbreaking Work of Staggering Genius           | Eggers         | Memoir        |
| Coraline                                            | Gaiman         | Novel         |
| What We Talk About When We Talk About Love: Stories | Carver         | Short Stories |
| Where I'm Calling From: Selected Stories            | Carver         | Short Stories |
.....
+-----------------------------------------------------+----------------+---------------+
*/
SELECT title,author_lname,
	CASE
		WHEN title LIKE '%stories%' THEN 'Short Stories'
		WHEN title = 'Just Kids' OR title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
		ELSE 'Novel'
	END AS 'TYPE'
FROM books;


/*+-----------------------------------------------------+----------------+---------+
| title                                               | author_lname   | COUNT   |
+-----------------------------------------------------+----------------+---------+
| What We Talk About When We Talk About Love: Stories | Carver         | 2 books |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | 1 book  |
| White Noise                                         | DeLillo        | 1 book  |
| A Hologram for the King: A Novel                    | Eggers         | 3 books |
| Oblivion: Stories                                   | Foster Wallace | 2 books |
| Norse Mythology                                     | Gaiman         | 3 books |
| 10% Happier                                         | Harris         | 1 book  |
| fake_book                                           | Harris         | 1 book  |
| The Namesake                                        | Lahiri         | 2 books |
| Lincoln In The Bardo                                | Saunders       | 1 book  |
| Just Kids                                           | Smith          | 1 book  |
| Cannery Row                                         | Steinbeck      | 1 book  |
+-----------------------------------------------------+----------------+---------+
*/

SELECT author_fname, author_lname,CONCAT(CAST(COUNT(*) AS CHAR(4)), ' book(s)') AS 'total books'
FROM books 
GROUP BY author_lname, author_fname;

/* data prep*/
CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

/*customers by spending high to low order */
/*send them loyality programs,etc*/
SELECT first_name, last_name,SUM(amount) AS total_spending
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spending DESC;


/* customers who haven't spent anything or ordered anything yet */
/*we can send out discount cupons.. etc*/
SELECT first_name, last_name,amount
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
WHERE orders.customer_id IS NULL;

/*-------------------------------------------*/

/*------------------ Challenges -------------------------*/
CREATE TABLE students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150)
);


CREATE TABLE papers(
	title VARCHAR(150) NOT NULL,
	grade INT NOT NULL,
	student_id INT,
	FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);


/*----------------------*/
/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Carlos     | Borges and Magical Realism            |    89 |
| Caleb      | My Second Book Report                 |    75 |
| Caleb      | My First Book Report                  |    60 |
+------------+---------------------------------------+-------+
*/
SELECT first_name, title,grade
FROM students
JOIN papers ON students.id = papers.student_id
ORDER BY grade DESC;

/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  |    60 |
| Caleb      | My Second Book Report                 |    75 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Raj        | NULL                                  |  NULL |
| Carlos     | Borges and Magical Realism            |    89 |
| Lisa       | NULL                                  |  NULL |
+------------+---------------------------------------+-------+
*/
SELECT first_name, title, grade
FROM students
LEFT JOIN papers ON students.id = papers.student_id;


/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  | 60    |
| Caleb      | My Second Book Report                 | 75    |
| Samantha   | Russian Lit Through The Ages          | 94    |
| Samantha   | De Montaigne and The Art of The Essay | 98    |
| Raj        | MISSING                               | 0     |
| Carlos     | Borges and Magical Realism            | 89    |
| Lisa       | MISSING                               | 0     |
+------------+---------------------------------------+-------+
*/
SELECT first_name, 
	IFNULL(title,'MISSING'), 
	IFNULL(grade,0)
FROM students
LEFT JOIN papers ON students.id = papers.student_id;


/*
+------------+---------+
| first_name | average |
+------------+---------+
| Samantha   | 96.0000 |
| Carlos     | 89.0000 |
| Caleb      | 67.5000 |
| Raj        | 0       |
| Lisa       | 0       |
+------------+---------+
*/
SELECT first_name,
	IFNULL(AVG(grade),0) AS average
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;


/*
+------------+---------+----------------+
| first_name | average | passing_status |
+------------+---------+----------------+
| Samantha   | 96.0000 | PASSING        |
| Carlos     | 89.0000 | PASSING        |
| Caleb      | 67.5000 | FAILING        |
| Raj        | 0       | FAILING        |
| Lisa       | 0       | FAILING        |
+------------+---------+----------------+
*/
SELECT first_name,
	IFNULL(AVG(grade),0) AS average,
	CASE
		WHEN AVG(grade) >= 75 THEN 'PASSING'
		WHEN AVG(grade) IS NULL THEN 'FAILING'
		ELSE 'FAILING'
	END AS passing_status
FROM students
LEFT JOIN papers ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

