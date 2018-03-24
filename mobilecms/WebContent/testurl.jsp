<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String type = "";
	String opid = "";
	String text = "";
	String match = "";
	String datetime="",name="",date="",time="",smstype="",smsopid="",smstext="",smsmatch="",smsdatetime="";
	
	text =request.getParameter("text");		
	datetime =request.getParameter("datetime"); 
	
	System.out.print("------>"+text);
	System.out.print("------>"+datetime);
%>

