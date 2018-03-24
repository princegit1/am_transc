<%@ page import="java.sql.*,conn.*,java.io.*"%><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*" %><%@page import="java.util.Properties"%><%@page import="java.util.Date"%><%	
	String date="";
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	String newsOne = "", newsTwo = "", newsThree = "",message="";		
	String keyword="";			
	String serviceProvider = "";	
	if(request.getParameter("keyword")!=null)
	keyword = request.getParameter("keyword");	
	
	if(keyword.equalsIgnoreCase("Sports")|| keyword.equalsIgnoreCase("Filmi")){
	
	serviceProvider = "MTNLDL";
	if(keyword.equalsIgnoreCase("Sports")){
	keyword="Sports News";
	}
	

	try
	{	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
	String query="";	
	stmt=cn.createStatement();	
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");	
	
	while(rs.next())
	{
	if(keyword.equalsIgnoreCase("Sports News") || keyword.equalsIgnoreCase("Filmi")){
	
	
	message=rs.getString("message1");	
	date = rs.getString("record_date");	
				
	newsOne = message.substring(0, message.indexOf("2#"));
	
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
	}
	//out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    					//out.println("<data>");
    					//out.println("<keyword>"+keyword+"</keyword>"); 
    					//out.println("<timestamp>"+date+"</timestamp>"); 
    					//out.println("<content>");
    					//out.println("<![CDATA["+newsOne+newsTwo+newsThree+"]]>");
   					    //out.println("</content>");
    					//out.println("<transid>31313131</transid>");   
    					//out.println("</data>");
			out.print(keyword+":<BR>"+newsOne+"<BR>"+newsTwo+"<BR>"+newsThree+"");

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
	
%>
