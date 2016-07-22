using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.Domain
{
    public class Chat
    {
        public string userName { set; get; }
        public int eventId { set; get; }
        public int userId { set; get; }
        public string colorCode { set; get; }
        public string content { set; get; }
        public DateTime postTime { set; get; }
    }
}