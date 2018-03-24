<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="java.util.HashMap, java.util.Date, java.util.Map" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<%
 	String headlineTitle[] = request.getParameterValues("headlineTitle");
	String description[] = request.getParameterValues("description");
	String videoUrl[] = request.getParameterValues("videoUrl");
	String imageUrl[] =request.getParameterValues("imageUrl");
	
	Connection cn=null;	
	PreparedStatement pstmt=null;
	try{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
	    String datetime = dateFormat.format(new Date());		
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
	String section = request.getParameter("section");
		out.println(request.getParameterValues("headlineTitle")[0]);
				
		int empId = Integer.parseInt((String)session.getAttribute("empId"));
		String sql="INSERT INTO mobile_rss_news (category_id,more_1,pic_1,pic_2,run_date,update_date,emp_id,headline_1) VALUES (?,?,?,?,?,?,?,?)";
		for(int i=0; i<5; i++)
		{
					
			pstmt = cn.prepareStatement(sql);						
			pstmt.setString(1,section);
			pstmt.setString(2,description[i]);						
			pstmt.setString(3,videoUrl[i]);
			pstmt.setString(4,imageUrl[i]);								
			pstmt.setString(5,datetime);
			pstmt.setString(6,datetime);
			pstmt.setInt(7,empId);	
			pstmt.setString(8,headlineTitle[i]);
			
			pstmt.executeUpdate();
			
			
		}
		
					
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_videos_percept_mrss.jsp?msg=Data Insertion Failed..");
	}
finally
{
	 if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close(); 
}

response.sendRedirect("select_section_for_videos_bsb.jsp?msg=Data Insertion Successfull..");
	%>



