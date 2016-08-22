<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="addFriends.aspx.cs" Inherits="Timeline.AppPage.addFriends" %>
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
            margin-right: 0px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        Manage Friends</p>
    <p>
        <asp:TextBox ID="tb_search" runat="server" Height="35px"></asp:TextBox><asp:Button ID="btn_searchFriend" runat="server" CssClass="button" Text="Search" OnClick="btn_searchFriend_Click" Width="100px" Height="40px"/></p>
       <div id="resultList" style="overflow:auto;height:30%">
           <asp:GridView ID="gv_searchResults" runat="server"  BackColor="White" BorderColor="#336666" 
               BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal"
                AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource_searchFriend" 
               OnSelectedIndexChanged="gv_searchResults_SelectedIndexChanged">
               <Columns>
                   <asp:TemplateField>
                       <ItemTemplate>
                           <asp:HiddenField ID="Hf_Id" runat="server" Value='<%# Eval("Id") %>' />
                       </ItemTemplate>
                   </asp:TemplateField>
                   <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Add" />
                   <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                   <asp:BoundField DataField="firstName" HeaderText="First Name" SortExpression="firstName">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
                   <asp:BoundField DataField="lastName" HeaderText="Last Name" SortExpression="lastName">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
                   <asp:BoundField DataField="gender" HeaderText="Gender" SortExpression="gender">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
                   <asp:BoundField DataField="birthday" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Birthday" SortExpression="birthday">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
                   <asp:BoundField DataField="occupation" HeaderText="Occupation" SortExpression="occupation">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
                   <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email">
                   <HeaderStyle Font-Bold="True" />
                   </asp:BoundField>
               </Columns>
               <EmptyDataTemplate>
                   Sorry, no results found!
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
           <asp:SqlDataSource ID="SqlDataSource_searchFriend" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [firstName], [lastName], [gender], [birthday], [email], [occupation] FROM [USER_INFO] 
WHERE 
(firstName LIKE '%' + @name + '%') or (lastName LIKE '%' + @name + '%')  or email=@name">
               <SelectParameters>
                   <asp:ControlParameter ControlID="tb_search" Name="name" PropertyName="Text" />
               </SelectParameters>
           </asp:SqlDataSource>
       </div><br /><br />
    <asp:GridView ID="gv_friendRequests" runat="server" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" AutoGenerateColumns="False" CssClass="auto-style1" DataKeyNames="Id" DataSourceID="SqlDataSource_friendRequests" OnSelectedIndexChanged="gv_friendRequests_SelectedIndexChanged" OnRowCommand="gv_friendRequests_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="hf_requestId" runat="server" Value='<%# Eval("Id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="btn_accept" runat="server" CausesValidation="false" CommandName="accept" Text="Accept" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="btn_ignore" runat="server" CausesValidation="false" CommandName="ignore" Text="Ignore" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField></asp:TemplateField>
            
            <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
            <asp:BoundField DataField="requestType" HeaderText="requestType" SortExpression="requestType" Visible="False" />
            <asp:BoundField DataField="name" HeaderText="Request From" SortExpression="requestFrom" />
            <asp:BoundField DataField="requestTo" HeaderText="requestTo" SortExpression="requestTo" Visible="False" />
            <asp:BoundField DataField="requestDate" DataFormatString="{0:MM/dd/yyyy}" HeaderText="Request Date" SortExpression="requestDate" />
            <asp:BoundField DataField="approvalDate" HeaderText="approvalDate" SortExpression="approvalDate" Visible="False" />
            <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" Visible="False" />
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
</asp:GridView><br />
    <asp:SqlDataSource ID="SqlDataSource_friendRequests" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT R.Id, R.requestType, R.requestFrom, R.requestTo, R.requestDate, R.approvalDate, R.status, U.firstName+' ' + U.lastName as name FROM [REQUESTS] R INNER JOIN USER_INFO U ON R.requestFrom = U.Id WHERE (([requestTo] = @requestTo) AND ([status] = 'PENDING'))">
        <SelectParameters>
            <asp:SessionParameter Name="requestTo" SessionField="userId" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    </asp:Content>
