<%@ page import="java.sql.*,conn.*"%>
<%
	String category="";
	category = request.getParameter("Circle"); 
	String username = request.getParameter("username");
	String password = request.getParameter("password");
if(username.equals("buongiorno") & password.equals("buongiorno"))	{
String completeNews="",newsOne="",newsTwo="" , newsThree="";
String[] cCodeArr = { "AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "JammuKashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UPEAST", "UPW", "WESTBENGAL"}; 
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String str = "";
	String name = "";
	String date = "";
	String time = "";
	int a1,a2 ;
	String aa="",ab ="",tempStr =""; 
	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();
		String upQuery1 = "select news_id, news, date_format(a.record_date,'%d-%M-%Y')record_date,time_format(a.record_date,'%r ')record_time,fname,lname  from mobile_news_new a, employee b where a.emp_id=b.emp_id and news_id= (select max(news_id) from mobile_news_new)";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{
				str = rs.getString("news");			
				name = (rs.getString("fname") +" "+ rs.getString("lname"));				
				date = rs.getString("record_date");				
				time = rs.getString("record_time");			
				
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
if(category!=null||!category.equals("")){
for(int i=0;i<23;i++)
		{
					
			a1 = str.indexOf(cCodeArr[i]+":");
			aa =  str.substring(a1,str.length());
			a2 = aa.indexOf("<br>");
			ab =  aa.substring(0,a2);
			tempStr = cCodeArr[i]+":";			
				if(category.equals(cNameArr[i])){
						 completeNews= ab.substring(ab.indexOf(tempStr)+tempStr.length());						
						  newsOne=completeNews.substring(0,completeNews.indexOf("2."));						
						  newsTwo=completeNews.substring(newsOne.length(),completeNews.indexOf("3."));				newsThree=completeNews.substring(newsOne.length()+newsTwo.length(),completeNews.length());
						%>
<%=newsOne%><br>
<%=newsTwo%><br>
<%=newsThree%><br>
updated at:<%=date%><%=time%>
					
						<%
						}	else{
						
						
						}
							
					}
				

					}	else{
					
					out.println("Please provide the url with correct Circle Name ");
					
					} 
		}
	else
	{
		out.println("Please check the URL parameter. <b>Something Must Be Wrong with Parameters.</b>");
	}
		
		%> 
		

