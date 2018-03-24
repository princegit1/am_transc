<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="com.oreilly.servlet.*" %>

<%
	Connection cn=null;	
	PreparedStatement pstmt=null;
	try
					{
	MultipartRequest req = new MultipartRequest(request,"/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String headline1 =  req.getParameter("hdln1");
	String kicker1 = req.getParameter("kkr1");
	String headline2 =  req.getParameter("hdln2");
	String kicker2 = req.getParameter("kkr2");
	String headline3 =  req.getParameter("hdln3");
	String kicker3 = req.getParameter("kkr3");
	String headline4 =  req.getParameter("hdln4");
	String kicker4 = req.getParameter("kkr4");
	String headline5 =  req.getParameter("hdln5");
	String kicker5 = req.getParameter("kkr5");
	String headline6 =  req.getParameter("hdln6");
	String kicker6 = req.getParameter("kkr6");
	String section = req.getParameter("section");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
    
	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
			
						String sql="INSERT INTO mobile_rss_news (category_id,headline_1,more_1,headline_2,more_2,headline_3,more_3,headline_4,more_4,headline_5,more_5,headline_6,more_6, run_date,update_date,emp_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstmt = cn.prepareStatement(sql);						
						pstmt.setString(1,section);
						pstmt.setString(2,headline1);
						pstmt.setString(3,kicker1);
						pstmt.setString(4,headline2);
						pstmt.setString(5,kicker2);
						pstmt.setString(6,headline3);
						pstmt.setString(7,kicker3);
						pstmt.setString(8,headline4);
						pstmt.setString(9,kicker4);
						pstmt.setString(10,headline5);
						pstmt.setString(11,kicker5);
						pstmt.setString(12,headline6);
						pstmt.setString(13,kicker6);
						pstmt.setString(14,datetime);
						pstmt.setString(15,datetime);
						pstmt.setInt(16,empId);						
						pstmt.executeUpdate();						
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_rss.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("select_section_for_rsss.jsp?msg=Data Insertion Successfull..");
	%>



