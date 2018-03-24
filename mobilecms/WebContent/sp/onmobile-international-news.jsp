<%@include file="..\global.jsp" %>
<?xml version="1.0" encoding="UTF-8"?><%@ page import="java.sql.*,conn.*"%><%	
	String upQuery="";
	String messageId = "";
	String categoryId = "";
	ResultSet rs3=null,rs=null;
	Connection cn3=null;
	Statement stmt=null,stmt3=null;	
	String serviceProvider = "ONMOBILE";
	String category = "onmobile-international-news";	
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",message="";
	String date="";
	
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
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y')  date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and a.MSG_ID='"+ rs3.getString("MSG_ID")+"'");	
	while(rs.next())
	{
	messageId=rs3.getString("MSG_ID");	
	message=rs.getString("message1");	
	date=rs.getString("date");
	
	
	
	
						completeNews = replaceSpCharacters(message);
						newsOne = completeNews.substring(0, completeNews.indexOf("2#"));
						if(newsOne.contains("1#")){
							
							newsOne=newsOne.replace("1#", "");
						}
						if(completeNews.contains("3#")){
						newsTwo = completeNews.substring(newsOne.length()+1,completeNews.indexOf("3#"));
						if(newsTwo.contains("2#")){
							
							newsTwo=newsTwo.replace("2#", "");
						}
						
						newsThree = completeNews.substring(newsOne.length()+ newsTwo.length()+2, completeNews.length());
						if(newsThree.contains("3#")){
							
							newsThree=newsThree.replace("3#", "");
						}
										
												
						}else{
						
						newsTwo = completeNews.substring(newsOne.length()+1,completeNews.length());
						if(newsTwo.contains("2#")){
							
							newsTwo=newsTwo.replace("2#", "");
						}
										

						}
						

						
						
						
						
	
	
	
	
	%><vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>			
<part><%=newsOne%></part>
<part><%=newsTwo%></part><%if(completeNews.contains("3#")){ %>
<part><%=newsThree%></part><%} %>
</multiPartSms>
</contentItem>
</vap><%
	
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
