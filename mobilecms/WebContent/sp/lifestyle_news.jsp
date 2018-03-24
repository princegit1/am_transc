<%@ page contentType="text/xml;charset=ISO-8859-1" %><xml><%@ page import="java.sql.*,conn.*"%><%
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


if(section.equals("cosmo")||section.equals("wonderwoman")){


int count = 0;
if(section.equals("cosmo")){sectionId=706;}
if(section.equals("wonderwoman")){sectionId=707;}


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
%><item>
<title><%=rs.getString("headline_1")%></title>
<text><%=rs.getString("more_1")%></text>
<image>http://media2.intoday.in/mobileservice/images/rss-onmobile/<%=imageStatus1%></image>
<title><%=rs.getString("headline_1")%></title>
<text><%=rs.getString("more_1")%></text>
<image>http://media2.intoday.in/mobileservice/images/rss-onmobile/<%=imageStatus1%></image>
</item><% 
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
%></xml>