using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.DAL
{
    public class ScheduleDAL
    {
        public int userId { set; get; }
        public int scheduleId { set; get; }
        public String freeSlot { set; get; }
        public DateTime freeSlotTimeFrom { set; get; }
        public DateTime freeSlotTimeTo { set; get; }

        public List<Schedule> readSchedule()
        {
            List<Schedule> scheduleList = new List<Schedule>();
            var conn = DBManager.getSqlConnection();
            conn.Open();

            string sql = "SELECT Id, userId, freeSlot, freeSlotTimefrom, freeSlotTimeTo" +
                          "  " +
                           " FROM SCHEDULE S where S.userId = @userId";

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@userId", userId);

            SqlDataReader dr = cmd.ExecuteReader();

            while(dr.Read())
            {
                scheduleId = dr.GetInt32(0);
                userId = dr.GetInt32(1);
                freeSlot = dr.GetString(2);
                freeSlotTimeFrom = dr.GetDateTime(3);
                freeSlotTimeTo = dr.GetDateTime(4);

                Schedule schedule = new Schedule();
                schedule.scheduleId = scheduleId;
                schedule.userId = userId;
                schedule.freeSlot = freeSlot;
                schedule.freeSlotTimeFrom = freeSlotTimeFrom;
                schedule.freeSlotTimeTo = freeSlotTimeTo;
                scheduleList.Add(schedule);
            }

            dr.Close();
            conn.Close();
            return scheduleList;
        }
      
    }
}