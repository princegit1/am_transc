<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="com.oreilly.servlet.*" %>

<%
	Connection cn=null;	
	PreparedStatement pstmt=null;
	String section = "";
	String image1 = "";	
	String image2 = "";
	int errodecode=0;
	try
					{
	MultipartRequest req = new MultipartRequest(request,"/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/");
	//MultipartRequest req = new MultipartRequest(request,"c://");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	
	//System.out.println("@@@@@@112"+req.getParameter("hdln1"));
	    
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
	 
	 String headline7 =  req.getParameter("hdln7");
	String kicker7 = req.getParameter("kkr7");	
	 
	 String headline8 =  req.getParameter("hdln8");
	String kicker8 = req.getParameter("kkr8");	
	
	 String headline9 =  req.getParameter("hdln9");
	String kicker9 = req.getParameter("kkr9");	
	 
	 String headline10 =  req.getParameter("hdln10");
	String kicker10 = req.getParameter("kkr10");
	 
	  String headline11 =  req.getParameter("hdln11");
	String kicker11 = req.getParameter("kkr11");	
	 
	 String headline12 =  req.getParameter("hdln12");
	String kicker12 = req.getParameter("kkr12");
	 
	 	
	 		String dur_1=req.getParameter("dur1");
			String dur_2=req.getParameter("dur2");
			String dur_3=req.getParameter("dur3");
			String dur_4=req.getParameter("dur4");
			String dur_5=req.getParameter("dur5");
			String dur_6=req.getParameter("dur6");
			String dur_7=req.getParameter("dur7");
			String dur_8=req.getParameter("dur8");
			String dur_9=req.getParameter("dur9");
			String dur_10=req.getParameter("dur10");
			String dur_11=req.getParameter("dur11");
			String dur_12=req.getParameter("dur12");				
	 
	 
	section = "488";
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
      
      
      
       /*System.out.println("@@@@@@1"+headline1);
	  System.out.println("@@@@@@2"+headline2);
	   System.out.println("@@@@@@3"+headline3);
	   System.out.println("@@@@@@4"+headline4);
	     System.out.println("@@@@@@5"+headline5);
	     System.out.println("@@@@@@6"+headline6);
	       System.out.println("@@@@@@7"+headline7);
	        System.out.println("@@@@@@8"+headline8);
	         System.out.println("@@@@@@9"+headline9);
	          System.out.println("@@@@@@10"+headline10);
	                System.out.println("@@@@@@9"+headline11);
	          System.out.println("@@@@@@10"+headline12);
	          
	          	 
 System.out.println("@@@@@@"+kicker1);
 System.out.println("@@@@@@"+kicker2);
	   System.out.println("@@@@@@"+kicker3);
	    System.out.println("@@@@@@"+kicker4);
	     System.out.println("@@@@@@"+kicker5);
	      System.out.println("@@@@@@"+kicker6);
	      System.out.println("@@@@@@"+kicker7);
	       System.out.println("@@@@@@"+kicker8);
	         System.out.println("@@@@@@"+kicker9);
	          System.out.println("@@@@@@"+kicker10);      
            System.out.println("@@@@@@"+kicker11);
	          System.out.println("@@@@@@"+kicker12);
      
      
       System.out.println("@@@@@@"+dur_1);
 System.out.println("@@@@@@"+dur_2);
	   System.out.println("@@@@@@"+dur_3);
	    System.out.println("@@@@@@"+dur_4);
	     System.out.println("@@@@@@"+dur_5);
	      System.out.println("@@@@@@"+dur_6);
	      System.out.println("@@@@@@"+dur_7);
	       System.out.println("@@@@@@"+dur_8);
	         System.out.println("@@@@@@"+dur_9);
	          System.out.println("@@@@@@"+dur_10);      
            System.out.println("@@@@@@"+dur_11);
	          System.out.println("@@@@@@"+dur_12);*/
      
      
      
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
		
	String sql="INSERT INTO mobile_rss_news (category_id,headline_1,more_1,headline_2,more_2,headline_3,more_3,headline_4,more_4,headline_5,more_5,headline_6,more_6,headline_7,more_7,headline_8,more_8,headline_9,more_9,headline_10,more_10,headline_11,more_11,headline_12,more_12, run_date,update_date,emp_id,pic_1,pic_2,pic_3,pic_4,pic_5,pic_6,pic_7,pic_8,pic_9,pic_10,pic_11,pic_12) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
						pstmt.setString(14,headline7);
						pstmt.setString(15,kicker7);	
						pstmt.setString(16,headline8);
						pstmt.setString(17,kicker8);	
						pstmt.setString(18,headline9);
						pstmt.setString(19,kicker9);	
						pstmt.setString(20,headline10);
						pstmt.setString(21,kicker10);
						pstmt.setString(22,headline11);
						pstmt.setString(23,kicker11);
						pstmt.setString(24,headline12);
						pstmt.setString(25,kicker12);
						pstmt.setString(26,datetime);
						pstmt.setString(27,datetime);
						pstmt.setInt(28,empId);	
						pstmt.setString(29,dur_1);
						pstmt.setString(30,dur_2);	
						pstmt.setString(31,dur_3);
						pstmt.setString(32,dur_4);	
						pstmt.setString(33,dur_5);
						pstmt.setString(34,dur_6);
						pstmt.setString(35,dur_7);
						pstmt.setString(36,dur_8);
						pstmt.setString(37,dur_9);
						pstmt.setString(38,dur_10);
						pstmt.setString(39,dur_11);
						pstmt.setString(40,dur_12);	
						pstmt.executeUpdate();							
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	
	errodecode=1;
	
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}
if(errodecode==1)
response.sendRedirect("videos_for_astro_vuclip.jsp?section="+section+"&msg=Data Insertion Failed..");
else
response.sendRedirect("videos_for_astro_vuclip.jsp?section="+section+"&msg=Data Insertion Successfull..");

	%>



