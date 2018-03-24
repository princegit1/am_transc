<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	int totalMsg = 0;
	int categoryId = 0;
	String username = request.getParameter("serviceProvider");
	String password = request.getParameter("password");
	String serviceProvider = "MTNLDL";
	String category = request.getParameter("category");
	AdminConn adminConn = AdminConn.getInstance();
	
	String upQuery="";
	ResultSet rs3=null;
	Connection cn3=null;
		
	ResultSet rs=null;
	Statement stmt=null;
	
	try
		{	
				

					cn3 = adminConn.getConnection();
					stmt=cn3.createStatement();
					
					rs=stmt.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and run_date=CURDATE() order by run_date");
					
					if(!(category.equalsIgnoreCase("Love-Guru") || category.equalsIgnoreCase("healthcareformen") || category.equalsIgnoreCase("LoveStruck") || category.equalsIgnoreCase("Mega-Love")))
					{
					
						while(rs.next())
						{
					
							if(rs.getString("header").length() > 0)
							{
					
%>
								<%=rs.getString("header")%>

								<%=rs.getString("message1")%>
								<%=rs.getString("header")%>
<%
							}
							else
							{
%>
								<%=rs.getString("message1")%>
<%
							}

						}
					}
					else
					{
						while(rs.next())
						{

							out.println(rs.getString("message1"));
						}
					}

			}
	
		catch(NullPointerException nex)
		{
			out.println(nex.toString());
		}
		
		finally
		{
			
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			
		}
%>
<br>
<br>
