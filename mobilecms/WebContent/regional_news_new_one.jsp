<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %> 
<%
String errorMessage = request.getParameter("msg");
//String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP"};
//String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA","Himanchal"};
String[] cCodeArr = { "BHR","DEL","HRY","HP","JK","MP","PUN","UPW","WB","RAJ"};
String[] cNameArr = {"BIHAR","DELHI","HARYANA", "HP", "JammuKashmir","MP","PUNJAB","UP","WESTBENGAL","RAJASTHAN"};
%>
<html>
<head>
<title>Send Regional News Content - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<script language="JavaScript">
<!--
function checkEmpty()
{
<%
	for(int i=0;i<10;i++)
	{
%>
		if(document.myNews.N1<%=cCodeArr[i]%>.value.length > 300)
		{
			alert("Check : Total of 5 News Exceeds Max. Lenght of 310 in Circle : <%=cNameArr[i]%>");
			return false;
		}


<%
	}
%>
		return true;
}


function resetTextAreas()
{
	<%
	for(int i=0;i<10;i++)
	{
	%>
		document.myNews.N1<%=cCodeArr[i]%>.value = "";
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

//-->
</script>

<link href="styles/main.css" rel="stylesheet" type="text/css">
<body>
<jsp:include page="topBand.jsp" />
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String str = "";
	String name = "";
	String date = "";

	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();
		String upQuery1 = "select news_id, news, date_format(a.record_date,'%d-%M-%Y %r ')record_date,fname,lname  from mobile_news_new_one a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_new_one)";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{
				str = rs.getString("news");				
				name = (rs.getString("fname") +" "+ rs.getString("lname"));				
				date = rs.getString("record_date");
				
		}
		else{
		str="";
		name="";
		date="";
		
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
<form action="newsContent_new_one.jsp" name="myNews" onSubmit="return checkEmpty()" method="post">
	<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">
		<tr valign="top">
			<td width="2%"></td>
			<td width="48%"></td>
			<td width="2%"></td>
			<td width="22%"></td>
			<td width="15%"></td>
			<td width="2%"></td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			  <P class="topic">Send Regional News<BR>
			  <a href="regional_news_ivr.jsp" target="_blank">Check Existing</a>
			  <!--<a href="getMobileNewsXml.jsp" target="_blank">Check XML</a>--></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="6" align="right">By: <b><%=name%></b>&nbsp;<%=date%>

			<%
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
			java.util.Date date1 = new java.util.Date();
			//out.println("Current Date Time : " + dateFormat.format(date1));
			%>;

			<input type="hidden" value="<%=date1%>" name="dates">&nbsp;</td>
		</tr>
		<tr height="5">
			<td>
			</td>
		</tr>
		<tr valign="top">
			<td>
				&nbsp;
			</td>
			<td colspan="5" align="left">
			<font color="red"><b>
			<%
				if(errorMessage != null)
				{
					out.println(java.net.URLDecoder.decode(request.getParameter("msg")));
				}
			%>
			</b></font>
			</td>
		</tr>
		<tr height="5">
			<td>
			</td>
		</tr>
		<tr valign="top">
			<td>&nbsp;</td>
			<td align="center">
					<input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">
			</td>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr height="8">
			<td>
			</td>
		</tr>
		<%
		int a1=0;
		String aa="";
		int a2=0;
		String ab="";
		String tempStr="";
		for(int i=0;i<10;i++)
		{
		%>
		<tr valign="top">
			<td>&nbsp;</td>
			<td>
					<TABLE border="1" cellPadding=3 cellSpacing=1 width="100%">
					  <tr>
						<TD>Service Name :</TD>
						<TD colspan="2">
						  <select name="serviceName">
				             <option value="NEWS" selected>NEWS - Daily Regional News </option>
						  </select>
						</TD>
					  </TR>
						<%
							
							
							if(str!=""&& str.contains(cCodeArr[i])){
							a1 = str.indexOf(cCodeArr[i]+":");
							aa =  str.substring(a1,str.length());
							a2 = aa.indexOf("<br>");
							ab =  aa.substring(0,a2);
							tempStr = cCodeArr[i]+":";
							}else{
							a1=0;
							aa="please add content here";
							a2=0;
							ab="ppplease add content here";							
							tempStr = cCodeArr[i]+":";
							}
							
							
							
							
							
							
							
						%>
					  <tr>
						<TD>News <span class="mandatory">*</span>:</TD>
						<TD colspan="2">
							<textarea name="N1<%=cCodeArr[i]%>" cols="60" rows="5"  id="xBann-<%=i%>-1" onKeyUp="Contar('xBann-<%=i%>-1','yBann-<%=i%>-1',' {CHAR} characters left.',300);"><%=ab.substring(ab.indexOf(tempStr)+tempStr.length(), ab.length())%></textarea><br><span id="yBann-<%=i%>-1" class="minitext">&nbsp;300 characters left.</span>
						</TD>
					  </TR>
					  <tr>
						<TD>Circle :</TD>
						<TD><b><%=cNameArr[i]%></b></TD>
						<td align="right">
							<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.N1<%=cCodeArr[i]%>)">&nbsp;
						</td>
						<input type="hidden" name="hidden<%=cCodeArr[i]%>" value="<%=cCodeArr[i]%>">
					  </TR>
					</TABLE>
			</td>
			<td>&nbsp;<!-- <%=ab%><br><br> --></td>
			<td colspan="2">
				<%=ab%><br><br>
				Total Character: <%=a2%>
			</td>
			<!--
			<td><%=name%></td>
			<td><%=date%></td>
			-->
			<td>&nbsp;</td>
		</tr>
		<tr height="2">
			<td>
				&nbsp;
			</td>
		</tr>
		<tr height="1" bgcolor="#dcdcdc">
			<td colspan="6">
			</td>
		</tr>
		<tr height="2">
			<td>
				&nbsp;
			</td>
		</tr>
		<%
		}
		%>
		<tr valign="top">
			<td>&nbsp;</td>
			<td align="center">
					<input type="submit" value="Send Content" name="newscontent">
			</td>
			<td colspan="4">&nbsp;</td>
		</tr>
	</table>
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="bottband">
    <div align="center"> All Rights Reserved &copy; ITGO</div>
    </td>
  </tr>
</table>
</body>
</html>