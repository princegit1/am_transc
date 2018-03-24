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
String[] cNameArr = {"BIHAR","DELHI","HARYANA", "HP", "JammuKashmir","MP","PUNJAB","UP","WESTBENGAL","RAJASTHAN"};
String u="http://mobileservice.digitaltoday.in/content/getMobileNewsXml.jsp?Circle=";
for(int i=0;i<10;i++)
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

