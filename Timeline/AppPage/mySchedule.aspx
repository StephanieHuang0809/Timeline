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

.popup {
  margin: auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 100%;
  position: absolute;
  transition: all 5s ease-in-out;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}




.popup .content {
  max-height: 90%;
  overflow: auto;
  text-align:center;
}

#squareFree {
    width:50px;
    height:50px;
    background:#FAAC58;
    margin:auto
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

#our_table th {
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

#our_table tr {
    background: #fff;
    color: #261F1D;
}


 #tbl_menu{
    width:70%;
    border-collapse:collapse;
    table-layout:auto;
    vertical-align:top;
    margin-bottom:15px;
    border:1px solid #999999;
}

#our_table th {
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


/*tr:hover, tr.alt:hover {
    color: #261F1D;
    background-color: #E5C37E;
}*/

.highlighted {
    color: #261F1D;
    background-color: #E5C37E;
}

#our_table tr.alt {
    background: #F5FAFA;
    color: #B4AA9D;
}

#our_table td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    padding: 6px 6px 6px 12px;
}	

.howToUse {
          margin: auto;
          padding: 20px;
          background: #fff;
          border-radius: 5px;
          width: 400px;
          position: absolute;
          transition: all 5s ease-in-out;
          z-index: 300;
          height: 350px;
          left: 200px;
          top: 200px;
          color:black;
      }

  </style>

    <script type="text/javascript" charset="utf-8">
        var isShow = false;

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
	    tableRowCell: ["08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "00:00", "00:30", "01:00", "01:30", "02:00", "03:00", "03:30", "04:00", "04:30", "05:00", "05:30", "06:00", "06:30", "07:00", "07:30"],  /* show the verticle scale */
	    days: [],// this value will be auto set base on start and end date.                                                            /* show the horizal  scale */
	    timeCell: [ /*"06/20/2016 10:00", "06/20/2016 11:00"*/], //this value will be set by ajax call
	    toSave: []
	}

	getTimeCellData = function (startMMddyyyy, endMMddyyyy) {
        var userId = <%=(int)Session["userId"]%>;
	    $.ajax({
	        type: "POST",
	        url: "mySchedule.aspx/GetCurrentTime",
	        data: '{userId: "' + userId + '",startDate: "' + startMMddyyyy + '", endDate:"' + endMMddyyyy + '" }',
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
		
	
      var isMouseDown = false;
      $("#our_table td")
        .mousedown(function () {
            if($('#saveChanges').is(':visible')){
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
		
      $('#btn_save').click(function () {
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

          
             var userId = <%=(int)Session["userId"]%>;
          $.ajax({
              type: "POST",
              url: "mySchedule.aspx/saveTimeCells",
              // data: { timecells: tableData.toSave },
              data: '{userId: "' + userId + '",timecells:' + jsonTimeCellstr + ', startDate: "' + tableData.start + '", endDate:"' + tableData.end  + '"}',
              contentType: "application/json; charset=utf-8",//response
              dataType: "json",//request
              async: false,//sync: so that when data is retrieved, the table is ready to highlight cells
              success: function (response) {
                  alert(response.d);//For testing purpose
                  $('#saveChanges').hide();
              },
              failure: function (response) {
                  alert(response.d);
              }
          });
      });

	});

        function editSchedule() {
            $('#saveChanges').show();
        }

        function cancelEditing() {
            window.location.assign("http://localhost:53349/AppPage/mySchedule.aspx");
            //$('#saveChanges').hide();

        }

        function showHideHowToUse() {
            if(isShow){
                $('#popup').hide();
                isShow = false;
            } else {
                $('#popup').show();
                isShow = true;
            }
        }

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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="image" id="btn_edit" src="../Images/editButtonBlack.png" style="width:70px;height:25px" title="Edit Schedule" onclick="editSchedule(); return false;"/>
    &nbsp;&nbsp;&nbsp;&nbsp; <input type="image" id="btn_howToUse" src="../Images/Help.png" style="width:35px;height:35px" title="How to use?" onclick="showHideHowToUse(); return false;"/>
   <!-- <input type="image" name="img" src="../Images/Help.png"onclick="#popup1"  style="height:35px; width:35px" title="Help"/> -->
&nbsp;<p> &nbsp;</p>


	<div class="howToUse" id="popup" style="text-align:center;display:none;vertical-align:central;margin:auto;">
		<h2 style="color:black">How to Use</h2>
		<a class="close" href="#">&times;</a>
		<div class="content">
            <div id="squareFree"></div>Free Slot<br /><br />
			Click on '<input type="image" disabled="disabled" style="width:70px;height:25px;background-position:bottom"  src="../Images/editButtonBlack.png" /> ', select your free slots by clicking on the relevant time slots and save changes.
		</div><br /><br />
        <input type="button" id="btn_ok" class="button" value="OK" style="width:60px;height:40px" onclick="showHideHowToUse(); return false;"/>

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
			<div id="saveChanges" style ="text-align:center;display:none">
               
                <input id="btn_save" class="button" type="button" value="Save" style="height:50px;width:100px"/>
                &nbsp;&nbsp;&nbsp;
                <input id="btn_cancel" class="button" type="button" value="Cancel" onclick="cancelEditing(); return false;" style="height:50px;width:100px"/>
                <br />
                <br />     
                </div>


</asp:Content>
