<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,conn.*,java.io.*"%><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*" %><%@page import="java.util.Properties"%><%@page import="java.util.Date"%><%	
	String date="";
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	String newsOne = "", newsTwo = "", newsThree = "",message="";		
	String keyword="";			
	String serviceProvider = "";	 
	if(request.getParameter("keyword")!=null)
	keyword = request.getParameter("keyword");	
	serviceProvider = "SPICE";
	
	if(keyword.equalsIgnoreCase("pan-india-top-news") || keyword.equalsIgnoreCase("pan-india-national-news")|| keyword.equalsIgnoreCase("pan-india-international-news")|| keyword.equalsIgnoreCase("pan-india-business-news")|| keyword.equalsIgnoreCase("pan-india-bollywood-news")
	||keyword.equalsIgnoreCase("pan-india-business-updates") || keyword.equalsIgnoreCase("pan-india-health-tips")|| keyword.equalsIgnoreCase("pan-india-beauty-tips")|| keyword.equalsIgnoreCase("pan-india-love-tips")
	||keyword.equalsIgnoreCase("pan-india-career-tips") || keyword.equalsIgnoreCase("pan-india-food-tips")|| keyword.equalsIgnoreCase("pan-india-travel-tips")|| keyword.equalsIgnoreCase("pan-india-weather-tips")
	||keyword.equalsIgnoreCase("pan-india-furniture") || keyword.equalsIgnoreCase("pan-india-relationship-tips")|| keyword.equalsIgnoreCase("idea-kk-news-kannada")){
	
	

	try
	{	 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
	//cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","itgd_office", "$t0p@ct1ng58");
	 
	String query="";	
	stmt=cn.createStatement();
	if(keyword.equalsIgnoreCase("pan-india-top-news") || keyword.equalsIgnoreCase("pan-india-national-news")|| keyword.equalsIgnoreCase("pan-india-international-news")|| keyword.equalsIgnoreCase("pan-india-business-news")|| keyword.equalsIgnoreCase("pan-india-bollywood-news")||keyword.equalsIgnoreCase("pan-india-business-updates")|| keyword.equalsIgnoreCase("idea-kk-news-kannada") ){
	
	
	
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");
	}else if(keyword.equalsIgnoreCase("pan-india-health-tips")|| keyword.equalsIgnoreCase("pan-india-beauty-tips")|| keyword.equalsIgnoreCase("pan-india-love-tips")
	||keyword.equalsIgnoreCase("pan-india-career-tips") || keyword.equalsIgnoreCase("pan-india-food-tips")|| keyword.equalsIgnoreCase("pan-india-travel-tips")|| keyword.equalsIgnoreCase("pan-india-weather-tips")
	||keyword.equalsIgnoreCase("pan-india-furniture") || keyword.equalsIgnoreCase("pan-india-relationship-tips")){	
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and a.run_date=curDate() and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");
		
	}
	
	while(rs.next())
	{
	 if(keyword.equalsIgnoreCase("pan-india-top-news") || keyword.equalsIgnoreCase("pan-india-national-news")|| keyword.equalsIgnoreCase("pan-india-international-news")|| keyword.equalsIgnoreCase("pan-india-business-news")|| keyword.equalsIgnoreCase("pan-india-bollywood-news")
	||keyword.equalsIgnoreCase("pan-india-business-updates") || keyword.equalsIgnoreCase("idea-kk-news-kannada")){
	
	
	message=rs.getString("message1");	
	date = rs.getString("record_date");	
	if(message.contains("2#")){
	newsOne = message.substring(0, message.indexOf("2#"));
	}else{
	newsOne=message;
	}
	
	if(message.contains("3#")){
	if(newsOne.contains("1#")){
	newsOne=newsOne.replace("1#", "1.");
	}
	newsTwo = message.substring(newsOne.length(),message.indexOf("3#"));	
	if(newsTwo.contains("2#")){
	newsTwo=newsTwo.replace("2#", "2.");
	}
	newsThree = message.substring(newsOne.length()+ newsTwo.length(), message.length());	
	if(newsThree.contains("3#")){
	newsThree=newsThree.replace("3#", "3.");
	}
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}
	}else{
	if(newsOne.contains("1#")){
	newsOne=newsOne.replace("1#", "1.");
	}
	newsTwo = message.substring(newsOne.length(),message.length());	
	if(newsTwo.contains("2#")){
	newsTwo=newsTwo.replace("2#", "2.");
	}
	if(newsTwo.contains("Pwrd by IndiaToday.in")){
	newsTwo=newsTwo.substring(0,newsTwo.indexOf("Pwrd by IndiaToday.in"));
	}
	}
	}else if(keyword.equalsIgnoreCase("pan-india-health-tips")|| keyword.equalsIgnoreCase("pan-india-beauty-tips")|| keyword.equalsIgnoreCase("pan-india-love-tips")
	||keyword.equalsIgnoreCase("pan-india-career-tips") || keyword.equalsIgnoreCase("pan-india-food-tips")|| keyword.equalsIgnoreCase("pan-india-travel-tips")|| keyword.equalsIgnoreCase("pan-india-weather-tips")
	||keyword.equalsIgnoreCase("pan-india-furniture") || keyword.equalsIgnoreCase("pan-india-relationship-tips") ){
	date = rs.getString("record_date");	
	newsOne=rs.getString("message1");	
	
	}
	out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    out.println("<data>");
    out.println("<keyword>"+keyword+"</keyword>"); 
    out.println("<timestamp>"+date+"</timestamp>"); 
    out.println("<content>");
    out.println("<![CDATA["+newsOne+newsTwo+newsThree+"]]>");
    out.println("</content>");
    out.println("<transid>31313131</transid>");   
    out.println("</data>");
	}	
	
	}		
	catch(Exception e)
	{
	out.println("");
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
	
%>
