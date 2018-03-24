<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<html>
<head>
<title>Send National News Content - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
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
<form action="save_onmobile_hinglish_roman_news.jsp" method="post" name="myNews" onSubmit="return checks();">
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
String headline1 = "";
String kicker1 = "";
String headline2 =  "";
String kicker2 = "";
String headline3 =  "";
String kicker3 = "";
String headline4 =  "";
String kicker4 ="";
String headline5 =  "";
String kicker5 = "";

String date = "";
String author = "";

try
{	

	upQuery="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5, nn.run_date from national_news nn,employee e where date(nn.run_date)=curDate() and nn.category_id=378 and nn.emp_id=e.EMP_ID";
	upQuery1="select e.FNAME as name,nn.msg_id,nn.update_date as date,nn.headline_1,nn.more_1,nn.headline_2,nn.more_2,nn.headline_3,nn.more_3,nn.headline_4,nn.more_4,nn.headline_5,nn.more_5, nn.run_date from national_news nn,employee e  where nn.msg_id=(select max(msg_id) from national_news where category_id='378') and nn.category_id=378 and nn.emp_id=e.EMP_ID";
	stmt=cn.createStatement();
	stmt1=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	rs1=stmt1.executeQuery(upQuery1);
	//out.println(upQuery1);
	if(rs.next())
	{
	headline1=rs.getString("headline_1");
	headline2=rs.getString("headline_2");
	headline3=rs.getString("headline_3");
	headline4=rs.getString("headline_4");
	headline5=rs.getString("headline_5");
	date=rs.getString("date");
	author=rs.getString("name");
	}
	else if(rs1.next()){
		
	headline1=rs1.getString("headline_1");
	headline2=rs1.getString("headline_2");
	headline3=rs1.getString("headline_3");
	headline4=rs1.getString("headline_4");
	headline5=rs1.getString("headline_5");
	date=rs1.getString("date");
	author=rs1.getString("name");
		}
%>
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="3" align="center">
			  <P class="topic">Send National News<BR>
			  <a href="sp/onmobile_hinglish_roman_news.jsp" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="3" align="right">By:<%=author%> <b><%=date%></b>&nbsp;&nbsp;</td>
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
			 <INPUT maxLength=310 size=78 name="hdln1" value="<%=headline1%>" id="eBann-1-1" onKeyUp="Contar('eBann-1-1','sBann-1-1',' {CHAR} characters left.',100);"><span id="sBann-1-1" class="minitext">&nbsp;100 characters left.</span> <span><script></script></span>
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
	Headline1: <%=headline1%><br><br>	
	Total Character Headline1: <%=headline1.length()%><br><br>	
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
			 <INPUT maxLength=100 size=78 name="hdln2" value="<%=headline2%>" id="eBann-2-1" onKeyUp="Contar('eBann-2-1','sBann-2-1',' {CHAR} characters left.',100);"><span id="sBann-2-1" class="minitext">&nbsp;100 characters left.</span>
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
	Headline2: <%=headline2%><br><br>
	Total Character Headline1: <%=headline2.length()%><br><br>
	
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
			 <INPUT maxLength=100 size=78 name="hdln3" value="<%=headline3%>" id="eBann-1-3"  onKeyUp="Contar('eBann-1-3','sBann-1-3',' {CHAR} characters left.',100);"><span id="sBann-1-3" class="minitext">&nbsp;100 characters left.</span> 
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
	Headline3: <%=headline3%><br><br>	
	Total Character Headline3: <%=headline3.length()%><br><br>
	
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
			 <INPUT maxLength=100 size=78 name="hdln4" value="<%=headline4%>" id="eBann-1-4"  onKeyUp="Contar('eBann-1-4','sBann-1-4',' {CHAR} characters left.',100);"><span id="sBann-1-4" class="minitext">&nbsp;100 characters left.</span> 
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
	Headline4: <%=headline4%><br><br>	
	Total Character headline4.length()%><br><br>	
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
			 <INPUT maxLength=100 size=78 name="hdln5" value="<%=headline5%>" id="eBann-1-5"  onKeyUp="Contar('eBann-1-5','sBann-1-5',' {CHAR} characters left.',100);"><span id="sBann-1-5" class="minitext">&nbsp;100 characters left.</span> 
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
	Headline5: <%=headline5%><br><br>	
	Total Character Headline5: <%=headline5.length()%><br><br>	
</td>


</tr>
<%
	


	
	
	}
			catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	rs = null;
	stmt = null;
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
</form>
</tbody></table></body></html>