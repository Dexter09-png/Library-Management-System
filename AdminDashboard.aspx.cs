using System;
using System.Data;
using System.Data.SqlClient;

namespace Library_management_system
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;
                           AttachDbFilename=|DataDirectory|\LibraryDb.mdf;
                           Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadBooks();
                LoadStats();
            }
        }

        private void LoadBooks()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "SELECT * FROM Books";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvBooks.DataSource = dt;
                gvBooks.DataBind();
            }
        }

        private void LoadStats()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Total Books
                SqlCommand cmdBooks = new SqlCommand("SELECT COUNT(*) FROM Books", con);
                lblTotalBooks.Text = cmdBooks.ExecuteScalar().ToString();

                // Borrowed Books
                SqlCommand cmdBorrowed = new SqlCommand("SELECT COUNT(*) FROM Borrowings WHERE Returned=0", con);
                lblBorrowedBooks.Text = cmdBorrowed.ExecuteScalar().ToString();

                // Users
                SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role='User'", con);
                lblUsers.Text = cmdUsers.ExecuteScalar().ToString();
            }
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddBook.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}
