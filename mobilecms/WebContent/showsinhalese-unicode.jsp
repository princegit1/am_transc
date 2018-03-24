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
<HTML><HEAD><TITLE>Mobile Service</TITLE>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />
<FORM  method=post name="newsForm" action="check-sinhalese-unicode.jsp">
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=0 hspace="5" vspace="5">
		<tr valign="middle">
			<td align="center">
Select Category : &nbsp;&nbsp;&nbsp;
<select name="categoryId">
<%
	try
	{
		String upQuery = "";
		String emp_role  = (String)session.getAttribute("emp_role");
			
				upQuery="select * from category_master where status='ACTIVE' and SERVICE_PROVIDER='sinhalese'";
			
		
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery + " order by category_type");
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
</select>&nbsp;&nbsp;&nbsp;
<input type="submit" value= " Insert Message &#187; ">
</td>
			</tr>
			</table>
</FORM>
</BODY>
</HTML>
