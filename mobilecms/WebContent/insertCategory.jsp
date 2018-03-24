<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	try
	{
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();

		String sql="INSERT INTO category_master (CATEGORY_TYPE,TOTAL_MESSAGE,SERVICE_PROVIDER,ALERT_TIME,HEADER,FOOTER,UPDATE_EMP_ID,MESSAGE_SIZE) VALUES (?,?,?,?,?,?,?,?)";
		//out.println(sql);
		pstmt = cn.prepareStatement(sql);
		pstmt.setString(1,request.getParameter("category_type"));
		pstmt.setInt(2,Integer.parseInt(request.getParameter("total_message")));
		pstmt.setString(3,request.getParameter("service_provider"));
		pstmt.setInt(4,Integer.parseInt(request.getParameter("alert_time")));

		pstmt.setString(5,request.getParameter("header"));
		pstmt.setString(6,request.getParameter("footer"));
		pstmt.setInt(7,Integer.parseInt(request.getParameter("empId")));
		pstmt.setInt(8,Integer.parseInt(request.getParameter("message_size")));
		pstmt.executeUpdate();
		//cn.commit();
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		pstmt.close();
		cn.close();
	}
	response.sendRedirect("showInsertCategory.jsp");
%>