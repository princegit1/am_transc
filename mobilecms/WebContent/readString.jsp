<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<body>

<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	
	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
		String upQuery1 = "select news_id,date_format(record_date,'%d-%M-%Y')record_date  from mobile_news";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{
%>
			<a href="readData.jsp?newsId=<%=rs.getString("news_id")%>"><%=rs.getString("record_date")%></a>
<%
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
