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
<FORM  method=post name="newsForm" action="news_for_videos_AP.jsp">
<TABLE cellSpacing=0 cellPadding=0 width=450 align=center border=0 hspace="5" vspace="5">
<tr valign="middle">
<td align="center"> <b>Circle :</b> </td><td align="center"> <b>Region :</b> </td>
</tr>
<tr valign="middle">
<td align="center">
<select name="region">
<option value="DELHI">DELHI</option>
<option value="UPW">UPW</option>
<option value="CHENNAI">CHENNAI</option>
<option value="AP">AP</option>
<option value="KERALA">KERALA</option>
<option value="KARNATAKA">KARNATAKA</option>
<option value="GUJARAT">GUJARAT</option>
<option value="ROB">ROB</option>
<option value="MUMBAI">MUMBAI</option>
<option value="TN">TN</option>
<option value="UPE">UPE</option>
<option value="HARYANA">HARYANA</option>
<option value="MAHARASHTRA">MAHARASHTRA</option>
<option value="RAJASTHAN">RAJASTHAN</option>
<option value="PUNJAB">PUNJAB</option>
<option value="UNKNOWN">UNKNOWN</option>
<option value="ORISSA">ORISSA</option>
<option value="HP">HP</option>
<option value="NE">NE</option>
<option value="ASSAM">ASSAM</option>
<option value="BIHAR">BIHAR</option>
<option value="MP">MP</option>
<option value="JK">JK</option>
</select>
</td>
<td align="center">
<select name="section">
<option value="" selected="selected">Select Section	</option>

<%	
try{
	String selectQuery="SELECT CATEGORY_ID,CATEGORY_TYPE from category_master where SERVICE_PROVIDER='APVIDEO' AND STATUS='ACTIVE'";
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
</td></tr></table></form>
</body></html>