using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace Library_management_system
{
    public partial class Login : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;
                           AttachDbFilename=|DataDirectory|\LibraryDb.mdf;
                           Integrated Security=True";

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string passwordHash = ComputeSha256(txtPassword.Text);

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string query = "SELECT Role FROM Users WHERE Username=@Username AND PasswordHash=@PasswordHash";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string role = result.ToString();

                            Session["Username"] = username;
                            Session["Role"] = role;

                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "✅ Login successful! Redirecting...";

                            // Redirect based on role
                            if (role == "Admin")
                                Response.Redirect("AdminDashboard.aspx");
                            else
                                Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "❌ Invalid username or password. Not registered?";
                            btnGoRegister.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "❌ Error: " + ex.Message;
            }
        }

        protected void btnGoRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            lblMessage.ForeColor = System.Drawing.Color.Blue;
            lblMessage.Text = "🔹 Enter your admin credentials above and click Login.";
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
}
