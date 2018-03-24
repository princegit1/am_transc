<%@ page import="java.sql.*"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%
Connection cn=null;	
PreparedStatement pstmt=null;
try {
	//MultipartRequest req = new MultipartRequest(request,"/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/");
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String kicker1 = request.getParameter("kkr1");	
		String section = request.getParameter("section");

	System.out.println(section+","+kicker1);

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd H:m:s");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);   
	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String sql="INSERT INTO mobile_rss_news (category_id,more_1, run_date,update_date,emp_id) VALUES (?,?,?,?,?)";
	pstmt = cn.prepareStatement(sql);						
	pstmt.setString(1,section);
	pstmt.setString(2,kicker1);	
	pstmt.setString(3,datetime);
	pstmt.setString(4,datetime);
	pstmt.setInt(5,empId);		
	System.out.println("INSERT INTO mobile_rss_news (category_id,more_1, run_date,update_date,emp_id) VALUES ("+section+","+kicker1+","+datetime+","+datetime+","+empId+")");
	pstmt.executeUpdate();						
} catch (Exception e) {
	e.printStackTrace();
	response.sendRedirect("news_for_olympic2012.jsp?msg=Data Insertion Failed..");
} finally {
	if(pstmt!=null)
		pstmt.close();
	if(cn!=null)
		cn.close();
}
response.sendRedirect("select_section_for_olympic2012.jsp?msg=Data Insertion Successfull..");
%>