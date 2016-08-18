using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode;
using Timeline.AppCode.BLL;
using Timeline.AppCode.Domain;

namespace Timeline.AppPage
{
    public partial class groupEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                this.hd_eventId.Value=Request.QueryString["id"];

                EventBLL eventBll = new EventBLL();
                Timeline.AppCode.Domain.Event myEvent = null;
                if (Request.QueryString["id"] != null)
                {
                    myEvent = eventBll.getEvent(int.Parse(Request.QueryString["id"]));

                }
                else
                {
                    myEvent = eventBll.getEvent(7);
                }
               
                this.tb_dateFrom.Text = String.Format("{0:MM/dd/yyyy}", myEvent.from);
                this.tb_dateTo.Text = String.Format("{0:MM/dd/yyyy}", myEvent.to);
                this.lb_eventName.Text = myEvent.name;
                this.lb_location.Text = myEvent.location;
                this.lb_from.Text = String.Format("{0:g}", myEvent.from);
                this.lb_to.Text = String.Format("{0:g}", myEvent.to); //String.Format("{0:MM/dd/yyyy}", myEvent.to)
                this.lb_status.Text = myEvent.status;
            }
        }

        protected void btn_view_Click(object sender, ImageClickEventArgs e)
        {
           
        }

        protected void btn_edit_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/AppPage/editEvent.aspx?id="+ Request.QueryString["id"]);
        }

        [System.Web.Services.WebMethod]
        public static string GetCurrentTime(int groupId, string startDate, string endDate)
        {
            ScheduleBLL scheduleBLL = new ScheduleBLL();
            scheduleBLL.readGroupSchedule(groupId, Util.StringToDate(startDate), Util.StringToDate(endDate));
            List<Schedule> dss = scheduleBLL.scheduleList;
            List<string> allcells = new List<string>();
            List<TimeCell> tmCells = new List<TimeCell>();

            foreach (Schedule s in dss)
            {
                List<String> cells = convertTimeLinetoTimeCell(s.freeSlotTimeFrom, s.freeSlotTimeTo);
                foreach (String c in cells)
                {
                    TimeCell tc = new TimeCell();
                    tc.cell = c;
                    tc.colorCode = s.colorCode;
                    tc.userId = s.userId;
                    tc.userName = s.user.firstName + " " + s.user.lastName;
                    addTimeCell(tmCells, tc);
                }

                //   allcells.AddRange(cells);
            }

            String json = tmCells.ToJSON();


            return json;
        }

        private static void addTimeCell(List<TimeCell> tcList, TimeCell tc)
        {

            if (tcList.Contains(tc))
            {

                //list.Find(x => x.GetId() == "xy");
                List<TimeCell> rel = tcList.FindAll(x => x.cell == tc.cell);
                foreach (TimeCell t in rel)
                {
                    t.lapNumber++;
                    t.lapNames.Add(tc.userName);
                }
            }

            tcList.Add(tc);


        }


        [System.Web.Services.WebMethod]
        public static string GetGroupTime(int groupId, string name, string startDate, string endDate)
        {
            ScheduleBLL scheduleBLL = new ScheduleBLL();
            // scheduleBLL.userId = (Int32)Session["userId"];
            //scheduleBLL.userId = 1;
            scheduleBLL.readSchedule(Util.StringToDate(startDate),Util.StringToDate(endDate));
            //scheduleBLL.readSchedule(null, null);
            List<Schedule> dss = scheduleBLL.scheduleList;
            List<string> allcells = new List<string>();
            foreach (Schedule s in dss)
            {
                List<String> cells = convertTimeLinetoTimeCell(s.freeSlotTimeFrom, s.freeSlotTimeTo);
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

        [System.Web.Services.WebMethod]
        public static string SendMsg(int groupId, string msg)
        {
            ChatBLL bll = new ChatBLL();
            bll.insert(groupId, 1, msg);

            return "{status:\"success\"}";
        }

        [System.Web.Services.WebMethod]
        public static string GetMsg(int groupId, string msg)
        {
            ChatBLL bll = new ChatBLL();
            DateTime laterThen = Util.StringToDateTimeHHmmSS(msg) ?? DateTime.MinValue;
            List<Chat> logs = bll.find(groupId, laterThen);

            return logs.ToJSON();
        }

    }
}