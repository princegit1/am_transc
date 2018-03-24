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
	String Na_MESSAGE1 = "",Na_MESSAGE2 = "",Na_MESSAGE3 = "",Na_MESSAGE4 = "",Na_MESSAGE5 = "",Na_MESSAGE6 = "";
	String In_MESSAGE1 = "",In_MESSAGE2 = "",In_MESSAGE3 = "",In_MESSAGE4 = "",In_MESSAGE5 = "",In_MESSAGE6 = "";
	String Sp_MESSAGE1 = "",Sp_MESSAGE2 = "",Sp_MESSAGE3 = "",Sp_MESSAGE4 = "",Sp_MESSAGE5 = "",Sp_MESSAGE6 = "";
	String Bu_MESSAGE1 = "",Bu_MESSAGE2 = "",Bu_MESSAGE3 = "",Bu_MESSAGE4 = "",Bu_MESSAGE5 = "",Bu_MESSAGE6 = "";
	
	
	
	
	
	
				Na_MESSAGE1 =request.getParameter("txt1"); 
				Na_MESSAGE2 =request.getParameter("txt2"); 
				Na_MESSAGE3 =request.getParameter("txt3"); 
				Na_MESSAGE4 =request.getParameter("txt4"); 
				Na_MESSAGE5 =request.getParameter("txt5"); 
				Na_MESSAGE6 =request.getParameter("txt6"); 
				/*international*/
				In_MESSAGE1 =request.getParameter("txt7"); 
				In_MESSAGE2 =request.getParameter("txt8"); 
				In_MESSAGE3 =request.getParameter("txt9"); 
				In_MESSAGE4 =request.getParameter("txt10"); 
				In_MESSAGE5 =request.getParameter("txt11"); 
				In_MESSAGE6 =request.getParameter("txt12"); 
				/*Sports*/
				Sp_MESSAGE1 =request.getParameter("txt13"); 
				Sp_MESSAGE2 =request.getParameter("txt14"); 
				Sp_MESSAGE3 =request.getParameter("txt15"); 
				Sp_MESSAGE4 =request.getParameter("txt16"); 
				Sp_MESSAGE5 =request.getParameter("txt17"); 
				Sp_MESSAGE6 =request.getParameter("txt18"); 
				/*Business*/
				Bu_MESSAGE1 =request.getParameter("txt19"); 
				Bu_MESSAGE2 =request.getParameter("txt20"); 
				Bu_MESSAGE3 =request.getParameter("txt21"); 
				Bu_MESSAGE4 =request.getParameter("txt22"); 
				Bu_MESSAGE5 =request.getParameter("txt23"); 
				Bu_MESSAGE6 =request.getParameter("txt24"); 
				
				Na_MESSAGE1 =val3.doAddSlashesString(Na_MESSAGE1);
				Na_MESSAGE2 =val3.doAddSlashesString(Na_MESSAGE2);
				Na_MESSAGE3 =val3.doAddSlashesString(Na_MESSAGE3);
				Na_MESSAGE4 =val3.doAddSlashesString(Na_MESSAGE4);
				Na_MESSAGE5 =val3.doAddSlashesString(Na_MESSAGE5); 
				Na_MESSAGE6 =val3.doAddSlashesString(Na_MESSAGE6);
				/*international*/
				In_MESSAGE1 =val3.doAddSlashesString(In_MESSAGE1);
				In_MESSAGE2 =val3.doAddSlashesString(In_MESSAGE2);
				In_MESSAGE3 =val3.doAddSlashesString(In_MESSAGE3); 
				In_MESSAGE4 =val3.doAddSlashesString(In_MESSAGE4);
				In_MESSAGE5 =val3.doAddSlashesString(In_MESSAGE5);
				In_MESSAGE6 =val3.doAddSlashesString(In_MESSAGE6);
				/*Sports*/
				Sp_MESSAGE1 =val3.doAddSlashesString(Sp_MESSAGE1);
				Sp_MESSAGE2 =val3.doAddSlashesString(Sp_MESSAGE2);
				Sp_MESSAGE3 =val3.doAddSlashesString(Sp_MESSAGE3);
				Sp_MESSAGE4 =val3.doAddSlashesString(Sp_MESSAGE4);
				Sp_MESSAGE5 =val3.doAddSlashesString(Sp_MESSAGE5);
				Sp_MESSAGE6 =val3.doAddSlashesString(Sp_MESSAGE6);
				/*Business*/
				Bu_MESSAGE1 =val3.doAddSlashesString(Bu_MESSAGE1);
				Bu_MESSAGE2 =val3.doAddSlashesString(Bu_MESSAGE2);
				Bu_MESSAGE3 =val3.doAddSlashesString(Bu_MESSAGE3);
				Bu_MESSAGE4 =val3.doAddSlashesString(Bu_MESSAGE4);
				Bu_MESSAGE5 =val3.doAddSlashesString(Bu_MESSAGE5);
				Bu_MESSAGE6 =val3.doAddSlashesString(Bu_MESSAGE6);
	
	
	
	
	

    AdminConn adminConn = AdminConn.getInstance();
    cn = adminConn.getConnection();
    Statement stmt = null,stmt1=null,stmt2=null;
    ResultSet rs= null;
    try
    {
     
                String sql="INSERT INTO i2i_message_details (Na_MESSAGE1,Na_MESSAGE2,Na_MESSAGE3,Na_MESSAGE4,Na_MESSAGE5,Na_MESSAGE6,In_MESSAGE1,In_MESSAGE2,In_MESSAGE3,In_MESSAGE4,In_MESSAGE5,In_MESSAGE6,Sp_MESSAGE1,Sp_MESSAGE2,Sp_MESSAGE3 ,Sp_MESSAGE4 ,Sp_MESSAGE5 ,Sp_MESSAGE6,Bu_MESSAGE1,Bu_MESSAGE2,Bu_MESSAGE3,Bu_MESSAGE4 ,Bu_MESSAGE5,Bu_MESSAGE6,RECORD_DATE,UPDATE_EMP_ID ) VALUES ('"+Na_MESSAGE1+"','"+Na_MESSAGE2+"','"+Na_MESSAGE3+"','"+Na_MESSAGE4+"','"+Na_MESSAGE5+"','"+Na_MESSAGE6+"','"+In_MESSAGE1+"','"+In_MESSAGE2+"','"+In_MESSAGE3+"','"+In_MESSAGE4+"','"+In_MESSAGE5+"','"+In_MESSAGE6+"','"+Sp_MESSAGE1+"','"+Sp_MESSAGE2+"','"+Sp_MESSAGE3+"' ,'"+Sp_MESSAGE4 +"','"+Sp_MESSAGE5+"' ,'"+Sp_MESSAGE6+"','"+Bu_MESSAGE1+"','"+Bu_MESSAGE2+"','"+Bu_MESSAGE3+"','"+Bu_MESSAGE4+"' ,'"+Bu_MESSAGE5+"','"+Bu_MESSAGE6+"',now(),'"+empId+"')";
               stmt = cn.createStatement();
				stmt.executeUpdate(sql);
               // cn.commit();
				 
            
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
        response.sendRedirect("i2imessage_insert.jsp?msg="+msg);
    
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
    
  </body>
</html>