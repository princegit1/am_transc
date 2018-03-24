<?xml version="1.0" encoding="UTF-8"?><%@ page import="java.sql.*,conn.*"%><%	
	String upQuery="";
	String messageId = "";
	String categoryId = "";
	ResultSet rs3=null,rs=null;
	Connection cn3=null;
	Statement stmt=null,stmt3=null;	
	String serviceProvider = "ITGD";
	String category = "Gold-Silver-Rates";	
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",message="";
	
	try
	{	
	AdminConn adminConn = AdminConn.getInstance();
	upQuery="select max(a.MSG_ID)as MSG_ID from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"'  order by a.MSG_ID";
	cn3 = adminConn.getConnection();
	//out.println(upQuery);
	stmt3=cn3.createStatement();
	rs3=stmt3.executeQuery(upQuery);	
	if(rs3.next())
	{	
	stmt=cn3.createStatement();
	messageId=rs3.getString("MSG_ID");
	upQuery="select a.message1,date_format(a.RECORD_DATE,'%d%m%Y')date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and a.MSG_ID='"+ messageId+"'";
	//out.println(upQuery);
	rs=stmt.executeQuery(upQuery);	
	while(rs.next())
	{
	%><vap version="1.0">
<contentItem lang="en-in" useOn="<%=rs.getString("date")%>" expires="<%=rs.getString("date")%>">
<multiPartSms>			
<part><%=rs.getString("message1")%></part>
</multiPartSms>
</contentItem>
</vap>	
	<%	
	}
	}else{out.print("No Message");}	
	
	}		
	catch(Exception e)
	{
	out.print("No Message");
	e.printStackTrace();
	}
	finally
	{
	if(rs3!=null)
	rs3.close();
	if(stmt3!=null)
	stmt3.close();
	if(rs!=null)
	rs.close();
	if(stmt!=null)
	stmt.close();
	cn3.close();
	}
	
%>
