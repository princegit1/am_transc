<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
System.out.println("sectionId---->"+sectionId);
String sectionname="";
if(sectionId.equals("355")){ sectionname="soccer-news"; }
if(sectionId.equals("356")){ sectionname="match-schedules"; }
if(sectionId.equals("357")){ sectionname="teams"; }
if(sectionId.equals("358")){ sectionname="match-results"; }
if(sectionId.equals("359")){ sectionname="trivia"; }


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
//alert(document.myNews.hdln1.value);
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
<!--<form action="save_rss_news_latinamerica.jsp" enctype="multipart/form-data" method="post" name="myNews" onSubmit="return checks();">-->
<form action="save_rss_news_latinamerica.jsp" method="post" name="myNews" onSubmit="return checks();">
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
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3, nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID";
	//System.out.println("upQuery1-->"+upQuery1);
	stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	
	if(rs1.next())
	{
	
	 name=rs1.getString("name");
	 date=rs1.getString("date");
	 headline_1=rs1.getString("headline_1");
	  more_1=rs1.getString("more_1");
	imageStatus1=rs1.getString("pic_1");
	 headline_2=rs1.getString("headline_2");
	 more_2=rs1.getString("more_2");
	  imageStatus2=rs1.getString("pic_2");
	  headline_3=rs1.getString("headline_3");
	 more_3=rs1.getString("more_3");
	  imageStatus3=rs1.getString("pic_3");
	 
	 }
	  if(imageStatus1!=null&&!imageStatus1.equals("")){
if(imageStatus1.contains("|")){
image1=imageStatus1.substring(0,imageStatus1.indexOf("|"));
image2=imageStatus1.substring(imageStatus1.indexOf("|")+1,imageStatus1.length());
}	
}
if(imageStatus2!=null&&!imageStatus2.equals("")){
if(imageStatus2.contains("|")){
image3=imageStatus2.substring(0,imageStatus2.indexOf("|"));
image4=imageStatus2.substring(imageStatus2.indexOf("|")+1,imageStatus2.length());

}	  
	 }
	 
	 if(imageStatus3!=null&&!imageStatus3.equals("")){
if(imageStatus3.contains("|")){
image5=imageStatus3.substring(0,imageStatus3.indexOf("|"));
image6=imageStatus3.substring(imageStatus3.indexOf("|")+1,imageStatus3.length());

}	  
	 }
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/latinamerica_news_rss.jsp?category=<%=sectionname %>" target="_blank">Check Existing</a></P>
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
			 <INPUT maxLength=310 size=78 name="hdln1" value="<%=headline_1%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',30);"><span id="sBann-1-1" class="minitext">&nbsp;30 characters left.</span> <span><script></script></span>
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
		IMAGE STATUS:-50x50	<select name="image1">
		
<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
	128X128		<select name="image2">

<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
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
	IMAGE STATUS:-<br>
	50X50:- <%=image1%><br>
	128X128:- <%=image2%>
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
			 <INPUT maxLength=100 size=78 name="hdln2" value="<%=headline_2%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',30);"><span id="sBann-2-1" class="minitext">&nbsp;30 characters left.</span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker2</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr2"   id="xBann-2-1" onKeyUp="Contar('xBann-2-1','yBann-2-1',' {CHAR} characters left.',400);"><%=more_2%></textarea><span id="yBann-2-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
			IMAGE STATUS:-50x50	<select name="image3">
<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
	128X128		<select name="image4">
<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
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
	IMAGE STATUS:-<br>
	50X50:- <%=image3%><br>
	128X128:- <%=image4%>
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
			 <INPUT maxLength=100 size=78 name="hdln3" value="<%=headline_3%>" id="eBann-3-1" onKeyUp="Contar('eBann-3-1','sBann-3-1',' {CHAR} characters left.',30);"><span id="sBann-3-1" class="minitext">&nbsp;30 characters left.</span>
			</TD>
		  </TR>
				
		  <tr> 
			<TD><B>Kicker3</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr3"   id="xBann-3-1" onKeyUp="Contar('xBann-3-1','yBann-3-1',' {CHAR} characters left.',400);"><%=more_3%></textarea><span id="yBann-3-1" class="minitext">&nbsp;400 characters left.</span>
			</TD>
		  </TR>
		  <tr> 
			<td align="left" colspan="3">
			IMAGE STATUS:-50x50	<select name="image5">
<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
	128X128		<select name="image6">
<option value="YES" selected="selected">YES</option>
<option value="NO">NO</option>
</select>	
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
	IMAGE STATUS:-<br>
	50X50:- <%=image5%><br>
	128X128:- <%=image6%>
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
<INPUT type="hidden" value="<%=sectionId%>" name="section"> 
<INPUT type=submit value=Submit name=txtSubmit2> 
</DIV>
</TD>
</TR>
</form>
</tbody></table></body></html>