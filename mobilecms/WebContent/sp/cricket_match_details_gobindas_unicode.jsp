<?xml version='1.0' encoding='utf-8' standalone='yes'?><%@ page contentType="text/xml;charset=utf-8" %><%@ page import="java.sql.*"%><%@ page import="java.util.Date" %><%@ page import="conn.*" %><%
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
		cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
		
		String upQuery1 = "SELECT a.message1,a.message2,DATE_FORMAT(a.RECORD_DATE,'%d-%m-%Y')run_date1 ,DATE_FORMAT(a.RECORD_DATE,'%d%M. %l%p ') DATE ,time_format(a.RECORD_DATE,'%r ') record_time FROM message_details_unicode a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='ITGD' AND  STATUS='ACTIVE' AND category_type='gobindas-unicode-cricket-score' ORDER BY a.MSG_ID  DESC LIMIT 1";
		
		
	
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		type =new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8");
				text =new String(new String(rs.getString("message2")).getBytes("ISO-8859-1"), "UTF-8"); 				
				date = rs.getString("run_date1");
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