<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	int totalMsg = 0;
	int categoryId = 0;
	String username = request.getParameter("serviceProvider");
	String password = request.getParameter("password");
	String serviceProvider = request.getParameter("serviceProvider");
	String category = request.getParameter("category");
	//String messageType = request.getParameter("messageType");
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();	
	try
	{
		String upQuery1 = "select * from category_master a,service_provider b where b.sp_name = a.service_provider and service_provider='"+serviceProvider+"' and category_type='"+category+"' and sp_username='"+username+"' and sp_password='"+password+"'";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		while(rs.next())
		{
			categoryId = rs.getInt("category_id");
			totalMsg = rs.getInt("total_message");
		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		rs = null;
		stmt = null;
	}

	if (totalMsg ==0)
	{
%>
		No Message
<%	
		return;
	}

	for(int k=1;k<=totalMsg;k++)
	{
		//ResultSet rs3=null;
		////Connection cn3=null;
		//Statement stmt3=null;
		try
		{	//int q = k+1;
		/*if(messageType.equals("Aries"))
			k=1;
		if(messageType.equals("Taurus"))
			k=2;
		if(messageType.equals("Gemini"))
			k=3;
		if(messageType.equals("Cancer"))
			k=4;
		if(messageType.equals("Leo"))
			k=5;
		if(messageType.equals("Virgo"))
			k=6;
		if(messageType.equals("Libra"))
			k=7;
		if(messageType.equals("Scorpio"))
			k=8;
		if(messageType.equals("Sagittarius"))
			k=9;
		if(messageType.equals("Capricorn"))
			k=10;
		if(messageType.equals("Aquarius"))
			k=11;
		if(messageType.equals("Pisces"))
			k=12;
		*/
			//String upQuery="select header,footer,total_message,COALESCE(message"+k+",'')message1 from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and run_date=CURDATE() and a.category_id="+categoryId;
			//out.println(upQuery);
			//AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();
			stmt=cn.createStatement();
			rs=stmt.executeQuery("select * from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and run_date=CURDATE() and a.category_id="+categoryId);
			if(rs.next())
			{
				String msg = "<!---horoscope starts--->HOROSCOPE <br><br>  <!- Aries -> "+rs.getString("message1")+"<br><br><!-Aries-end-><!- Taurus -> "+rs.getString("message2")+"<br><br><!-Taurus-end-><!- Gemini -> "+rs.getString("message3")+"<br><br><!-Gemini-end-><!- Cancer -> "+rs.getString("message4")+"<br><br><!-Cancer-end-><!- Leo -> "+rs.getString("message5")+"<br><br><!-Leo-end-><!- Virgo -> "+rs.getString("message6")+"<br><br><!-Virgo-end-><!- Libra -> "+rs.getString("message7")+"<br><br><!-Libra-end-><!- Scorpio -> "+rs.getString("message8")+"<br><br><!-Scorpio-end-><!- Sagittarius -> "+rs.getString("message9")+" <br><br><!-Sagittarius-end-><!- Capricorn -> "+rs.getString("message10")+"<br><br><!-Capricorn-end-><!- Aquarius -> "+rs.getString("message11")+"<br><br><!-Aquarius-end-><!- Pisces -> "+rs.getString("message12")+"<br><br><!-Pisces-end-><!---horoscope ends--->";
				//if(rs.getString("message1").length()>0)
				//{
%>
					<jsp:forward page="readMessage.jsp">
						<jsp:param name="header" value="<%=rs.getString("header")%>" />
						<jsp:param name="message" value="<%=msg%>" />
						<jsp:param name="footer" value="<%=rs.getString("footer")%>" />
					</jsp:forward>
<%
				//}
			}
			else
			{
%>
				No Message
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
			if(rs!=null)
			rs.close();
			if(stmt!=null)
			stmt.close();
			if(cn!=null)
			cn.close();
		}
	}

%>