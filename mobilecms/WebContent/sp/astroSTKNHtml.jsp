<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	int totalMsg = 0;
	int categoryId = 0;
	AdminConn adminConn = AdminConn.getInstance();
	
		String astroQuery="";
		ResultSet rs=null;
		Connection conn=null;
		Statement stmt=null;

		
		try
		{	
				astroQuery="SELECT message1,message2,message3,message4,message5,message6,message7,message8,message9,message10,message11,message12,date_format(run_date,'%d%m%Y')currentdate FROM message_details where category_id=16 and run_date=curDate()";
				conn = adminConn.getConnection();
				stmt=conn.createStatement();
				rs=stmt.executeQuery(astroQuery);
%>

<%
			

			while(rs.next())
			{
				String date = rs.getString("currentdate");
%>

					
						
						<%=rs.getString("message1")%>
						<br>
						
						<%=rs.getString("message2")%>
						<br>
						
						<%=rs.getString("message3")%>
						<br>
						
						<%=rs.getString("message4")%>
						<br>
						
						<%=rs.getString("message5")%>
						<br>
						
						<%=rs.getString("message6")%>
						<br>
						
						<%=rs.getString("message7")%>
						<br>
						
						<%=rs.getString("message8")%>
						<br>
						
						<%=rs.getString("message9")%>
						<br>
						
						<%=rs.getString("message10")%>
						<br>
						
						<%=rs.getString("message11")%>
						<br>
						
						<%=rs.getString("message12")%>
						

						
						
<%
			}


						
				
%>
					
<%
			
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
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			
			conn.close();
		}
%>
