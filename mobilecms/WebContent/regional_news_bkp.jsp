<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>

<%
String errorMessage = request.getParameter("msg");
%>
<%

String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "Jammu Kashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UP East", "UPW", "WESTBENGAL"};
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
	for(int i=0;i<23;i++)
	{
%>
		if(document.myNews.N1<%=cCodeArr[i]%>.value.length > 310)
		{
			alert("Check : Total of 5 News Exceeds Max. Lenght of 310 in Circle : <%=cNameArr[i]%>");
			return false;
		}		

		if(!validNews(document.myNews.N1<%=cCodeArr[i]%>.value))
		{
			alert("Check : $ and # are not allowed as part of News in Circle : <%=cNameArr[i]%>");
			return false;
		}		
<%
	}
%>
		return true;
}

function validNews(val)
{
	if(val.indexOf("#") != -1 || val.indexOf("$") != -1)
	{  
	   return false;
	}
	else
	{ 
		return true; 
	}
}
-->
</script> 
<link href="/content/styles/main.css" rel="stylesheet" type="text/css">
<body>
<script language="JavaScript">
<!--
/**/

function getCursorPosition(field)
{
  field.focus();
  var sel = document.selection.createRange();
  var storedRange = sel.duplicate();
  storedRange.moveToElementText(field);
  storedRange.setEndPoint('EndToEnd', sel);
  //alert("b"+storedRange);
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
  if (window.event) return window.event.keyCode
  else return (evt.keyCode || evt.which || evt.charCode);
}

/**/
//-->
</script>
<jsp:include page="topBand.jsp" />
<table width="100%" border="2" cellspacing="0" cellpadding="0">
  <tr>
	<td class="rwbckgr" align="center">
	<center>
<font color="red"><b>
<%
	if(errorMessage != null)
	{
		out.println(java.net.URLDecoder.decode(request.getParameter("msg")));
	}
%>
</b></font>
</center>

	<form action="newsContent.jsp" name="myNews" onSubmit="return checkEmpty()" method="post">
	  <P class="topic"><br>Send Regional News<BR>
	  <a href="/content/sp/news.html" target="_blank">Check Existing</a></P>
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
		String upQuery1 = "select news_id, news, date_format(a.record_date,'%d-%M-%Y %r ')record_date,fname,lname  from mobile_news a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news)";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{
				str = rs.getString("news");
				name = (rs.getString("fname") +" "+ rs.getString("lname"));
				date = rs.getString("record_date");
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
	//String abc=str.replace("$","<br>");
 //out.println("<font color=red>"+abc);

%>

<%
		for(int i=0;i<23;i++)
		{
%>
<TABLE align=center border=1 cellPadding=0 cellSpacing=0 width="100%">
<tr valign="top">
	<td width="50%">
	  <TABLE align=center border=0 cellPadding=0 cellSpacing=0 width="70%">
	    <TR class="formtdbg"> 
	      <TD>
			<TABLE border=0 cellPadding=3 cellSpacing=1 width="100%">
			  <TR class="rwbckgr"> 
				<TD colspan="3" >Service Name :</TD>
				<TD width="57%"> 
				  <select name="serviceName" >
		             <option value="NEWS" selected>NEWS - Daily Regional News </option>
				  </select>
				</TD>
			  </TR>
			  <TR class="rwbckgr"> 
				<TD colspan="3" >News <span class="mandatory">* 
				  </span>:</TD>
				<TD width="57%"> 
	             <textarea name="N1<%=cCodeArr[i]%>" cols="60" rows="5" value=""></textarea>
				</TD>
			  </TR>
			  <TR class="rwbckgr"> 
				<TD colspan="2" >Circle :</TD>                        
				<TD width="57%"><b><%=cNameArr[i]%></b> 
				<td>
					<input type="button" value="   Spell Check   " name="check" onclick="spellCheckStart(this.form.N1<%=cCodeArr[i]%>)">	
				</td>
				</TD>
				<input type="hidden" name="hidden<%=cCodeArr[i]%>" value="<%=cCodeArr[i]%>">
			  </TR>
			  <TR class="rwbckgr"> 
				<TD colspan="2" ></TD>                    
				<TD width="57%"></TD>
			  </TR>
			</TABLE>

	      </TD>
	    </TR>
	  </TABLE>
	  <table width="70%" border="0" cellspacing="0" cellpadding="0">
		<tr>
		  <td>&nbsp;</td>
		</tr>
	  </table>
	  </td>
	<td>
<%
		//String abc=str.replace("$","<br>");
		 int a1 = str.indexOf(cCodeArr[i]);
		 String aa =  str.substring(a1,str.length());
		 int a2 = aa.indexOf("$");
		 //out.println(a2);
		 String ab =  aa.substring(0,a2);
%>	
	<%=ab%><br><br>
	Total Character: <%=a2%>
	</td>
	<td><%=name%></td>
	<td><%=date%></td>
</tr>
</table>
<%
		}
%>

		  <p> 
			<input type="submit" value="Send Content" name="newscontent">
		  </p>
	  </form>
	<p>&nbsp;</p>
      </div></td>
  </tr>
</table>
</div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td class="bottband">
    <div align="center"> All Rights Reserved &copy; ITGO</div>
    </td>
  </tr>
</table>
</td>
  </tr>
</table>
</body>
</html>