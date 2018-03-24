<%@ page import="java.sql.*"%><%@ page import="conn.*" %><%
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
String name="";
String date="";
String headline_1="";
String more_1="";
String headline_2="";
String more_2="";
String headline_3="";
String more_3="";
String headline_4="";
String more_4="";
String headline_5="";
String more_5="";
String headline_6="";
String more_6="";
String sectionname="";
String section = request.getParameter("id");
if(section!=null && !section.equals("")){
if(section.equals("110")||section.equals("111")||section.equals("112")||section.equals("113")||section.equals("122")||section.equals("123")){
if(section.equals("110")){
sectionname="National";
}
if(section.equals("111")){
sectionname="Sports";
}
if(section.equals("112")){
sectionname="International";
}
if(section.equals("113")){
sectionname="Business";
}
if(section.equals("122")){
sectionname="TN-Regional";
}
if(section.equals("123")){
sectionname="KERALA-Regional";
}
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6, nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+section+"')";
	stmt=cn.createStatement();
	rs=stmt.executeQuery(selectQuery);	
	if(rs.next())
	{
	 
	 date=rs.getString("date");
	 headline_1=rs.getString("headline_1");
	 more_1=rs.getString("more_1");
	 headline_2=rs.getString("headline_2");
	 more_2=rs.getString("more_2");
	 headline_3=rs.getString("headline_3");
	 more_3=rs.getString("more_3");
	 headline_4=rs.getString("headline_4");
	 more_4=rs.getString("more_4");
	 headline_5=rs.getString("headline_5");
	 more_5=rs.getString("more_5");
	 headline_6=rs.getString("headline_6");
	 more_6=rs.getString("more_6");
	 %><?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>India Today | <%=sectionname%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=date %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://mobileservice.digitaltoday.in/content/img/indiatoday-logo.gif</url>
<title>India Today | <%=sectionname%></title>			
<description>India Today</description>
</image>
<item>
<title><%=headline_1%></title>
<description> <%=more_1%></description>
</item>
<item>
<title><%=headline_2%></title>
<description> <%=more_2%></description>
</item>
<item>
<title><%=headline_3%></title>
<description> <%=more_3%></description>
</item>
<item>
<title><%=headline_4%></title>
<description> <%=more_4%></description>
</item>
<item>
<title><%=headline_5%></title>
<description> <%=more_5%></description>
</item>
<item>
<title><%=headline_6%></title>
<description> <%=more_6%></description>
</item>
</channel>        
</rss>
<%
 }else{
	 out.print("DATA NOT FOUND FOR THIS CATEGORY.....");
	 }
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