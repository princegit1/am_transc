<%@ page language="java" import="java.util.*,java.sql.*,conn.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
 
  <body>

<%			String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
			String[] cCodeArr = { "AP", "ASM", "BHR", "CHN", "DEL", "GUJ","HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM","NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB" };
			String[] cNameArr = { "AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI","Gujarat", "HARYANA", "HP", "JammuKashmir", "KERALA", "KK","KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST","ORISSA", "PUNJAB", "Rajasthan", "TN", "UPEAST", "UPW","WESTBENGAL" };
			Connection cn = null;
			ResultSet rs = null;
			Statement stmt = null;
			String lastline="";
			String str = "";
			String name = "";
			String date = "";
			String time = "";
			int a1, a2;
			String aa = "", ab = "", tempStr = "";
			AdminConn adminConn = AdminConn.getInstance();
			try {
				cn = adminConn.getConnection();
				String upQuery1 = "select news_id, news, date_format(a.record_date,'%d-%M-%Y')record_date,time_format(a.record_date,'%r ')record_time,fname,lname  from mobile_news_new a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_new)";
				cn = adminConn.getConnection();
				stmt = cn.createStatement();
				rs = stmt.executeQuery(upQuery1);
				if (rs.next()) {
					str = rs.getString("news");
					name = (rs.getString("fname") + " " + rs.getString("lname"));
					date = rs.getString("record_date");
					time = rs.getString("record_time");

				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (stmt != null)
						stmt.close();
					if (cn != null)
						cn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}

			}
			
				for (int i = 0; i < 23; i++) {

					a1 = str.indexOf(cCodeArr[i] + ":");
					System.out.println(a1);
					aa = str.substring(a1, str.length());
					System.out.println(aa);
					a2 = aa.indexOf("<br>");
					System.out.println(a2);
					ab = aa.substring(0, a2);
					System.out.println(ab);
					tempStr = cCodeArr[i] + ":";
						System.out.println(tempStr);

					
						completeNews = ab.substring(ab.indexOf(tempStr)	+ tempStr.length());
						newsOne = completeNews.substring(0, completeNews.indexOf("2#"));
						newsTwo = completeNews.substring(newsOne.length(),completeNews.indexOf("3#"));
						newsThree = completeNews.substring(newsOne.length()+ newsTwo.length(), completeNews.length());
						if(newsThree.contains("Pwrd by IndiaToday.in")){
						newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
						lastline="Pwrd by IndiaToday.in";
						}
						
						
						
						String newsOnewNew=newsOne.substring(newsOne.indexOf("1#")+2,newsOne.length());
						String newsTwoNew=newsTwo.substring(newsTwo.indexOf("2#")+2,newsTwo.length());
						String newsThreeNew=newsThree.substring(newsThree.indexOf("3#")+2,newsThree.length());
						
						out.println(cCodeArr[i]+"<BR>");
						out.println("News"+"<BR>");
						out.println("1-"+newsOnewNew+"<BR>");
						out.println("2-"+newsTwoNew+"<BR>");
						out.println("3-"+newsThreeNew+"<BR>");
						out.println(lastline+"<BR><BR>");
						
						

					
				}
				out.println("updated at:" + date + time);
				out.flush();
				out.close();
		

    
%>


  </body>
</html>
