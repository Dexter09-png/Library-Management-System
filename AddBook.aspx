<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="Library_management_system.AddBook" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Book</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 450px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #2575fc;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }
        .btn {
            background-color: #2575fc;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-weight: bold;
            margin-top: 10px;
        }
        .btn:hover { background-color: #6a11cb; }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #495057;
        }
        .btn-danger {
            background-color: #ff6b6b;
        }
        .btn-danger:hover {
            background-color: #ff4757;
        }
        .message {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
            color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>➕ Add New Book</h2>

            <div class="form-group">
                <label for="txtTitle">Title</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAuthor">Author</label>
                <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtISBN">ISBN</label>
                <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtGenre">Genre</label>
                <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtTotalCopies">Total Copies</label>
                <asp:TextBox ID="txtTotalCopies" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAvailableCopies">Available Copies</label>
                <asp:TextBox ID="txtAvailableCopies" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtDuration">Borrow Duration (Days)</label>
                <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>

            <asp:Button ID="btnAdd" runat="server" Text="Add Book" CssClass="btn" OnClick="btnAdd_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <!-- Back and Logout Buttons -->
            <asp:Button ID="btnBack" runat="server" Text="⬅ Back to Dashboard" CssClass="btn btn-secondary" OnClick="btnBack_Click" />
            <asp:Button ID="btnLogout" runat="server" Text="🚪 Logout" CssClass="btn btn-danger" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
