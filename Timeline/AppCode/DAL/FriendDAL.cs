using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.DAL
{
    public class FriendDAL
    {
        public List<User> getFriendList(int userId)
        {
            List<User> friendList = new List<User>();
            var conn = DBManager.getSqlConnection();
            conn.Open();

            string sql = "SELECT U.Id, firstName, lastName, email" +
                          "  " +
                           " FROM USER_INFO U INNER JOIN FRIENDS F ON U.Id = F.userFriendId WHERE F.userId = @userId ORDER BY firstName ASC ";



            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("userId", userId);
           

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                User user = new User();
                user.userId = dr.GetInt32(0);
                user.firstName = dr.GetString(1);
                user.lastName = dr.GetString(2);
                user.email = dr.GetString(3);
                friendList.Add(user);
            }

            dr.Close();
            conn.Close();
            return friendList;
        }

        public void ignoreFriendRequest(int requestId)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            SqlCommand cmd = null;
            try
            {
                // Start a local transaction.
                string sql = "UPDATE REQUESTS SET " +
                             "approvalDate=@approvalDate " +
                             "status=@status WHERE ID=" + requestId;//get the event Id

                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("status", "IGNORED");
                cmd.Parameters.AddWithValue("approvalDate",DateTime.Now);
            }
            catch (Exception ex)
            {

                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }

            conn.Close();
        }

        public void acceptFriendRequest(int requestId)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            SqlTransaction transaction = conn.BeginTransaction();
            SqlCommand cmd = null;
            try
            {
                // Start a local transaction.
                string sql = "UPDATE REQUESTS SET " +
                             "approvalDate=@approvalDate ," +
                             "status=@status WHERE ID=" + requestId;
                
                cmd = new SqlCommand(sql, conn, transaction);
                cmd.Parameters.AddWithValue("status", "ACCEPTED");
                cmd.Parameters.AddWithValue("approvalDate", DateTime.Now);
                cmd.ExecuteNonQuery();

                sql = "SELECT requestFrom, requestTo FROM REQUESTS WHERE Id =" + requestId;
                cmd.CommandText = sql;
                SqlDataReader dr = cmd.ExecuteReader();

                int targetId = 0;
                int requestSentById = 0;
                
                if (dr.Read())
                {    
                   targetId = dr.GetInt32(0);
                   requestSentById = dr.GetInt32(1);
                }

                dr.Close();

                sql = "INSERT FRIENDS (userId,userFriendId)" +
                         " VALUES ( " +
                         "@userId, " +
                         "@userFriendId)";

                cmd.CommandText = sql;
                cmd.Parameters.AddWithValue("userId", targetId);
                cmd.Parameters.AddWithValue("userFriendId", requestSentById);
                cmd.ExecuteNonQuery();


                sql = "INSERT FRIENDS (userId,userFriendId)" +
                        " VALUES ( " +
                        "@userId2, " +
                        "@userFriendId2)";
                cmd.CommandText = sql;
                cmd.Parameters.AddWithValue("userId2", requestSentById);
                cmd.Parameters.AddWithValue("userFriendId2", targetId);
                cmd.ExecuteNonQuery();
                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                System.Diagnostics.Debug.WriteLine(@"Commit Exception Type: {0}", ex.GetType());
                System.Diagnostics.Debug.WriteLine(@"Message: {0}", ex.Message);
                throw ex;
            }
            finally {
                conn.Close();
            }

            
        }

        public void sendFriendRequest(int targetId, int requestSentById)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();
            SqlCommand cmd = null;
            try
            {
                // Start a local transaction.
                string sql = "INSERT REQUESTS (requestType, requestFrom, requestTo, requestDate, status)" +
                             " VALUES ( " +
                             "@requestType, " +
                             "@requestFrom, " +
                             "@requestTo, " +
                             "@requestDate, " +
                   //          "@approvalDate, " +
                             "@status);SELECT SCOPE_IDENTITY()";//get the event Id


                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("requestType", "ADD FRIEND");
                cmd.Parameters.AddWithValue("requestFrom", requestSentById);
                cmd.Parameters.AddWithValue("requestTo", targetId);
                cmd.Parameters.AddWithValue("requestDate", DateTime.Now);
             //   cmd.Parameters.AddWithValue("approvalDate", null);
                cmd.Parameters.AddWithValue("status", "PENDING");

                object newId = cmd.ExecuteScalar();
                int requestId = int.Parse(((Decimal)newId).ToString());

                sql = "INSERT NOTIFICATIONS (targetUserId,scope,type,message,date,link)" +
                           " VALUES ( " +
                           "@targetUserId, " +
                           "@scope, " +
                           "@type, " +
                           "@message, " +
                           "@date, " +
                           "@link)";

                cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("targetUserId", targetId);
                cmd.Parameters.AddWithValue("scope", "USER");
                cmd.Parameters.AddWithValue("type","FRIEND REQUEST");
                cmd.Parameters.AddWithValue("message","You have a new friend request!");
                cmd.Parameters.AddWithValue("date",DateTime.Now);
                cmd.Parameters.AddWithValue("link", "addFriends.aspx?id="+ requestId);
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

    }
}