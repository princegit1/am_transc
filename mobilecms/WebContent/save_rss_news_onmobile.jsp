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
	//MultipartRequest req = new MultipartRequest(request,"C:\\jboss-4.2.2.GA\\server\\default\\deploy\\content.war\\xml\\");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	
	String headline1 =  req.getParameter("hdln1");
	String kicker1 = req.getParameter("kkr1"); 
	String section = req.getParameter("section");
	String image1 = req.getParameter("img1");	
	
	String headline2 =  req.getParameter("hdln2");
	String kicker2 = req.getParameter("kkr2");	
	 String image2 = req.getParameter("img2");
	 
	 String headline3 =  req.getParameter("hdln3");
	String kicker3 = req.getParameter("kkr3");	
	 String image3 = req.getParameter("img3");
	 
	 String headline4 =  req.getParameter("hdln4");
	String kicker4 = req.getParameter("kkr4");	
	 String image4 = req.getParameter("img4");
	 String headline5 =  req.getParameter("hdln5");
	String kicker5 = req.getParameter("kkr5");	
	String image5 = req.getParameter("img5");
	
	
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
      
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
			
						String sql="INSERT INTO mobile_rss_news (category_id,headline_1,more_1,pic_1,headline_2,more_2,pic_2,headline_3,more_3,pic_3,headline_4,more_4,pic_4,headline_5,more_5,pic_5,run_date,update_date,emp_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
						
							pstmt.setString(11,headline4);
						pstmt.setString(12,kicker4);	
						pstmt.setString(13,image4);	
						
						
							pstmt.setString(14,headline5);
						pstmt.setString(15,kicker5);	
						pstmt.setString(16,image5);	
						
						pstmt.setString(17,datetime);
						pstmt.setString(18,datetime);
						pstmt.setInt(19,empId);						
						pstmt.executeUpdate();							
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_rss_onmobile.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("select_section_for_rsss_onmobile.jsp?msg=Data Insertion Successfull..");
	%>



