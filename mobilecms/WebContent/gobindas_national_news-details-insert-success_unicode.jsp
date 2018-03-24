<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="org.apache.commons.httpclient.HttpClient,org.apache.commons.httpclient.HttpStatus,org.apache.commons.httpclient.methods.PostMethod"%>
<%@ page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%@ page import="conn.*,com.itgd.server.*"%>
<%@ page contentType="text/html; charset=utf-8" %>
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
	int categoryId=737;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
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
				
	
    			Class.forName("com.mysql.jdbc.Driver").newInstance();
    				cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
    			//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");
    			try
    				{
     
					
					String sql="INSERT INTO message_details_unicode (CATEGORY_ID,MESSAGE1,MESSAGE2,UPDATE_EMP_ID,RUN_DATE) VALUES (?,?,?,?,CURDATE())";
						pstmt = cn.prepareStatement(sql);
						pstmt.setInt(1,categoryId);
						pstmt.setString(2,new String(new String(type).getBytes("UTF-8")));
						pstmt.setString(3,new String(new String(text).getBytes("UTF-8")));
						pstmt.setInt(4,empId);
						pstmt.executeUpdate();
                	//cn.commit();
				 
			  		}
              			catch(Exception e)
              		{
				      	e.printStackTrace();
              		}
              finally
              		{
                     	pstmt.close();
                     	cn.close();
              	}
          	

		

				%>
<%

		

		
		response.sendRedirect("gobindas_national_news-details-insert_unicode.jsp?msg="+msg);
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>