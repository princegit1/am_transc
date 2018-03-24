<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
%>
<html>
<head>
<title>Send Regional News Content - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<SCRIPT LANGUAGE="JavaScript">

function textCounter(field,cntfield,maxlimit) {
if (field.value.length > maxlimit) 
field.value = field.value.substring(0, maxlimit);
else
cntfield.value = maxlimit - field.value.length;
}
function resetTextAreas()
{
	
		document.myNews.Natioanl1.value = "";
		document.myNews.Bolly1.value = "";
		document.myNews.Sports1.value = "";
	
}
</script>

<link href="styles/main.css" rel="stylesheet" type="text/css">
<body>
<jsp:include page="topBand.jsp" />
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String name = "";
	String date = "",MSG_ID="",time="",datetime="";
	String Na_MESSAGE1 = "";
	String Sp_MESSAGE1 = "";
	String Bow_MESSAGE1 = "";
	

	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.Na_MESSAGE1 as Na_MESSAGE1,m.Sp_MESSAGE1 as Sp_MESSAGE1,m.Bow_MESSAGE1 as Bow_MESSAGE1,m.category_id,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%r ') record_time, em.FNAME as fname,em.EMP_ID as empId FROM airtel_ussd_message_details m,employee em where  m.update_emp_id=em.EMP_ID order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		MSG_ID=rs.getString("MSG_ID");
				Na_MESSAGE1 =rs.getString("Na_MESSAGE1"); 
				/*Sports*/
				Sp_MESSAGE1 =rs.getString("Sp_MESSAGE1"); 
				/*Bollywood*/
				Bow_MESSAGE1 =rs.getString("Bow_MESSAGE1"); 
				
				name = rs.getString("fname");
				//rs.getString("fname")
				date = rs.getString("record_date");
				
				time=rs.getString("record_time");
				//rs.getString("record_date");
				datetime=date+" "+time;
				
				
				 String empId=rs.getString("empId");

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

<form action="airtellUssd_success.jsp" name="myNews"  method="post">
<input type="hidden" name="MSG_ID" value='MSG_ID' />
<input type="hidden" name="fname" value='name' />
<input type="hidden" name="empId" value='empId' />
	<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">
		<tr valign="top">
			<td width="3%"></td>
		  <td width="44%"></td>
		  <td width="8%"></td>
		  <td width="24%"></td>
		  <td width="17%"></td>
		  <td width="4%"></td>
	  </tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			  <P class="topic">AirTel USSD News<BR>
			  <a href="sp/airtelall" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="6" align="right">By: <b><%=name%></b>&nbsp;(<%=datetime%>)&nbsp;</td>
		</tr>
		<tr height="5">
			<td>
			</td>
		</tr>
		<tr valign="top">
			<td>&nbsp;
				
			</td>
			<td colspan="5" align="left">
			<font color="red"><b>
			<%
				if(errorMessage != null)
				{
					out.println(java.net.URLDecoder.decode(request.getParameter("msg")));
				}
			%>
			</b></font>
			</td>
		</tr>
  <tr>
	<td height="5">
	</td>
		</tr>
		<table width="622" align="center" cellpadding="0" cellspacing="0">

<tr valign="top">
			<td width="500" align="center">
		  <input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">		  </td>
			
		    <td width="122" align="center">&nbsp;</td>
</tr>
<tr valign="top">
  <td height="10" align="center"></td>
  <td height="10" align="center"></td>
</tr>
</table>
		<tr height="8">
			<td>
			</td>
		</tr>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><strong>&nbsp; <br></strong></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <table width="622" border="0" cellspacing="0" cellpadding="0" align="center" >
<tr align="left">
<td></td>
</tr>
  <tr>
    <td width="397" valign="top"><textarea name="Natioanl1"  cols="80" rows="4" onKeyDown="textCounter(document.myNews.Natioanl1,document.myNews.remLen1,134)"
onKeyUp="textCounter(document.myNews.Natioanl1,document.myNews.remLen1,134)" style="width:450px;" ><%=Na_MESSAGE1%></textarea></td>
<td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen1" size="3" maxlength="3" value="134">
characters left</td>
  
 </tr>
<tr>
<td>&nbsp;</td>
</tr>

  <tr>
  
    <td width="397" valign="top"><textarea name="Sports1"  cols="80" rows="4" onKeyDown="textCounter(document.myNews.Sports1,document.myNews.remLen2,134)"
onKeyUp="textCounter(document.myNews.Sports1,document.myNews.remLen2,134)" style="width:450px;"  ><%=Sp_MESSAGE1%></textarea></td>


    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen2" size="3" maxlength="3" value="134">
characters left</td>

     

  </tr>
<tr>
<td>&nbsp;</td>
</tr>


  <tr>

   
    <td width="397" valign="top"><textarea name="Bolly1"   cols="80" rows="4" onKeyDown="textCounter(document.myNews.Bolly1,document.myNews.remLen3,134)"
onKeyUp="textCounter(document.myNews.Bolly1,document.myNews.remLen3,134)" style="width:450px;"  ><%=Bow_MESSAGE1%></textarea></td>
    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen3" size="3" maxlength="3" value="134">
characters left</td>

  </tr>
<tr>
<td>&nbsp;</td>
</tr>

  </table>
  <table width="622" align="center" cellpadding="0" cellspacing="0">		
<tr valign="top">
  <td height="10" align="center"></td>
  <td height="10" align="center"></td>
</tr>
<tr valign="top">
			
			<td width="500" align="center">
		  <input type="submit" value="Send Content" name="newscontent">		  </td>
	  
		    <td width="122" align="center">&nbsp;</td>
</tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
  <td class="bottband">
    <div align="center"> All Rights Reserved &copy; ITGO</div>
  </td>
  </tr>
</table>
</body>
</html>