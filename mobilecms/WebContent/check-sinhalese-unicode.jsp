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
document.myNews.title.value = "";
document.myNews.type.value = "";
document.myNews.fulltext.value = "";
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
	String title = "";
	String type = "";
	String fulltext = "";
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	AdminConn adminConn = null;
	try
	{
		//adminConn = AdminConn.getInstance();
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
    			//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");
		String upQuery1 = "SELECT a.message1,a.message2,a.message3,DATE_FORMAT(a.RECORD_DATE,'%d-%m-%Y')run_date1 ,DATE_FORMAT(a.RECORD_DATE,'%d%M. %l%p ') DATE ,time_format(a.RECORD_DATE,'%r ') record_time FROM message_details_unicode a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='sinhalese' AND  b.STATUS='ACTIVE' AND b.category_id='"+categoryId+"' ORDER BY a.MSG_ID  DESC LIMIT 1";
		
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		
		
		
		if(rs.next())
		{		title =new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8");
				type =new String(new String(rs.getString("message2")).getBytes("ISO-8859-1"), "UTF-8"); 
				fulltext =new String(new String(rs.getString("message3")).getBytes("ISO-8859-1"), "UTF-8"); 				
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
%>

<form action="insertsinhalese-unicode.jsp" method="post" name="myNews">
<input type="hidden" name="MSG_ID" value='MSG_ID' />
<input type="hidden" name="fname" value='name' />
<input type="hidden" name="empId" value='empId' />
<input type="hidden" name="datetime" value='datetime' />
<input type="hidden" name="categoryId" value="<%=categoryId%>">

<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">

<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			 <h2><font color="red">Insert Sinhalese Data</font></h2>
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
			
		
			
			
			<td colspan="2" align="center">
						<input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">
					</td>
			</tr>
			
				<tr>
				
					<td>
						Teaser
					</td>
							  <td width="397" valign="top"><textarea name="title"  cols="80" rows="4" onKeyDown="textCounter(document.myNews.title,document.myNews.remLen1,160)"
onKeyUp="textCounter(document.myNews.title,document.myNews.remLen1,160)" style="width:450px;" ><%=title%></textarea></td><td><input readonly type="text" name="remLen1" size="3" maxlength="3" value="160">
characters left</td>



				</tr>
				
				<tr>
				
					<td>
						Menu Item 
					</td>
							  <td width="200" valign="top"><textarea name="type"  cols="10" rows="4" onKeyDown="textCounter(document.myNews.type,document.myNews.remLen2,100)"
onKeyUp="textCounter(document.myNews.type,document.myNews.remLen2,100)" style="width:450px;" ><%=type%></textarea></td><td><input readonly type="text" name="remLen2" size="3" maxlength="3" value="100">
characters left</td>



				</tr>				
				
				<tr>
					<td>
						Response
					</td>
					 <td width="397" valign="top"><textarea name="fulltext"   cols="80" rows="4" onKeyDown="textCounter(document.myNews.fulltext,document.myNews.remLen3,390)"
onKeyUp="textCounter(document.myNews.fulltext,document.myNews.remLen3,390)" style="width:450px;"  ><%=fulltext%></textarea></td>
  <td><input readonly type="text" name="remLen3" size="3" maxlength="3" value="390">
characters left</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="Send Content">
					</td>
				</tr>
			</table>

</form>

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