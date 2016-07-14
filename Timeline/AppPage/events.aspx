﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="events.aspx.cs" Inherits="Timeline.AppPage.events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css" media="screen">
 h1 {
  text-align: center;
  font-family: Tahoma, Arial, sans-serif;
  color: #06D85F;
  margin: 80px 0;
}

.box {
  width: 40%;
  margin: 0 auto;
  background: rgba(255,255,255,0.2);
  padding: 35px;
  border: 2px solid #fff;
  border-radius: 20px/50px;
  background-clip: padding-box;
  text-align: center;
}

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

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0;
}
.overlay:target {
  visibility: visible;
  opacity: 1;
}

.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30%;
  position: relative;
  transition: all 5s ease-in-out;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .close {
  position: absolute;
  top: 20px;
  right: 30px;
  transition: all 200ms;
  font-size: 30px;
  font-weight: bold;
  text-decoration: none;
  color: #333;
}
.popup .close:hover {
  color: #06D85F;
}
.popup .content {
  max-height: 70%;
  overflow: auto;
}

@media screen and (max-width: 700px){
  .box{
    width: 70%;
  }
  .popup{
    width: 70%;
  }
}
         .auto-style1 {
             width: 18px;
         }
     </style>

<script type="text/javascript" charset="utf-8">
    $(function () {
        $("#<%=this.tb_dateFrom.ClientID%>").datepicker();
	    $("#<%=this.tb_dateTo.ClientID%>").datepicker();
    })
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
       Events</p>
    <p>
         <asp:Label ID="lb_intro" runat="server" Text="Select an event from the Event List below: " ForeColor="White" Font-Bold="True" Font-Names="Arial"></asp:Label>
    </p>
     <div id="list_event" style="float:left">

     </div>
     <div id="new_event" class="popup" style="float:right;width:45%;height:60%;margin-right:5%">
         <h2 style="text-align:center">New Event</h2>
         <table id="tbl_newEvent" border="0" style="width:85%;">
             <tr><td><asp:Label ID="lb_name" runat="server" Text="Name: "></asp:Label></td>
                 <td><asp:TextBox ID="tb_name" runat="server"></asp:TextBox></td>
                 <td colspan="2"><asp:HyperLink ID="hl_suggestedEvents" runat="server" ForeColor="Black" Font-Underline="True">Suggested Events?</asp:HyperLink></td>
                 <td></td>
             </tr>
             <tr><td><asp:Label ID="lb_location" runat="server" Text="Location: "></asp:Label></td>
                 <td><asp:TextBox ID="tb_location" runat="server"></asp:TextBox></td>
                 <td class="auto-style1"></td>
                 <td></td>
             </tr>
             <tr><td style="width:15%"><asp:Label ID="lb_dateFrom" runat="server" Text="Date From: "></asp:Label></td>
                 <td style="width:20%"><asp:TextBox ID="tb_dateFrom" runat="server"></asp:TextBox></td>
                 <td style="width:10px"><asp:Label ID="lb_dateTo" runat="server" Text=" To "></asp:Label></td>
                 <td style="width:20%"><asp:TextBox ID="tb_dateTo" runat="server"></asp:TextBox></td>
             </tr>
             <tr><td colspan="4"><asp:HyperLink ID="hl_inviteFriends" runat="server" ForeColor="Black" Font-Underline="True" >Invite Friends</asp:HyperLink></td>
                 <td></td>
                 <td></td>
                 <td></td>
             </tr>
         </table>
         <br /><br /><br /><br /><br />
         <div id="button" style="text-align:center">
                <asp:Button ID="btn_create" CssClass="button" Height="50px" Width="100px" runat="server" Text="Create" ToolTip="Create Event" OnClick="btn_create_Click"/>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cancel" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" ToolTip="Cancel Event" OnClick="btn_cancel_Click"/>
         </div>
     </div>
</asp:Content>
