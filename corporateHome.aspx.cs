using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeline.AppPage
{
    public partial class corporateHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dv_events_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            Response.Redirect("corporateHome.aspx");
        }
    }
}