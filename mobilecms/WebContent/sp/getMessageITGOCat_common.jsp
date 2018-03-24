<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String serviceProvider = request.getParameter("serviceProvider");
	String category = request.getParameter("category");
	int totalMsg = 0;
	int categoryId = 0;
	//String username = request.getParameter("serviceProvider");
	//String password = request.getParameter("password");
	//String serviceProvider = "MTNLDL";
	//String category = request.getParameter("category");
//out.println("Username ->" + username + " -- Password ->" + password + " -- Provider ->" + serviceProvider);
	if(username.equals("itgo") & password.equals("itgo") & serviceProvider.equals("ITGO"))
	{

		username = "MTNLDL";
		password = "MTNLDL";
		serviceProvider = "MTNLDL";

		AdminConn a