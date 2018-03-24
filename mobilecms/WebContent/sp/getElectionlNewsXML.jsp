<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
Connection cn=null;
ResultSet rs = null;
Statement stmt = null;
AdminConn adminConn = AdminConn.getInstance();
String upQuery="";
String headline_1="",headline_2="",headline_3="",date="",time="";	
int third = 0;
try
{				
	upQuery="SELECT headline_1,headline_2,headline_3,date_format(update_date,'%d%m%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate() and category_id=98";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	if(rs.next())
	{				
		date = rs.getString("record_date");				
		time = rs.getString("record_time");
		if(rs.getString("headline_1").length()>1)
			headline_1= rs.getString("headline_1");
		if(rs.getString("headline_2").length()>1)
			headline_2=rs.getString("headline_2") ;
		if(rs.getString("headline_3").length()>1){
			headline_3= rs.getString("headline_3");

			if(headline_3.contains("Pwrd by IndiaToday.in")){
			headline_3=headline_3.substring(0,headline_3.indexOf("Pwrd by IndiaToday.in"));
			}
			}
			else third = 1;

	}
%>
<vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>			
<part><%=headline_1%></part>
<part><%=headline_2%></part>
<%if(third ==0){	%><part><%=headline_3%></part>
<%}%></multiPartSms>
</contentItem>
</vap>
<%
}
catch(Exception e)
{
	out.println(e.toString());
}
finally
{
	rs.close();
	stmt.close();
	cn.close();
}
%>