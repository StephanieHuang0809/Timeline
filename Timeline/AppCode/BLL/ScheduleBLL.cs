using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Timeline.AppCode.DAL;

namespace Timeline.AppCode.BLL
{
    public class ScheduleBLL
    {
        public int userId { set; get; }
        public int scheduleId { set; get; }
        public String freeSlot { set; get; }
        public DateTime freeSlotTimeFrom { set; get; }
        public DateTime freeSlotTimeTo { set; get; }
        public List<Schedule> scheduleList { set; get; }

    public void readSchedule()
        {
            ScheduleDAL scheduleDAL= new ScheduleDAL();
            scheduleDAL.userId = this.userId;
            scheduleDAL.scheduleId = this.scheduleId;
            scheduleDAL.freeSlot = this.freeSlot;
            scheduleDAL.freeSlotTimeFrom = this.freeSlotTimeFrom;
            scheduleDAL.freeSlotTimeTo = this.freeSlotTimeTo;
            scheduleList = scheduleDAL.readSchedule();
        }
    }
}