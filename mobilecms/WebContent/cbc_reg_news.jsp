<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,conn.*,com.itgd.server.DecodeXML"%><%String category = "";category = request.getParameter("msg");
		String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
			String[] cCodeArr = { "KER","TN","AP", "KK"};
			String[] cNameArr = { "KERALA","TN","AP", "KK"};
			Connection cn = null;
			ResultSet rs = null;
			Statement stmt = null; 
			String str = "",name = "",date = "",time = "";
			int a1, a2;
			String aa = "", ab = "", tempStr = "";			
			try{
				//AdminConn adminConn = AdminConn.getInstance();
				Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
    			//cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","itgd_office", "$t0p@ct1ng58");
				String upQuery1 = "select news_id, news, date_format(record_date,'%d%m%Y')record_date from mobile_news_new  where news_id= (select max(news_id) from mobile_news_new)";
				stmt = cn.createStatement();
				rs = stmt.executeQuery(upQuery1);
				if (rs.next()) {
				str = rs.getString("news");					
				date = rs.getString("record_date");
					
			if (category != null || !category.equals("")) {
				for (int i = 0; i < 4; i++) {
					a1 = str.indexOf(cCodeArr[i] + ":");
					aa = str.substring(a1, str.length());
					a2 = aa.indexOf("<br>");
					ab = aa.substring(0, a2);
					tempStr = cCodeArr[i] + ":";
					if (category.equals(cCodeArr[i])) {
						completeNews = ab.substring(ab.indexOf(tempStr)+ tempStr.length());
						newsOne = completeNews.substring(0, completeNews.indexOf("2#"));
						if(newsOne.contains("1#")){
						
							newsOne=newsOne.replace("1#","1.");
						}		
						
						if(completeNews.contains("3#")){			
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
						
						if(newsOne.contains("1.")){
						newsOne=newsOne.replace("1.","");
						}	
						if(newsTwo.contains("2.")){
						newsTwo=newsTwo.replace("2.", "");
						}					
						if(newsThree.contains("3.")){
						newsThree=newsThree.replace("3.", "");
						}						
						%><vap version="1.0">
<contentItem lang="en-in" useOn='<%=date%>' expires='<%=date%>'>
<multiPartSms>
<part><%=newsOne%></part>
<part><%=newsTwo%></part>
<part><%=newsThree%></part>
</multiPartSms>
</contentItem>
</vap>
<%}else{
newsTwo = completeNews.substring(newsOne.length(),completeNews.length());
						
if(newsTwo.contains("2#")){
newsTwo=newsTwo.replace("2#", "2.");
}

if(newsTwo.contains("Pwrd by IndiaToday.in")){
newsTwo=newsTwo.substring(0,newsTwo.indexOf("Pwrd by IndiaToday.in"));
}

if(newsOne.contains("1.")){
newsOne=newsOne.replace("1.","");
}	
if(newsTwo.contains("2.")){
newsTwo=newsTwo.replace("2.", "");
}					
		
%><vap version="1.0">
<contentItem lang="en-in" useOn='<%=date%>' expires='<%=date%>'>
<multiPartSms>
<part><%=newsOne%></part>
<part><%=newsTwo%></part>
</multiPartSms>
</contentItem>
</vap>
<%}}}}}}catch (Exception e){e.printStackTrace();out.println("Connectivity is not available at this moment");}finally{try {if (rs != null)rs.close();if (stmt != null)stmt.close();if (cn != null)cn.close();}catch(SQLException e){e.printStackTrace();}}%>