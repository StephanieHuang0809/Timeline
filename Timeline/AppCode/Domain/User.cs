using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.Domain
{
    public class User
    {
        public int userId { set; get; }
        public string firstName { set; get; }
        public string lastName { set; get; }
        public string role { set; get; }
        public string email { set; get; }

        public void loadSelf()
        {
            var conn = DBManager.getSqlConnection();
            conn.Open();

            string sql = "select A.Id, A.firstName, A.lastName, A.role" +
                                " From USER_INFO A Where A.id=@userId";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("userId", userId);
            SqlDataReader dr = cmd.ExecuteReader();


            if (dr.Read())
            {
                this.userId = dr.GetInt32(0);
                this.firstName = dr.GetString(1);
                this.lastName = dr.GetString(2);
                this.role = dr.GetString(3);



            }
            dr.Close();
            conn.Close();


        }
    }
}