<%
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
%>
<HTML><HEAD><TITLE>Mobile Service</TITLE>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />
<FORM  method=post name="newsForm" action="show_cbc_category.jsp">
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=0 hspace="5" vspace="5">
		<tr valign="middle">
			<td align="center">
Select State : &nbsp;&nbsp;&nbsp;
<select name="categorystate">
		
			<OPTION>-Select State-</OPTION> 
			<OPTION value=AP>ANDHRA PRADESH</OPTION> 
			<OPTION value=TN>TAMILNADU</OPTION> 
			<OPTION value=MP>MADHYA PRADESH</OPTION> 
			<OPTION value=DELHI>DELHI</OPTION> 
			<OPTION value=RAJASTHAN>RAJASTHAN</OPTION> 
			<OPTION value=GUJARAT>GUJARAT</OPTION> 
			<OPTION value=ASSAM>ASSAM</OPTION> 
			<OPTION value=NE>NORTH EAST </OPTION> 
			<OPTION value=BIHAR>BIHAR</OPTION> 
			<OPTION value=KOLKATA>KOLKATA</OPTION> 
			<OPTION value=ROWB>ROWB</OPTION> 
			<OPTION value=MUMBAI>MUMBAI</OPTION>
			<OPTION value=MAHARASHTRA>MAHARASHTRA</OPTION>
		
</select>&nbsp;&nbsp;&nbsp;
<input type="submit" value= "Submit">
</td>
			</tr>
			</table>
</FORM>
</BODY>
</HTML>
