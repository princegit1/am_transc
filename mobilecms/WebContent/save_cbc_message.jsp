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
	
	String categoryId= "";
	String categorystate=request.getParameter("stateName");
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
	String xmlData="";
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String txtDate =  "";
	String txtNews =  "";		
	int status=0;	
	int i=1;
	//txtNews = request.getParameter("txtNews");
	int totalMsg = Integer.parseInt(request.getParameter("totalMessage"));
	out.println("<br>News:-------->"+totalMsg+"");
	try
	
			{
			
			for(int k=1;k<=totalMsg;k++)
		{
			
			txtNews = request.getParameter("txtNews-"+i+"-"+k);
			categoryId=request.getParameter("category-"+i+"-"+k);
			//out.println("<br>Date "+txtDate+"<br>");
			out.println("<br>News:"+i+""+k+" "+txtNews+"");
			
			int lenNews = 0;
			try
			{
				lenNews = txtNews.length();
			}
			catch(NullPointerException nex)
			{
				lenNews =0;
			}
			//out.println("Length New " +lenNews);
			if(lenNews>10)
			{
			
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();
						String sql="INSERT INTO message_details (CATEGORY_ID,MESSAGE1,RUN_DATE,UPDATE_EMP_ID) VALUES (?,?,now(),?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						pstmt.setString(1,categoryId);
						pstmt.setString(2,txtNews);
						pstmt.setInt(3,empId);
						status=pstmt.executeUpdate();
						//cn.commit(); 
						
						
						
						}
						}
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

response.sendRedirect("cbc_states.jsp?categorystate="+categorystate+"&status="+status);

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
