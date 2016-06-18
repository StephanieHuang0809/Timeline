using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Timeline.App_Code.DAL;

namespace Timeline.App_Code
{
    public class RegisterBLL
    {
        public int registrationId { set; get; }
        public int userId { set; get; }
        public String firstName { set; get; }
        public String lastName { set; get; }
        public String gender { set; get; }
        public DateTime? birthday { set; get; }
        public String password { set; get; }
        public String role { set; get; }

        public void register() {
            RegiszterDAL registerDal = new RegiszterDAL();

        }
      
        
    }

   
}