using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Timeline.AppCode.BLL;
using Timeline.AppCode.Domain;

namespace Timeline.AppPage
{
    public partial class myProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                User userProfile = new User();
                userProfile.userId = (Int32)Session["userId"];
                userProfile.loadSelf();
                this.tb_firstName.Text = userProfile.firstName;
                this.tb_lastName.Text = userProfile.lastName;
                this.tb_birthday.Text = String.Format("{0:dd/MM/yyyy}", userProfile.birthday);
                this.tb_email.Text = userProfile.email;
                this.tb_occupation.Text = userProfile.occupation;
                if (userProfile.gender.Equals("F"))
                {
                    this.rb_female.Checked = true;
                }
                else
                {
                    this.rb_male.Checked = true;
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            RegisterBLL registerBLL = new RegisterBLL();
            registerBLL.firstName = this.tb_firstName.Text;
            registerBLL.lastName = this.tb_lastName.Text;
            if (this.rb_female.Checked)
            {
                registerBLL.gender = "F";
            }
            else
            {
                registerBLL.gender = "M";
            }
            registerBLL.birthday = Convert.ToDateTime(this.tb_birthday.Text);
            registerBLL.occupation = this.tb_occupation.Text;
            registerBLL.email = this.tb_email.Text;
            registerBLL.role = "P";

            registerBLL.updateProfile();

            this.tb_firstName.Enabled = false;
            this.tb_lastName.Enabled = false;
            this.tb_birthday.Enabled = false;
            this.tb_occupation.Enabled = false;
            this.tb_email.Enabled = false;
            this.rb_female.Enabled = false;
            this.rb_male.Enabled = false;
            this.btn_save.Visible = false;
            this.btn_cancel.Visible = false;
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            this.tb_firstName.Enabled = false;
            this.tb_lastName.Enabled = false;
            this.tb_birthday.Enabled = false;
            this.tb_occupation.Enabled = false;
            this.tb_email.Enabled = false;
            this.rb_female.Enabled = false;
            this.rb_male.Enabled = false;
            this.btn_save.Visible = false;
            this.btn_cancel.Visible = false;
        }

        protected void btn_edit_Click(object sender, ImageClickEventArgs e)
        {
            this.tb_firstName.Enabled = true;
            this.tb_lastName.Enabled = true;
            this.tb_birthday.Enabled = true;
            this.tb_occupation.Enabled = true;
            this.tb_email.Enabled = true;
            this.rb_female.Enabled = true;
            this.rb_male.Enabled = true;
            this.btn_save.Visible = true;
            this.btn_cancel.Visible = true;
        }


    }
}