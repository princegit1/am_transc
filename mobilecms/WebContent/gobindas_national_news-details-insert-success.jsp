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
		type =request.getParameter("type"); 
		text =request.getParameter("text"); 
		match =request.getParameter("match"); 
		datetime =request.getParameter("datetime"); 
		
%>
<%
				//Inserting data into DB 				
				
				type =val3.doAddSlashesString(type);				
				text =val3.doAddSlashesString(text);
				
	
    			AdminConn adminConn = AdminConn.getInstance();
  			  	cn = adminConn.getConnection();
    			
    			try
    				{
     
                	String sqlinsert="INSERT INTO iplscore_details (smstype,smstext,RECORD_DATE,UPDATE_EMP_ID,type ) VALUES ('"+type+"','"+text+"',now(),'"+empId+"','gobindas_news')";
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

		

		
		response.sendRedirect("gobindas_national_news-details-insert.jsp?msg="+msg);
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>