<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="com.oreilly.servlet.*" %>

<%
	Connection cn=null;	
	PreparedStatement pstmt=null;
	String sectionname="";
String pathname="";
	try
					{
	//MultipartRequest req = new MultipartRequest(request,"c:\\home\\");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String headline1 =  request.getParameter("hdln1");		
	String section = request.getParameter("section");
	
	String url="http://media1.intoday.in/mobile/regional";
	
	if(section.equals("259")){
sectionname="voice-clips-onmobile-mp";
pathname="mp";
}
if(section.equals("260")){
sectionname="voice-clips-onmobile-cg";
pathname="cg";
}

url=url+"/"+pathname+"/"+headline1;
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
			
						String sql="INSERT INTO mobile_rss_news (category_id,pic_1,run_date,update_date,emp_id) VALUES (?,?,?,?,?)";
						pstmt = cn.prepareStatement(sql);						
						pstmt.setString(1,section);									
						pstmt.setString(2,headline1);								
						pstmt.setString(3,datetime);
						pstmt.setString(4,datetime);
						pstmt.setInt(5,empId);												
						pstmt.executeUpdate();						
					
			}
catch (Exception e)
	{
	e.printStackTrace();
	response.sendRedirect("voice_clips_onmobile.jsp?msg=Data Insertion Failed..");
	}
finally
{
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("select_section_for_voice_clips_onmobile.jsp?msg=Data Insertion Successfull..");
	%>



