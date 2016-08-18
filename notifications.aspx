<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="Timeline.AppPage.notifications" %>
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

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        Notifications</p>
    <div id="notifications" style="overflow:auto;height:50%">

        <asp:GridView ID="gv_notificationList" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource_notifications">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" Visible="False" />
                <asp:BoundField DataField="targetUserId" HeaderText="targetUserId" SortExpression="targetUserId" Visible="False" />
                <asp:BoundField DataField="scope" HeaderText="scope" SortExpression="scope" Visible="False" />
                <asp:BoundField DataField="type" HeaderText="Type" SortExpression="type" />
                <asp:BoundField DataField="message" HeaderText="Message" SortExpression="message" />
                <asp:BoundField DataField="date" HeaderText="Date" SortExpression="date" />
                <asp:HyperLinkField DataNavigateUrlFields="link" DataTextField="link" HeaderText="Link">
                <ControlStyle Font-Underline="True" ForeColor="Black" />
                </asp:HyperLinkField>
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
        <asp:SqlDataSource ID="SqlDataSource_notifications" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [targetUserId], [scope], [type], [message], [date], [link] FROM [NOTIFICATIONS]"></asp:SqlDataSource>

    </div>
</asp:Content>
