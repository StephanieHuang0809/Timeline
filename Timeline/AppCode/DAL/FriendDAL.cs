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

    }
}