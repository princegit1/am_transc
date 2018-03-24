<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="com.oreilly.servlet.*" %>

<%
	String title=null;
	String desc=null;
	String keyword=null;
	String video1=null;
	String video2=null;
	String video3=null;
	String image=null;
	String duration=null;
	String fileSize=null;
	String bitrate=null;
	String section=null;
		String price=null;
	
	Connection cn=null;	
	PreparedStatement pstmt=null;
	try
					{
	//MultipartRequest req = new MultipartRequest(request,"c:\\home\\");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	
	if(request.getParameter("title")!=null)
	{
		  title =  request.getParameter("title");
	}
	if(request.getParameter("desc")!=null)
	{
		  desc =  request.getParameter("desc");
	}
	if(request.getParameter("key")!=null)
	{
		  keyword = request.getParameter("key");		
	}
	if(request.getParameter("video1")!=null)
	{
		  video1 = request.getParameter("video1");
	}
	if(request.getParameter("video2")!=null)
	{
		  video2 = request.getParameter("video2");		
	}
	if(request.getParameter("video3")!=null)
	{
		  video3 = request.getParameter("video3");		
	}
	if(request.getParameter("img1")!=null)
	{
		  image =  request.getParameter("img1");		
	}
	
	
	if(request.getParameter("dur1")!=null)
	{
		  duration =  request.getParameter("dur1");		
	}
	
	
	if(request.getParameter("filesize")!=null)
	{
		  fileSize =  request.getParameter("filesize");		
	}
	
	
	if(request.getParameter("bitrate")!=null)
	{
		  bitrate =  request.getParameter("bitrate");		
	}
	
	if(request.getParameter("price")!=null)
	{
		  price =  request.getParameter("price");		
	}
	
	if(request.getParameter("section")!=null)
	{
		  section =  request.getParameter("section");		
	}
	
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    	java.util.Date date = new java.util.Date();
    	String datetime = dateFormat.format(date);   
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		String sql="INSERT INTO mobile_rss_news (category_id,`headline_1`,`more_1`,`pic_1`,`headline_2`,`more_2`,`pic_2`,`headline_3`,`more_3`,`pic_3`,`headline_4`,emp_id, run_date,update_date,`headline_5`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt = cn.prepareStatement(sql);						
		pstmt.setString(1,section);
		pstmt.setString(2,title);					
		pstmt.setString(3,desc);
		pstmt.setString(4,keyword);								
		pstmt.setString(5,video1);
		pstmt.setString(6,video2);
		pstmt.setString(7,image);	
		pstmt.setString(8,duration);
		pstmt.setString(9,fileSize);	
		pstmt.setString(10,bitrate);
		pstmt.setString(11,price);
		pstmt.setInt(12,empId);
		pstmt.setString(13,datetime);
		pstmt.setString(14,datetime);
		pstmt.setString(15,video3);
		pstmt.executeUpdate();						
		
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("news_for_videos_cbc.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("news_for_videos_cbc.jsp?section="+section+"&msg=Data Insertion Successfull..");
%>



