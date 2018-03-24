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
//String section = request.getParameter("category");
String section = "astro-vuclip";
if(section!=null && !section.equals("")){
if(section.equals("astro-vuclip")) {
int count = 0;
if(section.equals("astro-vuclip")){
sectionId=488;
}
Calendar cal = null;
cal = Calendar.getInstance();
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="SELECT nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) AS DATE,DATE_FORMAT(nn.update_date, '%m' ) AS MONTH,DATE_FORMAT(nn.update_date,'%a, %d %b %Y %T IST') AS date1,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6,nn.headline_7,nn.more_7,nn.headline_8,nn.more_8,nn.headline_9,nn.more_9,nn.headline_10,nn.more_10,nn.headline_11,nn.more_11,nn.headline_12,nn.more_12,nn.pic_1,nn.pic_2,nn.pic_3,nn.pic_4,nn.pic_5,nn.pic_6,nn.pic_7,nn.pic_8,nn.pic_9,nn.pic_10,nn.pic_11,nn.pic_12,nn.run_date FROM mobile_rss_news nn  WHERE nn.category_id='488' AND nn.msg_id= (SELECT MAX(nn1.msg_id) FROM mobile_rss_news nn1  WHERE nn1.category_id='488')";
	stmt=cn.createStatement();	
	rs=stmt.executeQuery(selectQuery);	
	while(rs.next()){
	if (count == 0) {
%>
<title>India Today&apos;s Astro Videos Feed</title>
<link>http://www.indiatoday.intoday.in/</link>
<description>India Today&apos;s Astro  Videos Feed</description><%}
%>
<item>
<title><%=rs.getString("headline_1")%></title>
<link><%=rs.getString("more_1")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_1")%>" type="video/flv" duration="<%=rs.getString("pic_1")%>">
<media:title><%=rs.getString("headline_1")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Aries.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_2")%></title>
<link><%=rs.getString("more_2")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_2")%>" type="video/flv" duration="<%=rs.getString("pic_2")%>">
<media:title><%=rs.getString("headline_2")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Taurus.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_3")%></title>
<link><%=rs.getString("more_3")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_3")%>" type="video/flv" duration="<%=rs.getString("pic_3")%>">
<media:title><%=rs.getString("headline_3")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Gemini.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_4")%></title>
<link><%=rs.getString("more_4")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_4")%>" type="video/flv" duration="<%=rs.getString("pic_4")%>">
<media:title><%=rs.getString("headline_4")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Cancer.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_5")%></title>
<link><%=rs.getString("more_5")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_5")%>" type="video/flv" duration="<%=rs.getString("pic_5")%>">
<media:title><%=rs.getString("headline_5")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Leo.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_6")%></title>
<link><%=rs.getString("more_6")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_6")%>" type="video/flv" duration="<%=rs.getString("pic_6")%>">
<media:title><%=rs.getString("headline_6")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Virgo.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_7")%></title>
<link><%=rs.getString("more_7")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_7")%>" type="video/flv" duration="<%=rs.getString("pic_7")%>">
<media:title><%=rs.getString("headline_7")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Libra.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_8")%></title>
<link><%=rs.getString("more_8")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_8")%>" type="video/flv" duration="<%=rs.getString("pic_8")%>">
<media:title><%=rs.getString("headline_8")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Scorpio.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_9")%></title>
<link><%=rs.getString("more_9")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_9")%>" type="video/flv" duration="<%=rs.getString("pic_9")%>">
<media:title><%=rs.getString("headline_9")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Sagittarius.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_10")%></title>
<link><%=rs.getString("more_10")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_10")%>" type="video/flv" duration="<%=rs.getString("pic_10")%>">
<media:title><%=rs.getString("headline_10")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Capricorn.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_11")%></title>
<link><%=rs.getString("more_11")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_11")%>" type="video/flv" duration="<%=rs.getString("pic_11")%>">
<media:title><%=rs.getString("headline_11")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Aquarius.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<item>
<title><%=rs.getString("headline_12")%></title>
<link><%=rs.getString("more_12")%></link>
<description></description>
<pubDate><%=rs.getString("date1")%></pubDate>
<media:content url="<%=rs.getString("more_12")%>" type="video/flv" duration="<%=rs.getString("pic_12")%>">
<media:title><%=rs.getString("headline_12")%></media:title>
<media:description></media:description>
<media:thumbnail>http://media2.intoday.in/mobileservice/images/astro/Pisces.jpg</media:thumbnail>
<media:keywords></media:keywords>
<media:category></media:category>
<guid></guid>
</media:content>
</item>
<%count++;} %>
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