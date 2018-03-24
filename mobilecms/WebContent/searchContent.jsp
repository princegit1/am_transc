<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	String emp_role  = (String)session.getAttribute("emp_role");
	String queryStr="";
	String content = request.getParameter("content");
	if(content == null)
		content = "";
	String categoryId = request.getParameter("categoryId");
	if(categoryId == null)
		categoryId = "";
	String date = request.getParameter("date");
	if(date == null)
		date = "";
	String fromDate = request.getParameter("fromDate");
	if(fromDate == null)
		fromDate = "";
	String toDate = request.getParameter("toDate");
	if(toDate == null)
		toDate = "";
	//out.println("Content->"+content+", Category Id->"+categoryId+", Date->"+date+", From Date->"+fromDate+", To Date->"+toDate);
%>
<HTML>
	<HEAD>
		<TITLE> Mobile Service - Powered by ITGO </TITLE>
		<META NAME="Generator" CONTENT="EditPlus">
		<META NAME="Author" CONTENT="">
		<META NAME="Keywords" CONTENT="">
		<META NAME="Description" CONTENT="">
		<script type="text/javascript" language="javascript" src="jscript/popcalendar.js"></script>
		<link href="main.css" rel="stylesheet" type="text/css">
		<script language="JavaScript">
			function check_input1()
			{
				if(document.forms[0].content.value == "")
				{
					alert("Insert Key Word to search");
					document.forms[0].content.focus();
					return false;
				}
				if(document.forms[0].categoryId.value == "")
				{
					alert("Select Category");
					document.forms[0].categoryId.focus();
					return false;
				}
				if(document.forms[0].date.value == "" && document.forms[0].fromDate.value == "" && document.forms[0].toDate.value == "")
				{
					alert("Select Date Range");
					document.forms[0].date.focus();
					return false;
				}
			}
			
			function populateForm()
			{
				document.forms[0].content.value = "<%=content%>";
				document.forms[0].categoryId.value = "<%=categoryId%>";
				document.forms[0].date.value = "<%=date%>";
				document.forms[0].fromDate.value = "<%=fromDate%>";
				document.forms[0].toDate.value = "<%=toDate%>";
			}
		</Script>
	</HEAD>
	<BODY onload="javascript:populateForm()">
		<center>
			<jsp:include page="topBand.jsp" />
			<form method="POST" action="searchContent.jsp" onsubmit="return check_input1()">
				<table border="0" width="60%">
					<tr bgcolor="#dcdcdc" height="20">
						<td colspan="4" align="left">
							&nbsp;<b>Search Content</b>
						</td>
					</tr>
					<tr height="35">
						<td width="15%" align="right">
							Search Text :&nbsp;
						</td>
						<td width="35%">
							&nbsp;<input type="text" name="content" value="" size="35">
						</td>
						<td width="15%" align="right">
							Category :&nbsp;
						</td>
						<td width="35%">
							&nbsp;<select name="categoryId">
									<option value = ""> Select </option>
									<option value = "-any-"> All Categories </option>
								<%
									ResultSet rs=null;
									Connection cn=null;
									Statement stmt=null;
									try
									{
										if(emp_role.equals("AMT"))
											queryStr="select * from category_master where status='ACTIVE' and category_id in (9,10,32,40,41,72)";
										else
											queryStr="select * from category_master where status='ACTIVE'";
										AdminConn adminConn = AdminConn.getInstance();
										cn = adminConn.getConnection();
										stmt=cn.createStatement();
										rs=stmt.executeQuery(queryStr);
										while(rs.next())
										{
								%>
								<option value="<%=rs.getInt("category_id")%>"><%=rs.getString("category_type")%> - <%=rs.getString("service_provider")%>
								<%
										}
									}
									catch(Exception ee)
									{
										out.print("errr"+ee);
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
					<tr height="1" bgcolor="#dcdcdc">
						<td colspan="4" align="right">
						</td>
					</tr>
					<tr height="35">
						<td align="right">
							Date Range :&nbsp;
						</td>
						<td colspan="2">
							&nbsp;From:
							&nbsp;<input type="text" name="fromDate" size="10" readonly="readonly"/>
							&nbsp;<a href="javascript:showCalendar(document.forms[0], document.forms[0].fromDate, 'yyyy/mm/dd',null,0,400,180)"><img src="img/calendar.gif" border="0" align="top" height="23" width="22"></a>
							&nbsp;&nbsp;
							To:
							&nbsp;<input type="text" name="toDate" size="10" readonly="readonly"/>
							&nbsp;<a href="javascript:showCalendar(document.forms[0], document.forms[0].toDate, 'yyyy/mm/dd',null,0,625,180)"><img src="img/calendar.gif" border="0" align="top" height="23" width="22"></a>
							&nbsp;&nbsp;&nbsp;<b>or</b>&nbsp;
						</td>
						<td>
							&nbsp;<Select name="date">
								<option value = ""> Select </option>
								<option value = "7"> Less Than:&nbsp;07 days </option>
								<option value = "14"> Less Than:&nbsp;14 days </option>
								<option value = "21"> Less Than:&nbsp;21 days </option>
								<option value = "30"> Less Than:&nbsp;01 month </option>
								<option value = "60"> Less Than:&nbsp;02 months </option>
								<option value = "90"> Less Than:&nbsp;03 months </option>
								<option value = "180"> Less Than:&nbsp;06 months </option>
							</Select>
						</td>
					</tr>
					<tr bgcolor="#dcdcdc" height="35">
						<td colspan="4" align="right">
							<input type="reset" value=" Clear " name="btnClr">&nbsp;&nbsp;
							<input type="submit" value="  Show  " name="btnShow">&nbsp;&nbsp;
						</td>
					</tr>
				</table>
				<%
				if(content.length()>0)
				{
				%>
				<TABLE cellSpacing=0 cellPadding=0 width=100% align=center border=0>
					<tr height="20" bgcolor="#dcdcdc">
						<td>&nbsp;<b>SL.</b></td>
						<td width="50%"><b>Content</b></td>
						<td>&nbsp;&nbsp;<b>Category</b></td>
						<td>&nbsp;<b>Run Date</b></td>
						<td>&nbsp;<b>Submit Date</b></td>
						<td>&nbsp;<b>Updated By</b></td>
					</tr>
					<%
					ResultSet rs_result = null;
					Connection cn_result = null;
					Statement stmt_result = null;
					try
					{
						int i=1;
						queryStr = "SELECT concat(message1,'') message1,CATEGORY_TYPE,service_provider,DATE(run_date) run_date,date_format(a.record_date,'%d-%M-%Y %r')record_date,fname,lname";
						queryStr += " FROM message_details a, employee b,category_master c WHERE a.category_id = c.category_id and message1 like '%"+content+"%'";
						if(!("-any-".equals(categoryId)))
							queryStr += " AND a.category_id = "+categoryId;
						queryStr += " and a.update_emp_id=b.emp_id ";//and a.category_id!=16";

						//out.println(queryStr);

						if(fromDate.length()>0 || toDate.length()>0)
						{
							if(fromDate.length()>0)
								queryStr += " and date_format(a.record_date,'%Y/%m/%d') >= '"+fromDate+"'";
							if(toDate.length()>0)
								queryStr += " and date_format(a.record_date,'%Y/%m/%d') <= '"+toDate+"'";
						}
						else
							//original by Giten
							//queryStr += " and run_date>=curdate()-"+date;
							//sanjay 160608
							queryStr += " and (To_days(curdate()) - To_days(run_date)) <="+date+" and (To_days(curdate()) - To_days(run_date)) > 0";

						queryStr += " order by a.record_date desc";
						
						//out.println(queryStr);
						
						AdminConn adminConn = AdminConn.getInstance();
						cn_result = adminConn.getConnection();
						stmt_result = cn_result.createStatement();
						rs_result = stmt_result.executeQuery(queryStr);
						while(rs_result.next())
						{
							String messageStr = rs_result.getString("message1");
							if(messageStr == null)
								continue;
					%>
						<tr valign="middle" height="20">
							<td>&nbsp;<%=i%></td>
							<td bgcolor="#eeeeee"><%=messageStr%></td>
							<td>&nbsp;&nbsp;<%=rs_result.getString("service_provider")%> - <%=rs_result.getString("CATEGORY_TYPE")%></td>
							<td>&nbsp;<%=rs_result.getString("run_date")%></td>
							<td>&nbsp;<%=rs_result.getString("record_date")%></td>
							<td>&nbsp;<%=rs_result.getString("fname")%> <%=rs_result.getString("lname")%></td>
						</tr>
						<tr height="1" bgcolor="#dcdcdc">
							<td colspan="6"></td>
						</tr>
					<%
						i++;
						}
						if(i==1)
						{
					%>
						<tr valign="top" align="center">
							<td colspan="6"><font color="red"><b>No Record Found</b></font></td>
						</tr>
					<%
						}
					}
					catch(Exception ee)
					{
						out.print("errr"+ee);
					}
					finally
					{
						if(rs_result!=null)
							rs_result.close();
						if(stmt_result!=null)
							stmt_result.close();
						if(cn_result!=null)
							cn_result.close();
					}
					%>
				</table>
				<%
				}
				%>
			</form>
		</center>
	</BODY>
</HTML>