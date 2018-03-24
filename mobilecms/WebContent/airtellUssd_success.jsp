<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
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
   //String fname ="santosh";
   String msg="";
    if(fname == null)
    {
      response.sendRedirect("index.jsp?msg=session exp.");
    }
   int empId = Integer.parseInt((String)session.getAttribute("empId"));
   MyValid3 val3 = new MyValid3();
    int categoryId= 99;    
    Connection cn=null;    
    String txtDate =  "";
    String txtNews =  "";
	String txtOrderingGet = "";
	int txtOrdering=0;
	String Na_MESSAGE1 = "";
	String Sp_MESSAGE1 = "";
	String Bow_MESSAGE1 = "";
	
	
	
	
	
				Na_MESSAGE1 =request.getParameter("Natioanl1"); 
				/*Sports*/
				Sp_MESSAGE1 =request.getParameter("Sports1"); 
				/*Business*/
				Bow_MESSAGE1 =request.getParameter("Bolly1"); 
				
				
				Na_MESSAGE1 =val3.doAddSlashesString(Na_MESSAGE1);
				
				/*Sports*/
				Sp_MESSAGE1 =val3.doAddSlashesString(Sp_MESSAGE1);
				
				/*Business*/
				Bow_MESSAGE1 =val3.doAddSlashesString(Bow_MESSAGE1);
				
	
	
	
	

    AdminConn adminConn = AdminConn.getInstance();
    cn = adminConn.getConnection();
    Statement stmt = null,stmt1=null,stmt2=null;
    ResultSet rs= null;
    try
    {
     
                String sql="INSERT INTO airtel_ussd_message_details (Na_MESSAGE1,Sp_MESSAGE1,Bow_MESSAGE1,RECORD_DATE,UPDATE_EMP_ID ) VALUES ('"+Na_MESSAGE1+"','"+Sp_MESSAGE1+"','"+Bow_MESSAGE1+"',now(),'"+empId+"')";
               stmt = cn.createStatement();
				stmt.executeUpdate(sql);
                //cn.commit();
				 
            
			  }
              catch(Exception e)
              {
				 msg="Try Again - News Not Inserted Successfully for Some Circles";
                e.printStackTrace();
              }
              finally
              {
                rs = null;
                stmt = null;
              }
          msg="News Inserted Successfully";
        response.sendRedirect("airtellUssd_insert.jsp?msg="+msg);
    
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>