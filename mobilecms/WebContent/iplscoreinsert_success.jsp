<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="org.apache.commons.httpclient.HttpClient,org.apache.commons.httpclient.HttpStatus,org.apache.commons.httpclient.methods.PostMethod"%>
<%@ page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%@ page import="conn.*,com.itgd.server.*"%>
<html>
  <head>
    <title>
      Mobile Service
    </title>
  </head>
  <head></head>
  <body bgcolor="#ffffff">
   <jsp:include page="topBand.jsp"/>
    <%
    String fname = (String)session.getAttribute("fname");
    String MSG_ID = (String)session.getAttribute("MSG_ID");
    String msg="";
    if(fname == null)
    {
      response.sendRedirect("index.jsp?msg=session exp.");
    }
   int empId = Integer.parseInt((String)session.getAttribute("empId"));
   MyValid3 val3 = new MyValid3();
    Connection cn=null;    
   	String type = "";
	String opid = "";
	String text = "";
	String match = "";
	String datetime="",name="",date="",time="",smstype="",smsopid="",smstext="",smsmatch="",smsdatetime="";
	
	ResultSet rs = null;
	Statement stmt = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	int statuscode=0;
	
		type =request.getParameter("type"); 
		opid =request.getParameter("opid"); 
		text =request.getParameter("text"); 
		match =request.getParameter("match"); 
		datetime =request.getParameter("datetime"); 

%>
<%
				//Inserting data into DB 				
				
				type =val3.doAddSlashesString(type);
				opid =val3.doAddSlashesString(opid);
				text =val3.doAddSlashesString(text);
				match =val3.doAddSlashesString(match);	
	
    			AdminConn adminConn = AdminConn.getInstance();
  			  	cn = adminConn.getConnection();
    			
    			try
    				{
     
                	String sqlinsert="INSERT INTO iplscore_details (smstype,opid,smstext,matchteam,RECORD_DATE,UPDATE_EMP_ID ) VALUES ('"+type+"','"+opid+"','"+text+"','"+match+"',now(),'"+empId+"')";
               		stmt = cn.createStatement();
					stmt.executeUpdate(sqlinsert);
                	//cn.commit();
				 
			  		}
              			catch(Exception e)
              		{
				      	e.printStackTrace();
              		}
              finally
              		{
                     	stmt = null;
              	}
          	

		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.smstype as smstype,m.opid as opid,m.smstext as smstext,m.matchteam as matchteam ,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%I:%i %p') record_time, em.FNAME as fname,em.EMP_ID as empId FROM iplscore_details m,employee em where  m.update_emp_id=em.EMP_ID order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt1=cn.createStatement();
		rs=stmt1.executeQuery(upQuery1);
		if(rs.next())
		{		MSG_ID=rs.getString("MSG_ID");
				smstype =rs.getString("smstype"); 
				smstext =rs.getString("smstext"); 
				smsmatch = rs.getString("matchteam");
				name = rs.getString("fname");
				date = rs.getString("record_date");
				time=rs.getString("record_time");
				smsdatetime=date+" "+time;
				

		}

				%>
<%

		HttpClient client = new HttpClient();
		client.getParams().setParameter("http.useragent", "Test Client");
		BufferedReader br = null;
		PostMethod method = new PostMethod("http://202.78.174.252/SistemaAlerts/iplscore");
		method.addParameter("username", "espn");
		method.addParameter("password", "espn123");
		method.addParameter("type", smstype);
		method.addParameter("opid", "sco");
		method.addParameter("text", smstext);
		method.addParameter("match", smsmatch);
		method.addParameter("datetime", smsdatetime);

		try{
		  int returnCode = client.executeMethod(method);
		  if(returnCode == HttpStatus.SC_NOT_IMPLEMENTED) {
				msg="The Post method is not implemented by this URI";
				method.getResponseBodyAsString();
			} else {
				statuscode=method.getStatusCode();
				
				// update  DB 				
					
    			try
    				{
     
                	String sql=" update  iplscore_details set STATUSCODE='"+statuscode+"' where MSG_ID ='"+MSG_ID+"'";
               		stmt2 = cn.createStatement();
					stmt2.executeUpdate(sql);
                	//cn.commit();
				 
			  		}
              			catch(Exception e)
              		{
				 	msg="Try Again - News Not Inserted Successfully for Some Circles";
                	e.printStackTrace();
              		}
              finally
              		{
                     	stmt = null;
              	}
              	if(statuscode==200){
          		msg="News Inserted Successfully and status code is="+statuscode;
        		
				
		}else{
				 msg="Data inserted but not sent because status code is="+statuscode;
			}
				
		  	}
		} catch (Exception e) {
			System.err.println(e);
		} finally {
			method.releaseConnection();
			if(br != null) try { br.close(); } catch (Exception fe) {}
		}
		response.sendRedirect("iplscoreinsert.jsp?msg="+msg);
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>