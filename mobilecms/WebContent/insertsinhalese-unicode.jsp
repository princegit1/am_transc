<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="conn.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%
	
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	int categoryId= Integer.parseInt(request.getParameter("categoryId"));
	Connection cn=null;
	
	PreparedStatement  pstmt = null;
	String title =  "";
	String type =  "";
	String fulltext =  "";
	//System.out.println("i"+categoryId);
	
try
{
title = request.getParameter("title");
type = request.getParameter("type");
fulltext = request.getParameter("fulltext");	
	
Class.forName("com.mysql.jdbc.Driver").newInstance();
  			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
	//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");

			try
			{
				
				String sql="INSERT INTO message_details_unicode (CATEGORY_ID,MESSAGE1,MESSAGE2,MESSAGE3,RUN_DATE,UPDATE_EMP_ID) VALUES (?,?,?,?,now(),?)";
				pstmt = cn.prepareStatement(sql);
				pstmt.setInt(1,categoryId);						
				pstmt.setString(2,title);
				pstmt.setString(3,type);
				pstmt.setString(4,fulltext);				
				pstmt.setInt(5,empId);
				pstmt.executeUpdate();
				//cn.commit();
				System.out.println("i"+title);
			}
			catch(Exception e)
			{
				System.out.println(e.toString());
			}
		
}
catch(Exception e)
{
	System.out.println(e.toString());
}
finally
{
	
	if(pstmt!=null)
	pstmt.close();
	if(cn!=null)
	cn.close();
}
%>
<HTML>
<HEAD>
<TITLE>Mobile Service</TITLE>
</HEAD>
<HEAD>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1 hspace="5" vspace="5">
  <TBODY>
    <TD align=center>
		Successfully inserted.<br><br>
	</TD>
	</TR>
	</TABLE>	
</BODY>
</HTML>
