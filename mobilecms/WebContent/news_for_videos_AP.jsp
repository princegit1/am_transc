<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
String regionId=request.getParameter("region");

String sectionname="";
if(sectionId.equals("756")){
sectionname="video-AP_Hind";
}
if(sectionId.equals("757")){
sectionname="video-AP_Islam";
}
if(sectionId.equals("758")){
sectionname="video-AP_Sikh";
}
if(sectionId.equals("759")){
sectionname="video-AP_Christ";
}
if(sectionId.equals("760")){
sectionname="video-AP_Jain";
}
if(sectionId.equals("761")){
sectionname="video-AP_NotKnown";
}
if(sectionId.equals("238")){sectionname="video-dharma";}
if(sectionId.equals("239")){sectionname="video-breaking-news-hindi";}
if(sectionId.equals("240")){sectionname="video-breaking-news-english";}
if(sectionId.equals("241")){sectionname="video-photoshoot";}

if(sectionId.equals("413")){sectionname="video-bollywood-and-hollywood-gossips";}
if(sectionId.equals("414")){sectionname="video-celeb-interviews";}
if(sectionId.equals("415")){sectionname="video-fashion";}
if(sectionId.equals("416")){sectionname="video-sports";}
if(sectionId.equals("417")){sectionname="video-lifestyle";}


 
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
/*
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
*/
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
<form action="save_content_for_videos_AP.jsp"     method="post" name="myNews" onSubmit="return checks();">
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
String imageStatus1="";
String imageStatus2="";
try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.pic_1,nn.pic_2,nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"' AND more_1='"+regionId+"') and nn.category_id='"+sectionId+"' AND more_1='"+regionId+"' and nn.emp_id=e.EMP_ID";
	stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	
	if(rs1.next())
	{
	
	 name=rs1.getString("name");
	 date=rs1.getString("date");
	 headline_1=rs1.getString("headline_1");
	  more_1=rs1.getString("more_1");
	imageStatus1=rs1.getString("pic_1");
	imageStatus2=rs1.getString("pic_2");
	
	 
	 }
	   
	 
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/AP_news_mrss.jsp?category=<%=sectionname %>" target="_blank">Check Existing</a></P>
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
		
		  
		  <tr style="display:none"> 
			<TD><B>News</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="kkr1" id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',300);"><%=more_1%></textarea><span id="yBann-1-1" class="minitext">&nbsp;300 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			<!-- <INPUT maxLength=310 size=120 name="hdln1" value="<%//=imageStatus1%>" id="eBann-1-1" >-->
			<textarea name="hdln1" id="eBann-1-1" rows="15" cols="90"><%=imageStatus1%></textarea>
						
			</td>
			
		  </TR>
		    <tr style="display:none"> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="hd2n1" value="<%=imageStatus2%>" id="mBann-1-1">
			
						
			</td>
			
		  </TR>
		   <tr style="display:none"> 
			<TD><B>Duration</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="pic1" value="<%=headline_1%>" id="fBann-1-1" onKeyUp="Contar('fBann-1-1','sBann-1-1',' {CHAR} characters left.',30);"><span id="fBann-1-1" class="minitext">&nbsp;30 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=more_1%><br><br>
	Total Character News: <%=more_1.length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageStatus2%>" border="0"/>
</td>


</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>

<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>

							
<%
	//}
	
	}
			catch(Exception e)
{
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
<INPUT type="hidden" value="<%=regionId%>" name=region> 
</form>
</tbody></table></body></html>