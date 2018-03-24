<?xml version="1.0" encoding="UTF-8"?>    
<Nearnet>
<%@ page contentType="text/xml;charset=ISO-8859-1" %><%@ page import="java.sql.*,conn.*,java.util.Calendar"%><%
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

if(section!=null && !section.equals("")){
if(section.equals("news-politics")||section.equals("entertainment-movie-trailers")||
section.equals("celebs-gossip")||section.equals("fashion-lifestyle")||
section.equals("devotional")) 
{

int count = 0;
if(section.equals("news-politics")){
sectionId=556;
}
if(section.equals("entertainment-movie-trailers")){
sectionId=557;
}
if(section.equals("celebs-gossip")){
sectionId=558;
}
if(section.equals("fashion-lifestyle")){
sectionId=559;
}
if(section.equals("devotional")){
	
	sectionId=560;
}
Calendar cal = null;
cal = Calendar.getInstance();
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(nn.update_date, '%a, %d %b %Y %T IST' ) as date,DATE_FORMAT(nn.update_date, '%m' ) AS month,DATE_FORMAT(nn.update_date,'%a, %d %b %Y %T IST') as date1,nn.more_1,nn.more_2,nn.more_3,nn.headline_1,nn.headline_2,nn.headline_3,nn.headline_4,nn.pic_1,nn.pic_2,nn.pic_3,nn.run_date from mobile_rss_news nn  where nn.category_id='"+sectionId+"' order by msg_id desc limit 1";
	System.out.println("@@@@@@@@@@"+selectQuery);
	
	stmt=cn.createStatement();
	
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
		


	  

%><object>
<language>en</language>
<partner_id><%=sectionId%></partner_id>
<content_id><%=rs.getString("msg_id")%></content_id>
<source>3G</source>
<title><%=rs.getString("headline_1")%></title>
<desc><%=rs.getString("more_1")%></desc>
<keyword><%=rs.getString("pic_1")%></keyword>
<artist></artist>
<album></album>
<actor></actor>
<composer></composer>
<director></director>
<developer></developer>
<publisher>IndiaToday</publisher>
<price><%=rs.getString("headline_4")%></price>
<rank>1</rank>
<recommendation>1</recommendation>
<age_group>1</age_group>
<min_age>18</min_age>
<max_age>8</max_age>
<version>version1</version>
<year_published></year_published>
<release_date></release_date>
<start></start>
<end></end>
<file_type>3gp</file_type>
<file_size><%=rs.getString("more_3")%></file_size>
<content_type>Video</content_type>
<duration_sec><%=rs.getString("headline_3")%></duration_sec>
<bitrate><%=rs.getString("pic_3")%></bitrate>
<mobile_url><%=rs.getString("more_2")%></mobile_url>
<web_url></web_url>
<sample_url_web></sample_url_web>
<sample_url_mobile></sample_url_mobile>
<preview_url><%=rs.getString("headline_2")%></preview_url>
<sms_auto_sms></sms_auto_sms>
<thumbnail_url>http://media2.intoday.in/mobileservice/images/BSB-Airtel/<%=rs.getString("pic_2")%></thumbnail_url>
<category1><%=section%></category1>
</object><%}

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
</Nearnet>  