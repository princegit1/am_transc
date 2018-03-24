<?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel><%@ page import="java.sql.*,conn.*"%><%
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
String sectionName="";
String date="";
String catid="";
String catsection="";

String section = request.getParameter("category");
if(section!=null && !section.equals("")){
if(section.equals("Romance-Tips")||section.equals("Romance-Destinations")||section.equals("Romance-Quotes")||section.equals("Romance-Humor")||
section.equals("Romance-Pick-up-lines")||section.equals("Relationship-Tips")||
section.equals("Relationship-Advice")||section.equals("Relationship-AgonyAunt")||section.equals("Home-Decore")||section.equals("Home-objects-of-desire")){




 int count = 0;
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select a.message1,DATE_FORMAT(a.RECORD_DATE, '%a, %d %b %Y %T IST' ) as date,b.CATEGORY_ID from message_details a, category_master b where a.category_id=b.category_id  and b.service_provider='Etisalat' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+section+"'";
	stmt=cn.createStatement();
	//System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
	
	if(rs.getString("CATEGORY_ID").equals("149")){
	sectionName="Tips";
	catsection="Romance";
	}if(rs.getString("CATEGORY_ID").equals("150")){
	sectionName="Destinations/Getaways/Holiday";
	catsection="Romance";
	}if(rs.getString("CATEGORY_ID").equals("152")){
	sectionName="Quotes";
	catsection="Romance";
	}if(rs.getString("CATEGORY_ID").equals("153")){
	sectionName="Humor";
	catsection="Romance";
	}if(rs.getString("CATEGORY_ID").equals("154")){
	sectionName="Pick up lines";
	catsection="Romance";
	}if(rs.getString("CATEGORY_ID").equals("151")){
	sectionName="Tips";
	catsection="Relationship";
	}if(rs.getString("CATEGORY_ID").equals("155")){
	sectionName="Advice";
	catsection="Relationship";
	}if(rs.getString("CATEGORY_ID").equals("156")){
	sectionName="Agony Aunt";
	catsection="Relationship";
	}if(rs.getString("CATEGORY_ID").equals("157")){
	sectionName="Home décor";
	catsection="Home";
	}if(rs.getString("CATEGORY_ID").equals("158")){
	sectionName="Objects of desire";
	catsection="Home";
	}
	
	
	

	
	
	
	
	
	
  if (count == 0) {
%>
<title>India Today | <%=catsection%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=rs.getString("date") %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>.jpg</url>
<title>India Today | <%=catsection%></title>			
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