using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Timeline.AppCode.DAL;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.BLL
{
    public class FriendBLL
    {
        public int userId { set; get; }
        
        public List<User> getFriendList(int userId)
        {
            FriendDAL friendDAL = new FriendDAL();
            return friendDAL.getFriendList(userId);
        }
    }
}