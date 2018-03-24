<?xml version='1.0' encoding='utf-8' standalone='yes'?><%@ page contentType="text/xml;charset=ISO-8859-1" %><%@ page import="java.sql.*"%><%@ page import="java.util.Date" %><%@ page import="conn.*" %><%
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
		 //adminConn = AdminConn.getInstance();	
		//cn = adminConn.getConnection();	
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
		String upQuery1 = "SELECT m.team1,m.team2,m.MSG_ID as MSG_ID,m.smstype as smstype,m.opid as opid,m.smstext as smstext,m.matchteam as matchteam ,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%r ') record_time, em.FNAME as fname,em.EMP_ID as empId FROM iplscore_details m,employee em where m.type='gobindas_news' and  m.update_emp_id=em.EMP_ID  order by msg_id desc limit 1";
		//cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		type =rs.getString("smstype"); 
				text =rs.getString("smstext"); 				
				date = rs.getString("record_date");
				time=rs.getString("record_time");
				datetime=date+" "+time;	
				%>	<UpdatePlugContent>
  <BeforeTheClickMessage>
    <RegularBTCMessage>
      <Content><![CDATA[<%=type %>]]></Content>
      <Menu>
        <MenuItem>
          <ItemText>FULL SCORE!@Rs3</ItemText>
          <ItemAction ActionType="sms">
            <AfterTheClickMessage>
              <RegularATCMessage>
                <Content><![CDATA[<%=text %>]]></Content>
              </RegularATCMessage>
            </AfterTheClickMessage>
          </ItemAction>
        </MenuItem>
      </Menu>
    </RegularBTCMessage>
  </BeforeTheClickMessage>
</UpdatePlugContent>
		<%
		
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