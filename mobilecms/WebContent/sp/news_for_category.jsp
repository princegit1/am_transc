<%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.util.Date" %><%@ page import ="java.text.SimpleDateFormat"%><%@ page import="conn.*" %><%
	int totalMsg = 0;
	int categoryId = 0;
String alertDate="";
	String upQuery="";
	Connection cn=null;	
	ResultSet rs=null;
	Statement stmt=null;
	String msg="";
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",newsFour = "",newsFive = "";
	//String username = request.getParameter("username");
	//String password = request.getParameter("password");	
	String serviceProvider = request.getParameter("serviceProvider");
	 Date dateNow = new Date ();      
      SimpleDateFormat dateformatDDMMYYYY = new SimpleDateFormat("ddMMyyyy");
      StringBuilder nowDate = new StringBuilder( dateformatDDMMYYYY.format( dateNow ) );
alertDate=nowDate.toString();
	System.out.print(serviceProvider);
	if(serviceProvider.equals("b!")||serviceProvider.equals("b") ){
	serviceProvider ="MTNLDL";
	}
	if(serviceProvider.equals("buongiorno")){
	serviceProvider ="AIRTEL";
	}
	if(serviceProvider.equals("itgd")){
	serviceProvider ="ITGD";
	}
	
	String category = request.getParameter("category");	
			
		try
		{	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");		
		upQuery="select date_format(run_date,'%d%m%Y')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+category+"' and DATE_FORMAT(run_date, '%d%m%Y')='"+alertDate+"'";
		//out.println(upQuery);
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);		
		while(rs.next())
		{
		msg=rs.getString("message1");
		if(msg.contains("Biz:")){
		msg=msg.replaceAll("Biz:","");
		newsOne = msg.substring(0, msg.indexOf("2#"));
		newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
		newsThree = msg.substring(msg.indexOf("3#"), msg.length());
		if(newsOne.contains("1#")){
		newsOne=newsOne.replace("1#", "1.");
		}	
		if(newsTwo.contains("2#")){
		newsTwo=newsTwo.replace("2#", "2.");
		}	
		if(newsThree.contains("3#")){
		newsThree=newsThree.replace("3#", "3.");
		}
		out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree);
		}else{
		

		if(category.equals("Filmi"))
			{
				newsOne = msg.substring(0, msg.indexOf("2#"));
			newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
			newsThree = msg.substring(msg.indexOf("3#"), msg.length());
			if(newsOne.contains("1#")){
			newsOne=newsOne.replace("1#", "1.");
			}	
			if(newsTwo.contains("2#")){
			newsTwo=newsTwo.replace("2#", "2.");
			}	
			if(newsThree.contains("3#")){
			newsThree=newsThree.replace("3#", "3.");
			}
			out.print("FILMY:"+newsOne+" "+newsTwo+" "+newsThree);
			}else if(category.equals("sports-mtn") || category.equals("Business News-mtn") || category.equals("Entertainment-mtn") || category.equals("exchange rates-mtn") || category.equals("Finance news-mtn") || category.equals("History-mtn") || category.equals("International news-mtn") || category.equals("Market Indicators-mtn") || category.equals("Market Reports-mtn") || category.equals("SA News-mtn") || category.equals("Fashion-B!"))
			{
				out.print(msg);
			}
			else {
			newsOne = msg.substring(0, msg.indexOf("2#"));
			newsTwo = msg.substring(newsOne.length(),msg.indexOf("3#"));
			newsThree = msg.substring(msg.indexOf("3#"), msg.length());
			if(newsOne.contains("1#")){
			newsOne=newsOne.replace("1#", "1.");
			}	
			if(newsTwo.contains("2#")){
			newsTwo=newsTwo.replace("2#", "2.");
			}	
			if(newsThree.contains("3#")){
			newsThree=newsThree.replace("3#", "3.");
			}
			out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree);
		
			}
			
		}
		
		}
		}		
		catch(Exception e)
		{
			System.out.println(e.toString());
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
	
%>