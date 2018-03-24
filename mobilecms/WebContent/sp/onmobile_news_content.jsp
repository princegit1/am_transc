<%@ page language="java"  pageEncoding="ISO-8859-1"%><%@ page import="java.sql.DriverManager"%><%@ page import="java.sql.ResultSet"%><%@ page import="java.sql.Connection"%><%@ page import="java.sql.Statement"%><%	
	String date="";
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null; 
	String query="";	
	String newsOne = "", newsTwo = "", newsThree = "",message="";		
	String keyword="";			
	String serviceProvider = "ITGD-ONMOBILE";	
	if(request.getParameter("category")!=null){
	keyword = request.getParameter("category");		
	if(keyword.equalsIgnoreCase("onmobile-wb-hinglish") || keyword.equalsIgnoreCase("onmobile-english")){	
	try
	{	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
	stmt=cn.createStatement();		
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");
	//out.println("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");	
	while(rs.next())
	{	
	message=rs.getString("message1");	
	date = rs.getString("record_date");				
		


	newsOne = message.substring(0, message.indexOf("2#"));	
	if(newsOne.contains("1#")){
	newsOne=newsOne.replace("1#", "1.");
	}

	

if(message.contains("3#")){
						newsTwo = message.substring(newsOne.length(),message.indexOf("3#"));
						if(newsTwo.contains("2#")){
							
							newsTwo=newsTwo.replace("2#", "2.");
						}
						
						newsThree = message.substring(newsOne.length()+ newsTwo.length(), message.length());
						if(newsThree.contains("3#")){
							
							newsThree=newsThree.replace("3#", "3.");
						}
										
												
						}else{
						
						newsTwo = message.substring(newsOne.length(),message.length());
						if(newsTwo.contains("2#")){
							
							newsTwo=newsTwo.replace("2#", "2.");
						}
										

						}

	//out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree+"");	
	%><?xml version="1.0" encoding="UTF-8"?>	
<vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>			
<part><%=newsOne%></part>
<part><%=newsTwo%></part><%if(message.contains("3#")){ %>
<part><%=newsThree%></part><%} %>
</multiPartSms>
</contentItem>
</vap>	
	<%
	
	}	
	
	}		
	catch(Exception e)
	{
	e.printStackTrace();
	}
	finally
	{	
	if(stmt!=null)
	stmt.close();
	if(rs!=null)
	rs.close();
	if(stmt!=null)
	stmt.close();
	if(cn!=null)
	cn.close();
	}
	}
	else{
	out.println("No keyword Found");
	}
	}else{
	out.println("No keyword Found");
	}
%>