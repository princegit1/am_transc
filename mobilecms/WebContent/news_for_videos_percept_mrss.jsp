<%@page import="java.util.Arrays"%>
<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
String sectionId=request.getParameter("section");
String sectionname="";
if(sectionId.equals("234")){
sectionname="video-at-headlines-news-wrap";
}
if(sectionId.equals("235")){
sectionname="video-hlt-headlines-news-wrap";
}
if(sectionId.equals("236")){
sectionname="video-at-news-story";
}
if(sectionId.equals("237")){
sectionname="video-hlt-news-story";
}
if(sectionId.equals("238")){sectionname="video-dharma";}
if(sectionId.equals("239")){sectionname="video-breaking-news-hindi";}
if(sectionId.equals("240")){sectionname="video-breaking-news-english";}
if(sectionId.equals("241")){sectionname="video-photoshoot";}
if(sectionId.equals("873")){sectionname="video-at-news";}


 
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
<form action="save_content_for_videos_percept_mrss.jsp"  method="post" name="myNews" onSubmit="return checks();">
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
	String headlineTitle[]=new String[]{"","","","",""}; 
	String description[] = new String[]{"","","","",""}; 
	String videoUrl[] = new String[]{"","","","",""}; 
	String imageUrl[] =new String[]{"","","","",""}; 
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.pic_1,nn.pic_2,nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id in (select msg_id from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID order by msg_id desc limit 5";
	stmt1=cn.createStatement();
	rs1=stmt1.executeQuery(upQuery1);
	int count=0;
	
	while(rs1.next())
	{
	 name=rs1.getString("name");
     date=rs1.getString("date");
	 headline_1=rs1.getString("headline_1");
	 more_1=rs1.getString("more_1");
	 imageStatus1=rs1.getString("pic_1");
	 imageStatus2=rs1.getString("pic_2");
	  
	 headlineTitle[count]=headline_1;
	 description[count]=more_1;
	 imageUrl[count]=imageStatus2;
	 videoUrl[count]=imageStatus1;
	 count++;	
	}	
	count=0;
	
	 
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/vuclip_news_mrss.jsp?category=<%=sectionname %>" target="_blank">Check Existing</a></P>
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
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="headlineTitle" value="<%=headlineTitle[4]%>" id="fBann-1-1" onKeyUp="Contar('fBann-1-1','sBann-1-1',' {CHAR} characters left.',30);"><span id="fBann-1-1" class="minitext">&nbsp;20 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="description" id="xBann-1-1" onKeyUp="Contar('xBann-1-1','yBann-1-1',' {CHAR} characters left.',300);"><%=description[4]%></textarea><span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=120 name="videoUrl" value="<%=videoUrl[4]%>" id="eBann-1-1" >
			
						
			</td>
			
		  </TR>
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="imageUrl" value="<%=imageUrl[4]%>" id="mBann-1-1">
			
						
			</td>
			
		  </TR>
		 
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=description[4]%><br><br>
	Total Character News: <%=description[4].length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageUrl[4]%>" border="0"/>
</td>


</tr>

	<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
          <tr> 
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="headlineTitle" value="<%=headlineTitle[3]%>" id="fBann-1-1" onKeyUp="Contar('fBann-1-1','sBann-1-1',' {CHAR} characters left.',30);"><span id="fBann-1-2" class="minitext">&nbsp;20 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="description" id="xBann-1-2" onKeyUp="Contar('xBann-1-2','yBann-1-2',' {CHAR} characters left.',300);"><%=description[3]%></textarea><span id="yBann-1-2" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=120 name="videoUrl" value="<%=videoUrl[3]%>" id="eBann-1-2" >
			
						
			</td>
			
		  </TR>
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="imageUrl" value="<%=imageUrl[3]%>" id="mBann-1-2">
			
						
			</td>
			
		  </TR>
		 
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=description[3]%><br><br>
	Total Character News: <%=description[3].length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageUrl[3]%>" border="0"/>
</td>


</tr>



	<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
          <tr> 
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="headlineTitle" value="<%=headlineTitle[2]%>" id="fBann-1-3" onKeyUp="Contar('fBann-1-1','sBann-1-1',' {CHAR} characters left.',30);"><span id="fBann-1-3" class="minitext">&nbsp;20 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="description" id="xBann-1-3" onKeyUp="Contar('xBann-1-3','yBann-1-3',' {CHAR} characters left.',300);"><%=description[2]%></textarea><span id="yBann-1-3" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=120 name="videoUrl" value="<%=videoUrl[2]%>" id="eBann-1-3" >
			
						
			</td>
			
		  </TR>
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="imageUrl" value="<%=imageUrl[2]%>" id="mBann-1-3">
			
						
			</td>
			
		  </TR>
		 
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=description[2]%><br><br>
	Total Character News: <%=description[2].length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageUrl[2]%>" border="0"/>
</td>


</tr>

	<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
          <tr> 
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="headlineTitle" value="<%=headlineTitle[1]%>" id="fBann-1-4" onKeyUp="Contar('fBann-1-4','sBann-1-4',' {CHAR} characters left.',30);"><span id="fBann-1-4" class="minitext">&nbsp;20 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="description" id="xBann-1-4" onKeyUp="Contar('xBann-1-4','yBann-1-4',' {CHAR} characters left.',300);"><%=description[1]%></textarea><span id="yBann-1-4" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=120 name="videoUrl" value="<%=videoUrl[1]%>" id="eBann-1-4" >
			
						
			</td>
			
		  </TR>
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="imageUrl" value="<%=imageUrl[1]%>" id="mBann-1-4">
			
						
			</td>
			
		  </TR>
		 
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=description[1]%><br><br>
	Total Character News: <%=description[1].length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageUrl[1]%>" border="0"/>
</td>


</tr>	<tr valign="top">

<td>
		<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
		
          <tr> 
			<TD><B>Title</B>:</TD>
			<TD colspan="2">
				 <INPUT maxLength=310 size=30 name="headlineTitle" value="<%=headlineTitle[0]%>" id="fBann-1-5" onKeyUp="Contar('fBann-1-5','sBann-1-5',' {CHAR} characters left.',30);"><span id="fBann-1-5" class="minitext">&nbsp;20 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Description</B>:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="description" id="xBann-1-5" onKeyUp="Contar('xBann-1-5','yBann-1-5',' {CHAR} characters left.',300);"><%=description[0]%></textarea><span id="yBann-1-5" class="minitext">&nbsp;150 characters left.</span>
			</TD>
		  </TR>
		  
		  <tr> 
			<TD><B>Video Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=120 name="videoUrl" value="<%=videoUrl[0]%>" id="eBann-1-5" >
			
						
			</td>
			
		  </TR>
		    <tr> 
			<TD><B>Image Url</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=310 size=50 name="imageUrl" value="<%=imageUrl[0]%>" id="mBann-1-5">
			
						
			</td>
			
		  </TR>
		 
		  
		</TABLE>
</td>
<td>&nbsp;</td>
<td colspan="2">
	News : <%=description[0]%><br><br>
	Total Character News: <%=description[0].length()%><br><br>
	uploaded image:<img src="http://media2.intoday.in/mobileservice/images/<%=imageUrl[0]%>" border="0"/>
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
	e.printStackTrace();
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