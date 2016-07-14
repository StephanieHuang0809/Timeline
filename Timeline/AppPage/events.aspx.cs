using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode;
using Timeline.AppCode.BLL;
using Timeline.AppCode.Domain;

namespace Timeline
{
    public partial class events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }

        }

        protected void btn_create_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            //EventBLL registerBLL = new EventBLL();
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            foreach (var item in Page.Controls)
            {
                if (item is TextBox)
                {
                    ((TextBox)item).Text = "";
                }
            }
        }
    }
}