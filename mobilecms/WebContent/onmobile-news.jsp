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
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	ResultSet resultSet = null;
	Connection connection = null;
	Statement statement = null;
	
%>
<html>
<head>
<title>Onmobile-Mobile Service</title>
</head>
<body bgColor=#ffffff>
	<jsp:include page="topBand.jsp" />
	<form method=post name="celltick-unicode-category" action="onmobile-news-insert.jsp">
		<table cellSpacing=0 cellPadding=0 width=550 align=center border=0 >
			<tr valign="middle" height="55">
				<td align="center">Select Category : &nbsp;&nbsp;&nbsp; <select	name="categoryId">
						<%
							try {
								/*StringBuffer category_unicode_Query =new StringBuffer()
								.append("select category_id,category_type,service_provider from category_master where status='ACTIVE' and ")
								.append("service_provider='Celltick' and (category_type like '%-unicode%' or category_type like '%-english%')  ")
								.append("order by category_type");
								*/
								String sql="select category_id,category_type,service_provider from category_master where status='ACTIVE' and service_provider='onmobile' and category_id >=1090 AND category_id <=1095  order by category_type";
								
								AdminConn adminConn = AdminConn.getInstance();
								connection = adminConn.getConnection();
								statement = connection.createStatement();
								resultSet = statement.executeQuery(sql);
								while (resultSet.next()) {
								String category_type=resultSet.getString("category_type")+"-"+resultSet.getString("service_provider");
								int category_id=resultSet.getInt("category_id");
								
						%>
						    <option value="<%=category_id%>"> <%=category_type%> </option>
							
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
						
				</select>&nbsp;&nbsp;&nbsp; 
                
                <select name="currentDate">
                
                <%
				try{
				 Date today = new Date();  

     Calendar calendar = Calendar.getInstance();  
     calendar.setTime(today);  
     calendar.add(Calendar.MONTH, 1);  
     calendar.set(Calendar.DAY_OF_MONTH, 1);  
     calendar.add(Calendar.DATE, -1);  
     Date lastDayOfMonth = calendar.getTime();  
     DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
	 int days=Integer.parseInt(sdf.format(lastDayOfMonth).split("-")[2]); 
   //  System.out.println("Last Day of Month: " + sdf.format(lastDayOfMonth).split("-")[2]); 
     Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		String month =sdf.format(lastDayOfMonth).split("-")[1];
		int day = c.get(Calendar.DAY_OF_MONTH);
		for(int i=1; i<=days; i++){
	
 %>
                
                <option value="<%=year+"-"+month+"-"+i%>"><%=year+"-"+month+"-"+i%></option>
                
                <%}}
				
				catch(Exception excep)
				{}
				%>
                </select>
                 <input type="submit"
					value=" Insert Message &#187; "></td>
			</tr>
		</table>
	</form>
</body>
</html>
