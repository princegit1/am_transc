<?xml version="1.0" encoding="UTF-8"?><%@ page import="java.sql.*"%><%@ page import="conn.*" %><%Connection cn=null;
ResultSet rs = null,rs1=null;
Statement stmt = null,stmt1=null;
AdminConn adminConn = AdminConn.getInstance();
String upQuery="";
String headline_1="",headline_2="",headline_3="",headline_4="",headline_5="",date="",time="";		
try
{				
	upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d%m%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate() and category_id=378";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	if(rs.next()){
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d%m%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate() and category_id=378";
			
		}else{
			
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d%m%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=date(curDate()-1) and category_id=378";
			
		}
		
		stmt1=cn.createStatement();
		rs1=stmt1.executeQuery(upQuery);
	if(rs1.next())
	{				
		date = rs1.getString("record_date");				
		time = rs1.getString("record_time");			
		if(rs1.getString("headline_1").length()>1)
			headline_1= rs1.getString("headline_1");
		if(rs1.getString("headline_2").length()>1)
			headline_2=rs1.getString("headline_2") ;
		if(rs1.getString("headline_3").length()>1){
			headline_3= rs1.getString("headline_3");
			if(headline_3.contains("Pwrd by IndiaToday.in")){
			headline_3=headline_3.substring(0,headline_3.indexOf("Pwrd by IndiaToday.in"));
			}
			}

	}
	
%>
<vap version="1.0">
<contentItem lang="en-in" useOn="<%=date%>" expires="<%=date%>">
<multiPartSms>			
<part><%=headline_1%></part>
<part><%=headline_2%></part>
<part><%=headline_3%></part>
</multiPartSms>
</contentItem>
</vap>
<%
}
catch(Exception e)
{
	e.printStackTrace();
	out.println("");
}
finally
{
	rs.close();
	stmt.close();
	cn.close();
}
%>
