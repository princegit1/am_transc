<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	int totalMsg = 0;
	int categoryId = 0;
	String alertDate = request.getParameter("ALTER-DATE");
	AdminConn adminConn = AdminConn.getInstance();
	
		String astroQuery="";
		ResultSet rs=null;
		Connection conn=null;
		Statement stmt=null;

		
		try
		{	
				astroQuery="SELECT message1,message2,message3,message4,message5,message6,message7,message8,message9,message10,message11,message12,date_format(run_date,'%d%m%Y')currentdate FROM message_details where category_id=105 and DATE_FORMAT(run_date, '%d%m%Y')='"+alertDate+"'";
				//out.println(astroQuery);
				conn = adminConn.getConnection();
				stmt=conn.createStatement();
				rs=stmt.executeQuery(astroQuery);
%>

<%
			

			while(rs.next())
			{
				String date = rs.getString("currentdate");
%>
  <b> Astro Date:</b><%=date%>
					
						<br><b><%="ARIES"%></b>
						<%=rs.getString("message1")%>
						<br>
						<b><%="TAURUS"%></b>
						<%=rs.getString("message2")%>
						<br>
						<b><%="GEMINI"%></b>
						<%=rs.getString("message3")%>
						<br>
						<b><%="CANCER"%></b>
						<%=rs.getString("message4")%>
						<br>
						<b><%="LEO"%></b>
						<%=rs.getString("message5")%>
						<br>
						<b><%="VIRGO"%></b>
						<%=rs.getString("message6")%>
						<br>
						<b><%="LIBRA"%></b>
						<%=rs.getString("message7")%>
						<br>
						<b><%="SCORPIO"%></b>
						<%=rs.getString("message8")%>
						<br>
						<b><%="SAGITTARIUS"%></b>
						<%=rs.getString("message9")%>
						<br>
						<b><%="CAPRICORN"%></b>
						<%=rs.getString("message10")%>
						<br>
						<b><%="AQUARIUS"%></b>
						<%=rs.getString("message11")%>
						<br>
						<b><%="PISCES"%></b>
						<%=rs.getString("message12")%>
					
							
<%}
			
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
