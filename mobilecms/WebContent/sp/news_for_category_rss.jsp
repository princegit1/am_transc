<?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<%@ page import="java.sql.*,java.util.ArrayList,conn.*"%><%
	int totalMsg = 0;
	int categoryId = 0;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
	Connection cn=null;	
	ResultSet rs=null;
	Statement stmt=null;
	String msg="";
	String lastbuildDate="";
	int msg_id=0;
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",newsFour = "",newsFive = "";
	//String username = request.getParameter("username");
	//String password = request.getParameter("password");	
	String serviceProvider = request.getParameter("serviceProvider");
	System.out.print(serviceProvider);
	if(serviceProvider.equals("b!")||serviceProvider.equals("b") ){
	serviceProvider ="MTNLDL";
	}
	if(serviceProvider.equals("buongiorno")){
	serviceProvider ="AIRTEL";
	}
	if(serviceProvider.equals("itgd")){
	serviceProvider ="ITGD";
	}
	
	String category = request.getParameter("category");	
			
		try
		{		
		upQuery="select date_format(run_date,'%d%m%Y')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+category+"' order by a.msg_id desc limit 1";
	//out.println(upQuery);
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);		
		while(rs.next())
		{
		msg=rs.getString("message1");
		lastbuildDate=rs.getString("run_date");
		msg_id=rs.getInt("msg_id");
		if(msg.contains("Biz:")){
		msg=msg.replaceAll("Biz:","");
		newsOne = msg.substring(0, msg.indexOf("2#"));
		newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
		newsThree = msg.substring(msg.indexOf("3#"), msg.length());
		if(newsOne.contains("1#")){
		newsOne=newsOne.replace("1#", "1.");
		}	
		if(newsTwo.contains("2#")){
		newsTwo=newsTwo.replace("2#", "2.");
		}	
		if(newsThree.contains("3#")){
		newsThree=newsThree.replace("3#", "3.");
		}
		out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree);
		}else{
		

		if(category.equals("Filmi"))
			{
				newsOne = msg.substring(0, msg.indexOf("2#"));
			newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
			newsThree = msg.substring(msg.indexOf("3#"), msg.length());
			if(newsOne.contains("1#")){
			newsOne=newsOne.replace("1#", "1.");
			}	
			if(newsTwo.contains("2#")){
			newsTwo=newsTwo.replace("2#", "2.");
			}	
			if(newsThree.contains("3#")){
			newsThree=newsThree.replace("3#", "3.");
			}
			out.print("FILMY:"+newsOne+" "+newsTwo+" "+newsThree);
			}else if(category.equals("sports-mtn") || category.equals("Business News-mtn") || category.equals("Entertainment-mtn") || category.equals("exchange rates-mtn") || category.equals("Finance news-mtn") || category.equals("History-mtn") || category.equals("International news-mtn") || category.equals("Market Indicators-mtn") || category.equals("Market Reports-mtn") || category.equals("SA News-mtn"))
			{
			%>
			
<title><%=msg%></title>
<link></link>
<description><%=msg%></description>
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
			}
			else {
			newsOne = msg.substring(0, msg.indexOf("2#"));
			newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
			newsThree = msg.substring(msg.indexOf("3#"), msg.length());
			if(newsOne.contains("1#")){
			newsOne=newsOne.replace("1#", "1.");
			}	
			if(newsTwo.contains("2#")){
			newsTwo=newsTwo.replace("2#", "2.");
			}	
			if(newsThree.contains("3#")){
			newsThree=newsThree.replace("3#", "3.");
			}
			out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree);
		
			}
			
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
	
%>