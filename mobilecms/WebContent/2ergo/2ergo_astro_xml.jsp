<?xml version="1.0" encoding="ISO-8859-1"?>
<%@ page contentType="text/xml;charset=ISO-8859-1" %>

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
<astro date="<%=date%>">
					
						<sunsign name="ARIES">
						<content><%=rs.getString("message1")%></content>
						</sunsign>
						<sunsign name="TAURUS">
						<content><%=rs.getString("message2")%></content>
						</sunsign>
						<sunsign name="GEMINI">
						<content><%=rs.getString("message3")%></content>
						</sunsign>
						<sunsign name="CANCER">
						<content><%=rs.getString("message4")%></content>
						</sunsign>
						<sunsign name="LEO">
						<content><%=rs.getString("message5")%></content>
						</sunsign>
						<sunsign name="VIRGO">
						<content><%=rs.getString("message6")%></content>
						</sunsign>
						<sunsign name="LIBRA">
						<content><%=rs.getString("message7")%></content>
						</sunsign>
						<sunsign name="SCORPIO">
						<content><%=rs.getString("message8")%></content>
						</sunsign>
						<sunsign name="SAGITTARIUS">
						<content><%=rs.getString("message9")%></content>
						</sunsign>
						<sunsign name="CAPRICORN">
						<content><%=rs.getString("message10")%></content>
						</sunsign>
						<sunsign name="AQUARIUS">
						<content><%=rs.getString("message11")%></content>
						</sunsign>
						<sunsign name="PISCES">
						<content><%=rs.getString("message12")%></content>
						</sunsign>

						
							</astro>
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
