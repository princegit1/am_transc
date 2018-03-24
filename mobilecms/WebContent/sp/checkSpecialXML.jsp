<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="java.sql.*,java.util.*"%>
<%@ page import="conn.*" %>
<%
Connection cn=null;
ResultSet rs = null;
Statement stmt = null;
AdminConn adminConn = AdminConn.getInstance();
String upQuery="";
String date ="";
ArrayList headline = new ArrayList();
String catId = request.getParameter("catId");
	if (catId == null)
	{
		catId ="99";	
	}
try
{				
	upQuery="SELECT m.message_id as mid,m.message as news,m.category_id,m.insert_date as record_date,c.CATEGORY_TYPE as catName,em.FNAME as fname, m.ordering as orders FROM message_special m,category_master c,employee em where m.category_id=c.CATEGORY_ID and m.update_emp_id=em.EMP_ID  and m.category_id='"+catId+"'  order by m.ordering";
	//out.println(upQuery);
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	while(rs.next())
	{				
		date = rs.getString("record_date");				
		headline.add(new String( rs.getString("news")));
	}
%>
<vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>		

<%

	for(int i=0;i<6;i++)
		{
			Object message[] = headline.toArray();

%>
<part><%=message[i]%></part>
<%
		}
%>
</multiPartSms>
</contentItem>
</vap>
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	rs.close();
	stmt.close();
	cn.close();
}
%>