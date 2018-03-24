<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page
	import="java.util.Date"%><%@ page import="conn.*"%><%
	String selectQuery = "";
	Connection cn = null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = null;
	String news = "";
	String date = "";
	String serviceProvider = "ITGD-6D";
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
	String category = "";
	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
		try {
			//adminConn = AdminConn.getInstance();
			selectQuery = "SELECT  DATE_FORMAT(a.run_date,'%d%m%Y')record_date,COALESCE(a.message1,'')message1,a.msg_id FROM message_details a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='"
					+ serviceProvider
					+ "' AND b.status='ACTIVE' AND b.category_type='"
					+ category
					+ "' AND a.run_date=CURDATE() ORDER BY a.run_date";	
//out.println(selectQuery ); 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
			//cn = adminConn.getConnection();
			stmt = cn.createStatement();
			rs = stmt.executeQuery(selectQuery);
			while (rs.next()) {

				news = rs.getString("message1");
				date = rs.getString("record_date");

				completeNews = news;
				newsOne = completeNews.substring(0, completeNews.indexOf("2#"));
				if (newsOne.contains("1#")) {

					newsOne = newsOne.replace("1#", "1.");
				}

				newsTwo = completeNews.substring(newsOne.length(),completeNews.length());

				if (newsTwo.contains("2#")) {
					newsTwo = newsTwo.replace("2#", "2.");
				}

				if (newsTwo.contains("Pwrd by IndiaToday.in")) {
					newsTwo = newsTwo.substring(0, newsTwo.indexOf("Pwrd by IndiaToday.in"));
				}

				if (newsOne.contains("1.")) {
					newsOne = newsOne.replace("1.", "");
				}
				if (newsTwo.contains("2.")) {
					newsTwo = newsTwo.replace("2.", "");
				}
			}
 			//out.println(newsOne);
			//out.println(newsTwo);

			Calendar calendar = new GregorianCalendar();
        		String am_pm="";
			int am_pm_hour=0;
			int hour = 0;
			am_pm_hour=calendar.get( Calendar.AM_PM );
			//am_pm_hour=Calendar.AM_PM;
			hour = calendar.get( Calendar.HOUR ); 			
 			//out.println( Calendar.HOUR);
			//out.println(am_pm_hour);

        	int minute = calendar.get( Calendar.MINUTE );
        	if(am_pm_hour == 0 ){
            	am_pm = "AM";
            	if(hour >=0)
               	out.println(newsOne);
        	}            
        	else{
            	am_pm = "PM";
            	if(hour>=0) 
                out.println(newsTwo);
        	}				

		} catch (Exception nex) {
			out.println("");
			System.out.println(nex.toString()); 
			
		}

		finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (cn != null)
				cn.close();

		}
	} else {
		out.println("category not found");
	}
%>
