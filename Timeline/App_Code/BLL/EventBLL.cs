using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Timeline.App_Code.BLL
{
    public class Event
    {
        public String name { set; get; }
        public String location { set; get; }
        public DateTime? from { set; get; }
        public DateTime? to { set; get; }
        public List<User> participants { set; get; }

        public void createEvent(String name,String location, DateTime from, DateTime to, List<User> participants)
        {
            EventDAL eventDal = new EventDAL();
            
        }



}
}