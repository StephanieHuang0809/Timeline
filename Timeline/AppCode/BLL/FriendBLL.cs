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

        public void sendRequest(int fromUser,int toUser)
        {
            FriendDAL dal = new FriendDAL();
            dal.sendFriendRequest(toUser, fromUser);
        }

        public void acceptRequest(int requestId)
        {
            FriendDAL dal = new FriendDAL();
            dal.acceptFriendRequest(requestId);
        }

        public void ignoreRequest(int requestId)
        {
            FriendDAL dal = new FriendDAL();
            dal.ignoreFriendRequest(requestId);
        }
    }
}