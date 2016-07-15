<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="groupEvent.aspx.cs" Inherits="Timeline.AppPage.groupEvent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" media="screen">

    </style>
    <script type="text/javascript" charset="utf-8">
    $(function () {
        $("#<%=this.tb_dateFrom.ClientID%>").datepicker();
	    $("#<%=this.tb_dateTo.ClientID%>").datepicker();
    })
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-family: 'Comic Sans MS'; font-size:medium; font-weight: 900; color: #FFFFFF">
       Event: <asp:label runat="server"></asp:label></p>
    <br />
    <asp:Label ID="lb_dateFrom" runat="server" Text=" Date From" ForeColor="White" Font-Bold="True" Font-Names="Arial"></asp:Label>
   
        <asp:TextBox ID="tb_dateFrom" runat="server" Height="25px" ToolTip="Click to select start date"></asp:TextBox>
&nbsp;&nbsp;<asp:Label ID="lb_dateTo" runat="server" Text="To" Font-Names="Arial" ForeColor="White" Font-Bold="True"></asp:Label>
&nbsp;
    <asp:TextBox ID="tb_dateTo" runat="server" Height="25px" ToolTip="Click to select end date"></asp:TextBox>
&nbsp;<asp:ImageButton ID="btn_view" runat="server" Height="25px" ImageUrl="~/Images/view.png" ToolTip="View Selected Dates" BorderStyle="None" ImageAlign="AbsBottom" OnClick="btn_view_Click" />
    <br />
    <div id="groupSchedule">

    </div>
    <br />
    <div id="chat">

    </div>
</asp:Content>
