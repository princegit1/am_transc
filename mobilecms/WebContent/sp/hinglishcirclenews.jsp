<%@ page import="java.sql.*,conn.*,com.itgd.server.DecodeXML"%><%		
		if (request.getParameter("circle")!=null) {
		String category = "";category = request.getParameter("circle");
			String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
			//String[] cCodeArr = { "AP", "ASM", "BHR", "CHN", "DEL", "GUJ","HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM","NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB" };
			//String[] cNameArr = { "AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI","Gujarat", "HARYANA", "HP", "JammuKashmir", "KERALA", "KK","KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST","ORISSA", "PUNJAB", "Rajasthan", "TN", "UPEAST", "UPW","WESTBENGAL" };
			String[] cCodeArr = {"RAJ","MP","GUJ","MUM","MAH", "HRY"};
			String[] cNameArr = {"Rajasthan","MP","Gujarat","Mumbai","Maharastra","HARYANA"};
			Connection cn = null;
			ResultSet rs = null;
			Statement stmt = null;
			String str = "",name = "",date = "",time = "";
			int a1, a2;
			String aa = "", ab = "", tempStr = "";			
			try{
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();	
				String upQuery1 = "select news_id, news, date_format(a.record_date,'%b %d  %h:%i %p')record_date,fname,lname  from mobile_news_hinglish a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_hinglish)";
				stmt = cn.createStatement();
				rs = stmt.executeQuery(upQuery1);
				if (rs.next()) {
				str = rs.getString("news");
					name = (rs.getString("fname") + " " + rs.getString("lname"));
					date = rs.getString("record_date");
					
			if (category != null || !category.equals("")) {
				for (int i = 0; i < 6; i++) {
					a1 = str.indexOf(cCodeArr[i] + ":");
					aa = str.substring(a1, str.length());
					a2 = aa.indexOf("<br>");
					ab = aa.substring(0, a2);
					tempStr = cCodeArr[i] + ":";
					if (category.equals(cCodeArr[i])) {
						completeNews = ab.substring(ab.indexOf(tempStr)+ tempStr.length());
						newsOne = completeNews.substring(0, completeNews.indexOf("2#"));
						if(newsOne.contains("1#")){
						
							newsOne=newsOne.replace("1#", "1.");
						}						
						newsTwo = completeNews.substring(newsOne.length(),completeNews.indexOf("3#"));
						if(newsTwo.contains("2#")){
							
							newsTwo=newsTwo.replace("2#", "2.");
						}
						newsThree = completeNews.substring(newsOne.length()+ newsTwo.length(), completeNews.length());
						if(newsThree.contains("3#")){
							
							newsThree=newsThree.replace("3#", "3.");
						}
						if(newsThree.contains("Pwrd by IndiaToday.in")){
							newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
						}
					out.println(cCodeArr[i] + " News:");out.println(newsOne);out.println(newsTwo);out.println(newsThree);out.println("On "+date);
					}}}}}catch (Exception e){e.printStackTrace();out.println("Connectivity is not available at this moment");}finally{try {if (rs != null)rs.close();if (stmt != null)stmt.close();if (cn != null)cn.close();}catch(SQLException e){e.printStackTrace();}}}%>