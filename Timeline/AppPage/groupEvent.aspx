<%@ Page Title="" Language="C#" MasterPageFile="~/AfterLogin.Master" AutoEventWireup="true" CodeBehind="groupEvent.aspx.cs" Inherits="Timeline.AppPage.groupEvent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" media="screen">
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

 #tbl_menu{
    width:70%;
    border-collapse:collapse;
    table-layout:auto;
    vertical-align:top;
    margin-bottom:15px;
    border:1px solid #999999;
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

.event_info{
    border-collapse:collapse;
    font-family:Comic Sans MS;
    font-size:large;
    font-weight:900;
    background-color:transparent;
    width:40%;
}

.event_info td{
    color:white;
}

.auto-style2 {
            width: 155px;
        }

#tbl_chatlogs{
    width:70%;
    height:auto;
    border-collapse:collapse;
    table-layout:auto;
    vertical-align:top;
    margin-bottom:15px;
    border:1px solid #999999;
}

#tbl_chatlogs th {
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

#tbl_chatlogs tr {
    background: #fff;
    color: #261F1D;
}

#tbl_chatlogs tr.alt {
    background: #F5FAFA;
    color: #B4AA9D;
}

#tbl_chatlogs td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    padding: 6px 6px 6px 12px;
}	
    </style>

  <script type="text/javascript" charset="utf-8">

       var glb_groupId = <%=Request.QueryString["id"]%>;
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
	    timeCell: [], //"[{\"userId\":1,\"cell\":\"07/11/2016 10:00\",\"colorCode\":\"FFDDFF\",\"userName\":\"Stephanie Huang\"},{\"userId\":1,\"cell\":\"07/11/2016 10:30\",\"colorCode\":\"FFDDFF\",\"userName\":\"Stephanie Huang\"},{\"userId\":1,\"cell\":\"07/11/2016 11:00\",\"colorCode\":\"FFDDFF\",\"userName\":\"Stephanie Huang\"}]"this value will be set by ajax call
        toSave:[]
	}

	function getDateFromAspString(aspString) {
	    var epochMilliseconds = aspString.replace(
            /^\/Date\(([0-9]+)([+-][0-9]{4})?\)\/$/,
            '$1');
	    if (epochMilliseconds != aspString) {
	        return new Date(parseInt(epochMilliseconds));
	    }
	}
   
	getTimeCellData = function (startMMddyyyy, endMMddyyyy) {
	    //alert(glb_groupId);
	    $.ajax({
	        type: "POST",
	        url: "groupEvent.aspx/GetCurrentTime",
	        data: '{groupId: "'+glb_groupId+'",startDate: "'+startMMddyyyy+'", endDate:"'+endMMddyyyy+'" }',
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: false,
	        success: function (response) {
	            var obj = eval("(" + response.d + ')');
	            tableData.timeCell = obj;
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
	    var lapDivNumber = 0;
	    var setTimeCell = function (day, timeString, userName, codeCode, lapNumber, lapNames) {
	        this.showLapInfo = function (divObj) {

	            var htmlDiv = $(divObj);

	            if (htmlDiv.is(':visible')) {
	                htmlDiv.hide();
	            } else {
	                htmlDiv.show();
	            }
	        }

	        console.log("day:" + day + " timeString:" + timeString);
	        $("#our_table tr").filter(':first').children().each(function () {
	            var $this = $(this);
	            if ($this.text().substring(0, 10) == day) {
	                var columnIndex = $this.index();
	                $("#our_table tr").each(function () {
	                    $this = $(this);
	                    var firstCellString = $this.find('th').text();
	                    if (firstCellString == timeString) {
	                        var rowIndex = $this.index();
	                        
	                        var toToggleTD = $this.children(':nth-child(' + (columnIndex + 1) + ')');
	                        if (!toToggleTD.hasClass('highlighted')) {
	                            toToggleTD.toggleClass("highlighted");
	                        }

	                        var lapValue = $this.children(':nth-child(' + (columnIndex + 1) + ')').text();
	                        if (lapValue != null && lapValue < lapNumber && lapNumber != 1) {
	                            var tdshow = $this.children(':nth-child(' + (columnIndex + 1) + ')');
	                            //$this.children(':nth-child(' + (columnIndex + 1) + ')').text(lapNumber + userName + lapNames);
	                            tdshow.text();
	                            //userName + lapNames
	                            //<div style="visibility:visible">ddddd</div>
	                            var lapDivName = "overLapDiv" + lapDivNumber++;
	                            var listr = "<li>" + userName + "</li>";
	                            $.each(lapNames, function (i, v) {
	                                listr += "<li>" + v + "</li>";
	                            })
	                            var newDiv = "<div id=\"" + lapDivName + "\" style='display:none'><lu>" + listr + "</lu></div>";
	                            tdshow.append(newDiv);
	                            tdshow.append('<a href="javascript:showLapInfo(' + lapDivName + ');">' + lapNumber + '</a>');
	                        }
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

		    getTimeCellData(tableData.start, tableData.end);
		    var timecells = tableData.timeCell;
		   // alert("timecells:" + timecells);
		    $.each(timecells, function (index, value) {	       
		        var arr = value.cell.split(" ");
		        setTimeCell(arr[0], arr[1],value.userName,value.colorCode, value.lapNumber,value.lapNames);
		    }
		    );
		}();
		
	
	
    /*  var isMouseDown = false;
      $("#our_table td")
        .mousedown(function () {
          isMouseDown = true;
          $(this).toggleClass("highlighted");
          return false; // prevent text selection
        })
        .mouseover(function () {
          if (isMouseDown) {
            $(this).toggleClass("highlighted");
          } else {
             var divObj = $(this).find("div").closest();
             if (divObj != null) {
                 divObj.show();
             }
          }
        })

        .bind("selectstart", function () {
          return false; // prevent text selection in IE
        });
      $(document)
        .mouseup(function () {
          isMouseDown = false;
        });*/


      window.setInterval(function () {
          var msg = $('#tbl_chatlogs tr:last td:first').text();
          if (msg == null || msg == "" || msg == "undefine") msg = "01/01/2000 00:00:00";
          
          $.ajax({
              type: "POST",
              url: "groupEvent.aspx/GetMsg",
              data: '{groupId: "'+glb_groupId+'",msg: "' + msg + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              async: true,
              success: function (response) {
                  
                  var chatLogs = eval("(" + response.d + ')');
                  $.each(chatLogs, function (index, chatLog) {
                      var dti = getDateFromAspString(chatLog.postTime);
                      var dateStr = $.datepicker.formatDate('mm/dd/yy', dti);
                      
                      var hour = (dti.getHours() + 100).toString().substring(1, 3);
                      var min = (dti.getMinutes() + 100).toString().substring(1, 3);
                      var sec = (dti.getSeconds() + 100).toString().substring(1, 3);
                      var datetimestr = dateStr + " " + hour + ":"+ min +":"+ sec;
                      $('#tbl_chatlogs').append("<tr><td>" + datetimestr + "</td><td>" + chatLog.userName + "</td><td>" + chatLog.content + "</td></tr>");

                  });
                  
                  //   var obj = eval("(" + response.d + ')');
                  // tableData.timeCell = obj;
                  //alert("ajax: "+tableData.timeCell);
              },
              failure: function (response) {
                  alert(response.d);
              }
          });
      },500 );//Call the method in every 5 seconds


        $('#btn_send').click(function () {
            var msg = $("#txt_send").val();
            if (msg == "") return false;
            $("#txt_send").val("");
            $('#btn_send').attr("disabled", true);
            $.ajax({
                type: "POST",
                url: "groupEvent.aspx/SendMsg",
                data: '{groupId: "'+glb_groupId+'",msg: "' + msg + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    $('#btn_send').removeAttr("disabled");
                },
                failure: function (response) {
                    $('#btn_send').removeAttr("disabled");
                    $("#txt_send").val("Error occur, send failed:"+response);
                }
            });
            
        });
    });
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
       <table id="event_info" class="event_info">
           <tr><td style="width:10%">Event: </td>
               <td ><asp:label runat="server" ID="lb_eventName"></asp:label></td>
               <td><asp:ImageButton ID="btn_edit" runat="server" Height="25px" ImageAlign="AbsBottom" ImageUrl="~/Images/editButtonBlack.png" OnClick="btn_edit_Click" ToolTip="Edit Event" /></td>
           </tr>
           <tr><td>Location: </td>
               <td><asp:label runat="server" ID="lb_location"></asp:label></td>
           </tr>
           <tr><td>From: </td>
               <td ><asp:label runat="server" ID="lb_from"></asp:label></td>
           </tr>
           <tr><td>To: </td>
               <td><asp:label runat="server" ID="lb_to"></asp:label></td>
           </tr>
           <tr><td>Status: </td>
               <td><asp:label runat="server" ID="lb_status"></asp:label></td>
           </tr>
       </table>   
    <br />
    <asp:Label ID="lb_dateFrom" runat="server" Text=" Date From" ForeColor="White" Font-Bold="True" Font-Names="Arial"></asp:Label>
   
        <asp:TextBox ID="tb_dateFrom" runat="server" Height="25px" ToolTip="Click to select start date"></asp:TextBox>
&nbsp;&nbsp;<asp:Label ID="lb_dateTo" runat="server" Text="To" Font-Names="Arial" ForeColor="White" Font-Bold="True"></asp:Label>
&nbsp;
    <asp:TextBox ID="tb_dateTo" runat="server" Height="25px" ToolTip="Click to select end date"></asp:TextBox>
&nbsp;<asp:ImageButton ID="btn_view" runat="server" Height="25px" ImageUrl="~/Images/view.png" ToolTip="View Selected Dates" BorderStyle="None" ImageAlign="AbsBottom" OnClick="btn_view_Click" />
    <br /><br />
    <div id="groupSchedule">
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
    <br />
     <p style="font-family: 'Comic Sans MS'; font-size:large; font-weight: 900; color: #FFFFFF">Message Board</p>
<div id="div_chat" style="width:70%;height:200px;overflow:scroll">
<table style="width:100%;height:100%">
            <tr>
                <td>
                    <table id="tbl_chatlogs" style="width:100%;border:none">
                        <tr style="border:none">
                            <td style="width:15%;border:none"></td>
                            <td style="width:20%;border:none"></td>
                            <td style="width:65%;border:none"></td>
                        </tr>
                    </table>
                </td>
            </tr>
           <!-- <tr>
                <td>
                    <input id="txt_send" type="text" size="50" />
                    <input id="btn_send" type="button" value="Send" />
                    <asp:HiddenField ID="hd_eventId" runat="server"  />

                </td>
            </tr>-->
        </table>
    </div><br />
    <div id="sendMsg" style="width:70%;text-align:center">
         <input id="txt_send" type="text" style="width:100%;height:80px;overflow:scroll" />
        <p><input id="btn_send" type="button" value="Send Message" class="button"/></p>
         <asp:HiddenField ID="hf_eventId" runat="server"  />
    </div>
    <br /><br />
    <asp:SqlDataSource ID="SqlDataSource_Events" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT E.Id, E.eventName, E.eventDateFrom FROM EVENT_INFO E INNER JOIN EVENT_PARTICIPANTS P ON E.Id = P.eventId INNER JOIN USER_INFO U ON P.userId = U.Id WHERE U.Id = 1"></asp:SqlDataSource>
    </asp:Content>
