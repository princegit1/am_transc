<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,java.io.*,conn.*,com.itgd.server.DecodeXML"%><%String keyword = "";keyword = request.getParameter("keyword");
				
			String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
			String[] cCodeArr = {  "TN","AP","GUJ","MAH", "MUM","ORI","MP","KER","KK" };
			String[] cNameArr = { "TN","AP","GUJ","MAH","MUM","ORI","MP","KER","KK"};
			Connection cn = null;
			ResultSet rs = null;
			Statement stmt = null;
			String str = "",name = "",date = "",time = "";
			int a1, a2;
			String aa = "", ab = "", tempStr = "";			
			try{
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();
				//Class.forName("com.mysql.jdbc.Driver").newInstance();
    			//cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");			
				String upQuery1 = "select news_id, news, date_format(a.record_date,'%d%m%Y%T')record_date,fname,lname  from mobile_news_new a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_new)";
				stmt = cn.createStatement();
				rs = stmt.executeQuery(upQuery1);
				if (rs.next()) {
					
					str = rs.getString("news");
					name = (rs.getString("fname") + " " + rs.getString("lname"));
					date = rs.getString("record_date");
					

				
			if (keyword != null || !keyword.equals("")) {
				for (int i = 0; i < 9; i++) {
					a1 = str.indexOf(cCodeArr[i] + ":");
					aa = str.substring(a1, str.length());
					a2 = aa.indexOf("<br>");
					ab = aa.substring(0, a2);
					tempStr = cCodeArr[i] + ":";
					if (keyword.equals(cNameArr[i])) {
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
						
						out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    					out.println("<data>");
    					out.println("<keyword>"+keyword+"</keyword>"); 
    					out.println("<timestamp>"+date+"</timestamp>"); 
    					out.println("<content>");
    					out.println("<![CDATA["+newsOne+newsTwo+newsThree+"]]>");
   					    out.println("</content>");
    					out.println("<transid>31313131</transid>");   
    					out.println("</data>");
						
						}}}}}catch (Exception e) {
				e.printStackTrace();
				//out.println("Connectivity is not available at this moment");
				FileInputStream fin;		

		try
		{	  
		
		    fin = new FileInputStream ("/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/"+keyword+".xml");		 
		    out.println( new DataInputStream(fin).readLine().trim() );
		    fin.close();		
		}

		catch (IOException ee)
		{
			out.println("Connectivity is not available at this moment");		
		}
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (stmt != null)
						stmt.close();
					if (cn != null)
						cn.close();					
				} catch (SQLException e) {
					e.printStackTrace();out.println("Connectivity is not available at this moment");}}%>