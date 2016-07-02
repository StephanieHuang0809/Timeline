using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode.BLL;

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
            registerBLL.birthday = Convert.ToDateTime(this.tb_birthday.Text);
            registerBLL.occupation = this.tb_occupation.Text;
            registerBLL.email = this.tb_email.Text;
            registerBLL.password = this.tb_password.Text;
            registerBLL.role = "P";

            registerBLL.register();
        }

        protected void cb_agree_CheckedChanged(object sender, EventArgs e)
        {
            if (this.cb_agree.Checked) {
                this.btn_submit.Enabled = true;
                this.btn_submit.CssClass = "opacity1";
            }
            else if (!this.cb_agree.Checked)
            {
                this.btn_submit.Enabled = false;
                this.btn_submit.CssClass = "opacity2";
            }
        }

        protected void CheckBoxRequired_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            e.IsValid = cb_agree.Checked;
        }
    }
}