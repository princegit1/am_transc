<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.util.Date" %><%@ page import ="java.text.SimpleDateFormat"%><%@ page import="conn.*" %><%
	String alertDate="";
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String serviceProvider = request.getParameter("serviceProvider");
	String category = request.getParameter("category");
	  Date dateNow = new Date ();      
      SimpleDateFormat dateformatDDMMYYYY = new SimpleDateFormat("MMddyyyy");
      StringBuilder nowDate = new StringBuilder( dateformatDDMMYYYY.format( dateNow ) );

	alertDate = request.getParameter("ALERT-DATE");
 if(alertDate==null)
	alertDate=nowDate.toString();

	int totalMsg = 0;
	int categoryId = 0;
	int counter=0;
	
	if(username.equals("itgo") & password.equals("itgo") & serviceProvider.equals("ITGO"))
	{

		username = "MTNLDL";
		password = "MTNLDL";
		serviceProvider = "MTNLDL";

		AdminConn adminConn = AdminConn.getInstance();
	
		String upQuery="";
		ResultSet rs3=null;
		Connection cn3=null;
		Statement stmt3=null;

		ResultSet rs=null;
		Statement stmt=null;
		try
		{	
				upQuery="select max(MSG_ID) as id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='MTNLDL' and status='ACTIVE' and category_type='Beauty'";
				//out.println(upQuery);
				
				cn3 = adminConn.getConnection();
				stmt3=cn3.createStatement();
				rs3=stmt3.executeQuery(upQuery);
				
				String date = "";

			while(rs3.next())
			{
				counter++;
				date = rs3.getString("id");
				stmt=cn3.createStatement();
					rs=stmt.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and MSG_ID='"+date+"'");
					if(!(category.equalsIgnoreCase("Love-Guru") || category.equalsIgnoreCase("healthcareformen") || category.equalsIgnoreCase("LoveStruck") || category.equalsIgnoreCase("Mega-Love")))
					{
						while(rs.next())
						{
							if(rs.getString("header").length() > 0)
							{
%><<%=rs.getString("header")%>><%=rs.getString("message1")%></<%=rs.getString("header")%>><%
							}
							else
							{
%><%=rs.getString("message1")%><%
							}

						}
					}
					else
					{
						while(rs.next())
						{
%><%=rs.getString("message1")%>
<%
						}
					}
%><%
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

if(counter<1)
{
	out.println("<center><h1>No Record Found!</h1></center>");
}
	

%>
