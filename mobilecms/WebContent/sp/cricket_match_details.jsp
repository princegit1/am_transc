<%@ page contentType="text/xml;charset=ISO-8859-1" %><%@ page import="java.sql.*"%><%@ page import="java.util.Date" %><%@ page import="conn.*" %><%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = null;
	String upQuery="";
	String type = "";
	String opid = "";
	String text = "";
	String match = "";
	String date = "",MSG_ID="",time="",datetime="";
	String team1="";
	String team2="";
	String team []=null;
	String eventValue="";
	String category = "";
	
try
		{	
		 adminConn = AdminConn.getInstance();	
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT m.team1,m.team2,m.MSG_ID as MSG_ID,m.smstype as smstype,m.opid as opid,m.smstext as smstext,m.matchteam as matchteam ,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%r ') record_time, em.FNAME as fname,em.EMP_ID as empId FROM iplscore_details m,employee em where m.type='cricket' and  m.update_emp_id=em.EMP_ID  order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		type =rs.getString("smstype"); 
				text =rs.getString("smstext"); 
				match = rs.getString("matchteam"); 
				date = rs.getString("record_date");
				time=rs.getString("record_time");
				datetime=date+" "+time;				
		   		team1=rs.getString("team1");
		   		team2=rs.getString("team2");
		  
				
				if(type.equals("MAN_OF_MATCH_EVENT")){
				eventValue="MOM";
				}else if(type.equals("PRE_MATCH_ANALYSIS_EVENT")){
				eventValue="";
				}else if(type.equals("TOSS_EVENT")){
				eventValue="TOSS";
				}else if(type.equals("BREAK_EVENT")){
				eventValue="LUNCH";
				}else if(type.equals("END_OF_MATCH_EVENT")){
				eventValue="MATCH_OVER";
				}
				
				if(type.equals("SCHEDULE")){
				%>
<schedule>
<text encoding="UNICODE" lang="ENGLISH">
<![CDATA[<%=text %>]]>
</text>
</schedule>
		<%
				}else{
				
				%>
		<xml>
		<sms   team1="<%=team1 %>" team2="<%=team2 %>"    eventId="<%=type %>"     eventValue="<%=eventValue %>"    matchId="<%=rs.getString("smstype") %>">
		<text lang = "ENGLISH" encoding = "UNICODE">
		<smstext>
		<![CDATA[<%=text %>]]>
		</smstext>
		</text>
		</sms>
		</xml> 
		<%
		}
		}else{		
		%>
		No Message
		<%
		}
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