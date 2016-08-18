using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeline.AppPage
{
    public partial class registerSuccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AppPage/login.aspx");
        }
    }
}