<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
//String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
String sectionname="";
//System.out.println("Section is "+sectionId);
if(sectionId.equals("556")){
sectionname="news-politics";
}
if(sectionId.equals("557")){
sectionname="entertainment-movie-trailers";
}
if(sectionId.equals("558")){
sectionname="celebs-gossip";
}
if(sectionId.equals("559")){
sectionname="fashion-lifestyle";
}
if(sectionId.equals("560")){
	sectionname="devotional";
}



 
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

document.myNews.title.value = "";
document.myNews.desc.value = "";
document.myNews.key.value = "";
document.myNews.video1.value = "";
document.myNews.video2.value = "";
document.myNews.video3.value = "";
document.myNews.img1.value = "";
document.myNews.dur1.value = "";
document.myNews.filesize.value = "";
document.myNews.bitrate.value = "";
document.myNews.price.value = "";

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
<form action="save_content_for_videos_cbc.jsp"  method="post" name="myNews" onSubmit="return checks();">
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


String title=null;
	String desc=null;
	String keyword=null;
	String video1=null;
	String video2=null;
	String video3=null;
	String image=null;
	String duration=null;
	String fileSize=null;
	String bitrate=null;
	String section=null;
	String price=null;

try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.headline_2,nn.headline_3,nn.headline_4,nn.headline_5,nn.more_1,nn.more_2,nn.more_3,nn.pic_1,nn.pic_2,nn.pic_3,nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID";
	//System.out.println(upQuery1);
	stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	
	if(rs1.next())
	{
	
	 name=rs1.getString("name");
	 date=rs1.getString("date");

	
	 title=rs1.getString("headline_1");
	 desc=rs1.getString("more_1");
	 keyword=rs1.getString("pic_1");;
	 video1=rs1.getString("headline_2");
	 video2=rs1.getString("more_2");
	 image=rs1.getString("pic_2");
	 duration=rs1.getString("headline_3");
	 fileSize=rs1.getString("more_3");
	 bitrate=rs1.getString("pic_3");
	  price=rs1.getString("headline_4");
	   video3=rs1.getString("headline_5");
	 
	 }
	   
	 
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/airtel-3g-video-content.jsp?category=<%=sectionname %>" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="right">By:<%=name%> <b><%=date%></b>&nbsp;&nbsp;</td>
		</tr>
		<tr height="5">
			<td colspan="3">
			<% if(request.getParameter("msg")!=null)
				out.println(request.getParameter("msg"));
				%>
			</td>
		</tr>
		
		<tr valign="top">
		
<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
		   <tr> 
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=120 name="title" value="<%=title%>" id="ABann-1-1" onKeyUp="Contar('BBann-1-1','CBann-1-1',' {CHAR} characters left.',300);"><span id="ABann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="desc" id="a1Bann-1-1" onKeyUp="Contar('b1Bann-1-1','c1Bann-1-1',' {CHAR} characters left.',300);"><%=desc%></textarea><span id="c1Bann-1-1" class="minitext">&nbsp;300 characters left.</span>
			</TD>
		  </TR>
		   <tr> 
			<TD><B>Key words</B>:</TD>
			<TD colspan="2">
				<INPUT maxLength=310 size=120 name="key" value="<%=keyword%>" id="a2Bann-1-1" onKeyUp="Contar('b2Bann-1-1','c2Bann-1-1',' {CHAR} characters left.',300);"><span id="a2Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url (High device)</B> :</TD>
			<TD colspan="2"> 
			<INPUT maxLength=310 size=120 name="video1" value="<%=video1%>" id="a3Bann-1-1" onKeyUp="Contar('b3Bann-1-1','c3Bann-1-1',' {CHAR} characters left.',300);"><span id="a3Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			
						
			</td>
			
		  </TR>
		   <tr> 
			<TD><B>Video Url (Medium device)</B> :</TD>
			<TD colspan="2"> 
			<INPUT maxLength=310 size=120 name="video3" value="<%=video3%>" id="v4Bann-1-1" onKeyUp="Contar('w4Bann-1-1','x4Bann-1-1',' {CHAR} characters left.',300);"><span id="v4Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			
						
			</td>
			
		  </TR>
		  <tr> 
			<TD><B>Video Url (Low device)</B> :</TD>
			<TD colspan="2"> 
			<INPUT maxLength=310 size=120 name="video2" value="<%=video2%>" id="a4Bann-1-1" onKeyUp="Contar('b4Bann-1-1','c4Bann-1-1',' {CHAR} characters left.',300);"><span id="a4Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			
						
			</td>
			
		  </TR>
		
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			<INPUT maxLength=310 size=120 name="img1" value="<%=image%>" id="a5Bann-1-1" onKeyUp="Contar('b5Bann-1-1','c5Bann-1-1',' {CHAR} characters left.',300);"><span id="a5Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			
						
			</td>
			
		  </TR>
		   <tr> 
			<TD><B>Duration</B>:</TD>
			<TD colspan="2">
				<INPUT maxLength=310 size=120 name="dur1" value="<%=duration%>" id="a6Bann-1-1" onKeyUp="Contar('b6Bann-1-1','c6Bann-1-1',' {CHAR} characters left.',300);"><span id="a6Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		     <tr> 
			<TD><B>File size</B>:</TD>
			<TD colspan="2">
				<INPUT maxLength=310 size=120 name="filesize" value="<%=fileSize%>" id="a7Bann-1-1" onKeyUp="Contar('b7Bann-1-1','c7Bann-1-1',' {CHAR} characters left.',300);"><span id="a7Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		     <tr> 
			<TD><B>Bit rate</B>:</TD>
			<TD colspan="2">
				<INPUT maxLength=310 size=120 name="bitrate" value="<%=bitrate%>" id="a8Bann-1-1" onKeyUp="Contar('b8Bann-1-1','c8Bann-1-1',' {CHAR} characters left.',300);"><span id="a8Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  <tr> 
			<TD><B>price </B>:</TD>
			<TD colspan="2">
				<INPUT maxLength=310 size=120 name="price" value="<%=price%>" id="a9Bann-1-1" onKeyUp="Contar('b9Bann-1-1','c9Bann-1-1',' {CHAR} characters left.',300);"><span id="a9Bann-1-1" class="minitext">&nbsp;300 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		</TABLE>
			
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
</form>
</tbody></table></body></html>