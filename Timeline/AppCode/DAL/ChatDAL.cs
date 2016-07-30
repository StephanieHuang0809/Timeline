using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.DAL
{
    public class ChatDAL
    {
        public void insert(int eventId, int userId, string content)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            try
            {
                // Start a local transaction.
                string sql = "INSERT CHAT (userId, content, eventId, postTime)" +
                             " VALUES ( " +
                             "@userId, " +
                             "@content, " +
                             "@eventId, " +
                             "SYSDATETIME())";//get the event Id


                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("userId", userId);
                cmd.Parameters.AddWithValue("content", content);
                cmd.Parameters.AddWithValue("eventId", eventId);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            conn.Close();
        }


        public List<Chat> getChat(int eventId, DateTime laterThen)
        {
            List<Chat> lst = new List<Chat>();
            SqlConnection conn = DBManager.getSqlConnection();
            try
            {

                conn.Open();
               // Start a local transaction.
                string sql = "select  C.userId, U.firstName, U.lastName, C.content, C.eventId, C.postTime, P.colorCode " +
                              "from CHAT C inner join User_info U on C.userId=U.Id " +
                              " inner join Event_PARTICIPANTS P on (C.eventId=P.eventId and C.userId=P.userId) " +
                             " Where  convert(varchar(18),C.postTime,120)>@postTime and C.eventId=@eventId order by C.postTime";//get the event Id

                var cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("eventId", eventId);
                cmd.Parameters.AddWithValue("postTime", laterThen.ToString("yyyy-MM-dd HH:mm:ss"));

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    Chat c = new Chat();
                    c.userId = dr.GetInt32(0);
                    c.userName = dr.GetString(1) + " " + dr.GetString(2);
                    c.content = dr.GetString(3);
                    c.eventId = dr.GetInt32(4);
                    c.postTime = dr.GetDateTime(5);
                    c.colorCode = dr.GetString(6);
                    lst.Add(c);
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);

            }
            finally
            {
                conn.Close();

            }

            return lst;
        }

    }
}