<%@ Page Title="" Language="C#" MasterPageFile="~/Root.Master" AutoEventWireup="true" CodeBehind="mySchedule.aspx.cs" Inherits="Timeline.mySchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--    <script   src="https://code.jquery.com/jquery-3.0.0.js"   integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="   crossorigin="anonymous"></script>-->
  <style type="text/css" media="screen">
 #our_table{
    width:70%;
    border-collapse:collapse;
    table-layout:auto;
    vertical-align:top;
    margin-bottom:15px;
    border:1px solid #999999;
}

 #tbl_menu{
    width:70%;
    border-collapse:collapse;
    table-layout:auto;
    vertical-align:top;
    margin-bottom:15px;
    border:1px solid #999999;
}


th {
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica,sans-serif;
    color: #F2EDEB;
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: left;
    padding: 6px 6px 6px 12px;
    background: #522D25 url(images/bg_header.jpg) no-repeat;
}

tr {
    background: #fff;
    color: #261F1D;
}

/*tr:hover, tr.alt:hover {
    color: #261F1D;
    background-color: #E5C37E;
}*/

.highlighted {
    color: #261F1D;
    background-color: #E5C37E;
}

tr.alt {
    background: #F5FAFA;
    color: #B4AA9D;
}

td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    padding: 6px 6px 6px 12px;
}	
    </style>

    <script type="text/javascript" charset="utf-8">

        function stringToDate(_date, _format, _delimiter) {
            var formatLowerCase = _format.toLowerCase();
            var formatItems = formatLowerCase.split(_delimiter);
            var dateItems = _date.split(_delimiter);
            var monthIndex = formatItems.indexOf("mm");
            var dayIndex = formatItems.indexOf("dd");
            var yearIndex = formatItems.indexOf("yyyy");
            var month = parseInt(dateItems[monthIndex]);
            month -= 1;
            var formatedDate = new Date(dateItems[yearIndex], month, dateItems[dayIndex]);
            return formatedDate;
        }
  
  var weekday = new Array(7);
	weekday[0]=  "Sun";
	weekday[1] = "Mon";
	weekday[2] = "Tues";
	weekday[3] = "Wed";
	weekday[4] = "Thu";
	weekday[5] = "Fri";
	weekday[6] = "Sat";
  
       


	var tableData = {
	    //start://startDateStr will replace by selected value
	    //end: //will replace by selected value
	    tableRowCell: ["08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:00", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00", "01:30", "02:00", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30",  "06:00","06:30", "07:00", "07:30"],  /* show the verticle scale */
	    days: [],// this value will be auto set base on start and end date.                                                            /* show the horizal  scale */
	    timeCell: {  }
	}
  
 
	$(function () {
	    $("#<%=this.tb_dateFrom.ClientID%>").datepicker();
	    $("#<%=this.tb_dateTo.ClientID%>").datepicker();

        var inputStart = $("#<%=this.tb_dateFrom.ClientID%>").val();
	    var inputEnd = $("#<%=this.tb_dateTo.ClientID%>").val();

	    if (inputStart == "") {

	        tableData.start = $.datepicker.formatDate('mm/dd/yy', new Date());
	    } else {
	        tableData.start = inputStart;
	    }

	    if (inputEnd == "") {
	        var endtmp = new Date();
	        endtmp.setDate(endtmp.getDate() + 7);
	        tableData.end = $.datepicker.formatDate('mm/dd/yy', endtmp);
	    } else {
	        tableData.end = inputEnd;
	    }

	    //caculate tableData.days
	    var startDt = stringToDate(tableData.start, "MM/dd/yyyy", "/");
	    var endDt = stringToDate(tableData.end, "MM/dd/yyyy", "/");

	    var dti = startDt;
	    while (dti <= endDt) {
	        tableData.days.push($.datepicker.formatDate('mm/dd/yy', dti));
	        dti.setDate(dti.getDate() + 1);
	        // alert(dti.getDate());
	    }


		/**
		 * highlight a cell by give a date and a time string
		 */
		var setTimeCell=function(day,timeString){
			$("#our_table tr").filter(':first').children().each(function(){
				var $this = $(this);
				if($this.text().substring(0,10)==day){
					var columnIndex = $this.index();
					$("#our_table tr").each(function(){
						$this = $(this);
						var firstCellString = $this.find('th').text();
						if(firstCellString==timeString){
							var rowIndex = $this.index();
							$this.children(':nth-child('+(columnIndex+1)+')').toggleClass("highlighted");
						}
					});
				}
			});
		}
	
		function drawTable() {
		    var titleRowHtml = "<th></th>";
		    var bodyRowHtml = "<th></th>";
		    $.each(tableData.days, function (index, value) {
		        titleRowHtml += "<th></th>";
		        bodyRowHtml += "<td></td>"
		    })

		    $("#our_table").append("<tr>" + titleRowHtml + "</tr>");
		    for (var i = 0; i < tableData.tableRowCell.length; i++) {
		        if (i % 2 == 0) {
		            $("#our_table").append("<tr  class=\"\">" + bodyRowHtml + "</tr>");
		        } else {
		            $("#our_table").append("<tr  class=\"alt\">" + bodyRowHtml + "</tr>");
		        }
		    }
		};

		drawTable();

		function drawTimeLabel() {
		    $('#our_table tr th:first-child').each(function (index, value) {
		        if (index > 0) {
		            $(this).text(tableData.tableRowCell[index - 1]);
		        }
		    });
		}

		drawTimeLabel();
		var init = function () {//initialise title
		    $.each(tableData.days, function (index, value) {
		        var vDt = $.datepicker.parseDate('mm/dd/yy', value);
		        $("#our_table tr").filter(':first').children(':nth-child(' + (index + 2) + ')').text(value + " " + weekday[vDt.getDay()] + "");
		    }) //first:first row; children:each cell in table

            //highlight cell
		    var timecells = tableData.timeCell;
		    $.each(timecells, function (key, value) {
		        if (value.length > 0) {
		            $.each(value, function () {
		                setTimeCell(key, this);
		            });
		        }
		    })
		}();
		
	
	
      var isMouseDown = false;
      $("#our_table td")
        .mousedown(function () {
          isMouseDown = true;
          $(this).toggleClass("highlighted");
          return false; // prevent text selection
        })
        .mouseover(function () {
          if (isMouseDown) {
            $(this).toggleClass("highlighted");
          }
        })
        .bind("selectstart", function () {
          return false; // prevent text selection in IE
        });
      $(document)
        .mouseup(function () {
          isMouseDown = false;
        });
		
		$('#btn_submit').click(function(){
			 $( ".highlighted" ).each(function() {		
				   var time = $(this).siblings().filter(':first').text();
				   var col_index = $(this).index()+1;
				   var day=$(this).parent().siblings().filter(':first').children(':nth-child('+col_index+')').text();
					
				   var selectedDatetime = day + "/" + tableData.month + " " + time;
					alert(selectedDatetime);
                });
		});

		function updateTimeTable(data){
		    alert(data.d);
		    return false;
		}

       

        function OnSuccess(response) {
            alert(response.d);
        }

		$('#btn_test').click(function () {
		    $.ajax({
        type: "POST",
        url: "mySchedule.aspx/GetCurrentTime",
        data: '{name: "jifen" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: updateTimeTable,
        failure: function(response) {
            alert(response.d);
        }
    });


		});

		
    });
  </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p style="font-family: 'Comic Sans MS'; font-size: xx-large; font-weight: 900; color: #FFFFFF">
        My Schedule</p>

       <asp:Label ID="lb_dateFrom" runat="server" Text=" Date From" ForeColor="White" Font-Bold="True" Font-Names="Arial"></asp:Label>
   
        <asp:TextBox ID="tb_dateFrom" runat="server" Height="25px" ToolTip="Click to select start date"></asp:TextBox>
&nbsp;&nbsp;<asp:Label ID="lb_dateTo" runat="server" Text="To" Font-Names="Arial" ForeColor="White" Font-Bold="True"></asp:Label>
&nbsp;
        <asp:TextBox ID="tb_dateTo" runat="server" Height="25px" ToolTip="Click to select end date"></asp:TextBox>
    <input type="button" id="btn_test" value="Test" />
    
&nbsp;<asp:ImageButton ID="btn_view" runat="server" Height="25px" ImageUrl="~/Images/view.png" ToolTip="View Selected Dates" BorderStyle="None" ImageAlign="AbsBottom" OnClick="btn_view_Click" />
&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btn_edit" runat="server" Height="25px" ImageAlign="AbsBottom" ImageUrl="~/Images/editButtonBlack.png" OnClick="btn_edit_Click" ToolTip="Edit Schedule" />
    &nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btn_howToUse" runat="server" Height="35px" ImageAlign="AbsBottom" ImageUrl="~/Images/Help.png" ToolTip="Help" />
&nbsp;<p>
        &nbsp;</p>

        <table id="our_table" border="0">
			<!--<tr>
			<th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th><th class="auto-style2"></th>
			</tr>
			<tr class="">
			<th>9:00</th>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			</tr>
			
			<tr class="alt">
			<th class="auto-style1">10:00</th>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			<td class="auto-style1"></td>
			</tr> -->
			</table>
			<div id="saveChanges" runat="server" style ="text-align:center">
			<table id="tbl_menu">	
			<tr>
			<th>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btn_submit" runat="server" ImageUrl="~/Images/save.png"  OnClick="btn_submit_Click"  ImageAlign="AbsBottom" ToolTip="Save Changes" Visible="true" Height="30px" Width="80px"/>
                &nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btn_cancel" runat="server"  ImageAlign="AbsBottom" ImageUrl="~/Images/cancel.png" OnClick="btn_cancel_Click" ToolTip="Cancel Changes" Visible="true" Height="30px" Width="80px" />
                <br />
                <br />     
			</th>
			</tr>
			</table>
                </div>
</asp:Content>
