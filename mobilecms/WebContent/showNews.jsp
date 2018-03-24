<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<html>
<head>
<title>Select Date for news</title>
    <LINK HREF="stylesheet.css" REL="stylesheet" TYPE="text/css">
</head>
<body>
	<jsp:include page="topBand.jsp" />
	<center>
		<TABLE WIDTH="50%" BORDER="1" CELLSPACING="0" CELLPADDING="3" ALIGN="CENTER" STYLE="border-collapse:collapse;" BORDERCOLOR="#ECECEC"   CLASS="text1">
				<%
					String keyword = request.getParameter("keyword");
					Connection cn=null;
					ResultSet rs = null;
					Statement stmt = null;
					String str = "";
					String name = "";
					String date = "";
					AdminConn adminConn = AdminConn.getInstance();
					try
					{
						cn = adminConn.getConnection();	
						String upQuery1 = "select a.news,date_format(a.record_date,'%d-%M-%Y %r') entrydate, b.fname, b.lname from mobile_news a, employee b where a.emp_id=b.emp_id and a.news_id="+request.getParameter("newsId");
						//"select date_format(record_date,'%d-%M-%Y %r')entrydate, fname, lname,news  from mobile_news where news_id="+request.getParameter("newsId");
						cn = adminConn.getConnection();
						stmt=cn.createStatement();
						rs=stmt.executeQuery(upQuery1);
						if(rs.next())
						{
								str = rs.getString("news");
								date = rs.getString("entrydate");
								name = rs.getString("fname")+" "+rs.getString("lname");
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
					String abc=str.replaceAll("[$]","<br><br>");//.replaceAll("(?i)"+keyword, "<b>"+keyword+"</b>");
				%>
			<tr>
				<td align="right">
					<b><%=date%></b><br>By: <b><%=name%></b>
				</td>
			</tr>
			<tr>
				<td>
				<%
					out.println("<font color=red>"+abc);
				%>
				</td>
			</tr>
		</table>
	</center>
</body>
</html>

