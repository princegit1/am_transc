<%@ page import="java.sql.*,conn.*"%><%	
	String upQuery="";
	String messageId = "";
	String categoryId = "";
	String date = "";
	ResultSet rs3=null,rs=null;
	Connection cn3=null;
	Statement stmt=null,stmt3=null;	
	String serviceProvider = "ITGD";
	String category = "";
	if(request.getParameter("category")!=null)
	category = request.getParameter("category");	
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",message="";	
	if(category.equalsIgnoreCase("TNP") || category.equalsIgnoreCase("KER")|| category.equalsIgnoreCase("ASM")|| category.equalsIgnoreCase("WB")){
	
	if(category.equalsIgnoreCase("TNP")){
	category="OM-Elec-News-TNP";
	}else if(category.equalsIgnoreCase("KER")){
	category="OM-Elec-News-Ker";
	}else if(category.equalsIgnoreCase("ASM")){
	category="OM-Elec-News-ASM";
	}else if(category.equalsIgnoreCase("WB")){
	category="OM-Elec-News-WB";
	}
	
	try
	{	
	AdminConn adminConn = AdminConn.getInstance();
	upQuery="select max(a.MSG_ID)as MSG_ID from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"'  order by a.MSG_ID";
	cn3 = adminConn.getConnection();
	stmt3=cn3.createStatement();
	rs3=stmt3.executeQuery(upQuery);	
	if(rs3.next())
	{	
	stmt=cn3.createStatement();
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y' ) date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and a.MSG_ID='"+ rs3.getString("MSG_ID")+"'");	
	while(rs.next())
	{
	messageId=rs3.getString("MSG_ID");	
	message=rs.getString("message1");	
	date=rs.getString("date");
	completeNews = message.substring(message.indexOf(":")+1, message.length()).trim();
	//completeNews = message;		
	newsOne = completeNews.substring(0, completeNews.indexOf("2#"));	
	newsTwo = completeNews.substring(newsOne.length(),completeNews.indexOf("3#"));		
	newsThree = completeNews.substring(newsOne.length()+ newsTwo.length(), completeNews.length());		
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}
	
	if(newsOne.contains("1#")){
	newsOne=newsOne.replace("1#", "");
	}
	if(newsTwo.contains("2#")){
	newsTwo=newsTwo.replace("2#", "");
	}
	if(newsThree.contains("3#")){
	newsThree=newsThree.replace("3#", "");
	}
	%><?xml version="1.0" encoding="UTF-8"?>
<vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>			
<part><%=newsOne%></part>
<part><%=newsTwo%></part>
<part><%=newsThree%></part>
</multiPartSms>
</contentItem>
</vap>
<%	
	
	}
	}else{
		
		out.print("No Message");
		}	
	
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
	}else{
	out.print("No Message");
	}
%>
