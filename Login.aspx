<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Library_management_system.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library System - User/Admin Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6a11cb, #2575fc);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #ffffffdd;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            text-align: center;
            width: 360px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 10px;
            margin: 8px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .btn {
            background-color: #2575fc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #6a11cb;
        }
        #lblMessage {
            margin-top: 10px;
            font-weight: bold;
        }
        .register-btn {
            background-color: #ff6b6b;
            margin-top: 15px;
        }
        .register-btn:hover {
            background-color: #ff4757;
        }
        .admin-btn {
            background-color: #1dd1a1;
            margin-top: 15px;
        }
        .admin-btn:hover {
            background-color: #10ac84;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>📚 Library Login</h2>
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Button ID="btnAdminLogin" runat="server" Text="Admin Login" CssClass="btn admin-btn" 
                        OnClick="btnAdminLogin_Click" />

            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <asp:Button ID="btnGoRegister" runat="server" Text="Register Here" CssClass="btn register-btn" 
                        OnClick="btnGoRegister_Click" Visible="false" />
        </div>
    </form>
</body>
</html>
