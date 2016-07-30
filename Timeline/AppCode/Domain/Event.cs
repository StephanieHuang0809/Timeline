using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.Domain
{
    public class Event
    {
        public int id { set; get; }
        public User owner;
        public String name { set; get; }
        public String location { set; get; }
        public DateTime? from { set; get; }
        public DateTime? to { set; get; }
        public String status { set; get; }
        public List<User> participants { set; get; }

        public Event()
        {
            this.participants = new List<User>();
        }

       


    }
}