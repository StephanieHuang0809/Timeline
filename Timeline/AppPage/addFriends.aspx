<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="addFriends.aspx.cs" Inherits="Timeline.AppPage.addFriends" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        Manage Friends</p>
    <asp:GridView ID="gv_friends" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#487575" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#275353" />
</asp:GridView><br />
    <asp:SqlDataSource ID="SqlDataSource_friends" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [firstName], [lastName], [gender], [birthday], [email], [occupation] FROM [USER_INFO] WHERE ([Id] = @Id)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="Id" SessionField="userId" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    <asp:DetailsView ID="dv_friends" runat="server" Height="50px" Width="125px"></asp:DetailsView>
</asp:Content>
