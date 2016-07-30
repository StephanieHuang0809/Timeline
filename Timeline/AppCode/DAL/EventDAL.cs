using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.DAL
{
    public class EventDAL
    {
        public void createEvent(String name, String location, DateTime from, DateTime to, String status, int ownerUserId, List<int> participantIdList)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            SqlCommand cmd = null;
            try
            {
                // Start a local transaction.
                string sql = "INSERT EVENT_INFO (eventName, EventLocation, eventDateFrom, EventDateTo, status, ownerUserId)" +
                             " VALUES ( " +
                             "@name, " +
                             "@location, " +
                             "@from, " +
                             "@to, " +
                             "@status, " +
                             "@ownerUserId);SELECT SCOPE_IDENTITY()";//get the event Id


                cmd = new SqlCommand(sql, conn);
                var param = new SqlParameter[6];
                param[0] = new SqlParameter("name", SqlDbType.VarChar, 50);
                param[1] = new SqlParameter("location", SqlDbType.VarChar, 50);
                param[2] = new SqlParameter("from", SqlDbType.DateTime);
                param[3] = new SqlParameter("to", SqlDbType.DateTime);
                param[4] = new SqlParameter("status", SqlDbType.VarChar, 50);
                param[5] = new SqlParameter("ownerUserId", SqlDbType.Int, 50);


                param[0].Value = (object)name ?? DBNull.Value;
                param[1].Value = (object)location ?? DBNull.Value;
                param[2].Value = (object)from ?? DBNull.Value;
                param[3].Value = (object)to ?? DBNull.Value;
                param[4].Value = (object)status ?? DBNull.Value;
                param[5].Value = (object)ownerUserId ?? DBNull.Value;


                foreach (var t in param)
                {
                    cmd.Parameters.Add(t);
                }

                cmd.CommandType = CommandType.Text;

                object newId = cmd.ExecuteScalar();
                int eventId = int.Parse(((Decimal)newId).ToString());

                sql = "INSERT EVENT_PARTICIPANTS (eventId,userId,colorCode)" +
                           " VALUES ( " +
                           "@eventId, " +
                           "@userId, " +
                           "@colorCode)";

                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("eventId", eventId);
                cmd.Parameters.AddWithValue("userId", ownerUserId);
                cmd.Parameters.AddWithValue("colorCode", Util.randomColorCode());
                cmd.ExecuteNonQuery();

                foreach (int participantId in participantIdList)
                {
                    cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("eventId", eventId);
                    cmd.Parameters.AddWithValue("userId", participantId);
                    cmd.Parameters.AddWithValue("colorCode", Util.randomColorCode());
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {

                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            conn.Close();
        }

        public void update(int id, string name, string location, DateTime from, DateTime to, string status, int ownerUserId, List<int> participantIdList)
        {

            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            SqlCommand cmd = null;
            try
            {
                // Start a local transaction.
                string sql = "UPDATE EVENT_INFO SET " +
                             "eventName=@name, " +
                             "EventLocation=@location, " +
                             "eventDateFrom=@from, " +
                             "EventDateTo=@to, " +
                             "status=@status, " +
                             "ownerUserId=@ownerUserId WHERE ID="+id+")";//get the event Id


                cmd = new SqlCommand(sql, conn);
                var param = new SqlParameter[6];
                param[0] = new SqlParameter("name", SqlDbType.VarChar, 50);
                param[1] = new SqlParameter("location", SqlDbType.VarChar, 50);
                param[2] = new SqlParameter("from", SqlDbType.DateTime);
                param[3] = new SqlParameter("to", SqlDbType.DateTime);
                param[4] = new SqlParameter("status", SqlDbType.VarChar, 50);
                param[5] = new SqlParameter("ownerUserId", SqlDbType.Int, 50);


                param[0].Value = (object)name ?? DBNull.Value;
                param[1].Value = (object)location ?? DBNull.Value;
                param[2].Value = (object)from ?? DBNull.Value;
                param[3].Value = (object)to ?? DBNull.Value;
                param[4].Value = (object)status ?? DBNull.Value;
                param[5].Value = (object)ownerUserId ?? DBNull.Value;


                foreach (var t in param)
                {
                    cmd.Parameters.Add(t);
                }

                cmd.CommandType = CommandType.Text;
                sql = "DELETE FROM EVENT_PARTICIPANTS WHERE eventId="+id;
                cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();


                sql = "INSERT EVENT_PARTICIPANTS (eventId,userId,colorCode)" +
                           " VALUES ( " +
                           "@eventId, " +
                           "@userId, " +
                           "@colorCode)";

                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("eventId", id);
                cmd.Parameters.AddWithValue("userId", ownerUserId);
                cmd.Parameters.AddWithValue("colorCode", Util.randomColorCode());
                cmd.ExecuteNonQuery();

                foreach (int participantId in participantIdList)
                {
                    cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("eventId", id);
                    cmd.Parameters.AddWithValue("userId", participantId);
                    cmd.Parameters.AddWithValue("colorCode", Util.randomColorCode());
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {

                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            conn.Close();

        }

        public Event getEventsInfo(int eventId)
        {
            var myEvent = new Domain.Event();

            try
            {
                SqlConnection conn = DBManager.getSqlConnection();
                conn.Open();
                string sql = "select E.id,E.ownerUserId,E.eventName,E.eventLocation,E.eventDateFrom,E.eventDateTo,E.status " +
                    " from event_info E where E.id=" + eventId;//get the event Id
                SqlCommand cmd = new SqlCommand(sql, conn);
                // Start a local transaction.
                SqlDataReader dr = cmd.ExecuteReader();
                //Timeline.AppCode.Domain.Event event = new Domain.Event();


                if (dr.Read())
                {
                    myEvent.id = dr.GetInt32(0);
                    User owner = new User();
                    owner.loadSelf();
                    myEvent.owner = owner;
                    myEvent.name = dr.GetString(2);
                    myEvent.location = dr.GetString(3);
                    myEvent.from = dr.GetDateTime(4);
                    myEvent.to = dr.GetDateTime(5);
                    myEvent.status = dr.GetString(6);
                    myEvent.participants = this.getParticipants(myEvent.id);

                }

                dr.Close();
                conn.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            return myEvent;
        }

        private List<User> getParticipants(int id)
        {
            List<User> users = new List<User>();
            try
            {
                SqlConnection conn = DBManager.getSqlConnection();
                conn.Open();
                string sql = "select userId from Event_participants where eventId= " + id;
                SqlCommand cmd = new SqlCommand(sql, conn);
                // Start a local transaction.
                SqlDataReader dr = cmd.ExecuteReader();
                //Timeline.AppCode.Domain.Event event = new Domain.Event();


                while (dr.Read())
                {
                    User user = new User();
                    user.userId = dr.GetInt32(0);
                    user.loadSelf();
                    users.Add(user);    
                }

                dr.Close();
                conn.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            return users;
        }





    }

}
