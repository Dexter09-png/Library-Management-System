using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Library_management_system
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;
                           AttachDbFilename=|DataDirectory|\LibraryDb.mdf;
                           Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                lblUser.Text = Session["Username"].ToString(); // Display username in welcome banner
                booksSection.Visible = true;
                borrowedSection.Visible = true;
                historySection.Visible = false;

                LoadBooks();
                LoadBorrowedBooks();
            }
        }

        private void LoadBooks()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "SELECT * FROM Books WHERE AvailableCopies > 0";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptBooks.DataSource = dt;
                rptBooks.DataBind();
            }
        }

        private void LoadBorrowedBooks()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"
                    SELECT b.BorrowID, bo.Title, bo.Author, b.BorrowDate, b.ReturnDate 
                    FROM Borrowings b
                    INNER JOIN Books bo ON b.BookID = bo.BookID
                    INNER JOIN Users u ON b.UserID = u.UserID
                    WHERE u.Username=@Username AND b.Returned=0";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptBorrowed.DataSource = dt;
                rptBorrowed.DataBind();
            }
        }

        protected void btnBorrow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int bookID = Convert.ToInt32(btn.CommandArgument);
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtDays = (TextBox)item.FindControl("txtDays");

            if (!int.TryParse(txtDays.Text, out int days) || days <= 0)
                return; // invalid input

            DateTime borrowDate = DateTime.Now;
            DateTime returnDate = borrowDate.AddDays(days);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string insertQuery = @"
                    INSERT INTO Borrowings (UserID, BookID, BorrowDate, ReturnDate, Returned)
                    VALUES ((SELECT UserID FROM Users WHERE Username=@Username), @BookID, @BorrowDate, @ReturnDate, 0)";
                SqlCommand cmd = new SqlCommand(insertQuery, con);
                cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@BookID", bookID);
                cmd.Parameters.AddWithValue("@BorrowDate", borrowDate);
                cmd.Parameters.AddWithValue("@ReturnDate", returnDate);
                cmd.ExecuteNonQuery();

                string updateQuery = "UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE BookID=@BookID";
                SqlCommand cmd2 = new SqlCommand(updateQuery, con);
                cmd2.Parameters.AddWithValue("@BookID", bookID);
                cmd2.ExecuteNonQuery();
            }

            LoadBooks();
            LoadBorrowedBooks();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int borrowID = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                // Mark borrowing as returned
                string updateBorrowing = "UPDATE Borrowings SET Returned=1 WHERE BorrowID=@BorrowID";
                SqlCommand cmd = new SqlCommand(updateBorrowing, con);
                cmd.Parameters.AddWithValue("@BorrowID", borrowID);
                cmd.ExecuteNonQuery();

                // Increment book availability
                string updateBook = @"
                    UPDATE Books 
                    SET AvailableCopies = AvailableCopies + 1 
                    WHERE BookID = (SELECT BookID FROM Borrowings WHERE BorrowID=@BorrowID)";
                SqlCommand cmd2 = new SqlCommand(updateBook, con);
                cmd2.Parameters.AddWithValue("@BorrowID", borrowID);
                cmd2.ExecuteNonQuery();
            }

            LoadBooks();
            LoadBorrowedBooks();
            LoadHistory(); // automatically refresh history
        }

        protected void btnHistory_Click(object sender, EventArgs e)
        {
            if (!historySection.Visible)
            {
                // Show history only
                historySection.Visible = true;
                booksSection.Visible = false;
                borrowedSection.Visible = false;
                LoadHistory();
            }
            else
            {
                // Show dashboard again
                historySection.Visible = false;
                booksSection.Visible = true;
                borrowedSection.Visible = true;
            }
        }

        private void LoadHistory()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"
                    SELECT bo.Title, bo.Author, b.BorrowDate, b.ReturnDate, b.Returned
                    FROM Borrowings b
                    INNER JOIN Books bo ON b.BookID = bo.BookID
                    INNER JOIN Users u ON b.UserID = u.UserID
                    WHERE u.Username=@Username
                    ORDER BY b.BorrowDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvHistory.DataSource = dt;
                gvHistory.DataBind();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
        protected void btnBackToDashboard_Click(object sender, EventArgs e)
        {
            historySection.Visible = false;
            booksSection.Visible = true;
            borrowedSection.Visible = true;
        }

        protected void rptBooks_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}
