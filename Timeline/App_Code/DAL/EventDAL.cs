using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Timeline.App_Code.BLL
{
    public class EventDAL
    {
        public void createEvent(String name, String location, DateTime from, DateTime to, List<User> participants)
        {
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();

            try
            {
                // Start a local transaction.
                string sql = "INSERT USER_INFO (name, location, from, to, participants)" +
                             " VALUES ( " +
                             "@name, " +
                             "@location, " +
                             "@from, " +
                             "@to, " +
                             "@participants);SELECT SCOPE_IDENTITY()";//get the applicationId


                var cmd = new SqlCommand(sql, conn);
                var param = new SqlParameter[11];
                param[0] = new SqlParameter("name", SqlDbType.VarChar, 50);
                param[1] = new SqlParameter("location", SqlDbType.VarChar, 50);
                param[2] = new SqlParameter("from", SqlDbType.DateTime);
                param[3] = new SqlParameter("to", SqlDbType.DateTime);
                param[4] = new SqlParameter("participants", SqlDbType.VarChar, 50);


                param[0].Value = (object)name ?? DBNull.Value;
                param[1].Value = (object)location ?? DBNull.Value;
                param[2].Value = (object)from ?? DBNull.Value;
                param[3].Value = (object)to ?? DBNull.Value;
                param[4].Value = (object)participants ?? DBNull.Value;


                foreach (var t in param)
                {
                    cmd.Parameters.Add(t);
                }

                cmd.CommandType = CommandType.Text;
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
