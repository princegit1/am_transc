<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,conn.*,java.io.*"%><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*" %><%@page import="java.util.Properties"%><%@page import="java.util.Date"%><%	
	String date="";
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	String newsOne = "", newsTwo = "", newsThree = "",message="";
	String[] astroSign = { "ARI", "TAU", "GEM", "CAN", "LEO", "VIR","LIB", "SCO", "SAG", "CAP", "AQU", "PIS"};	
	String keyword="";			
	String serviceProvider = "";	
	if(request.getParameter("keyword")!=null)
	keyword = request.getParameter("keyword");	
	
	if(keyword.equalsIgnoreCase("Hollywood-Reports") || keyword.equalsIgnoreCase("Indian-Cricket")|| keyword.equalsIgnoreCase("National")|| keyword.equalsIgnoreCase("Filmi")|| keyword.equalsIgnoreCase("liveindiacricket")
	||keyword.equalsIgnoreCase("ARI") || keyword.equalsIgnoreCase("TAU")|| keyword.equalsIgnoreCase("GEM")|| keyword.equalsIgnoreCase("CAN")
	||keyword.equalsIgnoreCase("LEO") || keyword.equalsIgnoreCase("VIR")|| keyword.equalsIgnoreCase("LIB")|| keyword.equalsIgnoreCase("SCO")
	||keyword.equalsIgnoreCase("SAG") || keyword.equalsIgnoreCase("CAP")|| keyword.equalsIgnoreCase("AQU")|| keyword.equalsIgnoreCase("PIS")
	||keyword.equalsIgnoreCase("6D-Aircel-Spo-News") || keyword.equalsIgnoreCase("6D-Aircel-Eng-Football")|| keyword.equalsIgnoreCase("6D-Aircel-F1")|| keyword.equalsIgnoreCase("6D-Aircel-Tennis")
	||keyword.equalsIgnoreCase("6D-Aircel-Biz-News") || keyword.equalsIgnoreCase("6D-Aircel-Stock-News")){
	
	if(keyword.equalsIgnoreCase("Hollywood-Reports")||keyword.equalsIgnoreCase("Indian-Cricket")|| keyword.equalsIgnoreCase("liveindiacricket")||keyword.equalsIgnoreCase("6D-Aircel-Spo-News") || keyword.equalsIgnoreCase("6D-Aircel-Eng-Football")|| keyword.equalsIgnoreCase("6D-Aircel-F1")|| keyword.equalsIgnoreCase("6D-Aircel-Tennis")
	||keyword.equalsIgnoreCase("6D-Aircel-Biz-News") || keyword.equalsIgnoreCase("6D-Aircel-Stock-News")){
	serviceProvider = "ITGD";
	}else{
	serviceProvider = "MTNLDL";
	}

	try
	{	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
	String query="";	
	stmt=cn.createStatement();
	if(keyword.equalsIgnoreCase("National")){
	rs=stmt.executeQuery("select headline_1,headline_2,headline_3,date_format(update_date,'%d%m%Y%T')record_date FROM national_news where category_id=63 order by msg_id  desc limit 1");
	}else if(keyword.equalsIgnoreCase("Hollywood-Reports") || keyword.equalsIgnoreCase("Indian-Cricket")|| keyword.equalsIgnoreCase("National")|| keyword.equalsIgnoreCase("Filmi")|| keyword.equalsIgnoreCase("liveindiacricket")||keyword.equalsIgnoreCase("6D-Aircel-Spo-News") || keyword.equalsIgnoreCase("6D-Aircel-Eng-Football")|| keyword.equalsIgnoreCase("6D-Aircel-F1")|| keyword.equalsIgnoreCase("6D-Aircel-Tennis")
	||keyword.equalsIgnoreCase("6D-Aircel-Biz-News") || keyword.equalsIgnoreCase("6D-Aircel-Stock-News")){	
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");
	}else{
	 for (int i = 0; i < 12; i++) {
       if(keyword.equalsIgnoreCase(astroSign[i])){
       String astroMessage=	message+(i+1);  
       String ss="SELECT message"+astroMessage+" as astroData,date_format(run_date,'%d%m%Y%T')record_date FROM message_details where category_id=16 and run_date=curDate()";
       rs=stmt.executeQuery(ss);
	}
	}
	}
	
	while(rs.next())
	{
	if(keyword.equalsIgnoreCase("National")){
	date = rs.getString("record_date");	
	newsOne="1."+rs.getString("headline_1");	
	newsTwo="2."+rs.getString("headline_2");	
	newsThree="3."+rs.getString("headline_3");
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}	
	
	}else  if(keyword.equalsIgnoreCase("Hollywood-Reports") || keyword.equalsIgnoreCase("Indian-Cricket")|| keyword.equalsIgnoreCase("National")|| keyword.equalsIgnoreCase("Filmi")){
	
	
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
	}else if(keyword.equalsIgnoreCase("liveindiacricket")||keyword.equalsIgnoreCase("6D-Aircel-Spo-News") || keyword.equalsIgnoreCase("6D-Aircel-Eng-Football")|| keyword.equalsIgnoreCase("6D-Aircel-F1")|| keyword.equalsIgnoreCase("6D-Aircel-Tennis")
	||keyword.equalsIgnoreCase("6D-Aircel-Biz-News") || keyword.equalsIgnoreCase("6D-Aircel-Stock-News")){
	date = rs.getString("record_date");	
	newsOne=rs.getString("message1");	
	if(newsOne.contains(""+keyword+">")){
	newsOne=newsOne.replaceAll(""+keyword+">","");
	}
	}else{
	date = rs.getString("record_date");	
	newsOne=rs.getString("astroData");	
	if(newsOne.contains(""+keyword+">")){
	newsOne=newsOne.replaceAll(""+keyword+">","");
	}
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
