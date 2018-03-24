<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
String sectionname="";
if(sectionId.equals("435")){
sectionname="spice-rajasthan-unicode";}
if(sectionId.equals("436")){
sectionname="spice-rajasthan-roman";}
if(sectionId.equals("437")){
sectionname="spice-bihar-unicode";}
if(sectionId.equals("438")){
sectionname="spice-bihar-roman";}
if(sectionId.equals("439")){
sectionname="spice-gujarat-unicode";}
if(sectionId.equals("440")){
sectionname="spice-gujarat-roman";}
if(sectionId.equals("441")){
sectionname="spice-delhi-unicode";}
if(sectionId.equals("442")){
sectionname="spice-delhi-roman";}
if(sectionId.equals("443")){
sectionname="spice-punjab-unicode";}
if(sectionId.equals("444")){
sectionname="spice-punjab-roman";}
if(sectionId.equals("445")){
sectionname="spice-kerala-unicode";}
if(sectionId.equals("446")){
sectionname="spice-kerala-roman";}
if(sectionId.equals("447")){
sectionname="spice-kolkata-wb-unicode";}
if(sectionId.equals("448")){
sectionname="spice-kolkata-wb-roman";}
if(sectionId.equals("449")){
sectionname="spice-assam-unicode";}
if(sectionId.equals("450")){
sectionname="spice-assam-roman";}
if(sectionId.equals("451")){
sectionname="spice-tamil-nadu-unicode";}
if(sectionId.equals("452")){
sectionname="spice-tamil-nadu-roman";}
if(sectionId.equals("453")){
sectionname="spice-andhra-pradesh-unicode";}
if(sectionId.equals("454")){
sectionname="spice-andhra-pradesh-roman";}
if(sectionId.equals("455")){
sectionname="spice-gujarat-unicode-regional";}
if(sectionId.equals("456")){
sectionname="spice-rajasthan-unicode-regional";}
if(sectionId.equals("457")){
sectionname="spice-rajasthan-roman-regional";}
if(sectionId.equals("458")){
sectionname="spice-bihar-unicode-regional";}
if(sectionId.equals("459")){
sectionname="spice-bihar-roman-regional";}
if(sectionId.equals("460")){
sectionname="spice-gujarat-roman-regional";}
if(sectionId.equals("461")){
sectionname="spice-delhi-unicode-regional";}
if(sectionId.equals("462")){
sectionname="spice-delhi-roman-regional";}
if(sectionId.equals("463")){
sectionname="spice-punjab-unicode-regional";}
if(sectionId.equals("464")){
sectionname="spice-punjab-roman-regional";}
if(sectionId.equals("465")){
sectionname="spice-kerala-unicode-regional";}
if(sectionId.equals("466")){
sectionname="spice-kerala-roman-regional";}
if(sectionId.equals("467")){
sectionname="spice-kolkata-wb-unicode-regional";}
if(sectionId.equals("468")){
sectionname="spice-kolkata-wb-roman-regional";}
if(sectionId.equals("469")){
sectionname="spice-assam-unicode-regional";}
if(sectionId.equals("470")){
sectionname="spice-assam-roman-regional";}
if(sectionId.equals("471")){
sectionname="spice-tamil-nadu-unicode-regional";}
if(sectionId.equals("472")){
sectionname="spice-tamil-nadu-roman-regional";}
if(sectionId.equals("473")){
sectionname="spice-andhra-pradesh-unicode-regional";}
if(sectionId.equals("474")){
sectionname="spice-andhra-pradesh-roman-regional";}




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
for(int i=1;i<11;i++)
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
var hd6 = document.myNews.hdln6.value.length;
var hd7 = document.myNews.hdln7.value.length;
var hd8 = document.myNews.hdln8.value.length;
var hd9 = document.myNews.hdln9.value.length;
var hd10 = document.myNews.hdln10.value.length;
var tot  = hd1+hd2+hd3+hd4+hd5+hd6+hd7+hd8+hd9+hd10;
if(tot >=500)
	{
	alert ("Total count of headline is greater than 50")
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
<form action="save_rss_news_spice.jsp"     enctype="multipart/form-data" method="post" name="myNews" onSubmit="return checks();">
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
String headline_2="";
String more_2="";
String headline_3="";
String more_3="";
String headline_4="";
String more_4="";
String headline_5="";
String more_5="";
String headline_6="";
String more_6="";
String headline_7="";
String more_7="";
String headline_8="";
String more_8="";
String headline_9="";
String more_9="";
String headline_10="";
String more_10="";
String image1="";
String image2="";
String image3="";
String image4="";
String image5="";
String image6="";
String imageStatus1="";
String imageStatus2="";
String imageStatus3="";
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6,nn.headline_7,nn.more_7,nn.headline_8,nn.more_8,nn.headline_9,nn.more_9,nn.headline_10,nn.more_10, nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID";
//out.println("-------->"+upQuery1);	
stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	
	
	
	if(rs1.next())
	{
	
	 name=rs1.getString("name");
	 date=rs1.getString("date");
	 
	 headline_1=rs1.getString("headline_1") == null ? "" : rs1.getString("headline_1");
	  more_1=rs1.getString("more_1") == null ? "" : rs1.getString("more_1");
	
	 headline_2=rs1.getString("headline_2") == null ? "" : rs1.getString("headline_2");
	 more_2=rs1.getString("more_2") == null ? "" : rs1.getString("more_2");

//out.println("-------->"+headline_2);
	 
	  headline_3=rs1.getString("headline_3") == null ? "" : rs1.getString("headline_3");
	 more_3=rs1.getString("more_3") == null ? "" : rs1.getString("more_3");
	 
	  headline_4=rs1.getString("headline_4") == null ? "" : rs1.getString("headline_4");
	  more_4=rs1.getString("more_4") == null ? "" : rs1.getString("more_4");
	
	 headline_5=rs1.getString("headline_5") == null ? "" : rs1.getString("headline_5");
	 more_5=rs1.getString("more_5") == null ? "" : rs1.getString("more_5");
	 
	  headline_6=rs1.getString("headline_6") == null ? "" : rs1.getString("headline_6");
	 more_6=rs1.getString("more_6") == null ? "" : rs1.getString("more_6");
	 
	  
	  headline_7=rs1.getString("headline_7") == null ? "" : rs1.getString("headline_7");
	  more_7=rs1.getString("more_7") == null ? "" : rs1.getString("more_7");
	
	 headline_8=rs1.getString("headline_8") == null ? "" : rs1.getString("headline_8");
	 more_8=rs1.getString("more_8") == null ? "" : rs1.getString("more_8");
	 
	  headline_9=rs1.getString("headline_9") == null ? "" : rs1.getString("headline_9");
	 more_9=rs1.getString("more_9") == null ? "" : rs1.getString("more_9");
	 
	 
	   headline_10=rs1.getString("headline_10") == null ? "" : rs1.getString("headline_10");
	 more_10=rs1.getString("more_10") == null ? "" : rs1.getString("more_10");
	 }
	 
//out.println("-------->"+headline_2);
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/rss_news_spice.jsp?id=<%=sectionId %>" target="_blank">Check Existing</a></P>
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
			<TD><B>Headline1</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln1" value="<%=headline_1%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',50);"><span id="sBann-1-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker1</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr1" id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',400);"><%=more_1%></textarea><span id="yBann-1-1" class="minitext">&nbsp;400 characters left.</span>
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
	Headline1: <%=headline_1%><br><br>
	Kicker1: <%=more_1%><br><br>
	Total Character Headline1: <%=headline_1.length()%><br><br>
	Total Character Kicker1: <%=more_1.length()%><br><br>
	
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
			 <INPUT maxLength=310 size=78 name="hdln2" value="<%=headline_2%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',50);"><span id="sBann-2-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker2</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr2" id="xBann-2-1" onKeyUp="Contar('xBann-2-1','yBann-2-1',' {CHAR} characters left.',400);"><%=more_2%></textarea><span id="yBann-2-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr2)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline2: <%=headline_2%><br><br>
	Kicker2: <%=more_2%><br><br>
	Total Character Headline2: <%=headline_2.length()%><br><br>
	Total Character Kicker2: <%=more_2.length()%><br><br>
	
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
			 <INPUT maxLength=310 size=78 name="hdln3" value="<%=headline_3%>" id="eBann-3-1" onKeyUp="Contar('eBann-3-1','sBann-3-1',' {CHAR} characters left.',50);"><span id="sBann-3-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker3</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr3" id="xBann-3-1" onKeyUp="Contar('xBann-3-1','yBann-3-1',' {CHAR} characters left.',400);"><%=more_3%></textarea><span id="yBann-3-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr3)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline3: <%=headline_3%><br><br>
	Kicker3: <%=more_3%><br><br>
	Total Character Headline3: <%=headline_3.length()%><br><br>
	Total Character Kicker3: <%=more_3.length()%><br><br>
	
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
			 <INPUT maxLength=310 size=78 name="hdln4" value="<%=headline_4%>" id="eBann-4-1" onKeyUp="Contar('eBann-4-1','sBann-4-1',' {CHAR} characters left.',50);"><span id="sBann-4-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker4</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr4" id="xBann-4-1" onKeyUp="Contar('xBann-4-1','yBann-4-1',' {CHAR} characters left.',400);"><%=more_4%></textarea><span id="yBann-4-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr4)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline4: <%=headline_4%><br><br>
	Kicker4: <%=more_4%><br><br>
	Total Character Headline4: <%=headline_4.length()%><br><br>
	Total Character Kicker4: <%=more_4.length()%><br><br>
	
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
			 <INPUT maxLength=310 size=78 name="hdln5" value="<%=headline_5%>" id="eBann-5-1" onKeyUp="Contar('eBann-5-1','sBann-5-1',' {CHAR} characters left.',50);"><span id="sBann-5-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker5</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr5" id="xBann-5-1" onKeyUp="Contar('xBann-5-1','yBann-5-1',' {CHAR} characters left.',400);"><%=more_5%></textarea><span id="yBann-5-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr5)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline5: <%=headline_5%><br><br>
	Kicker5: <%=more_5%><br><br>
	Total Character Headline5: <%=headline_5.length()%><br><br>
	Total Character Kicker5: <%=more_5.length()%><br><br>
	
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
			<TD><B>Headline6</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln6" value="<%=headline_6%>" id="eBann-6-1" onKeyUp="Contar('eBann-6-1','sBann-6-1',' {CHAR} characters left.',50);"><span id="sBann-6-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker6</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr6" id="xBann-6-1" onKeyUp="Contar('xBann-6-1','yBann-6-1',' {CHAR} characters left.',400);"><%=more_6%></textarea><span id="yBann-6-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr6)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline6: <%=headline_6%><br><br>
	Kicker6: <%=more_6%><br><br>
	Total Character Headline6: <%=headline_6.length()%><br><br>
	Total Character Kicker6: <%=more_6.length()%><br><br>
	
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
			<TD><B>Headline7</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln7" value="<%=headline_7%>" id="eBann-7-1" onKeyUp="Contar('eBann-7-1','sBann-7-1',' {CHAR} characters left.',50);"><span id="sBann-7-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker7</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr7" id="xBann-7-1" onKeyUp="Contar('xBann-7-1','yBann-7-1',' {CHAR} characters left.',400);"><%=more_7%></textarea><span id="yBann-7-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr7)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline7: <%=headline_7%><br><br>
	Kicker7: <%=more_7%><br><br>
	Total Character Headline7: <%=headline_7.length()%><br><br>
	Total Character Kicker7: <%=more_7.length()%><br><br>
	
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
			<TD><B>Headline8</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln8" value="<%=headline_8%>" id="eBann-8-1" onKeyUp="Contar('eBann-8-1','sBann-8-1',' {CHAR} characters left.',50);"><span id="sBann-8-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker8</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr8" id="xBann-8-1" onKeyUp="Contar('xBann-8-1','yBann-8-1',' {CHAR} characters left.',400);"><%=more_8%></textarea><span id="yBann-8-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr8)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline8: <%=headline_8%><br><br>
	Kicker8: <%=more_8%><br><br>
	Total Character Headline8: <%=headline_8.length()%><br><br>
	Total Character Kicker8: <%=more_8.length()%><br><br>
	
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
			<TD><B>Headline9</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln9" value="<%=headline_9%>" id="eBann-9-1" onKeyUp="Contar('eBann-9-1','sBann-9-1',' {CHAR} characters left.',50);"><span id="sBann-9-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker9</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr9" id="xBann-9-1" onKeyUp="Contar('xBann-9-1','yBann-9-1',' {CHAR} characters left.',400);"><%=more_9%></textarea><span id="yBann-9-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr9)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline9: <%=headline_9%><br><br>
	Kicker9: <%=more_9%><br><br>
	Total Character Headline9: <%=headline_9.length()%><br><br>
	Total Character Kicker9: <%=more_9.length()%><br><br>
	
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
			<TD><B>Headline10</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=78 name="hdln10" value="<%=headline_10%>" id="eBann-10-1" onKeyUp="Contar('eBann-10-1','sBann-10-1',' {CHAR} characters left.',50);"><span id="sBann-10-1" class="minitext">&nbsp;50 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker10</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr10" id="xBann-10-1" onKeyUp="Contar('xBann-10-1','yBann-10-1',' {CHAR} characters left.',400);"><%=more_10%></textarea><span id="yBann-10-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
		
				<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.kkr10)">&nbsp;	
			</td>
			
		  </TR>
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	Headline10: <%=headline_10%><br><br>
	Kicker10: <%=more_10%><br><br>
	Total Character Headline1: <%=headline_10.length()%><br><br>
	Total Character Kicker1: <%=more_10.length()%><br><br>
	
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