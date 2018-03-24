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

if(section.equals("movies-updates-latest-release")||
section.equals("movies-updates-review")||
section.equals("movies-updates-upcoming-movies")||
section.equals("movies-updates-mvie-star-trivia-suggestion")||
section.equals("star-dust-latest-gossip")||
section.equals("star-dust-stars-biography")||
section.equals("star-dust-stars-latest-news")||
section.equals("food-recipe")||
section.equals("food-food-tip")||
section.equals("food-health-food")||
section.equals("fashion-fashion-tips")||
section.equals("cars-review")||
section.equals("cars-latest-cars")||
section.equals("cars-stars-favorite-buddy")||
section.equals("cars-concept")||
section.equals("magazines-cosmplitan")){

int count = 0;


if(section.equals("movies-updates-latest-release")){
sectionId=362;
}
if(section.equals("movies-updates-review")){
sectionId=363;
}
if(section.equals("movies-updates-upcoming-movies")){
sectionId=364;
}
if(section.equals("movies-updates-mvie-star-trivia-suggestion")){
sectionId=365;
}
if(section.equals("star-dust-latest-gossip")){
sectionId=366;
}
if(section.equals("star-dust-stars-biography")){
sectionId=367;
}
if(section.equals("star-dust-stars-latest-news")){
sectionId=368;
}
if(section.equals("food-recipe")){
sectionId=369;
}
if(section.equals("food-food-tip")){
sectionId=370;
}
if(section.equals("food-health-food")){
sectionId=371;
}
if(section.equals("fashion-fashion-tips")){
sectionId=372;
}
if(section.equals("cars-review")){
sectionId=373;
}
if(section.equals("cars-latest-cars")){
sectionId=374;
}
if(section.equals("cars-stars-favorite-buddy")){
sectionId=375;
}
if(section.equals("cars-concept")){
sectionId=376;
}
if(section.equals("magazines-cosmplitan")){
sectionId=377;
}



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
<image><%if(image1.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/imi/<%=section%>.jpg<%} %></image>
<image><%if(image2.equals("YES")){ %>http://mobileservice.digitaltoday.in/content/img/imi/<%=section%>-128.jpg<%} %></image>
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