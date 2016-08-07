using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode.BLL;

namespace Timeline.AppPage
{
    public partial class addFriends : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_searchFriend_Click(object sender, EventArgs e)
        {
            this.gv_searchResults.DataBind();
        }

        protected void gv_searchResults_SelectedIndexChanged(object sender, EventArgs e)
        {

            // Get the currently selected row using the SelectedRow property.
            GridViewRow row = gv_searchResults.SelectedRow;

            HiddenField Id = row.FindControl("hf_Id") as HiddenField;
            String value = Id.Value;

            FriendBLL bll = new FriendBLL();
            //int userId = (int)Session["userId"];

            int userId = 1;
            bll.sendRequest(userId, int.Parse(value));

        }

        protected void gv_friendRequests_SelectedIndexChanged(object sender, EventArgs e)
        {


        }

 

        protected void gv_friendRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = 0;
            GridViewRow row;
            GridView grid = sender as GridView;
            index = Convert.ToInt32(e.CommandArgument);
            row = grid.Rows[index];
            FriendBLL friendBLL = new FriendBLL();

            switch (e.CommandName)
            {
                case "accept":
                    friendBLL.acceptRequest(1);
                    break;
                case "ignore":
                    friendBLL.ignoreRequest(1);
                    break;
            }
        }
    }
}