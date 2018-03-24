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
	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
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
		rs.close();
		stmt.close();
		cn.close();
	}

	if (totalMsg ==0)
	{
%>
		No Message
<%	
		return;
	}
String upQuery="";
	for(int k=1;k<=totalMsg;k++)
	{
		ResultSet rs3=null;
		Connection cn3=null;
		Statement stmt3=null;
		try
		{	//int q = k+1;
			if((categoryId==20) || (categoryId==21) || (categoryId==22))
			{
				upQuery="select header,footer,total_message,COALESCE(message1,'')message1	,COALESCE(message2,'No Message')message2,COALESCE(message3,'No Message')message3,COALESCE(message4,'No Message')message4,COALESCE(message5,'No Message')message5 from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='AIRTEL' and a.MSG_ID=(SELECT max(MSG_ID) from message_details WHERE category_id='"+categoryId+"')";
			}
			
			else
			{
				upQuery="select header,footer,total_message,COALESCE(message1,'')message1	,COALESCE(message2,'No Message')message2,COALESCE(message3,'No Message')message3,COALESCE(message4,'No Message')message4,COALESCE(message5,'No Message')message5 from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and run_date=CURDATE() and a.category_id="+categoryId;
			}
			//out.println(upQuery);
			//AdminConn adminConn = AdminConn.getInstance();
			cn3 = adminConn.getConnection();
			stmt3=cn3.createStatement();
			rs3=stmt3.executeQuery(upQuery);
			if(rs3.next())
			{
				if(rs3.getString("message"+k+"").length()>0)
				{
%>
					<jsp:forward page="readMessage.jsp">
						<jsp:param name="header" value="<%=rs3.getString("header")%>" />
						<jsp:param name="message" value="<%=rs3.getString("message"+k+"")%>" />
						<jsp:param name="footer" value="<%=rs3.getString("footer")%>" />
					</jsp:forward>
					 
<%
				}
				else
				{
%>
					&nbsp;
<%	
				}
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
			rs3.close();
			stmt3.close();
			cn3.close();
		}
	}

%>