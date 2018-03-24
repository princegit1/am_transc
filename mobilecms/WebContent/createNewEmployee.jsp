<HTML>
  <HEAD>
    <TITLE>Create your account</TITLE>
    <META NAME="Description" CONTENT="">
    <META NAME="Keywords" CONTENT="">
    <META NAME="Author" CONTENT="">
    <LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
  </HEAD>
  
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="java.util.Date" %>

<%
	Connection cn=null;
	//Statement st = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	int userId = 0;
	String fname = request.getParameter("fname");
	String mname = request.getParameter("mname");
	String lname = request.getParameter("lname");
	String uname = request.getParameter("uname");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	long mobile_no = Long.parseLong(request.getParameter("mobile_no"));

	String dob = "";//""request.getParameter("dob");
			dob = request.getParameter("year")+"/"+request.getParameter("month")+"/"+request.getParameter("day");
	String msg1 = "";

		try
		{
			AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();

			PreparedStatement checkUser = cn.prepareStatement("select fname, emp_id from employee where lower(uname) = lower('"+uname+"')");
			rs = checkUser.executeQuery();
			if(rs.next())
			{
%>
				<jsp:forward page="addEmployee.jsp">
				<jsp:param name="msg" value="User name already exists" />
				</jsp:forward>
<%
			}
		if(rs!=null)
			rs=null;

			PreparedStatement prod_category = cn.prepareStatement("select max(emp_id)+1 user_id from employee");
			rs = prod_category.executeQuery();
			if(rs.next())
			{
				userId = rs.getInt("user_id");
			}
			String status="ACTIVE";
			//st=cn.createStatement();
			String sql1="insert into employee (emp_id,uname, pwd, fname,mname,lname,email,dob,mobile_no,status) values (?,?,?,?,?,?,?,?,?,?)";
			pstmt = cn.prepareStatement(sql1);
			pstmt.setInt(1,userId);
			pstmt.setString(2,uname);
			pstmt.setString(3,pwd);
			pstmt.setString(4,fname);
			pstmt.setString(5,mname);
			pstmt.setString(6,lname);
			pstmt.setString(7,email);
			pstmt.setString(8,dob);
			pstmt.setLong(9,mobile_no);
			pstmt.setString(10,status);

			pstmt.executeUpdate();
			//cn.commit();
			msg1="sccessfully added";
		}
		catch(Exception e)
		{
			out.println(e.toString());
			msg1="Error in employee details: "+e.toString();
		}
		finally
		{
			if(rs!=null)
				rs.close();
			if(pstmt!=null)
				pstmt.close();
			if(cn!=null)
				cn.close();
		}


		/*Sending mail*/

		try
		{
				String messageText="Welcome to Mobile Service Admin Module";

				String host = "mailer.indiatodaygroup.com";
				String to =email;
				String from = "sms@intoday.com";

				String subject ="Welcome to Mobile Service Admin Module";
				  
				messageText = "Dear "+fname+", \n\nWelcome to Mobile Service Admin Module!\n\nYour User name & Password are given below.\n\nYou will now be able to input and edit information in the database.\n\nYour User Name - "+uname+"\n\nYour Password  - "+pwd+" \n\nWarmest Regards \n\nTeam  Mobile Service \n\n\nP.S. This is an automated email. Kindly do not reply, as you may not receive a response.\n\n" ;


				boolean sessionDebug = false;
				
				Properties props = System.getProperties();
				props.put("mail.smtp.host", "mailer.indiatodaygroup.com");

				Session mailSession = Session.getDefaultInstance(props, null);

				mailSession.setDebug(sessionDebug);

				Message msg = new MimeMessage(mailSession);

				msg.setFrom(new InternetAddress(from));
				InternetAddress[] address = {new InternetAddress(to)};
				msg.setRecipients(Message.RecipientType.TO, address);
		   
				msg.setSubject(subject);
				msg.setSentDate(new Date());
				msg.setText(messageText);

				Transport.send(msg);
				out.println("Messeg Send  ");
		}
		catch(Exception ex)
		{
			out.println("Error "+ex.toString());
		}
response.sendRedirect("addEmployee.jsp?msg="+msg1+"&fname="+fname);
%>	


</body>
</html>
