<%
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	String oldPassword = request.getParameter("oldpassword");	
	String newPassword = request.getParameter("newpassword");	

	String emp_Id = (String)session.getAttribute("empId");
	
	Connection cn=null;

	try
    {
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		String sql="UPDATE employee set PWD =? where emp_id=?";

		PreparedStatement pstmt = cn.prepareStatement(sql);
		pstmt.setString(1,newPassword);
		pstmt.setInt(2,Integer.parseInt(emp_Id));
		//pstmt.setString(3,oldPassword);

		pstmt.executeUpdate();
		//cn.commit();

        int oldPassValid = 1;
        if(oldPassValid == 1)
		{
			//cn.commit();
%>
			<Script language="JavaScript">
				alert("Your password has successfuly been changed. Please login again.");
				parent.location.href="index.jsp"
			</SCRIPT>
<%
		}           
        else
		{
%>
			<Script language="JavaScript">
				alert("Can't update password. You have entered an incorrect Old Password.");
				history.back();
			</SCRIPT>
<%
		}          
    }
    catch(Exception exec)
    {
		cn.rollback();
    }
	finally
	{
		try
		{
			cn.close();
		}catch(Exception exec){}
	}
%>