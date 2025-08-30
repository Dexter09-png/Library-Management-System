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

## 🔐 Security Features
- **Password Hashing**:  
  Admin and User passwords are stored as **hashed values** in the database using `SHA256` for better protection.  
- **Role-based Authentication**:  
  Ensures that only Admins can access the Admin Dashboard, while Users are restricted to their own dashboard.  
- **Session Management**:  
  Prevents unauthorized access by clearing sessions on logout.  
- **SQL Parameterization**:  
  All queries use parameterized commands to prevent **SQL Injection** attacks.
  
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

The system starts with **16 books**(more can be added by admin), including:  
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
1. Open solution (.sln) file in Visual Studio.

2. Ensure LibraryDb.mdf is attached in App_Data folder.

3. Update connection string in Web.config or code-behind if needed.

4. Run project (Ctrl + F5).

5. Login as:

 - Admin: admin / admin123

- User: user1 / user123

---

## 🎥 Screen Recording

<video src="media/Screen Recording 2025-08-31 025936.mp4" controls width="600">
  Your browser does not support the video tag.
</video>

---

## 🎨 UI Highlights

1. Gradient headers with modern styling.
2. Book cards with hover effects.
3. Responsive design using Flexbox.
4. Separate User Dashboard and Admin Dashboard.
5. History view with toggle option.

---

## 👥 Contributors

- [Dexter09-png](https://github.com/Dexter09-png) – Project Lead, Development & UI  
- [taqi02](https://github.com/taqi02) – Project Partner, Backend & Database

- Developed as a BSc IT Mini Project.
- Focus: ASP.NET, SQL Server, Web Development, User Experience.
