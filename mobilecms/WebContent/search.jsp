<%
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Mobile Service - Powered by ITGO </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
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
			
			if(document.forms[0].Category.selectedIndex == 0)
			{
				alert("Select Category");
				document.forms[0].Category.focus();
				return false;
			}
			
				
			if(document.forms[0].date.selectedIndex == 0)
			{
				alert("Select Date Range");
				document.forms[0].date.focus();
				return false;
			}
	}
		
</Script>
</HEAD>

<BODY>
<center>
<jsp:include page="topBand.jsp" />

<h3><P align=center color=red>Mobile Service Search</p></h3>

<form method="POST" action="search_results.jsp" onsubmit="return check_input1()">

	<table>
	
	<tr>
	<td>
		Search Text:
	</td>
	<td>
		<input type="text" name="content" value="">
	</td>
	</tr>
	<tr>
	<td>
		Select Category:
	</td>
	<td>
<select name="categoryId">
<%
	try
	{
		String emp_role  = (String)session.getAttribute("emp_role");
		String upQuery="";
		
		if(emp_role.equals("AMT"))
			{
				upQuery="select * from category_master where status='ACTIVE' and category_id in (9,10,32,40,41)";
			}
			else
			{
				upQuery="select * from category_master where status='ACTIVE'";
			}

		//String upQuery="select * from category_master";
		
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
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
	<tr>
	<td>
	Select Date Range: 
	</td>
	<td>
	<Select name="date">

		<option value = "7" >< 7days </option>
		<option value = "14" >< 14days </option>
		<option value = "21" >< 21days </option>
		<option value = "30" >< 1month </option>
		<option value = "60" >< 2 months </option>
		<option value = "90" >< 3 months </option>
		</Select>
	</td>
	</tr>
	<tr>
	<td>
	<p align="center"><input type="submit" value="Show" name="btnShow"></P><BR>
	</td>

	<br>
	<br>
	</tr>
	</table>

	<br>
	
	</table>
	
</form>
</center>
</BODY>

</HTML>
