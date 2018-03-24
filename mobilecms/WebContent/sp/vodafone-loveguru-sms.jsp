<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %><%@ page import="java.sql.*,conn.*"%><%
int totalMsg = 0;
int categoryId = 0;	
String serviceProvider = "HUTCH";
String category ="";
category="Voda-Loveguru-SMS";	
AdminConn adminConn = AdminConn.getInstance();	
String upQuery="";
ResultSet rs3=null;
Connection cn3=null;
Statement stmt3=null;
ResultSet rs=null;
Statement stmt=null;
try
{
upQuery="select distinct date_format(run_date,'%d%m%Y')run_date1, run_date,date_format(run_date,'%m') as run_date2 from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"'  order by run_date";
cn3 = adminConn.getConnection();
stmt3=cn3.createStatement();
rs3=stmt3.executeQuery(upQuery);out.println("<vap version=\"1.0\">");
String date = "";
while(rs3.next())
{
date = rs3.getString("run_date1");
if(!rs3.getString("run_date2").equals("06")){
out.println("<contentItem lang=\"en-in\" useOn='"+date+"' expires='"+date+"'>");
stmt=cn3.createStatement();
rs=stmt.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and run_date='"+ rs3.getString("run_date")+"' order by run_date");
while(rs.next())
{out.println(rs.getString("message1"));}
out.println("</contentItem>");}}}
catch(NullPointerException nex)
{
out.println(nex.toString());
}
catch(Exception e)
{
out.println(e.toString());
}
finally
{
if(rs3!=null)
rs3.close();
if(stmt3!=null)
stmt3.close();
if(rs!=null)
rs.close();
if(stmt!=null)
stmt.close();
cn3.close();
}out.println("</vap>");
%> 