<%@ Page Title="" Language="C#" MasterPageFile="~/AfterCorporateLogin.master" AutoEventWireup="true" CodeBehind="corporateProfile.aspx.cs" Inherits="Timeline.AppPage.corporateProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        Corporate Profile</p>
     <div id="profile" style="float:left;width:45%;height:50%;overflow:auto;margin-top:1%">
         <asp:DetailsView ID="dv_profile" runat="server" Height="50px" Width="200px" AutoGenerateRows="False" 
             BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" 
             DataKeyNames="Id" DataSourceID="SqlDataSource_profile" GridLines="Horizontal" AutoGenerateEditButton="True">
             <EditRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
             <Fields>
                 <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" Visible="False" />
                 <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name">
                 <HeaderStyle Font-Bold="True" />
                 </asp:BoundField>
                 <asp:TemplateField HeaderText="Email" SortExpression="email">
                     <EditItemTemplate>
                         <asp:TextBox ID="tb_email" runat="server" Text='<%# Bind("email") %>' TextMode="Email"></asp:TextBox>
                     </EditItemTemplate>
                     <InsertItemTemplate>
                         <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                     </InsertItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="lb_email" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                     </ItemTemplate>
                     <HeaderStyle Font-Bold="True" />
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Website" SortExpression="website">
                     <EditItemTemplate>
                         <asp:TextBox ID="tb_website" runat="server" Text='<%# Bind("website") %>' TextMode="Url"></asp:TextBox>
                     </EditItemTemplate>
                     <InsertItemTemplate>
                         <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("website") %>'></asp:TextBox>
                     </InsertItemTemplate>
                     <ItemTemplate>
                         <asp:HyperLink ID="hl_website" runat="server" NavigateUrl='<%# Eval("website") %>' Text='<%# Eval("website") %>'></asp:HyperLink>
                     </ItemTemplate>
                     <ControlStyle Font-Underline="True" ForeColor="Black" />
                     <HeaderStyle Font-Bold="True" />
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="Password" SortExpression="password">
                     <EditItemTemplate>
                         <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("password") %>' TextMode="Password"></asp:TextBox>
                     </EditItemTemplate>
                     <InsertItemTemplate>
                         <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("password") %>'></asp:TextBox>
                     </InsertItemTemplate>
                     <ItemTemplate>
                         <asp:TextBox ID="tb_password" runat="server" ReadOnly="True" Text='<%# Eval("password") %>' TextMode="Password"></asp:TextBox>
                     </ItemTemplate>
                     <ControlStyle ForeColor="Black" />
                     <HeaderStyle Font-Bold="True" />
                 </asp:TemplateField>
                 <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" Visible="False" />
             </Fields>
             <FooterStyle BackColor="White" ForeColor="#333333" />
             <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
             <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
             <RowStyle BackColor="White" ForeColor="#333333" />
         </asp:DetailsView>
         <asp:SqlDataSource ID="SqlDataSource_profile" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Id], [name], [email], [website], [password], [username] FROM [CORPORATE] WHERE ([Id] = @Id)" UpdateCommand="UPDATE CORPORATE SET name=@name, email=@email, website=@website, password=@password WHERE Id=@Id; ">
             <SelectParameters>
                 <asp:SessionParameter DefaultValue="1" Name="Id" SessionField="userId" Type="Int32" />
             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="name" />
                 <asp:Parameter Name="email" />
                 <asp:Parameter Name="website" />
                 <asp:Parameter Name="password" />
                 <asp:Parameter Name="Id" />
             </UpdateParameters>
         </asp:SqlDataSource>
         
     </div>
</asp:Content>
