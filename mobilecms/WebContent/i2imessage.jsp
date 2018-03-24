<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<html>
<head>
<title>Mobile Service - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<script language="JavaScript">
<!--
function resetTextAreas()
{
	<%
	for(int i=0;i<6;i++)
	{
	%>
		document.myNews.N1<%=i%>.value = "";
	<%
	}
	%>
}
	
-->
</script>
<script >
function Page(id)
	{
		//alert(id);
		window.location.href="i2imessage.jsp?catId="+id;
	}
</script>
<SCRIPT LANGUAGE="JavaScript">
function textCounter(field,cntfield,maxlimit) {
if (field.value.length > maxlimit) 
field.value = field.value.substring(0, maxlimit);
else
cntfield.value = maxlimit - field.value.length;
}
</script>

<link href="styles/main.css" rel="stylesheet" type="text/css">
<body>
<jsp:include page="topBand.jsp" />
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	ArrayList str =  new ArrayList();
	String name = "";
	String date = "";
	String catName = "";
	ArrayList mid = new ArrayList();
	int totalRecord = 0;
	ArrayList order =new ArrayList();
	String catId = request.getParameter("catId");
	if (catId == null)
	{
		catId ="99";	
	}

	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();
		String upQuery1 = "SELECT m.message_id as mid,m.message as news,m.category_id,m.insert_date as record_date,c.CATEGORY_TYPE as catName,em.FNAME as fname, m.ordering as orders FROM message_special m,category_master c,employee em where m.category_id=c.CATEGORY_ID and m.update_emp_id=em.EMP_ID  and m.category_id='"+catId+"' order by m.insert_date desc";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{
				str.add(new String( rs.getString("news")));
				name = (rs.getString("fname"));
				date = rs.getString("record_date");
				catName = rs.getString("catName");
				order.add(new Integer( rs.getInt("orders")));
				totalRecord = 1;
				mid.add(new Integer(rs.getInt("mid")));
		}
		

		
	}
	catch(Exception e)
	{
		e.printStackTrace();
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
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1>
  <TBODY>
  <TR>
    <TD align="center" width=173 height=64 colspan="3">
		Select Category 
		<SELECT name="categoryId" onChange="return Page(this.value);"> 
			<OPTION>-Select Category-</OPTION> 
			<OPTION value=99>National</OPTION> 
			<OPTION value=100>International</OPTION> 
			<OPTION value=101>Sports</OPTION> 
			<OPTION value=102>Business</OPTION>
		</SELECT> 
	</TD>
   </TR>
</TABLE>
<%
		if(totalRecord != 0)
		{
%>
<form action="special_new.jsp" name="myNews" onSubmit="return checkEmpty()" method="post">
<input type="hidden" value="<%=catId%>" name="categoryId" />
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
			  <P class="topic"><BR>
			  <a href="sp/i2iheadlines?catId=<%=catId%>" target="_blank">Check Existing</a></P>
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
			<td>&nbsp;
				
			</td>
			<td colspan="5" align="left">
			<font color="red"><b>
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
	for(int i=0;i<6;i++)
		{
			Object message[] = str.toArray();
			Object Ordering[] = order.toArray();
			Object MessageId[] = mid.toArray();
		%>

		<tr valign="top">
			<td>&nbsp;</td>
			<td>
					<table width="53%" border="1" cellpadding="1" cellspacing="1">
					<input type="hidden" name="messageId<%=i%>" value="<%=MessageId[i]%>" />
<tbody><tr>
						<td width="17%">Category Name :</td>

<td colspan="2"><%=catName%></td>
					  </tr>
						
					  <tr>
						<td>Headline <span class="mandatory">*</span>:</td>

						<td colspan="2">
							<textarea name="N1<%=i%>"  cols="60" rows="5" onKeyDown="textCounter(document.myNews.N1<%=i%>,document.myNews.remLen<%=i%>,120)"
onKeyUp="textCounter(document.myNews.N1<%=i%>,document.myNews.remLen<%=i%>,120)"  ><%=message[i]%></textarea><br><span i>&nbsp;<input readonly type="text" name="remLen<%=i%>" size="3" maxlength="3" value="120">
characters left
</span>
						</td>
					  </tr>
					  <tr>
						<td>Order</td>
						<td width="14%"><input type="text" value="<%=Ordering[i]%>" name="ord<%=i%>" /></td>

					  <td width="69%" align="right">&nbsp;						</td>
						
					  </tr>
	</tbody></table>
			</td>
			<td></td>
			<td colspan="2">
			<br><br>
				<%=message[i]%><br><br>
				
			</td>
			<!--
			<td><%=name%></td>
			<td><%=date%></td>
			-->
			<td>&nbsp;</td>
		</tr>
		<tr height="2">
			<td>&nbsp;
				
			</td>
		</tr>
		<tr height="1" bgcolor="#dcdcdc">
			<td colspan="6">
			</td>
		</tr>
		<tr height="2">
			<td>&nbsp;
				
			</td>
		</tr>
		<%
		}
		%>
		<tr valign="top">
			<td><%=totalRecord%></td>
			<td align="center">
					<input type="submit" value="Send Content" name="newscontent">
			</td>
			<td colspan="4">&nbsp;</td>
		</tr>
	</table>
</form>

<%

		}
else
{
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<form action="special_new.jsp" name="myNews" onSubmit="return checkEmpty()" method="post">
<input type="hidden" value="<%=catId%>" name="categoryId" />
<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			  <P class="topic"><BR>
			  <a href="sp/i2iheadlines?catId=<%=catId%>" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<%

		for(int i=0;i<6;i++)
		{
				%>
		<tr valign="top">
			<td>&nbsp;</td>
			<td>
					<table width="53%" border="1" cellpadding="1" cellspacing="1">
<tbody><tr>
						<td width="17%">Category Name :</td>

<td colspan="2"><%=catName%></td>
					  </tr>
						
					  <tr>
						<td>Headline <span class="mandatory">*</span>:</td>

						<td colspan="2">
							<textarea name="N1<%=i%>" cols="60" rows="5" onKeyDown="textCounter(document.myNews.N1<%=i%>,document.myNews.remLen<%=i%>,120)"
onKeyUp="textCounter(document.myNews.N1<%=i%>,document.myNews.remLen<%=i%>,120)"  ></textarea><br><span i>&nbsp;<input readonly type="text" name="remLen<%=i%>" size="3" maxlength="3" value="120">
characters left
</span>
						</td>
					  </tr>
					  <tr>
						<td>Order</td>
						<td width="14%"><input type="text"  name="ord<%=i%>" /></td>

					  <td width="69%" align="right">&nbsp;						</td>
						
					  </tr>
	</tbody></table>
			</td>
			<td></td>
			<td colspan="2">
				<br><br>
				Total Character: 
			</td>
			<!--
			<td><%=name%></td>
			<td><%=date%></td>
			-->
			<td>&nbsp;</td>
		</tr>
		<tr height="2">
			<td>&nbsp;
				
			</td>
		</tr>
		<tr height="1" bgcolor="#dcdcdc">
			<td colspan="6">
			</td>
		</tr>
		<tr height="2">
			<td>&nbsp;
				
			</td>
		</tr>
		<%
		}
			%>

			<tr valign="top">
			<td><%=totalRecord%></td>
			<td align="center">
					<input type="submit" value="Send Content" name="newscontent">
			</td>
			<td colspan="4">&nbsp;</td>
		</tr>
	</table>
</form>
			<%
}
		%>
			
		
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="bottband">
    <div align="center"> All Rights Reserved &copy; ITGO</div>
    </td>
  </tr>
</table>
</body>
</html>