using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Timeline
{
    public class DBManager
    {
        public DBManager()
        {
        }


        public static string getConnectString()
        {
            return ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        }


        public static SqlConnection getSqlConnection()
        {
            return new SqlConnection(getConnectString());
        }
    }
}