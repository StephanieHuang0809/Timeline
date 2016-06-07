<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Timeline.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; font-style: normal; font-variant: normal; text-align: justify; color: #000000;">
    <%--T:meLine<br />--%>
</p>
<p>
    <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate">
    </asp:Login>
</p>
    <p>
        New user? Click
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/register.aspx">here</asp:HyperLink>
        .</p>
</asp:Content>
