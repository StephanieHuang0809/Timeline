<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="myProfile.aspx.cs" Inherits="Timeline.AppPage.myProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" media="screen">
.button {
  font-size: 15px;
  font-weight:bold;
  padding: 10px;
  color: #190707;
  background-color:white;
  border: 2px solid #FFBF00;
  border-radius: 20px/50px;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease-out;
}

.button:hover {
  background: #FACC2E;
}
    .auto-style1 {
        height: 26px;
    }
</style>

<script type="text/javascript" charset="utf-8">
    $(function () {
        $("#<%=this.tb_birthday.ClientID%>").datepicker();
    });

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        My Profile&nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btn_edit" runat="server" Height="25px" ImageAlign="AbsBottom" ImageUrl="~/Images/editButtonBlack.png" OnClick="btn_edit_Click" ToolTip="Edit Event" /></p>
           <table id="registration" border="0" style="width:85%;color:white" >
        <tr><td style="width:12%">First Name :</td><td style="width:20%"><asp:TextBox ID="tb_firstName" runat="server" Enabled="False"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ID="rfv_firstName" runat="server" ErrorMessage="Please enter first name!" ControlToValidate="tb_firstName" ForeColor="#CC3300" Font-Bold="True"></asp:RequiredFieldValidator>
            </td>
           </tr>
        <tr> <td>Last Name :</td><td><asp:TextBox ID="tb_lastName" runat="server" Enabled="False"></asp:TextBox></td>
            <td>
            <asp:RequiredFieldValidator ID="rfv_lastName" runat="server" ErrorMessage="Please enter last name!" ControlToValidate="tb_lastName" ForeColor="#CC3300" Font-Bold="True"></asp:RequiredFieldValidator>
            </td></tr>
        <tr><td>Gender :</td><td><asp:RadioButton ID="rb_female" runat="server" Text="Female" ValidationGroup="gender" Checked="True" GroupName="rb_gender" />      
&nbsp;&nbsp;&nbsp;
        <asp:RadioButton ID="rb_male" runat="server" Text="Male" ValidationGroup="gender" GroupName="rb_gender" /></td>
            <td>
                &nbsp;</td>
            </tr>
        <tr><td>Birthday :</td><td><asp:TextBox ID="tb_birthday" runat="server" Enabled="False" ></asp:TextBox>
            </td><td>
                <asp:RequiredFieldValidator ID="rfv_birthday" runat="server" ErrorMessage="Please enter birthday!" ControlToValidate="tb_birthday" ForeColor="#CC3300" Font-Bold="True"></asp:RequiredFieldValidator>
            </td></tr>
        <tr><td>Occupation :</td><td>
            <asp:TextBox ID="tb_occupation" runat="server" Enabled="False"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="rfv_occupation" runat="server" ErrorMessage="Please enter occupation" ControlToValidate="tb_occupation" ForeColor="#CC3300" Font-Bold="True"></asp:RequiredFieldValidator>
            </td></tr>
        <tr><td class="auto-style1">Email :</td><td class="auto-style1"><asp:TextBox ID="tb_email" runat="server" TextMode="Email" Enabled="False"></asp:TextBox></td><td class="auto-style1">
            <asp:RequiredFieldValidator ID="rfv_email" runat="server" ErrorMessage="Please enter email!" ControlToValidate="tb_email" ForeColor="#CC3300" Font-Bold="True"></asp:RequiredFieldValidator>
            </td></tr>
    </table><br />
     <div id="button" style="margin-left:auto">
                <asp:Button ID="btn_save" CssClass="button" Height="50px" Width="100px" runat="server" Text="Save" ToolTip="Save" OnClick="btn_save_Click" Visible="False" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cancel" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" ToolTip="Cancel Event" OnClick="btn_cancel_Click" Visible="False"/>
     </div><br />
     <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        Changing Password</p>

    </asp:Content>
