<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="mySchedule.aspx.cs" Inherits="Timeline.mySchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--    <script   src="https://code.jquery.com/jquery-3.0.0.js"   integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="   crossorigin="anonymous"></script>-->
  <style type="text/css" media="screen">
  /*Button Style*/
      @import "compass/css3";
 /*Popup window style*/
 h1 {
  text-align: center;
  font-family: Tahoma, Arial, sans-serif;
  color: #06D85F;
  margin: 80px 0;
}

.box {
  width: 15%;
  margin: 0 auto;
  background: rgba(255,255,255,0.2);
  padding: 15px;
  border: 2px solid #fff;
  border-radius: 20px/50px;
  background-clip: padding-box;
  text-align: center;
}

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

.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0;
}
.overlay:target {
  visibility: visible;
  opacity: 1;
}

.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30%;
  position: relative;
  transition: all 5s ease-in-out;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .close {
  position: absolute;
  top: 20px;
  right: 30px;
  transition: all 200ms;
  font-size: 30px;
  font-weight: bold;
  text-decoration: none;
  color: #333;
}
.popup .close:hover {
  color: #06D85F;
}
.popup .content {
  max-height: 30%;
  overflow: auto;
}

@media screen and (max-width: 700px){
  .box{
    width: 10%;
  }
  .popup{
    width: 70%;
  }
}

#squareFree {
    width:50px;
    height:50px;
    background:#FAAC58;
}

/*Table style*/
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
        var isEditing = false;

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
	    tableRowCell: ["08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:00", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00", "01:30", "02:00", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30"],  /* show the verticle scale */
	    days: [],// this value will be auto set base on start and end date.                                                            /* show the horizal  scale */
	    timeCell: [ /*"06/20/2016 10:00", "06/20/2016 11:00"*/], //this value will be set by ajax call
	    toSave: []
	}

	getTimeCellData = function (startMMddyyyy, endMMddyyyy) {
	    $.ajax({
	        type: "POST",
	        url: "mySchedule.aspx/GetCurrentTime",
	        data: '{name: "stephanie",startDate: "' + startMMddyyyy + '", endDate:"' + endMMddyyyy + '" }',
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: false,
	        success: function (response) {
	           // alert(response.d);
	            var obj = eval("(" + response.d + ')'); //response.d : a string returned by GetCurrentTime() //eval: to convert string to obj
	            tableData.timeCell = obj;
	           // alert("ajax: "+tableData.timeCell);
	        },
	        failure: function (response) {
	            alert(response.d);
	        }
	    });
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

		    getTimeCellData(tableData.start, tableData.end);
		    var timecells = tableData.timeCell;
		    // alert("timecells:" + timecells);
		    $.each(timecells, function (index, value) {
		        var arr = value.split(" ");
		        setTimeCell(arr[0], arr[1]);
		    }
		    );
		}();
		
	 $('#<%= btn_edit.ClientID %>').click(function () {
            isEditing = true;
        });

         $('#<%= btn_view.ClientID %>').click(function () {
            isEditing = false;
        });
	
      var isMouseDown = false;
      $("#our_table td")
        .mousedown(function () {
            if (isEditing == true) {
                isMouseDown = true;
                $(this).toggleClass("highlighted");
            }
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
		
      $('#btn_submit_test').click(function () {
          tableData.toSave = [];
          //For each highlighted cell, add it to tableData
          $(".highlighted").each(function () {
              var time = $(this).siblings().filter(':first').text();
              var col_index = $(this).index() + 1;
              var day = $(this).parent().siblings().filter(':first').children(':nth-child(' + col_index + ')').text().substring(0, 10);
              var selectedDatetime = day + " " + time;
              tableData.toSave.push(selectedDatetime);
          });
          //Convert javascrip object (tableData.toSave) to string (JSON)
          var jsonTimeCellstr = JSON.stringify(tableData.toSave);
          alert(jsonTimeCellstr);
          $.ajax({
              type: "POST",
              url: "mySchedule.aspx/saveTimeCells",
              // data: { timecells: tableData.toSave },
              data: '{timecells:' + jsonTimeCellstr + '}',
              contentType: "application/json; charset=utf-8",//response
              dataType: "json",//request
              async: false,//sync: so that when data is retrieved, the table is ready to highlight cells
              success: function (response) {
                  alert(response.d);//For testing purpose
              },
              failure: function (response) {
                  alert(response.d);
              }
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

        $('#<%= btn_howToUse.ClientID %>').click(function () {
            alert("Hello");
            $('#popup1').show();
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
   <!-- <input type="button" id="btn_test" value="Test" />-->
    
&nbsp;<asp:ImageButton ID="btn_view" runat="server" Height="25px" ImageUrl="~/Images/view.png" ToolTip="View Selected Dates" BorderStyle="None" ImageAlign="AbsBottom" OnClick="btn_view_Click" />
&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btn_edit" runat="server" Height="25px" ImageAlign="AbsBottom" ImageUrl="~/Images/editButtonBlack.png" OnClick="btn_edit_Click" ToolTip="Edit Schedule" />
    &nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="btn_howToUse" runat="server" Height="35px" ImageAlign="AbsBottom" ImageUrl="~/Images/Help.png" ToolTip="Help"  />
   <!-- <input type="image" name="img" src="../Images/Help.png"onclick="#popup1"  style="height:35px; width:35px" title="Help"/> -->
&nbsp;<p> &nbsp;</p>

<div id="popup1" class="overlay">
	<div class="popup" style="text-align:center">
		<h2>How to Use</h2>
		<a class="close" href="#">&times;</a>
		<div class="content">
            <div id="squareFree"></div>Free Slot<br />
			Select your free slots by clicking on the relevant time slots.
		</div>
	</div>
</div>
       
<div style="float:left">
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
    </div>
			<div id="saveChanges" runat="server" style ="text-align:center">

                <asp:Button ID="btn_save" CssClass="button" Height="50px" Width="100px" runat="server" Text="Save" OnClick="btn_save_Click" ToolTip="Save Changes"/>
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_cance" CssClass="button" Height="50px" Width="100px" runat="server" Text="Cancel" OnClick="btn_cancel_Click" ToolTip="Cancel Changes"/>
                <br />
                <br />
                <input id="btn_submit_test" type="button" class="btn-big-red" value="Save" />
                </div>
</asp:Content>
