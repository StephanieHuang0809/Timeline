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
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica,
        sans-serif;
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
	
    .auto-style1 {
        height: 32px;
    }
    .auto-style2 {
        height: 29px;
    }
	
  </style>
    <script type="text/javascript" charset="utf-8">
  
  var weekday = new Array(7);
	weekday[0]=  "Sun";
	weekday[1] = "Mon";
	weekday[2] = "Tues";
	weekday[3] = "Wed";
	weekday[4] = "Thu";
	weekday[5] = "Fri";
	weekday[6] = "Sat";
  

	var tableData = {
	    year: 2016,
	    month: 6,
	    tableRowCell: ["9:00", "9:30", "10:00", "11:00", "12:00", "13:00", "14:00", "14:30", "15:00", "16:00", "17:00"],  /* show the verticle scale */
	    days: [12, 13, 14, 15, 16, 17, 18, 19, 20, 21],                                                            /* show the horizal  scale */
	    timeCell: { 12: ["9:00", "10:00"], 13: ["12:00"], 14: [], 15: [], 16: [], 17: [], 18: [], 19: [], 20: ["12:00"], 21: ["14:00"] }

	}
  
 
	$(function () {
	    $("#tb_dateFrom2").datepicker();
	    $("#tb_dateFrom").datepicker();
	    $("#dateTo").datepicker();

		/**
		 * highlight a cell by give a date and a time string
		 */
		var setTimeCell=function(day,timeString){
			$("#our_table tr").filter(':first').children().each(function(){
				var $this = $(this);
				if($this.text()==day){
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
		var init = function () {
		    var n = new Date();
		    n.setYear(tableData.year);
		    n.setMonth(tableData.month - 1);
		    $.each(tableData.days, function (index, value) {
		        n.setDate(value);
		        $("#our_table tr").filter(':first').children(':nth-child(' + (index + 2) + ')').text(value + " " + weekday[n.getDay()] + "");
		    })

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
    <p>
        My Schedule</p>

        Date Range:
    <input id="tb_dateFrom2" type="text"/>
        <asp:TextBox ID="tb_dateFrom" runat="server"></asp:TextBox>
&nbsp;<asp:ImageButton ID="btn_dateFrom" runat="server" Height="30px" ImageUrl="~/Images/calendar.png" ToolTip="Pick a date" />
&nbsp;to
        <asp:TextBox ID="tb_dateTo" runat="server"></asp:TextBox>
&nbsp;<asp:ImageButton ID="btn_dateTo" runat="server" Height="30px" ImageUrl="~/Images/calendar.png" ToolTip="Pick a date" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    
        <asp:HyperLink ID="HyperLink1" runat="server">How to use?</asp:HyperLink>
    
    <p>
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
			
			<table id="tbl_menu">
			<tr>
			<th>
				<button id="btn_submit">Submit</button>
			</th>
			</tr>
			
			<tr>
			<th>
                <asp:ImageButton ID="btn_submit0" runat="server" ImageUrl="~/Images/submit.png" Width="100px" OnClick="btn_submit_Click" />
			    <button id="btn_test">ajax test</button>
                <br />
                <br />
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
                         <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                        <asp:HiddenField ID="HiddenFieldYear" runat="server" />
                        <asp:HiddenField ID="HiddenFieldMonth" runat="server" />
                        <asp:HiddenField ID="HiddenFieldTableRowCell" runat="server" />
                        <asp:HiddenField ID="HiddenFieldDays" runat="server" />
                        <asp:HiddenField ID="HiddenFieldTimeCell" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
               
			</th>
			</tr>
			
			</table>
</asp:Content>
