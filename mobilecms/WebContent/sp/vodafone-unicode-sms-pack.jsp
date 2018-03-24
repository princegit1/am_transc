<?xml version="1.0" encoding="utf-8"?><%@ page contentType="text/xml;charset=utf-8" %><%@ page import="java.sql.*,java.util.*,java.util.Date,conn.*"%><%
	int totalMsg = 0;
	int categoryId = 0;	
	String serviceProvider = "ITGD";
	String category = request.getParameter("category");
	AdminConn adminConn = AdminConn.getInstance();
	
		String upQuery="";
		ResultSet rs3=null;
		Connection cn3=null;
		Statement stmt3=null;

		ResultSet rs=null;
		Statement stmt=null;
		try
		{	
							
				upQuery="select distinct date_format(run_date,'%d%m%Y')run_date1, run_date from message_details_unicode a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and (date_format(run_date,'%Y') in ('2013','2014')) order by run_date";
				Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn3 = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
				//cn3 = adminConn.getConnection();
				stmt3=cn3.createStatement();
				rs3=stmt3.executeQuery(upQuery);
out.println("<"+category.toUpperCase()+">");

			String date = "";

			while(rs3.next())
			{
				date = rs3.getString("run_date1");
%><Day_<%=date%>><%
					stmt=cn3.createStatement();

					rs=stmt.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details_unicode a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and run_date='"+ rs3.getString("run_date")+"' order by run_date");
					
						while(rs.next())
						{
//out.println(new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8"));
//out.println(rs.getString("message1"));
out.println(new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8"));
//out.println(new String(new String(rs.getString("message1")).getBytes("ISO-8859-1")));
//out.println(new String(new String(rs.getString("message1")).getBytes("UTF-8")));
						}
					
%></Day_<%=date%>><%
			}
		}
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
		}
		out.println("</"+category.toUpperCase()+">");
%>
