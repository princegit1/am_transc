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
String headline_7="";
String more_7="";
String headline_8="";
String more_8="";
String headline_9="";
String more_9="";
String headline_10="";
String more_10="";
String sectionname="";


String section = request.getParameter("id");
if(section!=null && !section.equals("")){
if(section.equals("435")||section.equals("436")||section.equals("437")||section.equals("438")||section.equals("439")||section.equals("440")||section.equals("441")||section.equals("442")||section.equals("443")||section.equals("444")||section.equals("445")||section.equals("446")||section.equals("447")||section.equals("448")||section.equals("449")||section.equals("450")||section.equals("451")||section.equals("452")||section.equals("453")||section.equals("454")||section.equals("455")||section.equals("456")||section.equals("457")||section.equals("458")||section.equals("459")||section.equals("460")||section.equals("461")||section.equals("462")||section.equals("463")||section.equals("464")||section.equals("465")||section.equals("466")||section.equals("467")||section.equals("468")||section.equals("469")||section.equals("470")||section.equals("471")||section.equals("472")||section.equals("473")||section.equals("474")){

if(section.equals("435")){
sectionname="spice-rajasthan-unicode";}
if(section.equals("436")){
sectionname="spice-rajasthan-roman";}
if(section.equals("437")){
sectionname="spice-bihar-unicode";}
if(section.equals("438")){
sectionname="spice-bihar-roman";}
if(section.equals("439")){
sectionname="spice-gujarat-unicode";}
if(section.equals("440")){
sectionname="spice-gujarat-roman";}
if(section.equals("441")){
sectionname="spice-delhi-unicode";}
if(section.equals("442")){
sectionname="spice-delhi-roman";}
if(section.equals("443")){
sectionname="spice-punjab-unicode";}
if(section.equals("444")){
sectionname="spice-punjab-roman";}
if(section.equals("445")){
sectionname="spice-kerala-unicode";}
if(section.equals("446")){
sectionname="spice-kerala-roman";}
if(section.equals("447")){
sectionname="spice-kolkata-wb-unicode";}
if(section.equals("448")){
sectionname="spice-kolkata-wb-roman";}
if(section.equals("449")){
sectionname="spice-assam-unicode";}
if(section.equals("450")){
sectionname="spice-assam-roman";}
if(section.equals("451")){
sectionname="spice-tamil-nadu-unicode";}
if(section.equals("452")){
sectionname="spice-tamil-nadu-roman";}
if(section.equals("453")){
sectionname="spice-andhra-pradesh-unicode";}
if(section.equals("454")){
sectionname="spice-andhra-pradesh-roman";}
if(section.equals("455")){
sectionname="spice-gujarat-unicode-regional";}
if(section.equals("456")){
sectionname="spice-rajasthan-unicode-regional";}
if(section.equals("457")){
sectionname="spice-rajasthan-roman-regional";}
if(section.equals("458")){
sectionname="spice-bihar-unicode-regional";}
if(section.equals("459")){
sectionname="spice-bihar-roman-regional";}
if(section.equals("460")){
sectionname="spice-gujarat-roman-regional";}
if(section.equals("461")){
sectionname="spice-delhi-unicode-regional";}
if(section.equals("462")){
sectionname="spice-delhi-roman-regional";}
if(section.equals("463")){
sectionname="spice-punjab-unicode-regional";}
if(section.equals("464")){
sectionname="spice-punjab-roman-regional";}
if(section.equals("465")){
sectionname="spice-kerala-unicode-regional";}
if(section.equals("466")){
sectionname="spice-kerala-roman-regional";}
if(section.equals("467")){
sectionname="spice-kolkata-wb-unicode-regional";}
if(section.equals("468")){
sectionname="spice-kolkata-wb-roman-regional";}
if(section.equals("469")){
sectionname="spice-assam-unicode-regional";}
if(section.equals("470")){
sectionname="spice-assam-roman-regional";}
if(section.equals("471")){
sectionname="spice-tamil-nadu-unicode-regional";}
if(section.equals("472")){
sectionname="spice-tamil-nadu-roman-regional";}
if(section.equals("473")){
sectionname="spice-andhra-pradesh-unicode-regional";}
if(section.equals("474")){
sectionname="spice-andhra-pradesh-roman-regional";}

try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6,nn.headline_7,nn.more_7,nn.headline_8,nn.more_8,nn.headline_9,nn.more_9,nn.headline_10,nn.more_10,nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+section+"')";
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
	 
	  
	  headline_7=rs.getString("headline_7");
	  more_7=rs.getString("more_7");
	
	 headline_8=rs.getString("headline_8");
	 more_8=rs.getString("more_8");
	 
	  headline_9=rs.getString("headline_9");
	 more_9=rs.getString("more_9");
	 
	 
	   headline_10=rs.getString("headline_10");
	 more_10=rs.getString("more_10");
	 
	 %><?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>India Today | <%=sectionname.toUpperCase().replaceAll("-"," ").replaceAll("SPICE","")%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=date %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://mobileservice.digitaltoday.in/content/img/indiatoday-logo.gif</url>
<title>India Today | <%=sectionname.toUpperCase().replaceAll("-","").replaceAll("SPICE","")%></title>			
<description>India Today</description>
</image>
<item>
<title><%=headline_1%></title>
<description> <%=more_1%></description>
</item>
<%if(section.equals("441")){%>
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
<item>
<title><%=headline_7%></title>
<description> <%=more_7%></description>
</item>
<item>
<title><%=headline_8%></title>
<description> <%=more_8%></description>
</item>
<item>
<title><%=headline_9%></title>
<description> <%=more_9%></description>
</item>
<item>
<title><%=headline_10%></title>
<description> <%=more_10%></description>
</item>
<%}%>
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