using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Timeline
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void btn_submit_Click(object sender, ImageClickEventArgs e)
        {
            if (!Page.IsValid) return;

            RegisterBLL registerBLL = new RegisterBLL();
            registerBLL.firstName = this.tb_firstName.Text;
            registerBLL.lastName = this.tb_lastName.Text;
            if (this.rb_female.Checked)
            {
                registerBLL.gender = "F";
            }else
            {
                registerBLL.gender = "M";
            }
          //  registerBLL.birthday = this.tb_birthday.Text;
            registerBLL.email = this.tb_email.Text;
            registerBLL.password = this.tb_password.Text;
            registerBLL.role = "P";
        }
    }
}