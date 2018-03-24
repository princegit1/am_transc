<%@ page language="java" pageEncoding="ISO-8859-1"%><%@ page import="java.io.IOException"%><%@ page import="java.io.DataInputStream"%><%@ page import="java.io.FileInputStream"%>
<%
FileInputStream fin;		

		try
		{	  
		    fin = new FileInputStream ("/home/jboss-4.2.2.GA/server/default/deploy/smscms.war/xml/"+63+".xml");		 
		    out.println( new DataInputStream(fin).readLine().trim() );
		    fin.close();		
		}

		catch (IOException ee)
		{
			System.err.println ("Unable to read from file");			
		}
%>

