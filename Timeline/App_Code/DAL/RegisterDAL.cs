﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Timeline.App_Code.DAL
{
    public class RegiszterDAL
    {
        public void register(
        int userId,
        String firstName,
        String lastName,
        String gender,
        DateTime? birthday,
        String email,
        String password,
        String role
       ){
            SqlConnection conn = DBManager.getSqlConnection();
            conn.Open();

            try
            {
                // Start a local transaction.
                string sql = "INSERT USER_INFO (firstName, lastName, gender, birthday, email, password, role)" +
                             " VALUES ( " +
                             "@firstName, " +
                             "@lastName, " +
                             "@gender, " +
                             "@birthday, " +
                             "@email, " +
                             "@password, " +
                             "@role);SELECT SCOPE_IDENTITY()";//get the applicationId


                var cmd = new SqlCommand(sql, conn);
                var param = new SqlParameter[11];
                param[0] = new SqlParameter("firstName", SqlDbType.VarChar, 50);
                param[1] = new SqlParameter("lastName", SqlDbType.VarChar, 50);
                param[2] = new SqlParameter("gender", SqlDbType.VarChar, 50);
                param[3] = new SqlParameter("birthday", SqlDbType.DateTime);
                param[4] = new SqlParameter("email", SqlDbType.VarChar, 50);
                param[5] = new SqlParameter("password", SqlDbType.VarChar, 50);
                param[6] = new SqlParameter("role", SqlDbType.VarChar, 50);


                param[0].Value = (object)firstName ?? DBNull.Value;
                param[1].Value = (object)lastName ?? DBNull.Value;
                param[2].Value = (object)gender ?? DBNull.Value;
                param[3].Value = (object)birthday ?? DBNull.Value;
                param[4].Value = (object)email ?? DBNull.Value;
                param[5].Value = (object)password ?? DBNull.Value;
                param[6].Value = (object)role ?? DBNull.Value;


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