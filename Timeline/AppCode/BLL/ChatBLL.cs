using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Timeline.AppCode.DAL;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.BLL
{
    public class ChatBLL
    {
        public List<Chat> find(int eventId, DateTime laterThen)
        {
            ChatDAL dal = new ChatDAL();
            return dal.getChat(eventId, laterThen);
        }

        public void insert(int eventId, int userId, string content)
        {
            ChatDAL dal = new ChatDAL();
            dal.insert(eventId, userId, content);
        }
    }
}