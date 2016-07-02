using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Timeline
{
    public partial class login2 : System.Web.UI.Page
    {
        bool isCorporate = false;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            Session.Clear();
            bool Authenticated = false;
            Authenticated = SiteSpecificAuthenticationMethod(Login1.UserName, Login1.Password);

            e.Authenticated = Authenticated;

            if (Authenticated)
            {
                Session.Timeout = 60;
                String url = Request.Params["returnUrl"];
                String role = Request.Params["role"];


                if (isCorporate)
                {
                    if (!Util.IsBlank(url))
                    {
                        if ("C".Equals(role)) this.Response.Redirect(url);
                    }
                    this.Response.Redirect("./corporateHome.aspx");
                }
                else
                {
                    if (!Util.IsBlank(url))
                    {
                        if ("P".Equals(role)) this.Response.Redirect(url);
                    }
                    this.Response.Redirect("./mySchedule.aspx");
                }
            }
        }

        private bool SiteSpecificAuthenticationMethod(string emailAddress, string Password)
        {
            SqlConnection con = getSqlConnection();
            con.Open();
            bool isAuth = false;

            this.isCorporate = false;
            string sql = "select A.Id, A.firstName, A.lastName, A.role" +

                                " From USER_INFO A Where A.email='" + emailAddress + "' and A.password='" + Password + "'";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();

            Session["email"] = emailAddress;

            if (dr.Read())
            {
                Session["userId"] = dr.GetInt32(0);
                Session["userName"] = dr.GetString(1) + dr.GetString(2);
                Session["role"] = dr.GetString(3);

                isAuth = true;

            }
            dr.Close();


            con.Close();
            return isAuth;
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

