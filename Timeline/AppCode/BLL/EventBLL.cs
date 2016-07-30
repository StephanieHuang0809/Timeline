using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Timeline.AppCode.DAL;
using Timeline.AppCode.Domain;

namespace Timeline.AppCode.BLL
{
    public class EventBLL
    {
        public int id { set; get; }
        public int ownerUserId { set; get; }
        public String name { set; get; }
        public String location { set; get; }
        public DateTime from { set; get; }
        public DateTime to { set; get; }
        public String status { set; get; }
        public List<int> participantIdList { set; get; }

        public EventBLL(){
            this.participantIdList = new List<int>();
        }

        public void createEvent()
        {
            EventDAL eventDal = new EventDAL();
            eventDal.createEvent(name, location, from, to, status, ownerUserId, participantIdList);
        }

        public Event getEvent(int id)
        {
            EventDAL eventDal = new EventDAL();
            return eventDal.getEventsInfo(id);

        }

        public void updateEvent()
        {
            EventDAL eventDal = new EventDAL();
            eventDal.update(id,name, location, from, to, status, ownerUserId, participantIdList);
        }
    }
}