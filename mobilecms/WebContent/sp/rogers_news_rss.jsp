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
System.out.println("---->"+section);
if(section!=null && !section.equals("")){
if(section.equals("national-india")||section.equals("national-china")||
section.equals("national-philippines")||section.equals("national-latinamerica")||
section.equals("national-caribbean")||section.equals("national-middleeast")||
section.equals("regional-india")||section.equals("business-india")||
section.equals("business-china")||section.equals("business-philippines")||section.equals("business-latinamerica")
||section.equals("business-caribbean")||section.equals("business-middleeast")||
section.equals("sports-india")||section.equals("sports-china")||section.equals("sports-philippines")||
section.equals("sports-latinamerica")||section.equals("sports-caribbean")||section.equals("sports-middleeast")||section.equals("entertainment")||section.equals("bollywood")||section.equals("punjab")||
section.equals("gujarat")||section.equals("tamilnadu")||section.equals("andhrapradesh")||section.equals("westbengal")||section.equals("karnataka")){
int count = 0;
if(section.equals("national-india")){
sectionId=160;
}
if(section.equals("national-china")){
sectionId=161;
}
if(section.equals("national-philippines")){
sectionId=162;
}
if(section.equals("national-latinamerica")){
sectionId=163;
}
if(section.equals("national-caribbean")){sectionId=164;}
if(section.equals("national-middleeast")){sectionId=165;}
if(section.equals("regional-india")){sectionId=166;}
if(section.equals("business-india")){sectionId=167;}
if(section.equals("business-china")){sectionId=168;}
if(section.equals("business-philippines")){sectionId=169;}
if(section.equals("business-latinamerica")){sectionId=170;}
if(section.equals("business-caribbean")){sectionId=171;}
if(section.equals("business-middleeast")){sectionId=172;}
if(section.equals("sports-india")){sectionId=173;}
if(section.equals("sports-china")){sectionId=174;}
if(section.equals("sports-philippines")){sectionId=175;}
if(section.equals("sports-latinamerica")){sectionId=176;}
if(section.equals("sports-caribbean")){sectionId=177;}
if(section.equals("sports-middleeast")){sectionId=178;}
if(section.equals("entertainment")){sectionId=179;}
if(section.equals("bollywood")){sectionId=180;}
if(section.equals("punjab")){sectionId=182;}
if(section.equals("gujarat")){sectionId=183;}
if(section.equals("tamilnadu")){sectionId=184;}
if(section.equals("andhrapradesh")){sectionId=185;}
if(section.equals("westbengal")){sectionId=186;}
if(section.equals("karnataka")){sectionId=187;}


try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3, nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"')";
	stmt=cn.createStatement();
	//System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
	if(!section.equals("entertainment")&&!section.equals("bollywood")&&!section.equals("punjab")&&!section.equals("gujarat")
	&&!section.equals("tamilnadu")&&!section.equals("andhrapradesh")&&!section.equals("westbengal")&&!section.equals("karnataka")
	){
	catsection=section.substring(0,section.indexOf("-")).toUpperCase()+" NEWS";
	sectionName=section.substring(section.indexOf("-")+1,section.length()).toUpperCase();
	}else{
	sectionName=section.toUpperCase();
	catsection=section.toUpperCase()+" NEWS";
	}
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
<url>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>.jpg</url>
<title>India Today | <%=catsection%></title>			
<description>India Today</description>
</image><%} %>
<item>
<title><%=rs.getString("headline_1")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_1")%></description>
<image><%if(image1.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>.jpg<%} %></image>
<image><%if(image2.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>-128.jpg<%} %></image>
</item>
<item>
<title><%=rs.getString("headline_2")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_2")%></description>
<image><%if(image3.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>_1.jpg<%} %></image>
<image><%if(image4.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>_1-128.jpg<%} %></image>
</item>
<item>
<title><%=rs.getString("headline_3")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_3")%></description>
<image><%if(image5.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>_2.jpg<%} %></image>
<image><%if(image6.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/rss/<%=section%>_2-128.jpg<%} %></image>
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