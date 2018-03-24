<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
	String type = "";
	String opid = "";
	String text = "";
	String match = "";
	String date = "",MSG_ID="",time="",datetime="";
	
	
		
try
		{	
			
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.smstype as smstype,m.opid as opid,m.smstext as smstext,m.matchteam as matchteam ,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%r ') record_time, em.FNAME as fname,em.EMP_ID as empId FROM iplscore_details m,employee em where  m.update_emp_id=em.EMP_ID  order by msg_id desc limit 1";
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
				
				
				
				out.println("<strong>TYPE</strong>&nbsp;&nbsp;-&nbsp;" + type+"<BR><BR>");
				out.println("<strong>TEXT</strong>&nbsp;&nbsp;-&nbsp;" + text+"<BR><BR>" );	
				out.println("<strong>MATCH</strong>&nbsp;&nbsp;-&nbsp;" + match+"<BR><BR>" );	
				out.println("<strong>DATE</strong>&nbsp;&nbsp;-&nbsp;" + datetime );	
				
				
				

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