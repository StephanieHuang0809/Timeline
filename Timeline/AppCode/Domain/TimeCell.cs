using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Timeline.AppCode.Domain
{
    public class TimeCell
    {
        public TimeCell()
        {
            this.lapNumber = 1;
            this.lapNames = new List<string>();
        }

        public int userId { set; get; }
        public int lapNumber { set; get; }
        public string cell { set; get; }
        public string colorCode { set; get; }
        public string userName { set; get; }
        public List<string> lapNames { set; get; }

        public override bool Equals(Object obj)
        {
            return ((TimeCell)obj).cell.Equals(this.cell);
        }

        public override int GetHashCode()
        {
            return base.GetHashCode();
        }
    }
}