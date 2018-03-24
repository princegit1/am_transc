<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
%>
<html>
<head>
<title>Send Breaking News - ITGO</title></head>
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

		
document.myNews.text.value = "";
		
	
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
	String type = "";
	String opid = "";
	String text = "";
	String match = "";
	

	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.smstext as smstext,date_format(m.RECORD_DATE,'%d-%m-%Y') record_date,time_format(m.RECORD_DATE,'%I:%i %p') record_time, em.FNAME as fname,em.EMP_ID as empId FROM breaking_news m,employee em where  m.update_emp_id=em.EMP_ID order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		MSG_ID=rs.getString("MSG_ID");							
				text =rs.getString("smstext"); 				
				name = rs.getString("fname");
				date = rs.getString("record_date");
				time=rs.getString("record_time");
				datetime=date+" "+time;
				String empId=rs.getString("empId");

		}
	}
	catch(Exception e)
	{
		out.println("Error=>"+e.toString());
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

<form action="breaking_news_success.jsp" method="post" name="myNews">
<input type="hidden" name="MSG_ID" value='MSG_ID' />
<input type="hidden" name="fname" value='name' />
<input type="hidden" name="empId" value='empId' />
<input type="hidden" name="datetime" value='datetime' />

<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">

<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			 <h2><font color="red">Breaking News<br></font></h2>
			  <a href="breakingnews.jsp" target="_blank">Check Existing</a>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<%
				if(errorMessage != null)
				{
					out.println("<font color='red'>"+java.net.URLDecoder.decode(request.getParameter("msg"))+"</font>");
				}
			%>
			<td colspan="6" align="right">By: <b><%=name%></b>&nbsp;(<%=datetime%>)&nbsp;</td>
		</tr>
	</table>
			<table align="center">
			
			<tr>
			
			<tr>
			
			<td colspan="8" align="center">
						&nbsp;
						&nbsp;
						&nbsp;
					</td>
			</tr>
			<tr>
			
			<td colspan="2" align="center">
						<input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">
					</td>
			</tr>
			
				
				
				<tr>
					<td>
						Text
					</td>
					 <td width="397" valign="top"><textarea name="text"   cols="80" rows="4" onKeyDown="textCounter(document.myNews.text,document.myNews.remLen3,160)"
onKeyUp="textCounter(document.myNews.text,document.myNews.remLen3,160)" style="width:450px;"  ><%=text%></textarea></td>
    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen3" size="3" maxlength="3" value="160">
characters left</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="Send Content">
					</td>
				</tr>
			</table>

</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
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