<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Timeline.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <p>
        <br />
    </p>
   
    <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate">
    </asp:Login>
    <br />
    New user? Click here
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/register.aspx">here</asp:HyperLink>
    .
</asp:Content>
