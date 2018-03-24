<HTML>
  <HEAD>
    <TITLE>Create your account</TITLE>
    <META NAME="Description" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Author" CONTENT="">
    <LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
  </HEAD>
  
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%@ page import="java.util.*"%>

<%
	Connection cn=null;
	PreparedStatement pstmt = null;
	
	String name = request.getParameter("name");
	String father_name = request.getParameter("father_name");
	String dob = "";
			dob = request.getParameter("year")+"/"+request.getParameter("month")+"/"+request.getParameter("day");
	String address = request.getParameter("address");
	String contact_no = request.getParameter("contact_no");
	
	String hs_name = request.getParameter("hs_name");
	String hs_percent = request.getParameter("hs_percent");
	String hs_year = request.getParameter("hs_year");
	String inter_name = request.getParameter("inter_name");
	String inter_percent = request.getParameter("inter_percent");
	String inter_year = request.getParameter("inter_year");
	String gra_name = request.getParameter("gra_name");
	String gra_percent = request.getParameter("gra_percent");
	String gra_year = request.getParameter("gra_year");
	String pg_name = request.getParameter("pg_name");
	String pg_percent = request.getParameter("pg_percent");
	String pg_year = request.getParameter("pg_year");
	String oth_name = request.getParameter("oth_name");
	String oth_percent = request.getParameter("oth_percent");
	String oth_year = request.getParameter("oth_year");
	
	String mus_course_name_1 = request.getParameter("mus_course_name_1");
	String mus_school_name_1 = request.getParameter("mus_school_name_1");
	String mus_percent_1 = request.getParameter("mus_percent_1");
	String mus_year_1 = request.getParameter("mus_year_1");
	String mus_course_name_2 = request.getParameter("mus_course_name_2");
	String mus_school_name_2 = request.getParameter("mus_school_name_2");
	String mus_percent_2 = request.getParameter("mus_percent_2");
	String mus_year_2 = request.getParameter("mus_year_2");
	String mus_course_name_3 = request.getParameter("mus_course_name_3");
	String mus_school_name_3 = request.getParameter("mus_school_name_3");
	String mus_percent_3 = request.getParameter("mus_percent_3");
	String mus_year_3 = request.getParameter("mus_year_3");
	String mus_course_name_4 = request.getParameter("mus_course_name_4");
	String mus_school_name_4 = request.getParameter("mus_school_name_4");
	String mus_percent_4 = request.getParameter("mus_percent_4");
	String mus_year_4 = request.getParameter("mus_year_4");
	String mus_course_name_5 = request.getParameter("mus_course_name_5");
	String mus_school_name_5 = request.getParameter("mus_school_name_5");
	String mus_percent_5 = request.getParameter("mus_percent_5");
	String mus_year_5 = request.getParameter("mus_year_5");

	String redio_performation = request.getParameter("redio_performation");
	String awards = request.getParameter("awards");
	String reason = request.getParameter("reason");
		
		try
		{
			AdminConnSubscriptions adminConn = AdminConnSubscriptions.getInstance();
			cn = adminConn.getConnection();

			String sql="insert into aajtak.sargam_data (name,father_name,dob,address,contact_no,hs_name,hs_percent,hs_year,inter_name,inter_percent,inter_year,gra_name,gra_percent, gra_year,pg_name,pg_percent, pg_year,oth_name,oth_percent,oth_year,mus_course_name_1,mus_school_name_1,mus_percent_1,mus_year_1,mus_course_name_2, mus_school_name_2, mus_percent_2, mus_year_2,mus_course_name_3,mus_school_name_3,mus_percent_3,mus_year_3,mus_course_name_4,mus_school_name_4, mus_percent_4,mus_year_4, mus_course_name_5,mus_school_name_5,mus_percent_5,mus_year_5,redio_performation, awards,reason) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = cn.prepareStatement(sql);
			pstmt.setString(1,name);
			pstmt.setString(2,father_name);
			pstmt.setString(3,dob);
			pstmt.setString(4,address);
			pstmt.setString(5,contact_no);

			pstmt.setString(6,hs_name);
			pstmt.setString(7,hs_percent);
			pstmt.setString(8,hs_year );

			pstmt.setString(9,inter_name );
			pstmt.setString(10,inter_percent);
			pstmt.setString(11,inter_year);
			
			pstmt.setString(12,gra_name);
			pstmt.setString(13,gra_percent);
			pstmt.setString(14,gra_year);
			
			pstmt.setString(15,pg_name);
			pstmt.setString(16,pg_percent);
			pstmt.setString(17,pg_year);
			
			pstmt.setString(18,oth_name);
			pstmt.setString(19,oth_percent);
			pstmt.setString(20,oth_year);
			
			pstmt.setString(21,mus_course_name_1);
			pstmt.setString(22,mus_school_name_1);
			pstmt.setString(23,mus_percent_1);
			pstmt.setString(24,mus_year_1);
			
			pstmt.setString(25,mus_course_name_2 );
			pstmt.setString(26,mus_school_name_2 );
			pstmt.setString(27,mus_percent_2);
			pstmt.setString(28,mus_year_2);
			
			pstmt.setString(29,mus_course_name_3 );
			pstmt.setString(30,mus_school_name_3 );
			pstmt.setString(31,mus_percent_3 );
			pstmt.setString(32,mus_year_3);
			
			pstmt.setString(33,mus_course_name_4);
			pstmt.setString(34,mus_school_name_4);
			pstmt.setString(35,mus_percent_4);
			pstmt.setString(36,mus_year_4);
			
			pstmt.setString(37,mus_course_name_5);
			pstmt.setString(38,mus_school_name_5);
			pstmt.setString(39,mus_percent_5);
			pstmt.setString(40,mus_year_5);

			pstmt.setString(41,redio_performation);
			pstmt.setString(42,awards);
			pstmt.setString(43,reason);

			pstmt.executeUpdate();
			//cn.commit();
		}
		catch(Exception e)
		{
			out.println(e.toString());
		}
		finally
		{
			if(pstmt!=null)
				pstmt.close();
			if(cn!=null)
				cn.close();
		}

response.sendRedirect("http://www.aajtak.com/sargam/thankyou.php");
%>	


</body>
</html>
