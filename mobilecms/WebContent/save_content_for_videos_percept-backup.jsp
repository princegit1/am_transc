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
	//MultipartRequest req = new MultipartRequest(request,"c:\\home\\");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String headline1 =  request.getParameter("hdln1");
	String kicker1 = request.getParameter("kkr1");		
	String section = request.getParameter("section");
	String duration = request.getParameter("pic1");	
	String pic =  request.getParameter("hd2n1");
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
    

	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
			
						String sql="INSERT INTO mobile_rss_news (category_id,more_1,pic_1,pic_2,run_date,update_date,emp_id,headline_1) VALUES (?,?,?,?,?,?,?,?)";
						pstmt = cn.prepareStatement(sql);						
						pstmt.setString(1,section);
						pstmt.setString(2,kicker1);						
						pstmt.setString(3,headline1);
						pstmt.setString(4,pic);								
						pstmt.setString(5,datetime);
						pstmt.setString(6,datetime);
						pstmt.setInt(7,empId);	
						pstmt.setString(8,duration);						
						pstmt.executeUpdate();						
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_videos_percept.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("select_section_for_videos_percept.jsp?msg=Data Insertion Successfull..");
	%>



