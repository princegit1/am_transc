<?xml version="1.0"?><rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel><%@ page import="java.sql.*,conn.*"%><%
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
String sectionName="";
String date="";
String catid="";
String catsection="";
int sectionId=0;
String image1="";
String image2="";
String image3="";
String image4="";
String image5="";
String image6="";
String imageStatus1="";
String imageStatus2="";
String imageStatus3="";

String section = request.getParameter("category");
//System.out.println("---->"+section);
if(section!=null && !section.equals("")){
if(section.equals("soccer-news")||section.equals("match-schedules")||
section.equals("teams")||section.equals("match-results")||section.equals("trivia")){
int count = 0;
if(section.equals("soccer-news")){sectionId=355;}
if(section.equals("match-schedules")){sectionId=356;}
if(section.equals("teams")){sectionId=357;}
if(section.equals("match-results")){sectionId=358;}
if(section.equals("trivia")){sectionId=359;}


try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3, nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"')";
	stmt=cn.createStatement();
	//System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
	sectionName=section.toUpperCase();
	catsection=section.toUpperCase()+" NEWS";
	imageStatus1=rs.getString("pic_1");	 
	  imageStatus2=rs.getString("pic_2");
	  imageStatus3=rs.getString("pic_3");	 
	
	  
	   if(imageStatus1!=null&&!imageStatus1.equals("")){
if(imageStatus1.contains("|")){
image1=imageStatus1.substring(0,imageStatus1.indexOf("|"));
image2=imageStatus1.substring(imageStatus1.indexOf("|")+1,imageStatus1.length());
}	
}
if(imageStatus2!=null&&!imageStatus2.equals("")){
if(imageStatus2.contains("|")){
image3=imageStatus2.substring(0,imageStatus2.indexOf("|"));
image4=imageStatus2.substring(imageStatus2.indexOf("|")+1,imageStatus2.length());

}
}
if(imageStatus3!=null&&!imageStatus3.equals("")){
if(imageStatus3.contains("|")){
image5=imageStatus3.substring(0,imageStatus3.indexOf("|"));
image6=imageStatus3.substring(imageStatus3.indexOf("|")+1,imageStatus3.length());

}
}

	  
  if (count == 0) {
%>
<title>India Today | <%=catsection%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=rs.getString("date") %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>.jpg</url>
<title>India Today | <%=catsection%></title>			
<description>India Today</description>
</image><%} %>
<item>
<title><%=rs.getString("headline_1")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_1")%></description>
<image><%if(image1.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>.jpg<%} %></image>
<image><%if(image2.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>-128.jpg<%} %></image>
</item>
<item>
<title><%=rs.getString("headline_2")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_2")%></description>
<image><%if(image3.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>_1.jpg<%} %></image>
<image><%if(image4.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>_1-128.jpg<%} %></image>
</item>
<item>
<title><%=rs.getString("headline_3")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_3")%></description>
<image><%if(image5.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>_2.jpg<%} %></image>
<image><%if(image6.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/latinamerica/<%=section%>_2-128.jpg<%} %></image>
</item><%count++;} %>
</channel>
</rss>
<% 

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