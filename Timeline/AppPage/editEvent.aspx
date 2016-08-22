<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="editEvent.aspx.cs" Inherits="Timeline.AppPage.editEvent" %>
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
.auto-style2 {
      width: 85%;
}
.auto-style4 {
      border-radius: 5px;
      width: 40%;
      position: relative;
      transition: all 5s ease-in-out;
      float: left;
      height: 569px;
      left: 0px;
      margin: 70px auto;
      padding: 20px;
      background: #fff;
                 top: 14px;
             }
.okUpdated {
       border-radius: 5px;
       width: 200px;
       position: relative;
       transition: all 5s ease-in-out;
       height: 120px;
       z-index: 20;
       visibility: visible;
       left: 8px;
       top: -398px;
       margin: 70px auto;
       padding: 20px;
       background: #fff;
             }
             
           
.suggestedEvents {
                 border-radius: 5px;
                 width: 40%;
                 position: relative;
                 transition: all 5s ease-in-out;
                 float: right;
                 height: 562px;
                 z-index: 10;
                 visibility:visible;
                 left: 244px;
                 top: -130px;
                 margin: 70px auto;
                 padding: 20px;
                 background: #fff;
             }
             
             .auto-style5 {
                 width: 100%;
             }
             
         </style>

<script type="text/javascript" charset="utf-8">
    $(function () {
        $("#<%=this.tb_dateFrom.ClientID%>").datepicker();
        $("#<%=this.tb_dateTo.ClientID%>").datepicker();
         });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div id="new_event" class="auto-style4" style="margin-left:5%;margin-top:1%">
         <h2 style="text-align:center;color:black">Edit Event</h2>
         <table id="tbl_newEvent" border="0" class="auto-style2">
             <tr><td><asp:Label ID="lb_name" runat="server" Text="Name: "></asp:Label></td>
                 <td><asp:TextBox ID="tb_name" runat="server"></asp:TextBox></td>
                 <td colspan="2"><asp:HyperLink ID="hl_suggestedEvents" runat="server" ForeColor="Black" Font-Underline="True">Suggested Events?</asp:HyperLink></td>
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
             <tr><td style="width:15%"><asp:Label ID="lb_timeFrom" runat="server" Text="Time From: "></asp:Label></td>
                 <td style="width:20%"><asp:TextBox ID="tb_timeFrom" runat="server"></asp:TextBox></td>
                 <td style="width:10px"><asp:Label ID="lb_timeTo" runat="server" Text=" To "></asp:Label></td>
                 <td style="width:20%"><asp:TextBox ID="tb_timeTo" runat="server"></asp:TextBox></td>
             </tr>
             <tr>
                 <td>Status: </td>
                 <td>
                     <asp:DropDownList ID="ddl_status" runat="server">
                         <asp:ListItem>Pending</asp:ListItem>
                         <asp:ListItem>Confirmed</asp:ListItem>
                     </asp:DropDownList>
                 </td></tr>
             <tr><td>&nbsp;</td></tr>
         </table>
          <h4>Select from the list below to invite friends: </h4>
         <div style ="height:150px;width:65%;overflow:auto;">
         <asp:GridView ID="gv_friends" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,Id1" 
             DataSourceID="SqlDataSource_Friends" Width="100%" BackColor="White" BorderColor="#336666" 
             BorderStyle="Double" BorderWidth="0px" CellPadding="4" GridLines="Horizontal" 
             ShowHeader="False" >
             <Columns>
                 <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                 <asp:TemplateField HeaderText="Name" SortExpression="firstName">
                     <ItemTemplate>
                         <asp:Label ID="lb_firstName" runat="server" Text='<%# Eval("firstName") %>'></asp:Label>
                         &nbsp;<asp:Label ID="lb_lastName" runat="server" Text='<%# Eval("lastName") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField ItemStyle-Width="30%" ItemStyle-HorizontalAlign="Right">
                     <ItemTemplate>
                         <asp:CheckBox ID="cb_select" runat="server" />
                     </ItemTemplate>

<ItemStyle HorizontalAlign="Right" Width="30%"></ItemStyle>
                 </asp:TemplateField>
                 <asp:TemplateField Visible="True">
                     <ItemTemplate>
                         <asp:HiddenField ID="hf_friendId" runat="server" Value='<%# Eval("Id") %>' />
                     </ItemTemplate>
                 </asp:TemplateField>
             </Columns>
             <FooterStyle BackColor="White" ForeColor="#333333" />
             <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
             <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
             <RowStyle BackColor="White" ForeColor="#333333" />
             <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
             <SortedAscendingCellStyle BackColor="#F7F7F7" />
             <SortedAscendingHeaderStyle BackColor="#487575" />
             <SortedDescendingCellStyle BackColor="#E5E5E5" />
             <SortedDescendingHeaderStyle BackColor="#275353" />
            </asp:GridView>
             <asp:HiddenField ID="hf_friendId" runat="server" Value='<%# Eval("Id") %>' />
         </div>
             <asp:HiddenField ID="hf_eventId" runat="server" />
         <br />
         <asp:SqlDataSource ID="SqlDataSource_Friends" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT U.Id, U.firstName, U.lastName, U.gender, U.birthday, U.email, U.occupation, F.Id, F.userId, F.userFriendId FROM USER_INFO U INNER JOIN FRIENDS F ON U.Id = F.userFriendId WHERE F.userId = @userId" >
             <SelectParameters>
                 <asp:SessionParameter Name="userId" SessionField="userId" />
             </SelectParameters>
         </asp:SqlDataSource>
         <br /><br />
         <div id="button" style="text-align:center">
                <asp:Button ID="btn_save" CssClass="button" Height="50px" Width="100px" runat="server" Text="Save" ToolTip="Save" OnClick="btn_save_Click" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cancel" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" ToolTip="Cancel Event" OnClick="btn_cancel_Click"/>
         </div>

         <!--<div id="eventUpdated" class="okUpdated" style="text-align:center;margin:0 auto;">
               <br /><h3 style="text-align:center">Event is being updated !</h3><br />
              <asp:Button ID="btn_okUpdated" CssClass="button" Height="40px" Width="80px" runat="server" Text="OK"/>
          </div>-->
     </div>
</asp:Content>
