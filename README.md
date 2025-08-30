# 📚 Library Management System

A **Web-based Library Management System** built using **ASP.NET Web Forms (C#)** and **SQL Server (LocalDB)**.  
The system allows **users** (students/readers) to borrow and return books, while **admins** (librarians) can manage the book inventory efficiently.  

---

## ✨ Features

### 👩‍💻 User Module
- Secure **Login/Logout** with role-based access.
- **Available Books Dashboard**:
  - Books displayed in horizontal card layout.
  - Shows title, author, available copies.
  - Borrow option with custom duration.
- **Borrowed Books Section**:
  - Displays borrowed books with due dates.
  - Allows returning books.
- **History Section**:
  - Shows borrowing history in a table.
  - Tracks returned vs not returned.
  - Back to dashboard button.

### 🛠️ Admin Module
- **Admin Login** with role check.
- **Admin Dashboard**:
  - Displays all books in database in a GridView.
  - Add New Book button.
- **Add Book Page**:
  - Add Title, Author, ISBN, Genre, Copies, Borrow Duration.
  - Automatically sets created date.
  - Back to dashboard button.

---

## 🗄️ Database Design

### **Users Table**
| Column      | Type        | Description            |
|-------------|-------------|------------------------|
| UserID      | INT (PK)    | Unique user ID         |
| Username    | NVARCHAR    | Login username         |
| Password    | NVARCHAR    | Encrypted password     |
| Role        | NVARCHAR    | "User" or "Admin"      |

### **Books Table**
| Column             | Type        | Description                      |
|--------------------|-------------|----------------------------------|
| BookID             | INT (PK)    | Unique book ID                   |
| Title              | NVARCHAR    | Book title                       |
| Author             | NVARCHAR    | Book author                      |
| ISBN               | NVARCHAR    | ISBN number                      |
| Genre              | NVARCHAR    | Book category/genre              |
| TotalCopies        | INT         | Total copies owned               |
| AvailableCopies    | INT         | Currently available copies       |
| BorrowDurationDays | INT         | Default borrowing duration       |
| CreatedAt          | DATETIME    | Timestamp of entry               |

### **Borrowings Table**
| Column     | Type        | Description                       |
|------------|-------------|-----------------------------------|
| BorrowID   | INT (PK)    | Unique borrow record              |
| UserID     | INT (FK)    | Linked to Users table             |
| BookID     | INT (FK)    | Linked to Books table             |
| BorrowDate | DATETIME    | Date borrowed                     |
| ReturnDate | DATETIME    | Due date                          |
| Returned   | BIT         | 0 = Not Returned, 1 = Returned    |

---

## 📚 Sample Book Data

The system starts with **24 books**, including:  
- *The Alchemist* – Paulo Coelho  
- *Harry Potter and the Sorcerer’s Stone* – J.K. Rowling  
- *Clean Code* – Robert C. Martin  
- *To Kill a Mockingbird* – Harper Lee  
- *The Pragmatic Programmer* – Andrew Hunt & David Thomas  
- …and more (Fantasy, Classic, Programming, Self-Help, Psychology, etc.)

---

## 🚀 Getting Started

### Prerequisites
- **Visual Studio** (2019 or later)
- **.NET Framework 4.8**
- **SQL Server LocalDB**

### Steps to Run
1. Clone this repo:
   ```bash
   git clone https://github.com/your-username/Library-Management-System.git
