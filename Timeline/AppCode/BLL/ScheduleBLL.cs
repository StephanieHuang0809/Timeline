using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using Timeline.AppCode.DAL;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.BLL
{
    public class ScheduleBLL
    {
        public int userId { set; get; }
        public int groupId { set; get; }
        public int scheduleId { set; get; }
        public String freeSlot { set; get; }
        public DateTime freeSlotTimeFrom { set; get; }
        public DateTime freeSlotTimeTo { set; get; }
        public List<Schedule> scheduleList { set; get; }

        public Dictionary<String, List<String>> timeCellMap { set; get; }


        public void readSchedule(DateTime? start, DateTime? end)
        {
            ScheduleDAL scheduleDAL = new ScheduleDAL();
            scheduleDAL.userId = this.userId;
            scheduleDAL.scheduleId = this.scheduleId;
            scheduleDAL.freeSlot = this.freeSlot;
            scheduleDAL.freeSlotTimeFrom = this.freeSlotTimeFrom;
            scheduleDAL.freeSlotTimeTo = this.freeSlotTimeTo;
            scheduleList = scheduleDAL.readSchedule(start, end);
        }

        public void readGroupSchedule(int groupId, DateTime? start, DateTime? end)
        {
            ScheduleDAL scheduleDAL = new ScheduleDAL();
            scheduleDAL.userId = this.userId;
            scheduleDAL.scheduleId = this.scheduleId;
            scheduleDAL.freeSlot = this.freeSlot;
            scheduleDAL.freeSlotTimeFrom = this.freeSlotTimeFrom;
            scheduleDAL.freeSlotTimeTo = this.freeSlotTimeTo;
            scheduleList = scheduleDAL.readSchedule(groupId, start, end);
        }

        public void readGroupSchedule(DateTime? start, DateTime? end)
        {
            ScheduleDAL scheduleDAL = new ScheduleDAL();
            scheduleDAL.userId = this.userId;
            scheduleDAL.scheduleId = this.scheduleId;
            scheduleDAL.freeSlot = this.freeSlot;
            scheduleDAL.freeSlotTimeFrom = this.freeSlotTimeFrom;
            scheduleDAL.freeSlotTimeTo = this.freeSlotTimeTo;
            scheduleList = scheduleDAL.readSchedule(this.groupId, start, end);
        }


        private void convertToMap(List<string> timecells)
        {
            this.timeCellMap = new Dictionary<string, List<string>>();

            foreach (String cell in timecells)
            {
                String[] dayTime = cell.Split(' ');
                if (timeCellMap.ContainsKey(dayTime[0]))
                {
                    timeCellMap[dayTime[0]].Add(cell);
                }
                else
                {
                    List<String> timeCellList = new List<string>();
                    timeCellList.Add(cell);
                    timeCellMap.Add(dayTime[0], timeCellList);
                }
            }

        }

        public void update(List<string> timecells, DateTime fromDate, DateTime toDate)
        {
            convertToMap(timecells);// Key:date Value: timecells
            ScheduleDAL dal = new ScheduleDAL();
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();

            // foreach (String dtStr in this.timeCellMap.Keys)
            DateTime dateRange = fromDate;

            while(dateRange <= toDate)
            {
                DateTime scheduleDate = dateRange;//Util.StringToDate(dtStr) ?? DateTime.MaxValue;
                dal.delete(conn, this.userId, scheduleDate);
                dateRange = dateRange.AddDays(1);
            }

            foreach (String dtStr in this.timeCellMap.Keys)
            {
                DateTime scheduleDate = Util.StringToDate(dtStr) ?? DateTime.MaxValue;
                var fromToList = mergeCells(timeCellMap[dtStr]);

                foreach (Dictionary<String, DateTime> fromTo in fromToList)
                {
                    if (fromTo != null)
                    {
                        dal.insert(conn, this.userId, scheduleDate, fromTo["From"], fromTo["To"].AddMinutes(30), "Y");
                    }
                }
            }

            conn.Close();

        }

        private List<Dictionary<String, DateTime>> mergeCells(List<string> dateStrList)
        {
            if (dateStrList == null || dateStrList.Count == 0) return null;
            List<DateTime> times = new List<DateTime>();
            foreach (string dtstr in dateStrList)
            {
                DateTime dti = Util.StringToDateTime(dtstr) ?? DateTime.MaxValue;
                times.Add(dti);
            }
            times.Sort();

            List<Dictionary<String, DateTime>> startFromMap = mergeTime(times);

            return startFromMap;
        }

        private List<Dictionary<String, DateTime>> mergeTime(List<DateTime> times)
        {
            List<Dictionary<String, DateTime>> timeMapList = new List<Dictionary<string, DateTime>>();
            DateTime from = times[0];
            DateTime to = times[0];

            for (int i = 1; i < times.Count; i++)
            {
                if (times[i].Equals(times[i - 1].AddMinutes(30)))
                {
                    to = times[i];
                }
                else
                {
                    Dictionary<String, DateTime> fromTo = new Dictionary<string, DateTime>();
                    fromTo.Add("From", from);
                    fromTo.Add("To", to);
                    timeMapList.Add(fromTo);

                    from = times[i];
                    to = times[i];
                }


                if (i == times.Count - 1)
                {
                    Dictionary<String, DateTime> fromTo = new Dictionary<string, DateTime>();
                    fromTo.Add("From", from);
                    fromTo.Add("To", to);
                    timeMapList.Add(fromTo);
                }
            }

            return timeMapList;
        }



    }




}