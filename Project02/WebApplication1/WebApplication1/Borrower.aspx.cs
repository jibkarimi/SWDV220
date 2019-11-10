using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Borrower : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Label1.Text = "Added Information: <br> *First Name: " + TextBox1.Text +
                 "<br> *Last Name: " + TextBox2.Text +
                  "<br> *Phone Number: " + TextBox3.Text;
                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";
            }
        }
    }
}