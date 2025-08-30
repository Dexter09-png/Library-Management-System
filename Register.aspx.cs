using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class Register : System.Web.UI.Page
{
    string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;
                       AttachDbFilename=|DataDirectory|\LibraryDb.mdf;
                       Integrated Security=True";

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (txtPassword.Text != txtConfirmPassword.Text)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "❌ Passwords do not match!";
            return;
        }

        string username = txtUsername.Text.Trim();
        string email = txtEmail.Text.Trim();
        string passwordHash = ComputeSha256(txtPassword.Text);

        try
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "INSERT INTO Users (Username, Email, PasswordHash, Role, CreatedAt) " +
                               "VALUES (@Username, @Email, @PasswordHash, 'User', GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        // ✅ Redirect to Login page after successful registration
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "❌ Registration failed.";
                    }
                }
            }
        }
        catch (SqlException ex)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            if (ex.Message.Contains("UNIQUE"))
                lblMessage.Text = "❌ Username or Email already exists.";
            else
                lblMessage.Text = "❌ Database error: " + ex.Message;
        }
    }

    private string ComputeSha256(string input)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
                builder.Append(b.ToString("x2"));
            return builder.ToString();
        }
    }
}
