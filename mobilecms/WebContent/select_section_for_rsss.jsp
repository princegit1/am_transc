<%@ page import="java.sql.*"%>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
AdminConn adminConn = AdminConn.getInstance();
cn = adminConn.getConnection();
%>
<html>
<head>
<title>Send  News Content  - ITGO</title>
<link href="styles/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="topBand.jsp" />
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=0 hspace="5" vspace="5">
<tr valign="middle">
<td align="center">
<FORM  method=post name="newsForm" action="news_for_rss.jsp">
<select name="section">
<option value="" selected="selected">Select Section	</option>

<%	
try{
	String selectQuery="SELECT CATEGORY_ID,CATEGORY_TYPE from category_master where SERVICE_PROVIDER='ITGD' AND STATUS='ACTIVE'";
	stmt=cn.createStatement();	
	rs=stmt.executeQuery(selectQuery);	
	while(rs.next())
	{ %>
<option value="<%=rs.getString("CATEGORY_ID") %>"><%=rs.getString("CATEGORY_TYPE") %></option>
<%} %>
</select>

<%}catch(Exception e){
e.printStackTrace();
}finally{
rs = null;
stmt = null;
cn=null;
} %>
<input type="submit" value= " Insert Message &#187; ">
<%
if(errorMessage!=null){
out.println("<font color=red>"+errorMessage);
}
 %>
</form>
</td></tr></table>
</body></html>