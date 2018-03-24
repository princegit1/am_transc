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
<FORM  method=post name="newsForm" action="check.jsp">
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
			if(emp_role.equals("AMT"))
			{
				upQuery="select * from category_master where status='ACTIVE' and category_id in (9,10,32,40,41,66,67,72)";
			}
			else
			{
				upQuery="select * from category_master where status='ACTIVE' and SERVICE_PROVIDER!='CBC' and category_type not like '%-unicode%' and category_id not in(160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180)";
			}
		
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
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
