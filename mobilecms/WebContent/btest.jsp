<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page  import= "java.io.BufferedInputStream"%>
<%@ page  import= "java.io.InputStream"%>
<%@ page  import= "java.io.InputStreamReader"%>
<%@ page  import= "java.io.Reader"%>
<%@ page  import= "java.net.URL"%>
<%@page import="java.io.BufferedReader;"%>

<%
String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "JammuKashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UPEAST", "UPW", "WESTBENGAL"};
String u="http://localhost:8080/content/sp/getMobileNewsHtml?username=buongiorno&password=buongiorno&Circle=";
%>
<html>
<body>

<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">
<%for(int i=0;i<23;i++)
{

String fetchUrl=u+cNameArr[i];
out.println("<strong>"+cNameArr[i]+"</strong>"+"<BR>");
URL url = new URL(fetchUrl);
BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
	  String inputLine;
	  
	while ((inputLine = in.readLine()) != null)
	   out.println(inputLine);
	   out.println("<BR><BR>");

	in.close();

} %>




</table>

</body>
</html>