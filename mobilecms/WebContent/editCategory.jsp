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
'AIRTEL','IDEA','52424','HUTCH','54321'
)
//-->
</script>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />

<TABLE cellSpacing=0 cellPadding=0 width=100% align=center border=1 hspace="5" 
vspace="5">
  <TBODY>
	<tr>
		<td><b>Service Provider</b><td>
		<td><b>Category</b></td>
		<td><b>Total Message</b></td>
		<td><b>Message Size</b></td>
		<td><b>Alert Time</b></td>
		<td><b>Header</b></td>
		<td><b>Footer</b></td>
		<td><b>Status</b></td>
		<td><b>Edit</b></td>
	<tr>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt=null;
	int totalMsg = 0;
	int categoryId = 0;
	//String serviceProvider = request.getParameter("serviceProvider");
	//String category = request.getParameter("category");
	AdminConn adminConn = AdminConn.getInstance();
	String fname = "";
	String lname="";
	int empId = 0;

	try
		{	//int q = k+1;
			String upQuery="select * from category_master a, employee b where a.update_emp_id=b.emp_id and a.category_id="+Integer.parseInt(request.getParameter("categoryId"));
			//out.println(upQuery);
			//AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();
			stmt=cn.createStatement();
			rs=stmt.executeQuery(upQuery);
			while(rs.next())
			{
				fname=rs.getString("Fname");
				lname=rs.getString("lname");
				empId = rs.getInt("emp_id");
%>
				<form method=post action="updCategory.jsp">
				<tr>
					<td>
						<SELECT NAME="service_provider">
						<option value="<%=rs.getString("service_provider")%>"><%=rs.getString("service_provider")%>
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
					<td><input type="text" name="category_type" value="<%=rs.getString("category_type")%>"></td>
					<td><input type="text" name="Total_message" value="<%=rs.getString("Total_message")%>" size=8></td>
					<td><input type="text" name="message_size" value="<%=rs.getString("MESSAGE_SIZE")%>" size=8></td>
					<td><input type="text" name="alert_time" value="<%=rs.getString("alert_time")%>"></td>
					<td><input type="text" name="header" value="<%=rs.getString("header")%>"></td>
					<td><input type="text" name="footer" value="<%=rs.getString("footer")%>"></td>
					<td>
						<select name="status">
								<option value="ACTIVE">ACTIVE
								<option value="DELETE">DELETE
						</select>
						<input type="hidden" name="empId" value="<%=emp_Id%>">
						<input type="hidden" name="categoryId" value="<%=request.getParameter("categoryId")%>">
					</td>
					<td><input type="submit" value=" Update "></td>
				<tr>
				</form>
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
			<td colspan=9><b>Insert New Category</b></td>
		<tr>
		<form method=post action="insertCategory.jsp">
		<tr>
			<td>
				<SELECT NAME="service_provider">
				<script language=javascript> <!--
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
