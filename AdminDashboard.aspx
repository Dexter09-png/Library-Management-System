<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Library_management_system.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Library System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        /* Header */
        header {
            background: linear-gradient(90deg, #2575fc, #6a11cb);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h2 {
            margin: 0;
            font-size: 26px;
        }
        .btn-header {
            background-color: #ff6b6b;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-left: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-header:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            background-color: #ff4757;
        }

        /* Dashboard Stats */
        .stats-container {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin: 20px;
        }
        .stat-card {
            flex: 1;
            min-width: 200px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 18px rgba(0,0,0,0.2);
        }
        .stat-card h3 {
            margin: 10px 0;
            font-size: 22px;
            color: #333;
        }
        .stat-card p {
            font-size: 18px;
            font-weight: bold;
            color: #2575fc;
        }

        /* Section */
        .section {
            padding: 20px 40px;
        }
        h3 {
            color: #333;
            margin-bottom: 15px;
        }

        /* Buttons */
        .btn {
            background-color: #2575fc;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            margin-bottom: 20px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            background-color: #6a11cb;
        }

        /* Grid */
        .grid-container {
            overflow-x: auto;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .grid-container table {
            width: 100%;
            border-collapse: collapse;
        }
        .grid-container th, .grid-container td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .grid-container th {
            background: #2575fc;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Header -->
        <header>
            <h2>📚 Admin Dashboard</h2>
            <div>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-header" OnClick="btnLogout_Click" />
            </div>
        </header>

        <!-- Stats Section -->
        <div class="stats-container">
            <div class="stat-card">
                <h3>Total Books</h3>
                <p><asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-card">
                <h3>Borrowed Books</h3>
                <p><asp:Label ID="lblBorrowedBooks" runat="server" Text="0"></asp:Label></p>
            </div>
            <div class="stat-card">
                <h3>Active Users</h3>
                <p><asp:Label ID="lblUsers" runat="server" Text="0"></asp:Label></p>
            </div>
        </div>

        <!-- Books Section -->
        <div class="section">
            <h3>Manage Books</h3>
            <asp:Button ID="btnAddBook" runat="server" Text="➕ Add Book" CssClass="btn" OnClick="btnAddBook_Click" />
            <div class="grid-container">
                <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="True"></asp:GridView>
            </div>
        </div>

    </form>
</body>
</html>
