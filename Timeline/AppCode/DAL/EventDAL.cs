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
        public void createEvent(String name, String location, DateTime from, DateTime to, String status, int ownerUserId, List<User> participants)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();

            try
            {
                // Start a local transaction.
                string sql = "INSERT EVENT_INFO (name, location, from, to, status, ownerUserId)" +
                             " VALUES ( " +
                             "@name, " +
                             "@location, " +
                             "@from, " +
                             "@to, " +
                             "@status, " +
                             "@ownerUserId);SELECT SCOPE_IDENTITY()";//get the event Id


                var cmd = new SqlCommand(sql, conn);
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
