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
	
				 
		text =request.getParameter("text");		
		datetime =request.getParameter("datetime"); 

%>
<%
				//Inserting data into DB 				
				
				
				text =val3.doAddSlashesString(text);
			
	
    			AdminConn adminConn = AdminConn.getInstance();
  			  	cn = adminConn.getConnection();
    			
    			try
    				{
     
                	String sqlinsert="INSERT INTO breaking_news (smstype,smstext,RECORD_DATE,UPDATE_EMP_ID ) VALUES ('breakingnews','"+text+"',now(),'"+empId+"')";
               		stmt = cn.createStatement();
					stmt.executeUpdate(sqlinsert);
                	//cn.commit();
				 
			  		}
              			catch(Exception e)
              		{
              		msg="Try Again - News Not Inserted Successfully ";
				   e.printStackTrace();
              		}
              finally
              		{
                     	
                     	if (rs != null) {
					try {
						rs.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					rs = null;
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					stmt = null;
				}if (cn != null) {
					try {
						cn.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					cn = null;
				}
              	
              	}
          	
		try
    				{
		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.smstype as smstype,m.smstext as smstext,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%I:%i %p') record_time, em.FNAME as fname,em.EMP_ID as empId FROM breaking_news m,employee em where  m.update_emp_id=em.EMP_ID order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt1=cn.createStatement();
		rs=stmt1.executeQuery(upQuery1);
		if(rs.next())
		{		MSG_ID=rs.getString("MSG_ID");				 
				smstext =rs.getString("smstext");				
				name = rs.getString("fname");
				date = rs.getString("record_date");
				time=rs.getString("record_time");
				smsdatetime=date+" "+time;
				
 
		}
		
		}
              			catch(Exception e)
              		{
              		
				      	e.printStackTrace();
              		}
              finally
              		{
                     	if (rs != null) {
					try {
						rs.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					rs = null;
				}
				if (stmt1 != null) {
					try {
						stmt1.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					stmt1 = null;
				}if (cn != null) {
					try {
						cn.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					cn = null;
				}
              	}
          	

//if (request.getParameter("endpoint") != null && request.getParameter("endpoint").length() > 0)
//sampleC_UploaderSoapProxyid.setEndpoint(request.getParameter("endpoint"));
cellnext.ws_content_uploader.C_UploaderSoapProxy sampleC_UploaderSoapProxyid = new cellnext.ws_content_uploader.C_UploaderSoapProxy();
try {
      String service_2id=  "BreakingNews";            
      String userid_3id=  "IndiaToday";
      String password_4id=  "IT123";
      String content_5id= smstext;         
      String lang_6id= "English";       
      String provider_7id= "India Today";
       
        %>
        <jsp:useBean id="cellnext1ws_content_uploader1Upload_x0020_Content_1id" scope="session" class="cellnext.ws_content_uploader.Upload_x0020_Content" />
        <%
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setService(service_2id);
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setUserid(userid_3id);
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setPassword(password_4id);
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setContent(content_5id);
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setLang(lang_6id);
        cellnext1ws_content_uploader1Upload_x0020_Content_1id.setProvider(provider_7id);
        cellnext.ws_content_uploader.Upload_x0020_ContentResponse getContent13mtemp = sampleC_UploaderSoapProxyid.getContent(cellnext1ws_content_uploader1Upload_x0020_Content_1id);
	if(getContent13mtemp == null){
	msg="The Post method is not implemented by this URI"+getContent13mtemp;

}else{

if(getContent13mtemp != null){
java.lang.String typeupload_x0020_ContentResult16 = getContent13mtemp.getUpload_x0020_ContentResult();
String tempResultupload_x0020_ContentResult16 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(typeupload_x0020_ContentResult16));
 try
    				{
     
                	String sql=" update  breaking_news set STATUSCODE='"+tempResultupload_x0020_ContentResult16+"' where MSG_ID ='"+MSG_ID+"'";
                	cn = adminConn.getConnection();
               		stmt2 = cn.createStatement();
					stmt2.executeUpdate(sql);
                	//cn.commit();
				 
			  		}
              			catch(Exception e)
              		{
				 	msg="Try Again - News Not Inserted Successfully ";
                	e.printStackTrace();
              		}
              finally
              		{
                     	
                     	if (rs != null) {
					try {
						rs.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					rs = null;
				}
				if (stmt2 != null) {
					try {
						stmt2.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					stmt2 = null;
				}if (cn != null) {
					try {
						cn.close();
					} catch (SQLException sqle) {
						System.err.println(sqle.getMessage());
					}
					cn = null;
				}
              	
              	}
              	if(tempResultupload_x0020_ContentResult16.equalsIgnoreCase("True|Success")){
          		
          		msg="News Inserted Successfully and status code is="+tempResultupload_x0020_ContentResult16;
        		
				
		}else{
				 msg="Data inserted but not sent because status code is="+tempResultupload_x0020_ContentResult16;
			}
				
		  	   
        
      
}

}

} catch (Exception e) { 
System.err.println(e);
}
response.sendRedirect("breaking_news.jsp?msg="+msg);
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>