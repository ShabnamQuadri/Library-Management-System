/* ======================================================
   📚 Library Management System - Oracle SQL Script

/* ---------- Create Tables ---------- */

CREATE TABLE books (
    book_id     NUMBER PRIMARY KEY,
    title       VARCHAR2(100) NOT NULL,
    author      VARCHAR2(100) NOT NULL,
    genre       VARCHAR2(50),
    price       NUMBER(8,2),
    stock_qty   NUMBER
);

CREATE TABLE members (
    member_id   NUMBER PRIMARY KEY,
    name        VARCHAR2(100) NOT NULL,
    phone       VARCHAR2(15),
    join_date   DATE
);

CREATE TABLE loans (
    loan_id     NUMBER PRIMARY KEY,
    member_id   NUMBER REFERENCES members(member_id),
    book_id     NUMBER REFERENCES books(book_id),
    loan_date   DATE,
    return_date DATE
);

/* ----------  Clear old data (safe refresh) ---------- */
TRUNCATE TABLE books;
TRUNCATE TABLE members;
TRUNCATE TABLE loans;

/* ----------  Insert Sample Data ---------- */

-- 📚 Insert books
INSERT INTO books (book_id, title, author, genre, price, stock_qty) VALUES
    (1, 'The Alchemist',     'Paulo Coelho',       'Fiction',     350.00, 5),
    (2, 'Clean Code',        'Robert C. Martin',   'Programming', 550.00, 3),
    (3, 'Atomic Habits',     'James Clear',        'Self-Help',   400.00, 4),
    (4, '1984',              'George Orwell',      'Fiction',     300.00, 2);

-- 👤 Insert members
INSERT INTO members (member_id, name, phone, join_date) VALUES
    (1, 'Shabnam Quadri', '9876543210', TO_DATE('2024-05-15', 'YYYY-MM-DD')),
    (2, 'Bushra Quadri',  '9123456780', TO_DATE('2024-06-10', 'YYYY-MM-DD')),
    (3, 'Umar Quadri',    '9988776655', TO_DATE('2024-07-01', 'YYYY-MM-DD'));

-- 📄 Insert loans
INSERT INTO loans (loan_id, member_id, book_id, loan_date, return_date) VALUES
    (1, 1, 2, TO_DATE('2024-07-10', 'YYYY-MM-DD'), NULL),
    (2, 2, 1, TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2024-07-20', 'YYYY-MM-DD')),
    (3, 3, 3, TO_DATE('2024-07-12', 'YYYY-MM-DD'), NULL);

/* ----------  Example Queries ---------- */

-- 1. List all available books
SELECT title, author, genre, stock_qty
FROM books
WHERE stock_qty > 0;

-- 2. Find all books borrowed by Shabnam Quadri
SELECT b.title, b.author, l.loan_date
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE m.name = 'Shabnam Quadri';

-- 3. Check overdue books (borrowed more than 14 days ago and not returned)
SELECT m.name, b.title, l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL
  AND l.loan_date < SYSDATE - 14;

-- 4. Update stock when a book is borrowed (reduce by 1)
UPDATE books
SET stock_qty = stock_qty - 1
WHERE book_id = 2; -- borrowed book_id

-- 5. Return a book (set return date to today)
UPDATE loans
SET return_date = SYSDATE
WHERE loan_id = 1;

-- 6. Count how many books each member has borrowed
SELECT m.name, COUNT(*) AS books_borrowed
FROM loans l
JOIN members m ON l.member_id = m.member_id
GROUP BY m.name;

-- 7. Show books borrowed in the last 7 days
SELECT m.name, b.title, l.loan_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.loan_date >= SYSDATE - 7;
