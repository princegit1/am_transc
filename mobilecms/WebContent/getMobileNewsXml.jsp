<?xml version="1.0" encoding="UTF-8"?><%@ page import="java.sql.*,conn.*"%><%String category = request.getParameter("Circle");String completeNews="",newsOne="",newsTwo="" , newsThree="";
String[] cCodeArr = { "BHR","DEL","HRY","HP","JK","MP","PUN","UPW","WB","RAJ"};
String[] cNameArr = {"BIHAR","DELHI","HARYANA", "HP", "JammuKashmir","MP","PUNJAB","UP","WESTBENGAL","RAJASTHAN"}; 
Connection cn=null;
ResultSet rs = null;
Statement stmt = null;
String str = "";
String name = "";
String date = "";
String time = "";
int a1,a2 ;
String aa="",ab ="",tempStr =""; 
AdminConn adminConn = AdminConn.getInstance();
try
{
	cn = adminConn.getConnection();
	String upQuery1 = "select news_id, news, date_format(a.record_date,'%d%m%Y')record_date,time_format(a.record_date,'%r ')record_time,fname,lname  from mobile_news_new_one a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_new_one)";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery1);
	if(rs.next())
	{
		str = rs.getString("news");			
		name = (rs.getString("fname") +" "+ rs.getString("lname"));				
		date = rs.getString("record_date");				
		time = rs.getString("record_time");
	}
}
catch(Exception e)
{
	out.println(e.toString());
}
finally
{
	if(rs!=null)
		rs.close();
	if(stmt!=null)
		stmt.close();
	if(cn!=null)
		cn.close();
}
if(category!=null) 
{
	for(int i=0;i<10;i++)
	{
	
	
	if(str!=""&& str.contains(cCodeArr[i])){
	a1 = str.indexOf(cCodeArr[i]+":");
	aa =  str.substring(a1,str.length());
	a2 = aa.indexOf("<br>");
	ab =  aa.substring(0,a2);
	tempStr = cCodeArr[i]+":";
	
		if(category.equals(cNameArr[i]))
		{
			completeNews= ab.substring(ab.indexOf(tempStr)+tempStr.length());	
			newsOne=completeNews.substring(completeNews.indexOf("#")+1,completeNews.indexOf("2#")).trim();			
			if(completeNews.contains("3#"))
			{
			newsTwo=completeNews.substring(completeNews.indexOf("2#")+2,completeNews.indexOf("3#")).trim();
			newsThree=completeNews.substring(completeNews.indexOf("3#")+2,completeNews.length()).trim();	
			
			}else{
			newsTwo=completeNews.substring(completeNews.indexOf("2#")+2,completeNews.length()).trim();	
			}
			
if(!completeNews.contains("3#")){			
%>
<vap version="1.0">
<contentItem lang="en-in" useOn='<%=date%>' expires='<%=date%>'>
<multiPartSms>
<part><%=newsOne%></part>
<part><%=newsTwo%></part>
</multiPartSms>
</contentItem>
</vap>
<%}else{

%>
<vap version="1.0">
<contentItem lang="en-in" useOn='<%=date%>' expires='<%=date%>'>
<multiPartSms>
<part><%=newsOne%></part>
<part><%=newsTwo%></part>
<part><%=newsThree%></part>
</multiPartSms>
</contentItem>
</vap>
<%

}
		}
		}
	}
} else {
	out.println("Please provide the url with correct Circle Name ");
}  
%> 