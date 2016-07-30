<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Timeline.login2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style3 {
            margin-left: 120px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div style="width:400px; margin-left:100px; margin-top:15%;">
    <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate" TitleText="T:meLine" Font-Names="Arial" Font-Size="Medium" ForeColor="White" InstructionTextStyle-HorizontalAlign="Left" UserNameLabelText="Username:" Height="210px" LoginButtonImageUrl="~/Images/login.png" LoginButtonType="Image" Width="280px">
        <InstructionTextStyle HorizontalAlign="Right"></InstructionTextStyle>
        <LoginButtonStyle Font-Names="Arial" BackColor="White" BorderStyle="None" Width="70px" />
        <TextBoxStyle BackColor="White" Width="190px" />
        <TitleTextStyle Font-Bold="True" Font-Names="Comic Sans MS" Font-Size="60px" HorizontalAlign="Center" VerticalAlign="Top" />
        </asp:Login>
    <br />
   <p style="font-family:Arial;color:white">New user? Click <asp:HyperLink ID="hl_register" runat="server" ForeColor="White" NavigateUrl="~/AppPage/register.aspx" Font-Bold="True" Font-Names="Arial" Font-Size="X-Large">here</asp:HyperLink>.
    <br /></p> </div>
</asp:Content>
