<%@ page import="java.sql.*"%>
<%@ page import="conn.*"%>
<html>
  <head>
  		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   		<title>Buongiorno Error Check</title>
		<link rel="stylesheet" href="mystyle.css" type="text/css"/>
		
  </head>
  <body>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" >
  <tr style="background-color:#D71920; font:bold 14px georgia; color:#ffffff; border:1px solid #000000;">

 
      	<td style="padding-left:2px;">Posted Message</td>
      	<td style="padding-left:2px;">Error Type</td>	
      	<td style="padding-left:2px;">Message Posted Time</td>	
	   	<td style="padding-left:2px;">Error Generation Time</td>
	  	
		<td></td>
			  		  	
  	</tr>


<%
String message=null,error=null,messagepostingtime=null,errortime=null;
Connection cn=null;
ResultSet rs = null;
Statement stmt = null;
try
{	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String upQuery1 = "select Message,Error,messagetime,errortime from error_master";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery1);
	while(rs.next())
	{
		message = rs.getString("Message");			
		error = rs.getString("Error");				
		messagepostingtime = rs.getString("messagetime");				
		errortime = rs.getString("errortime");
	%>


  <tr style="font:normal 12px georgia; color:#000000; border:1px solid #000000;">
     <td valign="top" style="padding-left:2px;"> <%= message%> </td>  
     <td align="center" valign="top" style="padding-left:2px;"> <%=error %> </td>   
     <td align="center" valign="top" style="padding-left:2px;"> <%= messagepostingtime %> </td>    
    <td valign="top" style="padding-left:2px;"> <%= errortime%></td>    
    
 </tr>
   
    <%
}
}
catch(Exception e)
{
	out.println(e.toString());
}
finally
{
	if(rs!=null)
		rs.close();
	if(stmt!=null)
		stmt.close();
	if(cn!=null)
		cn.close();
}
%> 	
 
	
	</table>

	</td>
  </tr>
</table>
</body>
</html>




