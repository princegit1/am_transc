<%@ page import="java.sql.*,java.util.ArrayList,conn.*"%><%
	int totalMsg = 0;
	int categoryId = 0;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
	Connection cn=null;	
	ResultSet rs=null;
	Statement stmt=null;
	String msg="";
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",newsFour = "",newsFive = "";
	String username = request.getParameter("username");
	String password = request.getParameter("password");	
	String serviceProvider = request.getParameter("serviceProvider");
	System.out.print(serviceProvider);
	if(serviceProvider.equals("b!")){
	serviceProvider ="MTNLDL";
	}if(serviceProvider.equals("buongiorno")){
	serviceProvider ="AIRTEL";
	}
	
	String category = request.getParameter("category");	
	if (username.equals("buongiorno") & password.equals("buongiorno")) {		
		try
		{		
		upQuery="select date_format(run_date,'%d%m%Y')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+category+"' order by a.msg_id desc limit 1";
		//out.println(upQuery);
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);		
		while(rs.next())
		{
		msg=rs.getString("message1");
		if(msg.contains("Biz:")){
		msg=msg.replaceAll("Biz:","");
		newsOne = msg.substring(0, msg.indexOf("2."));
		newsTwo = msg.substring(newsOne.length(),msg.indexOf("3."));
		newsThree = msg.substring(msg.indexOf("3."), msg.length());
		//newsThree = msg.substring(newsOne.length()+ newsTwo.length(), msg.indexOf("4."));
		//newsFour = msg.substring(newsOne.length()+ newsTwo.length()+newsThree.length(), msg.indexOf("5."));
		//newsFive = msg.substring(newsOne.length()+ newsTwo.length()+newsThree.length()+newsFour.length(), msg.length());
		out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree);
		}else{
		

		if(category.equals("Filmi"))
			{
				newsOne = msg.substring(0, msg.indexOf("2."));
				//newsTwo = msg.substring(newsOne.length(),msg.indexOf("3."));
				newsThree = msg.substring(newsOne.length(), msg.length());
				out.print(newsOne+"<BR>"+newsThree);
			}
			else {
			newsOne = msg.substring(0, msg.indexOf("2."));
			newsTwo = msg.substring(newsOne.length(),msg.indexOf("3."));
			newsThree = msg.substring(msg.indexOf("3."), msg.length());
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
		}
%>