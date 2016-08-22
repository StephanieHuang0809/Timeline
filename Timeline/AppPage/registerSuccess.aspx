<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="registerSuccess.aspx.cs" Inherits="Timeline.AppPage.registerSuccess" %>
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
    <div style="text-align:center">
    <p style="font-family: 'Comic Sans MS'; font-size:medium; font-weight: 900; color:black">
        &nbsp;</p>
    </div>
    <div style="text-align:center">
        <p style="font-family: 'Comic Sans MS'; font-size:medium; font-weight: 900; color:white">
        Congratulations! You have been registered successfully!</p>
        <br /><br />
        <asp:Button ID="btn_ok" CssClass="button" Height="40px" Width="80px" runat="server" Text="Ok" ToolTip="Ok" OnClick="btn_ok_Click" />
        <br />
    </div>
</asp:Content>
