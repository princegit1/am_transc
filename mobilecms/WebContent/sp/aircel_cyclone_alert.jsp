<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.util.Date" %><%@ page import="conn.*" %><%
	String category ="114";
	String selectQuery="";
	Connection cn=null;
	ResultSet rs=null;
	Statement stmt=null;
		try{			
		AdminConn adminConn = AdminConn.getInstance();
		selectQuery="select COALESCE(message1,'')message1 from message_details a where a.msg_id=(select max(msg_id) from message_details where category_id='"+category+"')";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(selectQuery);				
			while(rs.next())
			{				
			out.println(rs.getString("message1"));			
			}
							
		}
		catch(Exception nex)
		{
			out.println("");
			System.out.println(nex.toString());
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
%>
