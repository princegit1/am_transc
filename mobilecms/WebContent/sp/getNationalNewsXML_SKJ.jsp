<?xml version="1.0" encoding="UTF-8"?>
<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
	String headline_1="",headline_2="",headline_3="",headline_4="",headline_5="",date="",time="";		
try
		{				
			
		upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d%m%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate()";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		%>	
	<vap version="1.0">
	<contentItem lang="en-in" useOn='<%=date%>' expires='<%=date%>'>
	<multiPartSms>			
			<%
			if(rs.next())
			{				
				date = rs.getString("record_date");				
				time = rs.getString("record_time");			
				
				if(rs.getString("headline_1").length()>1)
				{
				headline_1= rs.getString("headline_1");
				%>
				<part><%=headline_1%></part>
				<%}
				if(rs.getString("headline_2").length()>1)
				{
				headline_2=rs.getString("headline_2") ;
				%>
				<part><%=headline_2%></part>
				<%
				}
				if(rs.getString("headline_3").length()>1)
				{
				headline_3= rs.getString("headline_3");
				%>
				<part><%=headline_3%></part>
				<%
				}
				if(rs.getString("headline_4").length()>1)
				{
				headline_4=rs.getString("headline_4") ;
				%>
				<part><%=headline_4%></part>
				<%
				}
				if(rs.getString("headline_5").length()>1)
				{
				headline_5=rs.getString("headline_5") ;
				%>
				<part><%=headline_5%></part>
				<%
				}
				
			}
			%>
</multiPartSms>
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