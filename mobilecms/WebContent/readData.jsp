<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<body>

<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String str = "";
	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
		String upQuery1 = "select news  from mobile_news where news_id="+request.getParameter("newsId");
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{
				str = rs.getString("news");
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
String abc=str.replaceAll("$","<br><br>");
 out.println("<font color=red>"+abc);
%>


