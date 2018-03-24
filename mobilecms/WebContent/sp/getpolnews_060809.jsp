<%@ page import="java.sql.*,conn.*"%><%String username = request.getParameter("serviceProvider");
		String password = request.getParameter("password");
		String serviceProvider = "IDEA";
		String category = request.getParameter("category");
		String upQuery = "";
		ResultSet rs3 = null;
		Connection cn3 = null;
		Statement stmt3 = null;
		ResultSet rs = null;
		Statement stmt = null;
		String message = "", newsOne = "", newsTwo = "", newsThree = "";
		try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		cn3 = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
		upQuery = "select distinct date_format(run_date,'%d%m%Y')run_date1, run_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"
					+ serviceProvider
					+ "' and  status='ACTIVE' and category_type='"
					+ category
					+ "'  order by run_date";
			stmt3 = cn3.createStatement();
			rs3 = stmt3.executeQuery(upQuery);

			String date = "";

			while (rs3.next()) {
				date = rs3.getString("run_date1");

				stmt = cn3.createStatement();
				rs = stmt
						.executeQuery("select date_format(run_date,'%d%m%Y')run_date,header,footer,total_message,COALESCE(message1,'')message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"
								+ serviceProvider
								+ "' and  status='ACTIVE' and category_type='"
								+ category
								+ "' and run_date='"
								+ rs3.getString("run_date")
								+ "' order by run_date");
				while (rs.next()) {

					message = rs.getString("message1");

				}
			}

			if (category != null || !category.equals("")) {

				newsOne = message.substring(0, message.indexOf("2#"));
				if (newsOne.contains("1#")) {

					newsOne = newsOne.replace("1#", "1.");
				}

				newsTwo = message.substring(newsOne.length(), message
						.indexOf("3#"));
				if (newsTwo.contains("2#")) {

					newsTwo = newsTwo.replace("2#", "2.");
				}
				newsThree = message.substring(newsOne.length()
						+ newsTwo.length(), message.length());
				if (newsThree.contains("3#")) {

					newsThree = newsThree.replace("3#", "3.");
				}
				if (newsThree.contains("Pwrd by IndiaToday.in")) {
					newsThree = newsThree.substring(0, newsThree
							.indexOf("Pwrd by IndiaToday.in"));
				}
				out.println("Political News:" + newsOne + "<BR>" + newsTwo
						+ "<BR>" + newsThree);

			}

		} catch (Exception e) {
			
			e.printStackTrace();
			out.println("Connectivity is not available at this moment");
		} finally {
			if (rs3 != null)
				try {
					rs3.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			if (stmt3 != null)
				try {
					stmt3.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			try {
				cn3.close();
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
%>
