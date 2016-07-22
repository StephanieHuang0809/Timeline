using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.Domain
{
    public class Schedule
    {
        public int userId { set; get; }
        public String colorCode { set; get; }
        public User user { set; get; }
        public int scheduleId { set; get; }
        public String freeSlot { set; get; }
        public DateTime freeSlotTimeFrom { set; get; }
        public DateTime freeSlotTimeTo { set; get; }

    }
}