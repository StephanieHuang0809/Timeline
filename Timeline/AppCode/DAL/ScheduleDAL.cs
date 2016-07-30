using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.DAL
{
    public class ScheduleDAL
    {
        public int userId { set; get; }
        public int scheduleId { set; get; }
        public String freeSlot { set; get; }
        public DateTime freeSlotTimeFrom { set; get; }
        public DateTime freeSlotTimeTo { set; get; }
        public DateTime scheduleDate { set; get; }

        public List<Schedule> readSchedule(DateTime? p_start, DateTime? p_to)
        {
            List<Schedule> scheduleList = new List<Schedule>();
            var conn = DBManager.getSqlConnection();
            conn.Open();

            string sql = "SELECT Id, userId, freeSlot, freeSlotTimefrom, freeSlotTimeTo" +
                          "  " +
                           " FROM SCHEDULE S where S.userId = @userId";

            if (p_start != null)
            {
                sql += " And scheduleDate>=@startDate";
            }

            if (p_to != null)
            {
                sql += " And scheduleDate<=@endDate";
            }

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("userId", userId);
            if (p_start != null)
            {
                cmd.Parameters.AddWithValue("startDate", p_start);

            }

            if (p_to != null)
            {
                cmd.Parameters.AddWithValue("endDate", p_to);
            }

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
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

        public List<Schedule> readSchedule(int eventId, DateTime? p_start, DateTime? p_to)
        {
            List<Schedule> scheduleList = new List<Schedule>();
            var conn = DBManager.getSqlConnection();
            conn.Open();

            string sql = "SELECT S.Id, S.userId, S.freeSlot, S.freeSlotTimefrom, S.freeSlotTimeTo, U.firstName, U.lastName" +
                           " FROM SCHEDULE S inner join EVENT_PARTICIPANTS P on S.userId=P.userId " +
                           " inner join USER_INFO U on P.userId=U.id" +
                           " where P.eventId = @eventId ";

            if (p_start != null)
            {
                sql += " And scheduleDate>=@startDate";
            }

            if (p_to != null)
            {
                sql += " And scheduleDate<=@endDate";
            }

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("eventId", eventId);
            if (p_start != null)
            {
                cmd.Parameters.AddWithValue("startDate", p_start);

            }

            if (p_to != null)
            {
                cmd.Parameters.AddWithValue("endDate", p_to);
            }

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                scheduleId = dr.GetInt32(0);
                userId = dr.GetInt32(1);
                freeSlot = dr.GetString(2);
                freeSlotTimeFrom = dr.GetDateTime(3);
                freeSlotTimeTo = dr.GetDateTime(4);

                User user = new User();
                user.userId = userId;
                user.firstName = dr.GetString(5);
                user.lastName = dr.GetString(6);

                Schedule schedule = new Schedule();
                schedule.scheduleId = scheduleId;
                schedule.userId = userId;
                schedule.user = user;
                schedule.freeSlot = freeSlot;
                schedule.freeSlotTimeFrom = freeSlotTimeFrom;
                schedule.freeSlotTimeTo = freeSlotTimeTo;
                scheduleList.Add(schedule);
            }

            dr.Close();
            conn.Close();
            return scheduleList;

        }

        public int delete(SqlConnection conn, int userId, DateTime scheduleDate)
        {

            string sql = "delete from schedule where scheduleDate=@date and userId=@userId";
            System.Diagnostics.Debug.WriteLine(@"delete from schedule where scheduleDate=@date and userId=@userId {0},{1}", userId,scheduleDate);
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("date", scheduleDate);
            cmd.Parameters.AddWithValue("userId", userId);
            cmd.ExecuteNonQuery();
            // int r = (int)cmd.ExecuteScalar();
            return 0;
        }

        public int insert(SqlConnection conn, int userId, DateTime scheduleDate, DateTime timefrom, DateTime timeto, String freeSlot)
        {
            string sql = "insert into schedule (userId, freeSlot,scheduleDate,freeSlotTimeFrom,freeSlotTimeTo) " +
                " values (@userId,@freeSlot,@scheduleDate,@freeSlotTimeFrom,@freeSlotTimeTo)";
            
            System.Diagnostics.Debug.WriteLine("userId="+ userId +"DateTime"+ scheduleDate+" FromeDateTime"+ timefrom + " ToDateTime" + timeto+" free" + freeSlot);


            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("userId", userId);
            cmd.Parameters.AddWithValue("freeSlot", freeSlot);
            cmd.Parameters.AddWithValue("scheduleDate", scheduleDate);
            cmd.Parameters.AddWithValue("freeSlotTimeFrom", timefrom);
            cmd.Parameters.AddWithValue("freeSlotTimeTo", timeto);

            cmd.ExecuteNonQuery();
            int r = 0;//(int)cmd.ExecuteScalar();
            return r;
        }


        public static void main()
        {
            ScheduleDAL dal = new ScheduleDAL();
            dal.readSchedule(DateTime.Now, DateTime.Now);


        }

    }
}