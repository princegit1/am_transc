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
	String section = req.getParameter("section");
	String image1 = req.getParameter("image1");	
	String image2 =  req.getParameter("image2");
	String image3 = req.getParameter("image3");
	String image4 = req.getParameter("image4");
	String image5 = req.getParameter("image5");
	String image6 = req.getParameter("image6");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
      image1=image1+"|"+image2;
    image2=image3+"|"+image4;
		 image3=image5+"|"+image6;
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
			
						String sql="INSERT INTO mobile_rss_news (category_id,headline_1,more_1,pic_1,headline_2,more_2,pic_2,headline_3,more_3,pic_3, run_date,update_date,emp_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstmt = cn.prepareStatement(sql);						
						pstmt.setString(1,section);
						pstmt.setString(2,headline1);
						pstmt.setString(3,kicker1);	
						pstmt.setString(4,image1);
						pstmt.setString(5,headline2);
						pstmt.setString(6,kicker2);	
						pstmt.setString(7,image2);				
						pstmt.setString(8,headline3);
						pstmt.setString(9,kicker3);
						pstmt.setString(10,image3);				
						pstmt.setString(11,datetime);
						pstmt.setString(12,datetime);
						pstmt.setInt(13,empId);						
						pstmt.executeUpdate();							
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_rss_rogerscanada.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("select_section_for_rsss_rogerscanada.jsp?msg=Data Insertion Successfull..");
	%>



