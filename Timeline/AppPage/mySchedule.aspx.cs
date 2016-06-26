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

        }

        protected void btn_submit_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = "Refreshed at " + DateTime.Now.ToString();
            this.HiddenFieldYear.Value = "2016";
            this.HiddenFieldMonth.Value = "6";
            this.HiddenFieldTableRowCell.Value = " [\"9:00\", \"9:30\", \"10:00\"]";
            this.HiddenFieldDays.Value = "[12, 13, 14, 15, 16, 17, 18, 19, 20, 21]";
            this.HiddenFieldTimeCell.Value = "{ 12: [\"9:00\", \"10:00\"], 13: [\"12:00\"], 14: [], 15: [], 16: [], 17: [], 18: [], 19: [], 20: [\"12:00\"], 21: [\"14:00\"]}";
  
        }

        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(string name)
        {
            //    var tableData = {
            //   year: 2016,
            //  month: 6,
            //  tableRowCell: ["9:00", "9:30", "10:00", "11:00", "12:00", "13:00", "14:00", "14:30", "15:00", "16:00", "17:00"],  /* show the verticle scale */
            //      days: [],                                                            /* show the horizal  scale */
            //  timeCell: { 12: ["9:00", "10:00"], 13: ["12:00"], 14: [], 15: [], 16: [], 17: [], 18: [], 19: [], 20: ["12:00"], 21: ["14:00"]}
            //  }

            var tableData = new Dictionary<String, Object>();
            tableData.Add("year",2016);
            tableData.Add("month",6);
            var tableRowCellList = new List<String>();
            tableRowCellList.Add("9:00");
            tableRowCellList.Add("9:30");
            tableRowCellList.Add("10:00");
            tableRowCellList.Add("10:30");
            tableRowCellList.Add("11:00");
            tableRowCellList.Add("11:30");
            tableRowCellList.Add("12:00");
            tableRowCellList.Add("12:30");
            tableRowCellList.Add("13:00");
            tableData.Add("tableRowCell", tableRowCellList);
           
            tableData.Add("days",new int[] { 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 });

            var timeCellDic = new Dictionary<int,String[]>();
            timeCellDic.Add(12,new String[]{ "9:00", "10:00"});
            timeCellDic.Add(13, new String[] { "9:00" });
            tableData.Add("timeCell", timeCellDic);

            var timeTable = new TimeTable
            {
                year = 2016,
                month = 6
            };
            String jsonString = JSONHelper.ToJSON(timeTable);

            return jsonString +"The Current Time is: " + DateTime.Now.ToString();
        }


    }
}