<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "Jammu Kashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UP East", "UPW", "WESTBENGAL"};
%>
<html>
<head>
<title>Send National News Content - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<script language="JavaScript">
<!--

function resetTextAreas()
{
<%
for(int i=1;i<6;i++)
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
</head>
<link href="styles/main.css" rel="stylesheet" type="text/css">
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
<form action="save_national_news.jsp" method="post" name="myNews" onSubmit="return checks();">
<%
ResultSet rs=null;
ResultSet rs1=null;
Connection cn=null;
Statement stmt=null;
Statement stmt1=null;
AdminConn adminConn = AdminConn.getInstance();
cn = adminConn.getConnection();

String upQuery="";
String upQuery1="";
try
{	

	upQuery="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5, nn.run_date from national_news nn,employee e where date(nn.run_date)=curDate() and nn.category_id=63 and nn.emp_id=e.EMP_ID";
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5, nn.run_date from national_news nn,employee e  where nn.msg_id=(select max(msg_id) from national_news where category_id='63') and nn.category_id=63 and nn.emp_id=e.EMP_ID";
	stmt=cn.createStatement();
	stmt1=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	rs1=stmt1.executeQuery(upQuery1);
	//out.println(upQuery1);
	if(rs.next())
	{
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">Send National News<BR>
			  <a href="sp/national_news.jsp" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="right">By:<%=rs.getString("name")%> <b><%=rs.getString("date")%></b>&nbsp;&nbsp;</td>
		</tr>
		<tr height="5">
			<td colspan="3">
			</td>
		</tr>
		
		<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
		  <tr> 
			<TD><B>Headline1</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln1" value="<%=rs.getString("headline_1")%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',100);"><span id="sBann-1-1" class="minitext">&nbsp;100 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker1</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr1"  id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',150);"><%=rs.getString("more_1")%></textarea><span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr1)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline1: <%=rs.getString("headline_1")%><br><br>
	Kicker1: <%=rs.getString("more_1")%><br><br>
	Total Character Headline1: <%=rs.getString("headline_1").length()%><br><br>
	Total Character Kicker1: <%=rs.getString("more_1").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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

							<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline2</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln2" value="<%=rs.getString("headline_2")%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',100);"><span id="sBann-2-1" class="minitext">&nbsp;100 characters left.</span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker2</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr2" id="xBann-2-1" onKeyUp="Contar('xBann-2-1','yBann-2-1',' {CHAR} characters left.',150);"><%=rs.getString("more_2")%></textarea><span id="yBann-2-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr2)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline2: <%=rs.getString("headline_2")%><br><br>
	Kicker2: <%=rs.getString("more_2")%><br><br>
	Total Character Headline1: <%=rs.getString("headline_2").length()%><br><br>
	Total Character Kicker1: <%=rs.getString("more_2").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
			<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline3</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln3" value="<%=rs.getString("headline_3")%>" id="eBann-1-3"  onKeyUp="Contar('eBann-1-3','sBann-1-3',' {CHAR} characters left.',100);"><span id="sBann-1-3" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker3</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5"  name="kkr3" id="xBann-3-1" onKeyUp="Contar('xBann-3-1','yBann-3-1',' {CHAR} characters left.',150);"><%=rs.getString("more_3")%></textarea><span id="yBann-3-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr3)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline3: <%=rs.getString("headline_3")%><br><br>
	Kicker3: <%=rs.getString("more_3")%><br><br>
	Total Character Headline3: <%=rs.getString("headline_3").length()%><br><br>
	Total Character Kicker3: <%=rs.getString("more_3").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
				<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline4</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln4" value="<%=rs.getString("headline_4")%>" id="eBann-1-4"  onKeyUp="Contar('eBann-1-4','sBann-1-4',' {CHAR} characters left.',100);"><span id="sBann-1-4" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker4</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr4" id="xBann-4-1" onKeyUp="Contar('xBann-4-1','yBann-4-1',' {CHAR} characters left.',150);"><%=rs.getString("more_4")%></textarea><span id="yBann-4-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr4)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline4: <%=rs.getString("headline_4")%><br><br>
	Kicker4: <%=rs.getString("more_4")%><br><br>
	Total Character Headline4: <%=rs.getString("headline_4").length()%><br><br>
	Total Character Kicker4: <%=rs.getString("more_4").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
				<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline5</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln5" value="<%=rs.getString("headline_5")%>" id="eBann-1-5"  onKeyUp="Contar('eBann-1-5','sBann-1-5',' {CHAR} characters left.',100);"><span id="sBann-1-5" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker5</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr5" id="xBann-5-1" onKeyUp="Contar('xBann-5-1','yBann-5-1',' {CHAR} characters left.',150);"><%=rs.getString("more_5")%></textarea><span id="yBann-5-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr5)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline5: <%=rs.getString("headline_5")%><br><br>
	Kicker5: <%=rs.getString("more_5")%><br><br>
	Total Character Headline5: <%=rs.getString("headline_5").length()%><br><br>
	Total Character Kicker5: <%=rs.getString("more_5").length()%>
</td>


</tr>
<%
	}
	else {
		if(rs1.next()){
%>
						<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">Send National News<BR>
			  <a href="sp/news.html" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="right">By:<%=rs1.getString("name")%> <b><%=rs1.getString("date")%></b>&nbsp;&nbsp;</td>
		</tr>
		<tr height="5">
			<td colspan="3">
			</td>
		</tr>
		  <tr> 
			<TD><B>Headline1</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln1" value="<%=rs1.getString("headline_1")%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',100);"><span id="sBann-1-1" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker1</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr1"  id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',150);"><%=rs1.getString("more_1")%></textarea><span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr1)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline1: <%=rs1.getString("headline_1")%><br><br>
	Kicker1: <%=rs1.getString("more_1")%><br><br>
	Total Character Headline1: <%=rs1.getString("headline_1").length()%><br><br>
	Total Character Kicker1: <%=rs1.getString("more_1").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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

							<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline2</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln2" value="<%=rs1.getString("headline_2")%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',100);"><span id="sBann-2-1" class="minitext">&nbsp;100 characters left.</span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker2</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr2" id="xBann-2-1" onKeyUp="Contar('xBann-2-1','yBann-2-1',' {CHAR} characters left.',150);"><%=rs1.getString("more_2")%></textarea><span id="yBann-2-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr2)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline2: <%=rs1.getString("headline_2")%><br><br>
	Kicker2: <%=rs1.getString("more_2")%><br><br>
	Total Character Headline2: <%=rs1.getString("headline_2").length()%><br><br>
	Total Character Kicker2: <%=rs1.getString("more_2").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
			<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline3</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln3" value="<%=rs1.getString("headline_3")%>" id="eBann-1-3"  onKeyUp="Contar('eBann-1-3','sBann-1-3',' {CHAR} characters left.',100);"><span id="sBann-1-3" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker3</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr3" id="xBann-3-1" onKeyUp="Contar('xBann-3-1','yBann-3-1',' {CHAR} characters left.',150);"><%=rs1.getString("more_3")%></textarea><span id="yBann-3-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr3)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline3: <%=rs1.getString("headline_3")%><br><br>
	Kicker3: <%=rs1.getString("more_3")%><br><br>
	Total Character Headline3: <%=rs1.getString("headline_3").length()%><br><br>
	Total Character Kicker3: <%=rs1.getString("more_3").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
				<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline4</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln4" value="<%=rs1.getString("headline_4")%>" id="eBann-1-4"  onKeyUp="Contar('eBann-1-4','sBann-1-4',' {CHAR} characters left.',100);"><span id="sBann-1-4" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker4</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr4" id="xBann-4-1" onKeyUp="Contar('xBann-4-1','yBann-4-1',' {CHAR} characters left.',150);"><%=rs1.getString("more_4")%></textarea><span id="yBann-4-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr4)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline4: <%=rs1.getString("headline_4")%><br><br>
	Kicker4: <%=rs1.getString("more_4")%><br><br>
	Total Character Headline4: <%=rs1.getString("headline_4").length()%><br><br>
	Total Character Kicker4: <%=rs1.getString("more_4").length()%>
</td>


</tr>
<tr height="2">
<td  colspan="3">
	&nbsp;
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
				<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		  <tr> 
			<TD><B>Headline5</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=100 size=78 name="hdln5" value="<%=rs1.getString("headline_5")%>" id="eBann-1-5"  onKeyUp="Contar('eBann-1-5','sBann-1-5',' {CHAR} characters left.',100);"><span id="sBann-1-5" class="minitext">&nbsp;100 characters left.</span> 
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker5</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr5" id="xBann-5-1" onKeyUp="Contar('xBann-5-1','yBann-5-1',' {CHAR} characters left.',150);"><%=rs1.getString("more_5")%></textarea><span id="yBann-5-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="right" colspan="3">
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr5)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline5: <%=rs1.getString("headline_5")%><br><br>
	Kicker5: <%=rs1.getString("more_5")%><br><br>
	Total Character Headline5: <%=rs1.getString("headline_5").length()%><br><br>
	Total Character Kicker5: <%=rs1.getString("more_5").length()%>
</td>


</tr>

<%		}


	}
	
	}
			catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	rs = null;
	stmt = null;
}
%>

<TR>
<TD height="35" colspan="3">
<DIV align=center>
<INPUT type=submit value=Submit name=txtSubmit2> 
</DIV>
</TD>
</TR>
</form>
</tbody></table></body></html>