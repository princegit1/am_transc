<%@ page contentType="text/xml; charset=ISO-8859-1" %><?xml version="1.0" encoding="ISO-8859-1" ?><rss version="2.0" xmlns:media="http://search.yahoo.com/mrss">
<channel><%@ page import="java.sql.*,conn.*,java.util.Calendar"%><%
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
if(section.equals("video-AP_Hind")||section.equals("video-hlt-headlines-news-wrap")||
section.equals("video-at-news-story")||section.equals("video-hlt-news-story")||
section.equals("video-dharma")||section.equals("video-breaking-news-hindi")||
section.equals("video-breaking-news-english")||section.equals("video-photoshoot")||
section.equals("video-vardaat")||section.equals("video-otc")||section.equals("video-bollywood-and-hollywood-gossips")||section.equals("video-celeb-interviews")||section.equals("video-fashion")||section.equals("video-sports")||section.equals("video-lifestyle")) {
int count = 0;
if(section.equals("video-AP_Hind")){
sectionId=756;
}
if(section.equals("video-AP_Islam")){
sectionId=757;
}
if(section.equals("video-AP_Sikh")){
sectionId=758;
}
if(section.equals("video-AP_Christ")){
sectionId=759;
}
if(section.equals("video-AP_Jain")){sectionId=760;}
if(section.equals("video-AP_NotKnown")){sectionId=761;}

if(section.equals("video-breaking-news-english")){sectionId=240;}
if(section.equals("video-photoshoot")){sectionId=241;}
if(section.equals("video-vardaat")){sectionId=262;}
if(section.equals("video-otc")){sectionId=263;}

if(section.equals("video-bollywood-and-hollywood-gossips")){sectionId=413;}
if(section.equals("video-celeb-interviews")){sectionId=414;}
if(section.equals("video-fashion")){sectionId=415;}
if(section.equals("video-sports")){sectionId=416;}
if(section.equals("video-lifestyle")){sectionId=417;}
    Calendar cal = null;
	cal = Calendar.getInstance();
try
{	
	//AdminConn adminConn = AdminConn.getInstance();
	//cn = adminConn.getConnection();
	Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,DATE_FORMAT(nn.update_date, '%m' ) AS month,DATE_FORMAT(nn.update_date,'%a, %d %b %Y %T IST') as date1,nn.more_1,nn.headline_1,nn.pic_1,nn.pic_2,nn.run_date from mobile_rss_news nn  where nn.category_id='"+sectionId+"' order by msg_id desc";
	stmt=cn.createStatement();
	//System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
		


	  
  if (count == 0) {
%>
<title>India Today&apos;s Videos Feed</title>
<link>http://www.indiatoday.intoday.in/</link>
<description>India Today&apos;s Videos Feed</description><%}
//if(rs.getInt("month")>=cal.get(Calendar.MONTH) &&rs.getInt("month")<=cal.get(Calendar.MONTH) + 1){
%>
<item>
<title><%=rs.getString("more_1")%></title>
<link><%=rs.getString("pic_1")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("pic_1")%>" type="video/flv" duration="<%=rs.getString("headline_1")%>">
<media:title><%=rs.getString("more_1")%></media:title>
<media:description></media:description>
<%if(sectionId==241 ||sectionId==413||sectionId==414||sectionId==415||sectionId==416||sectionId==417||sectionId==262) {
	if(rs.getString("pic_2")!=null){
		if(sectionId==413||sectionId==414||sectionId==415||sectionId==416||sectionId==417||sectionId==262||sectionId==241) {
%>
		<media:thumbnail url="http://media2.intoday.in/mobileservice/images/<%=rs.getString("pic_2")%>"/>
<% } else {%>
		<media:thumbnail>http://media2.intoday.in/mobileservice/images/<%=rs.getString("pic_2")%></media:thumbnail>
<%}
}else{%>
		<media:thumbnail></media:thumbnail>
<%}
}else{%>
	<media:thumbnail></media:thumbnail>
<%}%>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item><%//}
count++;} %>
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