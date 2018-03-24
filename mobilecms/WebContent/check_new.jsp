<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%
	Connection cn = null;
	Statement stmt =null;
	ResultSet rs=null;

	String uname = request.getParameter("username");
	String pwd = request.getParameter("password");
	try
	{
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		PreparedStatement loginChk = cn.prepareStatement("SELECT EMP_ID, FNAME,EMP_ROLE FROM employee WHERE UNAME= ? AND PWD = ?");
		loginChk.setString(1, uname);
		loginChk.setString(2, pwd);
		rs = loginChk.executeQuery();
		if(rs.next())
		{
			session.setAttribute( "log", "i123");
			response.sendRedirect("national_update.jsp");
		}
		else
		{
			response.sendRedirect("login.jsp?msg=Invalid username or password, Try again");
		}
	}
	catch(Exception ex)
	{
		out.println("There is some problem with server please try after some time. "+ex.toString());
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



