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
		String team1="";
	String team2="";
		type =request.getParameter("series"); 
		opid =request.getParameter("opid"); 
		text =request.getParameter("text"); 
		match =request.getParameter("match"); 
		datetime =request.getParameter("datetime"); 
		team1 =request.getParameter("team1"); 
		team2 =request.getParameter("team2"); 

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
     
                	String sqlinsert="INSERT INTO iplscore_details (smstype,opid,smstext,matchteam,RECORD_DATE,UPDATE_EMP_ID,team1,team2,type ) VALUES ('"+type+"','"+opid+"','"+text+"','"+match+"',now(),'"+empId+"','"+team1+"','"+team2+"','cricket')";
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
                     	stmt.close();
                     	cn.close();
              	}
          	

		

				%>
<%

		

		
		response.sendRedirect("cricket-match-details-insert.jsp?msg="+msg);
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>