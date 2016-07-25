﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="eventList.aspx.cs" Inherits="Timeline.AppPage.eventList" %>
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
      float: right;
      height: 569px;
      left: 0px;
      margin: 70px auto;
      padding: 20px;
      background: #fff;
                 top: 14px;
             }
.okCreated {
       border-radius: 5px;
       width: 200px;
       position: relative;
       transition: all 5s ease-in-out;
       height: 120px;
       z-index: 20;
       visibility: hidden;
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
        $("#<%=this.ddl_region.ClientID%>").selectmenu();
        $("#<%=this.ddl_category.ClientID%>").selectmenu();
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
       Events</p>
    <p>
         <asp:Label ID="lb_intro" runat="server" Text="Select an event from the Event List below: " ForeColor="White" Font-Bold="True" Font-Names="Arial"></asp:Label>
    </p>
     <div id="list_event" style="float:left;width:35%;height:80%;overflow:auto;margin-top:2%">
         <asp:GridView ID="gv_events" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource_Events" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="0px" CellPadding="4" GridLines="Horizontal" Width="100%" ShowHeader="False">
             <Columns>
                 <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" ShowHeader="False" SortExpression="Id" Visible="False">
                 <ControlStyle ForeColor="Black" />
                 </asp:BoundField>
                 <asp:TemplateField HeaderText="Event Name" ShowHeader="False" ItemStyle-Width="45%">
                     <ItemTemplate>
                         <asp:HyperLink ID="hl_events" runat="server" NavigateUrl='<%# "~/AppPage/groupEvent.aspx?id="+Eval("Id") %>' Text='<%# Eval("eventName") %>' ToolTip='<%# "Click to view this event" %>' ForeColor="Black"></asp:HyperLink>
                     </ItemTemplate>
                     <ControlStyle Font-Underline="True" ForeColor="Black" />
                 </asp:TemplateField>
                 <asp:BoundField DataField="eventDateFrom" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Date" ShowHeader="False" SortExpression="eventDateFrom" />
                 <asp:ButtonField ButtonType="Button" Text="Remove" ItemStyle-HorizontalAlign="Right"/>
             </Columns>
             <EmptyDataTemplate>
                 There is no events in the list.
             </EmptyDataTemplate>
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
         <asp:SqlDataSource ID="SqlDataSource_Events" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT E.Id, E.eventName, E.eventDateFrom FROM EVENT_INFO E INNER JOIN EVENT_PARTICIPANTS P ON E.Id = P.eventId INNER JOIN USER_INFO U ON P.userId = U.Id WHERE U.Id = 1"></asp:SqlDataSource>
     </div>
    
     <div id="new_event" class="auto-style4" style="margin-right:5%;margin-top:1%">
         <h2 style="text-align:center;color:black">New Event</h2>
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
         <asp:GridView ID="gv_friends" runat="server" AutoGenerateColumns="False" DataKeyNames="Id,Id1" DataSourceID="SqlDataSource_Friends" Width="100%" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="0px" CellPadding="4" GridLines="Horizontal" ShowHeader="False">
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
         </asp:GridView></div>
         <br />
         <asp:SqlDataSource ID="SqlDataSource_Friends" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT U.Id, U.firstName, U.lastName, U.gender, U.birthday, U.email, U.occupation, F.Id, F.userId, F.userFriendId FROM USER_INFO U INNER JOIN FRIENDS F ON U.Id = F.userFriendId WHERE F.userId = 1" ></asp:SqlDataSource>
         <br /><br />
         <div id="button" style="text-align:center">
                <asp:Button ID="btn_create" CssClass="button" Height="50px" Width="100px" runat="server" Text="Create" ToolTip="Create Event" OnClick="btn_create_Click"/>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cancel" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" ToolTip="Cancel Event" OnClick="btn_cancel_Click"/>
         </div>
          <div id="eventCreated" class="okCreated" style="text-align:center;margin:0 auto;">
               <br /><h3 style="text-align:center">Event is being created !</h3><br />
              <asp:Button ID="btn_okCreated" CssClass="button" Height="40px" Width="80px" runat="server" Text="OK" OnClick="btn_okCreated_Click"/>
          </div>
     </div>
    <div id="suggested_events" class="suggestedEvents" style="margin-right:5%;">
         <h2 style="text-align:center;color:black">Suggested Events</h2>
         <table id="tbl_suggestedEvents" border="0" class="auto-style5">
             <tr><td><asp:Label ID="lb_region" runat="server" Text="Region: "></asp:Label></td>
                 <td><asp:DropDownList ID="ddl_region" runat="server" Width="180px">
                     <asp:ListItem Value="Islandwide">Islandwide</asp:ListItem>
                     <asp:ListItem Value="East">East</asp:ListItem>
                     <asp:ListItem Value="West">West</asp:ListItem>
                     <asp:ListItem Value="South">South</asp:ListItem>
                     <asp:ListItem Value="North">North</asp:ListItem>
                     <asp:ListItem Value="Central">Central</asp:ListItem>
                     </asp:DropDownList></td>
             </tr>
             <tr><td><asp:Label ID="lb_category" runat="server" Text="Category: "></asp:Label></td>
                 <td><asp:DropDownList ID="ddl_category" runat="server" Width="180px">
                     <asp:ListItem Value="Dining">Dining</asp:ListItem>
                     <asp:ListItem Value="Moviews">Movies</asp:ListItem>
                     <asp:ListItem Value="Shopping">Shopping</asp:ListItem>
                     <asp:ListItem Value="Sports">Sports</asp:ListItem>
                     </asp:DropDownList></td>
             </tr>
             <tr><td colspan="2" style="width:100%">
                 <div id="corporateEvents" style="width:100%;height:150px;overflow:scroll">
                 <asp:GridView ID="gv_corporateEvents" runat="server"   DataKeyNames="Id" AutoGenerateColumns="False" 
                     BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="0px" CellPadding="4" 
                     DataSourceID="SqlDataSource_CorporateEvents" GridLines="Horizontal" ShowHeader="False" Width="100%">
                     <Columns>
                         <asp:CommandField ShowSelectButton="True" />
                         <asp:BoundField DataField="name" HeaderText="Corporate Name" SortExpression="name" />
                         <asp:BoundField DataField="eventName" HeaderText="Event Name" SortExpression="eventName" />
                         <asp:BoundField DataField="eventLocation" HeaderText="Location" SortExpression="eventLocation" />
                         <asp:BoundField DataField="locationRegion" HeaderText="Region" SortExpression="locationRegion" Visible="False" />
                         <asp:BoundField DataField="category" HeaderText="Category" SortExpression="category" Visible="False" />
                         <asp:BoundField DataField="Id" HeaderText="Corporate ID" Visible="False" />
                     </Columns>
                     <EmptyDataTemplate>
                         Sorry, no results are found.
                     </EmptyDataTemplate>
                     <FooterStyle BackColor="White" ForeColor="#333333" />
                     <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                     <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                     <RowStyle BackColor="White" ForeColor="#333333" />
                     <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                     <SortedAscendingCellStyle BackColor="#F7F7F7" />
                     <SortedAscendingHeaderStyle BackColor="#487575" />
                     <SortedDescendingCellStyle BackColor="#E5E5E5" />
                     <SortedDescendingHeaderStyle BackColor="#275353" />
                     </asp:GridView></div><br />
                 <asp:DetailsView ID="DetailsView_CorporateEvents" runat="server" Height="50px" Width="100%" 
                     DataKeyNames="Id" AutoGenerateRows="False" DataSourceID="SqlDataSource_Corporates" AllowPaging="True" >
                     <EmptyDataTemplate>
                         Sorry, no results are found.
                     </EmptyDataTemplate>
                     <Fields>
                         <asp:BoundField DataField="name" HeaderText="Corporate:" SortExpression="name" />
                         <asp:HyperLinkField DataNavigateUrlFields="url" DataTextField="eventName" HeaderText="Event: " >
                         <ControlStyle ForeColor="Black" />
                         </asp:HyperLinkField>
                         <asp:BoundField DataField="eventLocation" HeaderText="Location: " SortExpression="eventLocation" />
                         <asp:BoundField DataField="dateFrom" DataFormatString="{0:dd/MM/yyyy}" ApplyFormatInEditMode="true" HeaderText="From: " SortExpression="dateFrom" />
                         <asp:BoundField DataField="dateTo" DataFormatString="{0:dd/MM/yyyy}" ApplyFormatInEditMode="true" HeaderText="To: " SortExpression="dateTo" />
                         <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" Visible="False" />
                         <asp:BoundField DataField="locationRegion" HeaderText="locationRegion" SortExpression="locationRegion" Visible="False" />
                         <asp:BoundField DataField="url" HeaderText="Event Link" SortExpression="url" Visible="False" />
                         <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" Visible="False" />
                         <asp:BoundField DataField="website" HeaderText="Company Website" SortExpression="website" Visible="False" />
                     </Fields>
                 </asp:DetailsView>
                 </td>
             </tr>
         </table>
         <asp:SqlDataSource ID="SqlDataSource_CorporateEvents" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT E.eventName, E.eventLocation, E.locationRegion, E.category, E.dateFrom, E.dateTo, E.url, C.name, C.email, C.website, C.Id  FROM CORPORATE C INNER JOIN CORPORATE_EVENT E ON C.Id = E.userId WHERE E.locationRegion=@region AND E.category=@category">
       <SelectParameters>
		   <%--  <asp:ControlParameter Name="Id" ControlID="gv_corporateEvents" />--%>
           <asp:ControlParameter ControlID="ddl_region" Name="region" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddl_category" Name="category" PropertyName="SelectedValue" Type="String" />
		 </SelectParameters>
         </asp:SqlDataSource>
         <asp:SqlDataSource ID="SqlDataSource_Corporates" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT E.eventName, E.eventLocation, E.locationRegion, E.category, E.dateFrom, E.dateTo, E.url, C.name, C.email, C.website, C.Id  FROM CORPORATE C INNER JOIN CORPORATE_EVENT E ON C.Id = E.userId WHERE C.Id=@CorporateId">
             <SelectParameters>
                 <asp:ControlParameter ControlID="gv_corporateEvents" Name="CorporateId" />
             </SelectParameters>
         </asp:SqlDataSource>
         <br /><br />
         <div style="text-align:center">
                <asp:Button ID="btn_ok" CssClass="button" Height="50px" Width="100px" runat="server" Text="Ok" OnClick="btn_ok_Click" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cancelSuggestion" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" OnClick="btn_cancelSuggestion_Click" />
         </div>
     </div>
</asp:Content>
