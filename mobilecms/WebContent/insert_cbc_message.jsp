<%
	//System.out.println("i");
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	int empId = Integer.parseInt((String)session.getAttribute("empId"));

%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="conn.*" %>
<%
	
	int categoryId= Integer.parseInt(request.getParameter("categoryId"));
	String categorystate=request.getParameter("categorystate");
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
	String xmlData="";
	String fileName=request.getParameter("categoryId");
	String xmlPath="C:\\jboss-4.2.2.GA\\server\\default\\deploy\\smscms.war\\xml\\";
	//String xmlPath="/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/";
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String txtDate =  "";
	String txtNews =  "";		
	int status=0;	
	txtNews = request.getParameter("txtNews");
	try
	
			{
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();
						String sql="INSERT INTO message_details (CATEGORY_ID,MESSAGE1,RUN_DATE,UPDATE_EMP_ID) VALUES (?,?,now(),?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						pstmt.setInt(1,categoryId);
						pstmt.setString(2,txtNews);
						pstmt.setInt(3,empId);
						status=pstmt.executeUpdate();
						//cn.commit(); 
					}
					catch(Exception e)
					{
						out.println(e.toString());
					}
			
finally
{
	if(rs!=null)
	rs.close();
	if(stmt!=null)
	stmt.close();
	if(cn!=null)
	cn.close();
}

response.sendRedirect("show_cbc_category.jsp?categoryId="+categoryId+"&categorystate="+categorystate+"&status="+status);

%>


<HTML><HEAD><TITLE>Mobile Service</TITLE>
</HEAD>
<HEAD>

</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1 hspace="5" 
vspace="5">
  <TBODY>
    <TD align=center>
		Successfully inserted.<br><br>
	</td>
	</tr>
	</table>
	
</BODY>
</HTML>
