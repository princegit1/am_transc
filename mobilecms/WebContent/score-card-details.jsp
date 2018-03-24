<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>

<%	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = null;
	try
	{
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();	
		String upQuery1 = "select news  from mobile_news where news_id="+request.getParameter("newsId");
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{
				
		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Admin Area</title>
<style>
.ui-timepicker-div .ui-widget-header { margin-bottom: 8px; }
.ui-timepicker-div dl { text-align: left; }
.ui-timepicker-div dl dt { height: 25px; margin-bottom: -25px; }
.ui-timepicker-div dl dd { margin: 0 10px 10px 65px; }
.ui-timepicker-div td { font-size: 90%; }
.ui-tpicker-grid-label { background: none; border: none; margin: 0; padding: 0; }
</style>


<script type="text/javascript" src="http://media2.intoday.in/indiatoday/js/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function(){ 
    jQuery.validator.addMethod("alpha", function(name, element) {
    name = name.replace(/\s+/g, "");
	return this.optional(element) || name.match(/^[a-zA-Z]*$/);}, "Please enter only alphabets");
	 
//alert($("#no_of_question").attr("value"));
    $("#quiz_form").validate({
		
	       rules:{
			"treatment-type[]":{required:true},
			"color-frequency[]":{required:true},
			"st-frequency[]":{required:true},
			"blow-frequency[]":{required:true},
			"problem-type[]":{required:true},
			
            quiz_title: {required:true},
			longDesc: {required: true}, 
          	//shortDesc: { required: true}, 
			//no_of_question:{required:true, digits: true},			
			//no_of_validation:{required:true, max:$("#no_of_question").attr("value"), digits: true},
			//no_of_validation:{required:true,  digits: true},
		bgfile: { required: true, accept: "jpeg|jpg", filesize: 1048576  },			
					 
        },
		messages: {
			quiz_title: "Please specify  title.",
			longDesc: "please specify  metadetails.",			
			//shortDesc: "Please specify description.",
			//no_of_question:"Please specify number of images.",			
			//no_of_validation:"Please specify mandatory question number."
			
bgfile: "File must be JPG or JPEG, less than 1MB",	
			}
    });
	
		
		
  });
  </script>
</head>
<body>
<jsp:include page="topBand.jsp" />
  <div class="wrapper">
    <div class="wrapper2">		
    <div class="header">    	    
           <%if(session.getAttribute("user")!=null){%> <div align="left" class="info-box"><strong>Welcome, <%out.print((String)session.getAttribute("user"));%></strong><a href="logOut.jsp" class="orange_Input IE_lineHeight_18px floatRight logout" style="background:#3C5E8C; color:#fff;">logout</a> </div><%}%>
            </div>
    <div class="topNav">
    
    	
        <div class="clear"></div>
            </div>
    
    <div class="clear"></div>



	<div class="main_wrapper">
<div class="rightBox">
    <div class="content_box">

<style>
table.adminform {
	background-color: #F5F5F5;
	border: 1px solid #D5D5D5;
	padding: 1px;
	width: 100%;
}

table.adminform tr.row0 {
	background-color: #F5F5F5;
}

table.adminform tr.row1 {
	background-color: #EEEEEE;
}

table.adminform th {
	background: none repeat scroll 0 0 #777777;
	border-radius: 5px 5px 0 0;
	color: #FFFFFF;
	font-size: 12px;
	height: 25px;
	padding: 6px 4px 2px;
	text-align: left;
}

table.adminform td {
	border: medium none;
	padding: 3px;
	text-align: left;
}

table.adminform td.editor {
	font-size: 9px;
}

table.cpanel td {
	text-align: center;
}

select,textarea,input[type="button"],input[type="file"],input[type="text"],input[type="password"],input[type="datetime"],input[type="datetime-local"],input[type="date"],input[type="month"],input[type="time"],input[type="week"],input[type="number"],input[type="email"],input[type="url"],input[type="search"],input[type="tel"],input[type="color"],.uneditable-input
	{
	border-radius: 4px 4px 4px 4px;
	color: #555555;
	display: inline-block;
	font-size: 14px;
	margin-bottom: 0;
	padding: 2px;
	vertical-align: middle;
}

input {
	border: 1px solid #999999;
}

input[type="button"],input[type="submit"],input[type="image"] {
	background-color: #333333 !important;
	color: #FFFFFF !important;
}

select {
	background-color: #FFFFFF;
	border: 1px solid #CCCCCC;
	width: 175px;
}

select,select[multiple],select[size] {
	height: auto;
	line-height: 30px;
}

table {
	border: medium none;
	border-collapse: separate;
	border-radius: 10px 10px 10px 10px;
}

.adminform {
	background: none repeat scroll 0 0 #EEEEEE;
	border-radius: 10px 10px 10px 10px;
	margin: 5px 0;
	padding: 5px 5px 25px;
}

.tab-page {
	border-radius: 10px 10px 10px 10px;
}

.mceEditor {
	border-width: 5px !important;
}

.dynamic-tab-pane-control .tab-row .tab {
	background-color: #999999 !important;
	background-image: none !important;
	border-radius: 5px 5px 0 0;
	color: #FFFFFF !important;
	font-weight: bold;
	margin-top: 5px !important;
}

.dynamic-tab-pane-control .tab-row .tab a {
	color: #FFFFFF !important;
}

.dynamic-tab-pane-control .tab-row .tab.selected {
	background-color: #333333 !important;
	background-image: none !important;
	border-radius: 5px 5px 0 0;
	color: #FFFFFF !important;
	font-weight: bold;
}

.mceSelectList {
	font-size: 9pt !important;
	height: 20px;
}
</style>
<form name="quiz_form" id="quiz_form" method="post" action="insert_cricket_score.jsp" >
<table width="100%" cellspacing="0" cellpadding="0" border="1"
	class="adminform">
	<tbody>
		<tr>
			<td  valign="top" align="left">
				<table width="100%" cellspacing="0" cellpadding="8" border="0">
					<tbody>
						<tr>
							<th align="left">
								Match Details
								<div style="float:right"><a href="http://mobileservice.digitaltoday.in/content/sp/cricket_score.jsp">Preview</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Go" value="Save Score"></div></th>
						</tr>
					</tbody>
				</table>
				<table width="100%" cellspacing="0" cellpadding="0" border="0">
					<tbody>
						<tr>
							<td width="35%" style="border-right: 1px solid #333;">
								<table width="100%" cellspacing="0" cellpadding="8" border="0">
									<tbody>
										<tr>
											<td width="130" height="35">
												Series Name:&nbsp;
											</td>
											<td height="35">
											<select name="series">
											<%	
	
	try
	{
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT id,`series` FROM `series` WHERE `publish`='1'";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{%>
		<option value="<%=rs.getString("series") %>"><%=rs.getString("series") %></option>		
		<%}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 
	%>
												
													
													
												</select>
												
											</td>
										</tr>

										
										<tr>
											<td valign="top" height="15">
												Match :&nbsp;
											</td>
											<td valign="top" height="35">
												<select name="match">
														<%	
	
	try
	{
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT id,`match` FROM `match` WHERE `publish`='1'";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{%>
		<option value="<%=rs.getString("match") %>"><%=rs.getString("match") %></option>		
		<%}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 
	%>
												</select>
												<br>
												
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Match Status:&nbsp;
											</td>
											<td height="35">
												<select name="status">
													<option value="start">start</option>
<option value="preview">preview</option>
<option value="delay">delay</option>
<option value="inprogress">inprogress</option>
<option value="rain">rain</option>
<option value="stump">stump</option>
<option value="toss">toss</option>
<option value="abandon">abandon</option>
<option value="complete">complete</option>
												</select>
											</td>
											
										</tr>
										
										
									</tbody>
								</table>
							</td>
							<td width="35%" style="border-right: 1px solid #333;">
								<table width="100%" cellspacing="0" cellpadding="0" border="0">
									<tbody>
									<tr>
											<td valign="top" height="35">
												Current Over:&nbsp;
											</td>
											<td height="35">
												<input type="text"   id="currentover"
													class="text_area" name="currentover" value="0" >
											</td>
										</tr>
										
										
										<tr>
											<td valign="top" height="35">
												Current Score:&nbsp;
											</td>
											<td height="35">
												<input type="text"  id="currentscore"
													class="text_area" name="currentscore" value="0" >
											</td>
											
										</tr>
										<tr>
											<td valign="top" >
												Total Overs:
											</td>
											<td>
											<input type="text"  class="text_area" id="totalover" value="0" name="totalover">
												
											</td>
										</tr>
										<tr>
											<td valign="top" align="right">
												Current Partnership:
											</td>
											<td>
												<input type="text"  class="text_area" id="currentpartnership" value="0" name="currentpartnership">
											</td>
										</tr>
										
									</tbody>
								</table>
							</td>
							<td width="30%">
								<table width="100%" cellspacing="0" cellpadding="8" border="0">

									<tbody>
										<tr align="right">
											<td valign="top">
												Bat Team:
											</td>
											<td>
												<select name="batteam">
													<%	
	
	try
	{
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT `team1`,`team2` FROM `match` WHERE `publish`='1'";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{%>
		<option value="<%=rs.getString("team1") %>"><%=rs.getString("team1") %></option>
		<option value="<%=rs.getString("team2") %>"><%=rs.getString("team2") %></option>		
		<%}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 
	%>
												</select>
											</td>
										</tr>
										<tr align="right">
											<td valign="top">
												Bowl Team:
											</td>
											<td>
												<select name="bowlteam">
													<%	
	
	try
	{
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT `team1`,`team2` FROM `match` WHERE `publish`='1'";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{%>
		<option value="<%=rs.getString("team1") %>"><%=rs.getString("team1") %></option>
		<option value="<%=rs.getString("team2") %>"><%=rs.getString("team2") %></option>		
		<%}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 
	%>
												</select>
											</td>
										</tr>
										<tr>
											<td valign="top" align="right">
												crr:
											</td>
											<td>
												<input type="text"  class="text_area" id="crr" value="0" name="crr">
											</td>
										</tr>
										
										<tr>
											<td valign="top" align="right">
												rrr:
											</td>
											<td>
												<input type="text"  class="text_area" id="rrr" value="0" name="rrr">
											</td>
										</tr>
										
										
										
										
									</tbody>
								</table>
							</td>
						</tr>

						<tr>
							<tr>
							<td colspan="3">

								<div style="clear: both; width: 100%;"></div>
								 
								<table width="32%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Batsman : 1
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="batsman_name1" class="text_area" id="batsman_name1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="batsman_sname1" class="text_area" id="batsman_sname1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="batsman1_score" class="text_area" id="batsman1_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="32%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Batsman : 2
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="batsman_name2" class="text_area" id="batsman_name2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="batsman_sname2" class="text_area" id="batsman_sname2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="batsman2_score" class="text_area" id="batsman2_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="32%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Bowler 
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="bowler_name" class="text_area" id="bowler_name" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="bowler_sname" class="text_area" id="bowler_sname" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="bowler_score" class="text_area" id="bowler_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="24%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Top Batsman : 1
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="top_batsman_name1" class="text_area" id="top_batsman_name1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="top_batsman_sname1" class="text_area" id="top_batsman_sname1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="top_batsman1_score" class="text_area" id="top_batsman1_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="24%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Top Batsman : 2
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="top_batsman_name2" class="text_area" id="top_batsman_name2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="top_batsman_sname2" class="text_area" id="top_batsman_sname2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="top_batsman2_score" class="text_area" id="top_batsman2_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="24%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Top Bowler : 1
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="top_bowler_name1" class="text_area" id="top_bowler_name1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="top_bowler_sname1" class="text_area" id="top_bowler_sname1" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="top_bowler1_score" class="text_area" id="top_bowler1_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="24%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
													Top Bowler : 2
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="top_bowler_name2" class="text_area" id="top_bowler_name2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="top_bowler_sname2" class="text_area" id="top_bowler_sname2" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="top_bowler2_score" class="text_area" id="top_bowler2_score" style="width: 95%;">
											</td>
										</tr>
										
										
																			
										
									</tbody>
								</table>


								<table width="32%" cellspacing="0" cellpadding="0" border="0" style="float: left; border: 1px solid #333; margin: 5px;">
									<tbody>
										<tr>
											<th colspan="2" style="height: 15px;">
												Last Wicket Details
												
											</th>
										</tr>
										
										<tr>
											<td width="30%" height="35">
												Name:&nbsp;
											</td>
											<td width="69%" height="35">
												<input type="text" name="last_batsman_name" class="text_area" id="last_batsman_name" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="last_batsman_sname" class="text_area" id="last_batsman_sname" style="width: 95%;">
											</td>
										</tr>
										<tr>
											<td valign="top" height="35">
												Score:&nbsp;(14(39, 2x4, 0x6))
											</td>
											<td height="35">
												<input type="text" name="last_batsman_score" class="text_area" id="last_batsman_score" style="width: 95%;">
											</td>
										</tr>
										
										<tr>
											<td valign="top" height="35">
												Status:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="last_batsman_status" class="text_area" id="last_batsman_status" style="width: 95%;">
											</td>
										</tr>
											<tr>
											<td valign="top" height="35">
												Bowler Name:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="last_bowler_name" class="text_area" id="last_bowler_name" style="width: 95%;">
											</td>
										</tr>								
										<tr>
											<td valign="top" height="35">
												Bowler Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="last_bowler_sname" class="text_area" id="last_bowler_sname" style="width: 95%;">
											</td>
										</tr>	
										<tr>
											<td valign="top" height="35">
												Filder Name:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="filder_name" class="text_area" id="filder_name" style="width: 95%;">
											</td>
										</tr>	
										<tr>
											<td valign="top" height="35">
												Filder Sname:&nbsp;
											</td>
											<td height="35">
												<input type="text" name="filder_sname" class="text_area" id="filder_sname" style="width: 95%;">
											</td>
										</tr>				
									</tbody>
								</table>


								



							</td>
						</tr>
						</tr>
						<tr>
							<td colspan="2">
								&nbsp;
							</td>
						</tr>
						
					</tbody>
				</table>
			</td>

		</tr>
	</tbody>
</table>
</form>


	</div>
</div>
 
</div><div class="clear"></div>
<div class="footer">
    <div class="copyright">India Today &copy; Copyright 2013</div>
</div>    </div>
  </div>
</body>
</html>