<%@ page import="java.sql.*,conn.*,java.io.*"%><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*" %><%@page import="java.util.Properties"%><%@page import="java.util.Date"%><%	
	String date="";
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	String newsOne = "", newsTwo = "", newsThree = "",message="";		
	String keyword="",categoryName="";			
	String serviceProvider = "";	
	if(request.getParameter("keyword")!=null){
	keyword = request.getParameter("keyword");	
	
	if(keyword.equalsIgnoreCase("national")){
	keyword="National";
	categoryName="National";
	}else if(keyword.equalsIgnoreCase("national")){
	keyword="National";
	categoryName="National";
	}else if(keyword.equalsIgnoreCase("spo")){
	keyword="Sports-Spice";
	categoryName="Sports";
	}else if(keyword.equalsIgnoreCase("biz")){
	keyword="Biz-Spice";
	categoryName="Business";
	}else if(keyword.equalsIgnoreCase("stock")){
	keyword="stock-spice";
	categoryName="Stock";
	}else if(keyword.equalsIgnoreCase("intl")){
	keyword="Intl-Spice";
	categoryName="International News";
	}else if(keyword.equalsIgnoreCase("topnews")){
	keyword="TopNews";
	categoryName="Top News";
	}
	if(keyword.equalsIgnoreCase("TopNews")||keyword.equalsIgnoreCase("National")|| keyword.equalsIgnoreCase("Sports-Spice")  ||keyword.equalsIgnoreCase("Biz-Spice") || keyword.equalsIgnoreCase("stock-spice")||keyword.equalsIgnoreCase("Intl-Spice")){
	
	if(keyword.equalsIgnoreCase("Sports-Spice") ||keyword.equalsIgnoreCase("Biz-Spice")){
	serviceProvider = "ITGD";
	}else if(keyword.equalsIgnoreCase("Intl-Spice")){
	serviceProvider = "AIRTEL";
	}else if(keyword.equalsIgnoreCase("stock-spice")){
	serviceProvider = "ITGD";
	}else {
	serviceProvider = "MTNLDL";
	}

	try
	{	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","content", "l0b$tert0day%*");
	String query="";	
	stmt=cn.createStatement();
	if(keyword.equalsIgnoreCase("National")){
	rs=stmt.executeQuery("select headline_1,headline_2,headline_3,date_format(update_date,'%d%m%Y%T')record_date FROM national_news where category_id=63 order by msg_id  desc limit 1");
	}else if(keyword.equalsIgnoreCase("Intl-Spice")||keyword.equalsIgnoreCase("National")||keyword.equalsIgnoreCase("Sports-Spice") ||keyword.equalsIgnoreCase("Biz-Spice") || keyword.equalsIgnoreCase("stock-spice")){	
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date ,date_format(a.RECORD_DATE,'Date-%W,%M %d,%Y %T STOCK Market Update.') date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+keyword+"' order by a.MSG_ID  desc limit 1");
	}else if(keyword.equalsIgnoreCase("TopNews")){	
	rs=stmt.executeQuery("select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6, nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id=110)");
	}
	
	while(rs.next())
	{
	if(keyword.equalsIgnoreCase("National")){
	date = rs.getString("record_date");	
	newsOne="1)"+rs.getString("headline_1");	
	newsTwo="2)"+rs.getString("headline_2");	
	newsThree="3)"+rs.getString("headline_3");
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}	
	
	}else  if( keyword.equalsIgnoreCase("Intl-Spice")||keyword.equalsIgnoreCase("Sports-Spice") || 
	keyword.equalsIgnoreCase("Biz-Spice") || keyword.equalsIgnoreCase("stock-spice")){
if( keyword.equalsIgnoreCase("stock-spice")){
 
	date = rs.getString("record_date");	
	newsOne=rs.getString("date")+" "+rs.getString("message1");	
}else{
date = rs.getString("record_date");	
	newsOne=rs.getString("message1");
}
	if(newsOne.contains(""+keyword+">")){
	newsOne=newsOne.replaceAll(""+keyword+">","");
	}
	if(newsOne.contains("Biz:")){
	newsOne=newsOne.replaceAll("Biz:","");
	}
	}else  if( keyword.equalsIgnoreCase("TopNews")){
	
	date = rs.getString("date");	
	newsOne=rs.getString("headline_1");
	 newsTwo=rs.getString("more_1");
	 
	}
	if(keyword.equalsIgnoreCase("TopNews")){
	
    out.println(date);         
    out.println(newsOne);
    out.println(newsTwo);  
    
	
	}else{
	

    out.println(newsOne+newsTwo+newsThree);
    
	
	}
	
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
