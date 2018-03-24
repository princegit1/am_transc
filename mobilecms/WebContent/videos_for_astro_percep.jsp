<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
//String sectionId=request.getParameter("section");
String sectionId="875";
String sectionname="";
if(sectionId.equals("875")){
sectionname="astro-percep";}

%>
<html>
<head>
<title>Send News Content - ITGO</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<script language="JavaScript">
function resetTextAreas()
{
<%
for(int i=1;i<13;i++)
{
%>
document.myNews.kkr<%=i%>.value = "";
document.myNews.hdln<%=i%>.value = "";
document.myNews.dur<%=i%>.value = "";
<%
}
%>
}
</script> 
<link href="styles/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="topBand.jsp" />
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="top">
				<td align="center" colspan="3">
					<input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">
			</td>
			
		</tr>
		<tr height="8">
			<td colspan="3">
			</td>
		</tr>
<form action="save_videos_for_astro_percep.jsp"     enctype="multipart/form-data" method="post" name="myNews" onSubmit="return checks();">
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
String dur_1="";
String headline_2="";
String more_2="";
String dur_2="";
String headline_3="";
String more_3="";
String dur_3="";
String headline_4="";
String more_4="";
String dur_4="";
String headline_5="";
String more_5="";
String dur_5="";
String headline_6="";
String more_6="";
String dur_6="";
String headline_7="";
String more_7="";
String dur_7="";
String headline_8="";
String more_8="";
String dur_8="";
String headline_9="";
String more_9="";
String dur_9="";
String headline_10="";
String more_10="";
String dur_10="";
String headline_11="";
String more_11="";
String dur_11="";
String headline_12="";
String more_12="";
String dur_12="";
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
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.pic_1,nn.headline_2,nn.more_2,nn.pic_2,nn.headline_3,nn.more_3,nn.pic_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5,nn.headline_6,nn.more_6,nn.headline_7,nn.more_7,nn.headline_8,nn.more_8,nn.headline_9,nn.more_9,nn.headline_10,nn.more_10,nn.headline_11,nn.more_11,nn.headline_12,nn.more_12,nn.pic_1,nn.pic_2,nn.pic_3,nn.pic_4,nn.pic_5,nn.pic_6,nn.pic_7,nn.pic_8,nn.pic_9,nn.pic_10,nn.pic_11,nn.pic_12, nn.run_date from mobile_rss_news nn,employee e  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+sectionId+"') and nn.category_id='"+sectionId+"' and nn.emp_id=e.EMP_ID";
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
	 
	 headline_11=rs1.getString("headline_11") == null ? "" : rs1.getString("headline_11");
	 more_11=rs1.getString("more_11") == null ? "" : rs1.getString("more_11");
	 
	 headline_12=rs1.getString("headline_12") == null ? "" : rs1.getString("headline_12");
	 more_12=rs1.getString("more_12") == null ? "" : rs1.getString("more_12");
	 
	 
	 dur_1=rs1.getString("pic_1") == null ? "" : rs1.getString("pic_1");
	  dur_2=rs1.getString("pic_2") == null ? "" : rs1.getString("pic_2");
	   dur_3=rs1.getString("pic_3") == null ? "" : rs1.getString("pic_3");
	    dur_4=rs1.getString("pic_4") == null ? "" : rs1.getString("pic_4");
	     dur_5=rs1.getString("pic_5") == null ? "" : rs1.getString("pic_5");
	      dur_6=rs1.getString("pic_6") == null ? "" : rs1.getString("pic_6");
	       dur_7=rs1.getString("pic_7") == null ? "" : rs1.getString("pic_7");
	        dur_8=rs1.getString("pic_8") == null ? "" : rs1.getString("pic_8");
	         dur_9=rs1.getString("pic_9") == null ? "" : rs1.getString("pic_9");
	          dur_10=rs1.getString("pic_10") == null ? "" : rs1.getString("pic_10");
	          dur_11=rs1.getString("pic_11") == null ? "" : rs1.getString("pic_11");
	          dur_12=rs1.getString("pic_12") == null ? "" : rs1.getString("pic_12");
	  
	 
	 
	 }
	 
//out.println("-------->"+headline_2);
	 
%>
<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="center">
			  <P class="topic">News For Rss Update:-<%=sectionname%><BR>
			  <a href="sp/vuclip_astro_mrss.jsp" target="_blank">Check Existing</a></P>
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
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>ARIES</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln1" value="<%=headline_1%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',140);"><span id="sBann-1-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		
         <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
			<textarea cols="60" rows="5" name="dur1" id="dur1" onKeyUp="Contar('dur1','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_1%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			</TD>
		  </TR>		
                
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr1" value="<%=more_1%>"  >
				
			</TD>
			 </TR>
				
		 
		  
		</TABLE>
</td>
</tr>


<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>
<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>TAURUS</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln2" value="<%=headline_2%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',140);"><span id="sBann-2-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur2" id="dur2" onKeyUp="Contar('dur2','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_2%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>		
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr2" value="<%=more_2%>"  >				
			</TD>
			 </TR>
				
		
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>

<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>GEMINI</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln3" value="<%=headline_3%>" id="eBann-3-1" onKeyUp="Contar('eBann-3-1','sBann-3-1',' {CHAR} characters left.',140);"><span id="sBann-3-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur3" id="dur3" onKeyUp="Contar('dur3','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_3%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>		
				
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr3" value="<%=more_3%>"  >
				
			</TD>
			 </TR>		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>



<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>CANCER</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln4" value="<%=headline_4%>" id="eBann-4-1" onKeyUp="Contar('eBann-4-1','sBann-4-1',' {CHAR} characters left.',140);"><span id="sBann-4-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
		  <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur4" id="dur4" onKeyUp="Contar('dur3','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_4%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>						
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr4" value="<%=more_4%>"  >
				
			</TD>
			 </TR>		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>



<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>LEO</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln5" value="<%=headline_5%>" id="eBann-5-1" onKeyUp="Contar('eBann-5-1','sBann-5-1',' {CHAR} characters left.',140);"><span id="sBann-5-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>				
   		  <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur5" id="dur5" onKeyUp="Contar('dur3','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_5%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
       
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr5" value="<%=more_5%>"  >				
			</TD>
			 </TR>		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>VIRGO</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln6" value="<%=headline_6%>" id="eBann-6-1" onKeyUp="Contar('eBann-6-1','sBann-6-1',' {CHAR} characters left.',140);"><span id="sBann-6-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
				
            <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur6" id="dur6" onKeyUp="Contar('dur3','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_6%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
                
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr6" value="<%=more_6%>"  >
				
			</TD>
			 </TR>	
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>LIBRA</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln7" value="<%=headline_7%>" id="eBann-7-1" onKeyUp="Contar('eBann-7-1','sBann-7-1',' {CHAR} characters left.',140);"><span id="sBann-7-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur7" id="dur7" onKeyUp="Contar('dur3','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_7%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
		
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr7" value="<%=more_7%>"  >
				
			</TD>
			 </TR>				
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>SCORPIO</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln8" value="<%=headline_8%>" id="eBann-8-1" onKeyUp="Contar('eBann-8-1','sBann-8-1',' {CHAR} characters left.',140);"><span id="sBann-2-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>

          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur8" id="dur8" onKeyUp="Contar('dur8','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_7%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
				
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr8" value="<%=more_8%>"  >
				
			</TD>
			 </TR>	
		
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>SAGITTARIUS</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln9" value="<%=headline_9%>" id="eBann-9-1" onKeyUp="Contar('eBann-9-1','sBann-9-1',' {CHAR} characters left.',140);"><span id="sBann-9-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur9" id="dur9" onKeyUp="Contar('dur8','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_9%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
				
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr9" value="<%=more_9%>"  >
				
			</TD>
			 </TR>			
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>CAPRICORN</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln10" value="<%=headline_10%>" id="eBann-10-1" onKeyUp="Contar('eBann-10-1','sBann-10-1',' {CHAR} characters left.',140);"><span id="sBann-10-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur10" id="dur10" onKeyUp="Contar('dur8','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_10%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
				
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr10" value="<%=more_10%>"  >
				
			</TD>
			 </TR>		
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>AQUARIUS</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln11" value="<%=headline_11%>" id="eBann-11-1" onKeyUp="Contar('eBann-11-1','sBann11-1',' {CHAR} characters left.',140);"><span id="sBann-11-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur11" id="dur11" onKeyUp="Contar('dur8','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_11%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
				
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr11" value="<%=more_11%>"  >
				
			</TD>
			 </TR>		
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>

<tr valign="top">

<td>
		<TABLE border="0" cellPadding=3 cellSpacing=1 width="70%">
		
		  <tr> 
			<TD><B>PISCES</B> :</TD>
			<TD colspan="2"> 
			 <INPUT maxLength=140 size=100 name="hdln12" value="<%=headline_12%>" id="eBann-12-1" onKeyUp="Contar('eBann-12-1','sBann12-1',' {CHAR} characters left.',140);"><span id="sBann-12-1" class="minitext">&nbsp;140 characters left.</span> <span><script></script></span>
			</TD>
		  </TR>
          <tr> 
			<TD>Description:</TD>
			<TD colspan="2">
				<textarea cols="60" rows="5" name="dur12" id="dur12" onKeyUp="Contar('dur12','yBann-1-1',' {CHAR} characters left.',150);"><%=dur_12%></textarea>
            <span id="yBann-1-1" class="minitext">&nbsp;150 characters left.</span>	
			
			</TD>
		  </TR>
			
		  <tr> 
			<TD>Video Url:</TD>
			<TD colspan="2">
			<INPUT maxLength=310 size=100 name="kkr12" value="<%=more_12%>"  >
				
			</TD>
			 </TR>				
		  
		</TABLE>
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>
		
<tr height="1" bgcolor="#dcdcdc">
<td colspan="3">
</td>
</tr>
<tr height="2">
<td  colspan="3">&nbsp;
	
</td>
</tr>


							
<%
	
	
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