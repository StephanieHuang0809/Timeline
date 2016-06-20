using System;


    public class RegisterBLL
    {
        public int userId { set; get; }
        public String firstName { set; get; }
        public String lastName { set; get; }
        public String gender { set; get; }
        public DateTime? birthday { set; get; }
        public String email { set; get; }
        public String password { set; get; }
        public String role { set; get; }
        
        public void register()
        {

       
            //RegisterDAL dal = new RegisterDAL();
            //RegisterDAL registerDAL = new RegisterDAL();
            //registerDAL.register(this.firstName, this.lastName, this.gender, this.birthday, this.email, this.password, this.role);
        }
    }

   
