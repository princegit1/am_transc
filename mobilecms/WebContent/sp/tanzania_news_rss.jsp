<?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel><%@ page import="java.sql.*,java.util.ArrayList,conn.*"%><%
	//AdminConn adminConn = null;
	//adminConn = AdminConn.getInstance();
	String upQuery="";
	Connection cn=null;	
	ResultSet rs=null;
	Statement stmt=null;
	String msg="";
	String lastbuildDate="";
	String serviceProvider ="Tanzania";
	String category = request.getParameter("category");	
	if(category!=null && !category.equals("")){			
		try
		{		
		upQuery="select date_format(run_date,'%d%m%Y')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+category+"' order by a.msg_id desc limit 1";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
//out.println(upQuery);		
//cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);		
		while(rs.next())
		{
		msg=rs.getString("message1");
		lastbuildDate=rs.getString("run_date");
		if(category.equals("local-news") || category.equals("stock-alerts") || category.equals("breaking-news") ||category.equals("rugby") || category.equals("soccer") || category.equals("international-news") )

			{
			%>			
<title><%=category.toUpperCase().replaceAll("-"," ")%></title>
<link></link>
<description><%=category.toUpperCase().replaceAll("-","")%></description>
<atom:link href="" rel="self"></atom:link>
<language>en-us</language>
<lastBuildDate><%=lastbuildDate%></lastBuildDate>
<item>
<title><%=msg%></title>
<link></link>
<description><%=msg%></description>
<guid></guid>
</item>
</channel>
</rss> 
<%	
			}else{
out.print("CATEGORY NOT FOUND.....");
}
		
			
		}
		
		
		}		
		catch(Exception e)
		{
			System.out.println(e.toString());
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
	}else{
out.print("CATEGORY NOT FOUND.....");
}
%>