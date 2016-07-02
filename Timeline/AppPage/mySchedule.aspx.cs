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
    public partial class mySchedule : System.Web.UI.Page
    {
        
        public String timeCellStr;



        protected void Page_Load(object sender, EventArgs e)
        {
            this.saveChanges.Visible = false;
            if (!IsPostBack)
            {
                this.tb_dateFrom.Text = String.Format("{0:MM/dd/yyyy}", DateTime.Now);
                this.tb_dateTo.Text = String.Format("{0:MM/dd/yyyy}", DateTime.Now); ;

             /*   ScheduleBLL scheduleBLL = new ScheduleBLL();
                scheduleBLL.userId = (Int32)Session["userId"];
                scheduleBLL.readSchedule();
                List<Schedule> dss = scheduleBLL.scheduleList;
                foreach(Schedule ss in dss)
                {
                    Console.WriteLine(ss.freeSlotTimeFrom);
                    Console.WriteLine(ss.freeSlotTimeTo);
                }


                */

            }


        }

        protected void btn_edit_Click(object sender, ImageClickEventArgs e)
        {
            this.saveChanges.Visible = true;
        }

        protected void btn_view_Click(object sender, ImageClickEventArgs e)
        {
            ScheduleBLL scheduleBLL = new ScheduleBLL();
            // scheduleBLL.userId = (Int32)Session["userId"];
             scheduleBLL.userId = 1;
             scheduleBLL.readSchedule();
            List<Schedule> dss = scheduleBLL.scheduleList;
            
            foreach (Schedule ss in dss)
            {
                Console.WriteLine(ss.freeSlotTimeFrom);
                Console.WriteLine(ss.freeSlotTimeTo);
            }

            this.timeCellStr = "\"06/13/2016\": [\"09:00\", \"10:00\"]";
            this.saveChanges.Visible = false;
        }

        protected void btn_submit_Click(object sender, ImageClickEventArgs e)
        {
            this.saveChanges.Visible = false;
        }

        protected void btn_cancel_Click(object sender, ImageClickEventArgs e)
        {
            this.saveChanges.Visible = false;
        }

        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(string name)
        {
            return "Hello " + name + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
        }


    }
}