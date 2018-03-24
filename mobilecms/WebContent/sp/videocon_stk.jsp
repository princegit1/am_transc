<%@ page import="java.sql.*,java.util.ArrayList,conn.*"%><%
	//AdminConn adminConn = null;
	//adminConn = AdminConn.getInstance();
	String upQuery="";
	Connection cn=null;	
	ResultSet rs=null;
	Statement stmt=null;
	String msg="";
	String lastbuildDate="";
	String serviceProvider ="Videocon";
	String category = request.getParameter("category");	
	if(category!=null && !category.equals("")){			
		try
		{		
		upQuery="select DATE_FORMAT(a.RECORD_DATE,'LstUpd : %d-%M-%y %h:%i %p')run_date, message1,msg_id from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  b.status='ACTIVE' and b.CATEGORY_TYPE='"+category+"' order by a.msg_id desc limit 1";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
//out.println(upQuery);		
//cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);		
		while(rs.next())
		{
		msg=rs.getString("message1");
		lastbuildDate=rs.getString("run_date");
		
		
		 if(category.equals("forex") || category.equals("breaking-news")  )
			{
			out.print(msg);
			if(category.equals("forex")) {out.print(lastbuildDate);}

			
			}else{
out.print("CATEGORY NOT FOUND.....");
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
	}else{
out.print("CATEGORY NOT FOUND.....");
}
%>