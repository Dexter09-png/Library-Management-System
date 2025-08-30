<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Library_management_system.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #2575fc, #6a11cb);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h2 { margin: 0; }

        .welcome-banner {
            background: #fff;
            margin: 20px;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            font-size: 22px;
            font-weight: bold;
            color: #333;
            text-align: center;
        }

        .btn-header {
            background-color: #ff6b6b;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
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

        .section { padding: 20px 30px; }
        h3 { color: #333; }

        .books-container, .borrowed-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .book-card {
            background-color: white;
            width: 180px;
            height: 220px;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }

        .book-card h4 { margin: 0 0 5px 0; }
        .btn-action {
            background-color: #2575fc;
            border: none;
            padding: 6px 12px;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-action:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
            background-color: #6a11cb;
        }

        .txt-days { width: 50px; padding: 3px; margin-top: 5px; }

        .history-table {
            width: 100%;
            border-collapse: collapse;
        }
        .history-table th, .history-table td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        .history-table th { background-color: #2575fc; color: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <h2>📚 Library Dashboard</h2>
            <div>
                <asp:Button ID="btnHistory" runat="server" Text="History" CssClass="btn-header" OnClick="btnHistory_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-header" OnClick="btnLogout_Click" />
            </div>
        </header>

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            👋 Welcome back, <asp:Label ID="lblUser" runat="server" Text=""></asp:Label>! Enjoy your reading journey 📖
        </div>

       <!-- Available Books -->
<div class="section" id="booksSection" runat="server">
    <h3>Available Books</h3>
    <div class="books-container">
        <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
            <ItemTemplate>
                <div class="book-card">
                    <h4><%# Eval("Title") %></h4>
                    <p>Author: <%# Eval("Author") %></p>
                    <p>Available: <%# Eval("AvailableCopies") %></p>
                    <asp:TextBox ID="txtDays" runat="server" CssClass="txt-days" Placeholder="Days"></asp:TextBox>
                    <asp:Button ID="btnBorrow" runat="server" Text="Borrow" CssClass="btn-action"
                                CommandArgument='<%# Eval("BookID") %>' OnClick="btnBorrow_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

<!-- Borrowed Books -->
<div class="section" id="borrowedSection" runat="server">
    <h3>My Borrowed Books</h3>
    <div class="borrowed-container">
        <asp:Repeater ID="rptBorrowed" runat="server">
            <ItemTemplate>
                <div class="book-card borrowed-card">
                    <h4><%# Eval("Title") %></h4>
                    <p>Author: <%# Eval("Author") %></p>
                    <p>Borrowed On: <%# Eval("BorrowDate", "{0:yyyy-MM-dd}") %></p>
                    <p>Due Date: <%# Eval("ReturnDate", "{0:yyyy-MM-dd}") %></p>
                    <asp:Button ID="btnReturn" runat="server" Text="Return" CssClass="btn-action"
                                CommandArgument='<%# Eval("BorrowID") %>' OnClick="btnReturn_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>


        <!-- History Section -->
<div class="section" id="historySection" runat="server" visible="false">
    <h3>Borrowing History</h3>
    <asp:GridView ID="gvHistory" runat="server" AutoGenerateColumns="False" CssClass="history-table">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" />
            <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed On" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="ReturnDate" HeaderText="Returned On" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:TemplateField HeaderText="Returned">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("Returned")) ? "Yes" : "No" %>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Back Button -->
    <asp:Button ID="btnBackToDashboard" runat="server" Text="⬅ Back to Dashboard" CssClass="btn-header" OnClick="btnBackToDashboard_Click" />
</div>

    </form>
</body>
</html>
