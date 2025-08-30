using System;
using System.Data.SqlClient;

namespace Library_management_system
{
    public partial class AddBook : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;
                           AttachDbFilename=|DataDirectory|\LibraryDb.mdf;
                           Integrated Security=True";

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"INSERT INTO Books 
                                (Title, Author, ISBN, Genre, TotalCopies, AvailableCopies, BorrowDurationDays, CreatedAt)
                                VALUES (@Title, @Author, @ISBN, @Genre, @TotalCopies, @AvailableCopies, @Duration, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@Author", txtAuthor.Text.Trim());
                cmd.Parameters.AddWithValue("@ISBN", txtISBN.Text.Trim());
                cmd.Parameters.AddWithValue("@Genre", txtGenre.Text.Trim());
                cmd.Parameters.AddWithValue("@TotalCopies", Convert.ToInt32(txtTotalCopies.Text));
                cmd.Parameters.AddWithValue("@AvailableCopies", Convert.ToInt32(txtAvailableCopies.Text));
                cmd.Parameters.AddWithValue("@Duration", Convert.ToInt32(txtDuration.Text));
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "✅ Book added successfully!";
            txtTitle.Text = txtAuthor.Text = txtISBN.Text = txtGenre.Text = txtTotalCopies.Text = txtAvailableCopies.Text = txtDuration.Text = "";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashboard.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}
