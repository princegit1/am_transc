<%@ page import="java.sql.*,java.util.ArrayList,conn.*"%><%
	String upQuery = "";
	Connection cn = null;
	ResultSet rs = null;
	Statement stmt = null;
	String msg = "";
	String lastbuildDate = "";
	String serviceProvider = "IDEA";
	String category = "";
	if (request.getParameter("category") != null
			&& !request.getParameter("category").equals("")) {
		category = request.getParameter("category");
		if (category.equals("business-news")
				|| category.equals("sports-news")
				|| category.equals("top-gainer-loser")
				|| category.equals("international-news")
				|| category.equals("stock-alert")
				|| category.equals("nse-bse-update")
				|| category.equals("national-news")) {
				
			try {
	Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
				upQuery = "select date_format(run_date,'%d%m%Y')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"
						+ serviceProvider
						+ "' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"
						+ category + "' order by a.msg_id desc limit 1";
				//out.println(upQuery);		
				//cn = adminConn.getConnection();
				stmt = cn.createStatement();
				rs = stmt.executeQuery(upQuery);
				while (rs.next()) {
					msg = rs.getString("message1"); 
					lastbuildDate = rs.getString("run_date");

					out.print(msg);

				}

			} catch (Exception e) {
				out.print("CONTENT NOT FOUND");
				System.out.println(e.toString());
			} finally {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (cn != null)
					cn.close();
			}
		} else {
			out.print("CATEGORY NOT FOUND");
		}
	} else {
		out.print("CATEGORY NOT FOUND");
	}
%>