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
            //this.saveChanges.Visible = false;
            if (!IsPostBack)
            {
                this.tb_dateFrom.Text = String.Format("{0:MM/dd/yyyy}", DateTime.Now);
                this.tb_dateTo.Text = String.Format("{0:MM/dd/yyyy}", DateTime.Now.AddDays(6)); ;

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

        protected void btn_view_Click(object sender, ImageClickEventArgs e)
        {
            ScheduleBLL scheduleBLL = new ScheduleBLL();
             scheduleBLL.userId = (Int32)Session["userId"];
             scheduleBLL.readSchedule(Util.StringToDate(this.tb_dateFrom.Text), Util.StringToDate(this.tb_dateTo.Text));
            List<Schedule> scheduleList = scheduleBLL.scheduleList;
            
            foreach (Schedule schedule in scheduleList)
            {
                Console.WriteLine(schedule.freeSlotTimeFrom);
                Console.WriteLine(schedule.freeSlotTimeTo);
            }

         //   this.saveChanges.Visible = false;
        }

        protected void btn_howToUse_Click(object sender, ImageClickEventArgs e)
        {

        }

        //This method is just for testing
        [System.Web.Services.WebMethod]
        public static string GetCurrentUserTimeCell(string name, string startDate, string endDate)
        {
            return "GetCurrentTime " + name + " " + startDate + " " + endDate + Environment.NewLine + "The Current Time is: "
                + DateTime.Now.ToString();
        }

        [System.Web.Services.WebMethod]
        public static string saveTimeCells(int userId, List<String> timecells, string startDate, string endDate)
        {
            ScheduleBLL bll = new ScheduleBLL();
            bll.userId = userId;
            bll.update(timecells,Util.StringToDate(startDate)??DateTime.MaxValue,Util.StringToDate(endDate)??DateTime.MinValue);

            return "Successfully saved";
        }

        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(int userId, string startDate, string endDate)
        {
            ScheduleBLL scheduleBLL = new ScheduleBLL();
            scheduleBLL.userId = userId;
            scheduleBLL.readSchedule(Util.StringToDate(startDate), Util.StringToDate(endDate));
            List<Schedule> scheduleList = scheduleBLL.scheduleList;
            List<string> allcells = new List<string>();//E.g 8:00 - 10:00 Then in allcells: 8:00, 8:30, 9:00, 9:30, 10:00
            foreach (Schedule schedule in scheduleList)
            {
                List<String> cells = convertTimeLinetoTimeCell(schedule.freeSlotTimeFrom, schedule.freeSlotTimeTo);
                allcells.AddRange(cells);
            }

            String json = allcells.ToJSON();

            return json;
        }

        private static List<String> convertTimeLinetoTimeCell(DateTime start, DateTime end)
        {
            List<String> result = new List<string>();

            DateTime dt = start;
            while (dt < end)
            {
                var dtStr = String.Format("{0:MM/dd/yyyy HH:mm}", dt);
                dt = dt.AddMinutes(30);
                result.Add(dtStr);
            }

            return result;
        }

    }
}