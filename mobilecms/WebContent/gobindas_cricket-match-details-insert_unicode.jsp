<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
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

				
				document.myNews.text.value = "";
					document.myNews.type.value = "";
					
					
	
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
	String team1="";
	String team2="";
	String eventValue1="",eventValue2="",eventValue3="",eventValue4="",eventValue5="",eventValue6="";
	AdminConn adminConn = null;
	try
	{
		//adminConn = AdminConn.getInstance();
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
    			//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");
		String upQuery1 = "SELECT a.message1,a.message2,DATE_FORMAT(a.RECORD_DATE,'%d-%m-%Y')run_date1 ,DATE_FORMAT(a.RECORD_DATE,'%d%M. %l%p ') DATE ,time_format(a.RECORD_DATE,'%r ') record_time FROM message_details_unicode a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='ITGD' AND  STATUS='ACTIVE' AND category_type='gobindas-unicode-cricket-score' ORDER BY a.MSG_ID  DESC LIMIT 1";
//out.println("@@@@@@@@@@"+upQuery1);		
//cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		type =new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8");
				text =new String(new String(rs.getString("message2")).getBytes("ISO-8859-1"), "UTF-8"); 				
				date = rs.getString("run_date1");
				time=rs.getString("record_time");
				datetime=date+" "+time;	
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


//out.println("@@@@@@@@@@"+type);	



%>

<form action="gobindas_cricket-match-details-insert-success_unicode.jsp" method="post" name="myNews">
<input type="hidden" name="MSG_ID" value='MSG_ID' />
<input type="hidden" name="fname" value='name' />
<input type="hidden" name="empId" value='empId' />
<input type="hidden" name="datetime" value='datetime' />

<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">

<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			 <h2><font color="red">Insert Cricket Data Details</font></h2>
			  <a href="sp/cricket_match_details_gobindas_unicode.jsp" target="_blank">Check Existing</a>
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
						Title 
					</td>
							  <td width="397" valign="top"><textarea name="type"  cols="80" rows="4" onKeyDown="textCounter(document.myNews.type,document.myNews.remLen1,160)"
onKeyUp="textCounter(document.myNews.type,document.myNews.remLen1,160)" style="width:450px;" ><%=type%></textarea></td>



				</tr>
				
				<tr>
					<td>
						Text
					</td>
					 <td width="397" valign="top"><textarea name="text"   cols="80" rows="4" onKeyDown="textCounter(document.myNews.text,document.myNews.remLen3,300)"
onKeyUp="textCounter(document.myNews.text,document.myNews.remLen3,300)" style="width:450px;"  ><%=text%></textarea></td>
    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen3" size="3" maxlength="3" value="300">
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