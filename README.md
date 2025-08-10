
# 📚 Library Management System (SQL Project)

## 📌 Project Overview
This is a beginner-friendly **SQL database project** that simulates a simple **Library Management System**.  
It was built using **Oracle SQL** in an online compiler (Oracle LiveSQL), and covers the basics of creating tables, inserting data, and writing SQL queries.

The project stores information about:
- Books available in the library
- Members registered in the library
- Loans (which member borrowed which book)

## 🎯 Features
- Create and manage **Books**, **Members**, and **Loans** tables
- Add new records using `INSERT` statements
- Fetch data using `SELECT` queries with `JOIN`
- Check for **overdue books**
- Update stock when a book is borrowed
- Mark books as returned

## 🗄️ Database Structure
### 1. **Books Table**
Stores details about each book.
| Column Name | Data Type     | Description |
|-------------|--------------|-------------|
| book_id     | NUMBER (PK)  | Unique ID for each book |
| title       | VARCHAR2(100)| Book title |
| author      | VARCHAR2(100)| Author name |
| genre       | VARCHAR2(50) | Book genre |
| price       | NUMBER(8,2)  | Price of the book |
| stock_qty   | NUMBER       | Quantity available |

### 2. **Members Table**
Stores details about library members.
| Column Name | Data Type     | Description |
|-------------|--------------|-------------|
| member_id   | NUMBER (PK)  | Unique ID for each member |
| name        | VARCHAR2(100)| Member's name |
| phone       | VARCHAR2(15) | Contact number |
| join_date   | DATE         | Date the member joined |

### 3. **Loans Table**
Keeps track of borrowed books.
| Column Name | Data Type     | Description |
|-------------|--------------|-------------|
| loan_id     | NUMBER (PK)  | Unique loan ID |
| member_id   | NUMBER (FK)  | References `members.member_id` |
| book_id     | NUMBER (FK)  | References `books.book_id` |
| loan_date   | DATE         | Date the book was borrowed |
| return_date | DATE         | Date the book was returned |

## 💻 Example Queries
- Show all books available in the library
- List books borrowed by a specific member
- Find overdue books
- Update stock when a book is borrowed
- Mark a book as returned
