<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	int totalMsg = 0;
	int categoryId = 0;
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String serviceProvider = request.getParameter("serviceProvider");
	String category = request.getParameter("category");

	
	if(username.equals("buongiorno") & password.equals("buongiorno") & serviceProvider.equals("ITGO"))
	{
		username = "54321";
		password = "54321";
		serviceProvider = "54321";
	AdminConn adminConn = AdminConn.getInstance();
	
		String upQuery="";
		ResultSet rs3=null;
		Connection cn3=null;
		Statement stmt3=null;

		ResultSet rs=null;
		Statement stmt=null;
		try
		{	
				upQuery="select distinct date_format(run_date,'%d%m%Y')run_date1, run_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"'  order by run_date";
				cn3 = adminConn.getConnection();
				stmt3=cn3.createStatement();
				rs3=stmt3.executeQuery(upQuery);
%>
<ax>
<%
			String date = "";

			while(rs3.next())
			{
				date = rs3.getString("run_date1");
%>
					<% out.println("Date:-"+date+ "<br/>");%> 
<%
					stmt=cn3.createStatement();

					rs=stmt.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and run_date='"+ rs3.getString("run_date")+"' order by run_date");
					if(!(category.equalsIgnoreCase("Love-Guru") || category.equalsIgnoreCase("healthcareformen") || category.equalsIgnoreCase("LoveStruck") || category.equalsIgnoreCase("Mega-Love")))
					{
						while(rs.next())
						{
							String msg= rs.getString("message1");
							String NewMessage =msg.substring(msg.indexOf("<"),msg.indexOf("</"));
							String ModifiedMessage=NewMessage.substring(NewMessage.lastIndexOf(">")+1,NewMessage.length());
%>
							<% out.println(ModifiedMessage+ "<br/><br/>");%>
							
<%
					
					
				
						}
					}
					else
					{
						while(rs.next())
						{
%>
							<% out.println(rs.getString("message1")+ "<br/><br/>");%>
<%
						}
					}
%>
				
<%
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
		}
		else
	{
		out.println("Please check the URL parameter. <b>Something Must Be Wrong with Parameters.</b>");
	}
%>
