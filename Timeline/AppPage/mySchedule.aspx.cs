using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode;
using Timeline.AppCode.Domain;

namespace Timeline
{
    public partial class mySchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.saveChanges.Visible = false;
        }

        protected void btn_edit_Click(object sender, ImageClickEventArgs e)
        {
            this.saveChanges.Visible = true;
        }

        protected void btn_view_Click(object sender, ImageClickEventArgs e)
        {
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
        public static string GetCurrentTime(String start, String end)
        {

            //    var tableData = {
            //   year: 2016,
            //  month: 6,
            //  tableRowCell: ["9:00", "9:30", "10:00", "11:00", "12:00", "13:00", "14:00", "14:30", "15:00", "16:00", "17:00"],  /* show the verticle scale */
            //      days: [],                                                            /* show the horizal  scale */
            //  timeCell: { 12: ["9:00", "10:00"], 13: ["12:00"], 14: [], 15: [], 16: [], 17: [], 18: [], 19: [], 20: ["12:00"], 21: ["14:00"]}
            //  }

            var timeTable = new TimeTable();
           // timeTable.start = Util.StringToDate("20/05/2015");
           // timeTable.to = Util.StringToDate("20/05/2015");

            String jsonString = JSONHelper.ToJSON(timeTable);

            return jsonString;
        }

       

       
    }
}