<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%
	Connection cn = null;
	Statement stmt =null;
	ResultSet rs=null;

	String email = request.getParameter("email");
	String description = "ok";
	
	try
	{
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		PreparedStatement loginChk = cn.prepareStatement("SELECT email FROM employee WHERE uname= ?");
		loginChk.setString(1, email);
		rs = loginChk.executeQuery();
		if(rs.next())
		{
			description ="WRONG";
		}    
		else
		{
			description = "OK";
		}
	}
	catch(Exception ex)
	{
		description = "There is some problem with server please try after some time. "+ex.toString();
	}

	if (description != null) {
	   response.setContentType("text/xml");
	   response.setHeader("Cache-Control", "no-cache");
	   response.getWriter().write("" + description.toString() + "");
	} else {
	   //nothing to show
	   response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	}
%>


