using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode;
using Timeline.AppCode.BLL;
using Timeline.AppCode.Domain;

namespace Timeline
{
    public partial class AfterLogin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

      /*  [System.Web.Services.WebMethod]
        public static string GetFriends(int userId)
        {
            FriendBLL  friendBLL = new FriendBLL();
           // int userId = (Int32)Session["userId"];
            List<User> friendList = friendBLL.getFriendList(userId);

            String json = friendList.ToJSON();

            return json;
        }
        */
    }
}