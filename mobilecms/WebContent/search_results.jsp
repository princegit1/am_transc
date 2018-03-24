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
	String content = request.getParameter("content");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	int date = Integer.parseInt(request.getParameter("date"));
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

<h3><P align=center color=red>Search Results</p></h3>
<TABLE cellSpacing=0 cellPadding=0 width=100% align=center border=1 hspace="5" 
vspace="5">
<tr align="center">
	<td width="2%"><b>SL.</b></td>
	<td width="50%"><b>Content</b></td>
	<td width="13%"><b>Category</b></td>
	<td width="5%"><b>Run Date</b></td>
	<td width="10%"><b>Submit Date</b></td>
	<td width="10%"><b>Update By</b></td>
</tr>
<%
	try
	{
		int i=1;
		String upQuery="SELECT message1,CATEGORY_TYPE,service_provider,DATE(run_date)run_date,a.record_date,fname,lname FROM message_details a, employee b,category_master c WHERE a.category_id = c.category_id and message1 like '%"+content+"%' AND a.category_id = "+categoryId+" and run_date>=curdate()-"+date+" and a.update_emp_id=b.emp_id and a.category_id!=16";
		//out.println(upQuery);
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		while(rs.next())
		{
%>
			<tr valign="top">
				<td><%=i%></td>
				<td><%=rs.getString("message1")%></td>
				<td><%=rs.getString("service_provider")%> - <%=rs.getString("CATEGORY_TYPE")%></td>
				<td><%=rs.getString("run_date")%></td>
				<td><%=rs.getString("record_date")%></td>
				<td><%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
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
		if(rs!=null)
		rs.close();
		if(stmt!=null)
		stmt.close();
		if(cn!=null)
		cn.close();
	}
%>
	</table>
</BODY>

</HTML>
