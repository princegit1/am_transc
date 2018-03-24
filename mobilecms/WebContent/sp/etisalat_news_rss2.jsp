<?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel><%@ page import="java.sql.*,conn.*"%><%
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
String sectionName="";
String date="";
String catid="";

String section = request.getParameter("category");
if(section!=null && !section.equals("")){
if(section.equals("Romance")||section.equals("Relationship")||section.equals("Home")){
if(section.equals("Romance")){
catid="149,150,152,153,154";
}
if(section.equals("Relationship")){
catid="151,155,156";
}
if(section.equals("Home")){
catid="157,158";
}

 int count = 0;
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select a.message1,DATE_FORMAT(a.RECORD_DATE, '%a, %d %b %Y %T IST' ) as date,b.CATEGORY_ID from message_details a, category_master b where a.category_id=b.category_id  and b.service_provider='Etisalat' and  b.status='ACTIVE' and b.CATEGORY_ID in ("+catid+")";
	stmt=cn.createStatement();
	rs=stmt.executeQuery(selectQuery);	
	while(rs.next()){
	
	if(rs.getString("CATEGORY_ID").equals("149")){
	sectionName="Tips";
	}if(rs.getString("CATEGORY_ID").equals("150")){
	sectionName="Destinations/Getaways/Holiday";
	}if(rs.getString("CATEGORY_ID").equals("152")){
	sectionName="Quotes";
	}if(rs.getString("CATEGORY_ID").equals("153")){
	sectionName="Humor";
	}if(rs.getString("CATEGORY_ID").equals("154")){
	sectionName="Pick up lines";
	}if(rs.getString("CATEGORY_ID").equals("151")){
	sectionName="Tips";
	}if(rs.getString("CATEGORY_ID").equals("155")){
	sectionName="Advice";
	}if(rs.getString("CATEGORY_ID").equals("156")){
	sectionName="Agony Aunt";
	}if(rs.getString("CATEGORY_ID").equals("157")){
	sectionName="Home décor";
	}if(rs.getString("CATEGORY_ID").equals("158")){
	sectionName="Objects of desire";
	}
	
	
	
	
  if (count == 0) {
%>
<title>India Today | <%=section%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=rs.getString("date") %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://mobileservice.digitaltoday.in/content/img/indiatoday-logo.gif</url>
<title>India Today | <%=section%></title>			
<description>India Today</description>
</image>
<%} %>
<item>
<title><%=sectionName%></title>
<description> <%=rs.getString("message1")%></description>
</item><%count++;} %>
</channel>
</rss><% 

}
catch(Exception e)
{
System.out.print(e.toString());
}
finally
{
	rs = null;
	stmt = null;
	cn=null;
}
}
else{
out.print("CATEGORY NOT FOUND.....");
}
}else{
out.print("CATEGORY NOT FOUND.....");
}
%>