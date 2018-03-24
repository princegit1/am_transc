<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
String sectionname="";
if(sectionId.equals("396")){sectionname="olympic-trivia";}
if(sectionId.equals("397")){sectionname="olympic-trivia-roman";}
if(sectionId.equals("398")){sectionname="olympics-news";}
if(sectionId.equals("399")){sectionname="olympic-news-roman";}
if(sectionId.equals("400")){sectionname="olympics-medal-tally";}
if(sectionId.equals("401")){sectionname="olympics-medal-tally-roman";}
if(sectionId.equals("402")){sectionname="key-player";}
if(sectionId.equals("403")){sectionname="olympics-key-players-roman";}
if(sectionId.equals("404")){sectionname="sports-wise-medal-tally";}
if(sectionId.equals("405")){sectionname="sports-wise-medal-tally-roman";}



%>
<html>
<head>
<title>Send News Content - ITGO</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<script language="JavaScript">
<!--

function resetTextAreas()
{
<%
for(int i=1;i<7;i++)
{
%>
document.myNews.kkr<%=i%>.value = "";
document.myNews.hdln<%=i%>.value = "";
<%
}
%>
}
-->
</script> 
<script language="JavaScript">
<!--
function getCursorPosition(field)
{
field.focus();
var sel = document.selection.createRange();
var storedRange = sel.duplicate();
storedRange.moveToElementText(field);
storedRange.setEndPoint('EndToEnd', sel);
return storedRange.text.length - sel.text.length;
}
function spellCheckStart(field)
{
pos = getCursorPosition(field);

if (pos > 0)
{
if (!confirm("Do you wish to check from current cursor position?"))
{
return;
}
}
spellcheck(field, field.value, pos, 10);
}
function spellCheckEdit(field, N1AP)
{
field.value=N1AP;
}
function getkey(evt)
{
if (window.event)
return window.event.keyCode;
else
return (evt.keyCode || evt.which || evt.charCode);
}
//-->
</script>


<script type="text/javascript">
<!--
function getObject(obj) {
var theObj;
if(document.all) {
if(typeof obj=="string") {
return document.all(obj);
} else {
return obj.style;
}
}
if(document.getElementById) {
if(typeof obj=="string") {
return document.getElementById(obj);
} else {
return obj.style;
}
}
return null;
}

//Contador de caracteres.
function Contar(entrada,salida,texto,caracteres) {
var entradaObj=getObject(entrada);
var salidaObj=getObject(salida);
var longitud=caracteres - entradaObj.value.length;
if(longitud <= 0) {
longitud=0;
texto='<span class="disable"> '+texto+' </span>';
entradaObj.value=entradaObj.value.substr(0,caracteres);
}
salidaObj.innerHTML = texto.replace("{CHAR}",longitud);
}

function checks()
{

var hd1 = document.myNews.hdln1.value.length;
var hd2 = document.myNews.hdln2.value.length;
var hd3 = document.myNews.hdln3.value.length;
var hd4 = document.myNews.hdln4.value.length;
var hd5 = document.myNews.hdln5.value.length;
var tot  = hd1+hd2+hd3+hd4+hd5;
if(tot >=310)
	{
	alert ("Total count of headline is greater than 310")
		return false;
	}

 return true;
}
//-->
</script>

<link href="styles/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="topBand.jsp" />
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="top">
				<td align="center" colspan="3">
					<input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">
			</td>
			
		</tr>
		<tr height="8">
			<td colspan="3">
			</td>
		</tr>
<form action="news_for_olympic2012_save.jsp" method="post" name="myNews" onSubmit="return checks();">
<%
ResultSet rs=null;
ResultSet rs1=null;
Connection cn=null;
Statement stmt=null;
Statement stmt1=null;
String upQuery="";
String upQuery1="";
String name="";
String date="";
String headline_1="";
String more_1="";
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.more_1, nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID";
	System.out.println("upQuery1->"+upQuery1);
	//upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.more_1, nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='164') and nn.category_id='164' and nn.emp_id=e.EMP_ID";
	stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	
	if(rs1.next())
	{
	
	 name=rs1.getString("name");
	 date=rs1.getString("date");
	  more_1=rs1.getString("more_1");
	 
	 }
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/rogers_news_rss.jsp?category=<%=sectionname %>" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="right">By:<%=name%> <b><%=date%></b>&nbsp;&nbsp;</td>
		</tr>
		<tr height="5">
			<td colspan="3">
			</td>
		</tr>
		
		<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
				
		  <tr> 
			<TD><B>Message</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr1" id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',300);"><%=more_1%></textarea><span id="yBann-1-1" class="minitext">&nbsp;300 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr1)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Message: <%=more_1%><br><br>
	Total Character Message: <%=more_1.length()%><br><br>
</td>


</tr>



<tr height="1" bgcolor="#dcdcdc">
<td colspan="3">
</td>
</tr>
<tr height="1" bgcolor="#dcdcdc">
<td colspan="3">
</td>
</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
</td>
</tr>

							
<%
	//}
	
	}
			catch(Exception e)
{
	e.printStackTrace();
	System.out.print(e.toString());
}
finally
{
	rs = null;
	rs1 = null;
	stmt = null;
	stmt1 = null;
	cn=null;
}
%>

<TR>
<TD height="35" colspan="3">
<DIV align=center>
<INPUT type=submit value=Submit name=txtSubmit2> 
</DIV>
</TD>
</TR>
<INPUT type="hidden" value="<%=sectionId%>" name=section> 
</form>
</tbody></table></body></html>