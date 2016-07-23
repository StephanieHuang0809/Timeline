using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode.BLL;

namespace Timeline.AppPage
{
    public partial class eventList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_create_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            EventBLL eventBLL = new EventBLL();
            //eventBLL.ownerUserId = (Int32)Session["userId"];
            eventBLL.ownerUserId = 1;
            eventBLL.name = this.tb_name.Text;
            eventBLL.location = this.tb_location.Text;
            eventBLL.from = Convert.ToDateTime(this.tb_dateFrom.Text);
            eventBLL.to = Convert.ToDateTime(this.tb_dateTo.Text);
            eventBLL.status = this.ddl_status.SelectedValue.ToString();

            foreach (GridViewRow row in this.gv_friends.Rows)
            {
                CheckBox check = row.Cells[3].FindControl("cb_select") as CheckBox;
                if (check.Checked)
                {
                    string friendId = row.Cells[0].Text;
                    eventBLL.participantIdList.Add(Convert.ToInt32(friendId));
                }
            }

           // eventBLL.createEvent();
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {

        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {

        }

        protected void btn_cancelSuggestion_Click(object sender, EventArgs e)
        {

        }

    }
}