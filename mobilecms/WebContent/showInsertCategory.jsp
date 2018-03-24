<%
	String firstname = (String)session.getAttribute("fname");
	String emp_Id = (String)session.getAttribute("empId");
	if(firstname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>

<HTML><HEAD><TITLE>Mobile Service</TITLE></HEAD>
<HEAD>
<script language="JavaScript">
<!--
var sp = new Array(
'AIRTEL','IDEA','2424','HUTCH','54321','MTNLDL','ITGD','LatinAmerica'

)
//-->
</script>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />

<TABLE cellSpacing=0 cellPadding=0 width=100% align=center border=0 hspace="5" vspace="5">
	<tr height="20" bgcolor="#dcdcdc">
		<td>&nbsp;<b>Service Provider</b><td>
		<td>&nbsp;<b>Category</b></td>
		<td>&nbsp;<b>Total Message</b></td>
		<td>&nbsp;<b>Message Size</b></td>
		<td>&nbsp;<b>Alert Time</b></td>
		<td>&nbsp;<b>Header</b></td>
		<td>&nbsp;<b>Footer</b></td>
		<td>&nbsp;<b>Update By</b></td>
		<td>&nbsp;<b>Action</b></td>
	<tr>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	int totalMsg = 0;
	int categoryId = 0;
	String serviceProvider = request.getParameter("serviceProvider");
	String category = request.getParameter("category");
	String fname = "";
	String lname="";
	int empId = 0;

	AdminConn adminConn = AdminConn.getInstance();
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
		try
		{	
			cn = adminConn.getConnection();
			stmt=cn.createStatement();
			//original query
			//rs=stmt.executeQuery("select * from category_master a, employee b where a.update_emp_id=b.emp_id order by category_type");
			//changed to hide DELETE status records
			rs=stmt.executeQuery("select * from category_master a, employee b where a.update_emp_id=b.emp_id and a.STATUS='ACTIVE' order by category_type");
			while(rs.next())
			{
				fname=rs.getString("Fname");
				lname=rs.getString("lname");
				empId = rs.getInt("emp_id");
%>
				<tr height="20">
					<td>&nbsp;<%=rs.getString("service_provider")%>&nbsp;<td>
					<td>&nbsp;<%=rs.getString("category_type")%>&nbsp;</td>
					<td>&nbsp;<%=rs.getString("Total_message")%>&nbsp;</td>
					<td>&nbsp;<%=rs.getString("MESSAGE_SIZE")%></td>
					<td>&nbsp;<%=rs.getString("alert_time")%>&nbsp;</td>
					<td>&nbsp;<%=rs.getString("header")%>&nbsp;</td>
					<td>&nbsp;<%=rs.getString("footer")%>&nbsp;</td>
					<td>&nbsp;<%=fname%> <%=lname%>&nbsp;</td>
					<td>&nbsp;<a href="editCategory.jsp?categoryId=<%=rs.getInt("CATEGORY_ID")%>">Edit</a></td>
				</tr>
				<tr height="1" bgcolor="#dcdcdc">
					<td colspan="9"><td>
				</tr>
<%
			}
		}
		catch(NullPointerException nex)
		{
			out.println(nex.toString());
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
		<tr>
			<td colspan="9"><b>Insert New Category</b></td>
		<tr>
		<tr height="20" bgcolor="#dcdcdc">
			<td><b>Service Provider</b><td>
			<td><b>Category</b></td>
			<td><b>Total Message</b></td>
			<td><b>Message Size</b></td>
			<td><b>Alert Time</b></td>
			<td><b>Header</b></td>
			<td><b>Footer</b></td>
			<td><b>Update By</b></td>
			<td><b>Action</b></td>
		<tr>
		<form method=post action="insertCategory.jsp">
		<tr>
			<td>
				<SELECT NAME="service_provider">
				<script language=javascript>
				<!--
				for(i=0;i<sp.length;i++)
				{
					document.write("<option value = " +sp[i]+ ">" + sp[i])
				}
				//-->
				</script>
				</SELECT>
			<td>
			<td><input type="text" name="category_type"></td>
			<td><input type="text" name="total_message"></td>
			<td><input type="text" name="message_size"></td>
			<td><input type="text" name="alert_time"></td>
			<td><input type="text" name="header"></td>
			<td><input type="text" name="footer"></td>
			<td><input type="text" name="fname" value="<%=firstname%>" size="8" readonly><input type="hidden" name="empId" value="<%=emp_Id%>"></td>
			<td><input type="submit" value=" Insert "></td>
		<tr>
		</form>
	</table>
</BODY>
</HTML>
