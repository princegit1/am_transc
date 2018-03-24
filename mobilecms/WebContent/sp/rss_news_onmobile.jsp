<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
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
String imageStatus4="";
String imageStatus5="";

String section = request.getParameter("category");
//System.out.println("---->"+section);
if(section!=null && !section.equals("")){




if(section.equals("ap")||section.equals("tn")||
section.equals("kk")||section.equals("bihar")||
section.equals("delhi")||section.equals("hp")||
section.equals("haryana")||section.equals("jk")||
section.equals("mp")||section.equals("punjab")||section.equals("gujarat")||
section.equals("rajasthan")||section.equals("maharashtra")||section.equals("west-bengal")||section.equals("up")||
section.equals("india")||section.equals("world")||section.equals("business")||section.equals("sports")||section.equals("movies")||section.equals("kerala")

){


int count = 0;

if(section.equals("ap")){sectionId=524;}
if(section.equals("tn")){sectionId=525;}
if(section.equals("kk")){sectionId=526;}
if(section.equals("bihar")){sectionId=527;}
if(section.equals("delhi")){sectionId=528;}
if(section.equals("hp")){sectionId=529;}
if(section.equals("haryana")){sectionId=530;}
if(section.equals("jk")){sectionId=531;}
if(section.equals("mp")){sectionId=532;}
if(section.equals("punjab")){sectionId=533;}
if(section.equals("gujarat")){sectionId=534;}
if(section.equals("rajasthan")){sectionId=535;}
if(section.equals("maharashtra")){sectionId=536;}
if(section.equals("west-bengal")){sectionId=537;}
if(section.equals("up")){sectionId=538;}
if(section.equals("kerala")){sectionId=671;}

if(section.equals("india")){sectionId=566;}
if(section.equals("world")){sectionId=567;}
if(section.equals("business")){sectionId=568;}
if(section.equals("sports")){sectionId=569;}
if(section.equals("movies")){sectionId=570;}



try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.msg_id,DATE_FORMAT(SUBTIME(nn.update_date, '5:30:00'), '%a, %d %b %Y %T GMT') as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3,nn.headline_4,nn.more_4,nn.pic_4,nn.headline_5,nn.more_5,nn.pic_5, nn.run_date from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"')";
	stmt=cn.createStatement();
	//System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
	
	
	catsection=section.toUpperCase()+" NEWS";

	if(catsection.contains("-"))
	catsection=catsection.replace("-"," ");
	
	
	imageStatus1=rs.getString("pic_1");	  
	imageStatus2=rs.getString("pic_2");	 
imageStatus3=rs.getString("pic_3");	 
imageStatus4=rs.getString("pic_4");	 
imageStatus5=rs.getString("pic_5");	 	  

	  
  if (count == 0) {
%>
<title>India Today | <%=catsection%></title>
<description>India Today</description>
<link>http://indiatoday.intoday.in/</link>
<lastBuildDate><%=rs.getString("date") %></lastBuildDate>
<generator>FeedCreator 1.7.2</generator>
<image>
<url>http://media2.intoday.in/mobileservice/images/rss-onmobile/<%=imageStatus1%></url>
<title>India Today | <%=catsection%></title>	
<link>http://indiatoday.intoday.in/</link>		
<description>India Today</description>
</image><%} %>
<item>
<title><%=rs.getString("headline_1")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_1")%></description>
<image>http://media2.intoday.in/mobileservice/images/<%=imageStatus1%></image>
<pubDate><%=rs.getString("date") %></pubDate>
</item>
<item>
<title><%=rs.getString("headline_2")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_2")%></description>
<image>http://media2.intoday.in/mobileservice/images/<%=imageStatus2%></image>
<pubDate><%=rs.getString("date") %></pubDate>
</item>
<item>
<title><%=rs.getString("headline_3")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_3")%></description>
<image>http://media2.intoday.in/mobileservice/images/<%=imageStatus3%></image>
<pubDate><%=rs.getString("date") %></pubDate>
</item>
<item>
<title><%=rs.getString("headline_4")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_4")%></description>
<image>http://media2.intoday.in/mobileservice/images/<%=imageStatus4%></image>
<pubDate><%=rs.getString("date") %></pubDate>
</item>
<item>
<title><%=rs.getString("headline_5")%></title>
<link>http://indiatoday.intoday.in/</link>
<description> <%=rs.getString("more_5")%></description>
<image>http://media2.intoday.in/mobileservice/images/<%=imageStatus5%></image>
<pubDate><%=rs.getString("date") %></pubDate>
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