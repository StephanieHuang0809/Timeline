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

                    eventBLL.createEvent();
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            clearTextBoxes(this);
            checkboxclear();
        }

        public void clearTextBoxes(Control parent)
        {
            foreach (Control x in parent.Controls)
            {
                if ((x.GetType() == typeof(TextBox)))
                {
                    ((TextBox)(x)).Text = "";
                }
                if (x.HasControls())
                {
                    clearTextBoxes(x);
                }
            }
        }

        public void checkboxclear()
        {
            foreach (GridViewRow row in this.gv_friends.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkrow = (CheckBox)row.FindControl("cb_select");
                    if (chkrow.Checked)
                        chkrow.Checked = false;
                }
            }

            //CheckBox chkrow1 = (CheckBox)this.gv_friends.HeaderRow.FindControl("ChbGridHead");
           // if (chkrow1.Checked)
             //   chkrow1.Checked = false;
        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {

        }

        protected void btn_cancelSuggestion_Click(object sender, EventArgs e)
        {

        }

        protected void btn_okCreated_Click(object sender, EventArgs e)
        {
            clearTextBoxes(this);
            checkboxclear();
        }
    }
}