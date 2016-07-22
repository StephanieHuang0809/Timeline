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

        [System.Web.Services.WebMethod]
        public static string GetFriends()
        {
            FriendBLL  friendBLL = new FriendBLL();
            // scheduleBLL.userId = (Int32)Session["userId"];
            List<User> friendList = friendBLL.getFriendList(1);

            String json = friendList.ToJSON();

            return json;
        }

    }
}