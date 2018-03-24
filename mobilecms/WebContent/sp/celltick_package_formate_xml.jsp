<?xml version="1.0" encoding="ISO-8859-1"?><%@ page
	contentType="text/xml;charset=utf-8"%><%@ page
	import="java.sql.*,java.util.*,java.util.Date,conn.*"%>
<%
	int totalMsg = 0;
	int categoryId = 0;
	String serviceProvider = "sinhalese";
	String category = "";	
	Connection cn = null;
	ResultSet rs = null;
	Statement stmt = null;
	if(request.getParameter("category")!=null){
	out.print("<UpdatePlugContent>");
	try {	
		category = request.getParameter("category");	
		Class.forName("com.mysql.jdbc.Driver").newInstance();
    	cn = DriverManager.getConnection("jdbc:mysql://10.10.25.242:3306/content?useUnicode=true&characterEncoding=UTF-8","itgd", "itgd@nd@123");
    	//cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/content?useUnicode=true&characterEncoding=UTF-8","root", "root");
		stmt = cn.createStatement();
		rs = stmt.executeQuery("select date_format(a.run_date,'%d%m%Y')run_date,COALESCE(a.message1,'')message1,COALESCE(a.message2,'')message2,COALESCE(a.message3,'')message3,msg_id from message_details_unicode a, category_master b where a.category_id=b.category_id and b.service_provider='celltick' and  b.status='ACTIVE' and b.category_type='"
						+ category + "'  order by a.run_date");
						
						/*out.print("select date_format(a.run_date,'%d%m%Y')run_date,COALESCE(a.message1,'')message1,COALESCE(a.message2,'')message2,COALESCE(a.message3,'')message3,msg_id from message_details_unicode a, category_master b where a.category_id=b.category_id and b.service_provider='celltick' and  b.status='ACTIVE' and b.category_type='"
						+ category + "'  order by a.run_date");*/
						
		while (rs.next()) {
%>

<BeforeTheClickMessage> <RegularBTCMessage>
<Content><%=new String(new String(rs.getString("message1")).getBytes("ISO-8859-1"), "UTF-8")%></Content>
</RegularBTCMessage> </BeforeTheClickMessage>
<%
		}
	} catch (NullPointerException nex) {
		out.println(nex.toString());
	} catch (Exception e) {
		out.println(e.toString());
	} finally {
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (cn != null)
			cn.close();
	}
	out.print("</UpdatePlugContent>");
	}else{
	
	}%>
