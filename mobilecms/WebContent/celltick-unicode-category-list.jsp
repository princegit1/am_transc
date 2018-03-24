
<%
	String fname = (String) session.getAttribute("fname");
	if (fname == null) {
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="conn.*"%>
<%
	ResultSet resultSet = null;
	Connection connection = null;
	Statement statement = null;
%>
<html>
<head>
<title>Celltick-Mobile Service</title>
</head>
<body bgColor=#ffffff>
	<jsp:include page="topBand.jsp" />
	<form method=post name="celltick-unicode-category" action="celltick-unicode-message-insert.jsp">
		<table cellSpacing=0 cellPadding=0 width=550 align=center border=0 >
			<tr valign="middle" height="55">
				<td align="center">Select Category : &nbsp;&nbsp;&nbsp; <select	name="categoryId">
						<%
							try {
								StringBuffer category_unicode_Query =new StringBuffer()
								.append("select category_id,category_type,service_provider from category_master where status='ACTIVE' and ")
								.append("service_provider='Celltick' and category_type like '%-unicode%' ")
								.append("order by category_type");
								
								AdminConn adminConn = AdminConn.getInstance();
								connection = adminConn.getConnection();
								statement = connection.createStatement();
								resultSet = statement.executeQuery(category_unicode_Query.toString());
								while (resultSet.next()) {
								String category_type=resultSet.getString("category_type")+"-"+resultSet.getString("service_provider");
								int category_id=resultSet.getInt("category_id");
								
						%>
						    <option value="<%=category_id%>"><%=category_type%></option>
							
							<%
								}
								} catch (Exception exception) {
									out.print("Error Message :----"+ exception);
								} finally {
									if (resultSet != null)
										resultSet.close();
									if (statement != null)
										statement.close();
									if (connection != null)
										connection.close();
									resultSet = null;
									connection = null;
									statement = null;
								}
							%>
						
				</select>&nbsp;&nbsp;&nbsp; <input type="submit"
					value=" Insert Message &#187; "></td>
			</tr>
		</table>
	</form>
</body>
</html>
