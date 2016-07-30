using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode.BLL;
using Timeline.AppCode.Domain;

namespace Timeline.AppPage
{
    public partial class editEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                EventBLL eventBll = new EventBLL();
                Timeline.AppCode.Domain.Event myEvent = null;
                if (Request.QueryString["id"] != null|| Request.QueryString["id"] != "")
                {
                    myEvent = eventBll.getEvent(int.Parse(Request.QueryString["id"]));
                    
                }
                else
                {
                    myEvent = eventBll.getEvent(7);
                }
                hf_eventId.Value = myEvent.id.ToString();
                this.tb_name.Text = myEvent.name;
                this.tb_location.Text = myEvent.location;
                
                this.tb_dateFrom.Text = String.Format("{0:MM/dd/yyyy}",myEvent.from);
                this.tb_dateTo.Text = String.Format("{0:MM/dd/yyyy}", myEvent.to);

                this.tb_timeFrom.Text = String.Format("{0:HH:mm:ss}", myEvent.from);
                this.tb_timeTo.Text = String.Format("{0:HH:mm:ss}", myEvent.to);


                foreach (GridViewRow row in this.gv_friends.Rows)
                {
                    HiddenField hd = row.Cells[3].FindControl("hf_friendId") as HiddenField;
                    User userTmp = new User();
                    userTmp.userId = int.Parse(hd.Value);

                    if (myEvent.participants.Contains(userTmp))
                    {
                        CheckBox check = row.Cells[2].FindControl("cb_select") as CheckBox;
                        check.Checked = true;

                    }

                }

            }

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            EventBLL eventBLL = new EventBLL();
            //eventBLL.ownerUserId = (Int32)Session["userId"];
            eventBLL.ownerUserId = 1;
            eventBLL.id = int.Parse(this.hf_eventId.Value);
            eventBLL.name = this.tb_name.Text;
            eventBLL.location = this.tb_location.Text;
            string dftime = this.tb_dateFrom.Text + " " + this.tb_timeFrom.Text;
            eventBLL.from = Util.StringToDateTimeHHmmSS(dftime)??DateTime.Now;
            string dttime = this.tb_dateTo.Text + " " + this.tb_timeTo.Text;
            eventBLL.to = Util.StringToDateTimeHHmmSS(dttime) ?? DateTime.Now;
            eventBLL.status = this.ddl_status.SelectedValue.ToString();

            foreach (GridViewRow row in this.gv_friends.Rows)
            {
                
                if (row.Cells[2].FindControl("cb_select") == null)
                {
                    continue;
                }
                CheckBox check = row.Cells[2].FindControl("cb_select") as CheckBox;

                if (check.Checked)
                {
                    HiddenField hd = row.Cells[3].FindControl("hf_friendId") as HiddenField;
                    string friendId = hd.Value;
                    eventBLL.participantIdList.Add(Convert.ToInt32(friendId));
                }
            }

            eventBLL.updateEvent();
            Response.Redirect("~/AppPage/groupEvent.aspx?id=" + Request.QueryString["id"]);
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AppPage/groupEvent.aspx?id=" + Request.QueryString["id"]);
        }

    }
}