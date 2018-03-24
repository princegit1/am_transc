<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,conn.*,java.io.*"%><%@ page import="javax.mail.*" %><%@ page import="javax.mail.internet.*" %><%@page import="java.util.Properties"%><%@page import="java.util.Date"%><%	
	String upQuery="";
	String messageId = "";
	String categoryId = "";
	String date="";
	ResultSet rs3=null,rs=null;
	Connection cn3=null;
	Statement stmt=null,stmt3=null;	
	String serviceProvider = "MTNLDL";
	String category="";
	String username ="";
	String password="";
	String sprovider="";
	if(request.getParameter("category")!=null)
	category = request.getParameter("category");
	if(request.getParameter("username")!=null)	
	username = request.getParameter("username");
	if(request.getParameter("password")!=null)	
	password = request.getParameter("password");
	if(request.getParameter("serviceProvider")!=null)	
	sprovider = request.getParameter("serviceProvider");		
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "",message="";
	if(username.equalsIgnoreCase("cellnext") && password.equalsIgnoreCase("cellnext")&& sprovider.equalsIgnoreCase("cellnext")){
	if(category.equalsIgnoreCase("Sports News") || category.equalsIgnoreCase("Business News")|| category.equalsIgnoreCase("Intl News")|| category.equalsIgnoreCase("National")){
	
	if(category.equalsIgnoreCase("Sports News")){
	categoryId="85";
	}else if(category.equalsIgnoreCase("Business News")){
	categoryId="75";
	}else if(category.equalsIgnoreCase("Intl News")){
	categoryId="92";
	}else if(category.equalsIgnoreCase("National")){
	categoryId="63";
	}
	
	if(category.equalsIgnoreCase("Intl News")){
	serviceProvider = "AIRTEL";
	}

	try
	{	
	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	cn3 = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content","db1_mobile", "o0ywR!urPT+t");
	if(category.equalsIgnoreCase("National")){
	upQuery="SELECT max(MSG_ID)as MSG_ID FROM national_news where category_id=63";
	}else{
	upQuery="select max(a.MSG_ID)as MSG_ID from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"'  order by a.MSG_ID";
	}
	
	stmt3=cn3.createStatement();
	rs3=stmt3.executeQuery(upQuery);	
	if(rs3.next())
	{	
	stmt=cn3.createStatement();
	if(category.equalsIgnoreCase("National")){
	rs=stmt.executeQuery("select headline_1,headline_2,headline_3,date_format(update_date,'%d%m%Y%T')record_date FROM national_news where category_id=63 and MSG_ID='"+ rs3.getString("MSG_ID")+"'");
	}else{
	rs=stmt.executeQuery("select a.message1,date_format(a.RECORD_DATE,'%d%m%Y%T')record_date from message_details a, category_master b where a.category_id=b.category_id and b.service_provider='"+serviceProvider+"' and  status='ACTIVE' and category_type='"+category+"' and a.MSG_ID='"+ rs3.getString("MSG_ID")+"'");
	}	
	while(rs.next())
	{
	
	if(category.equalsIgnoreCase("National")){
	date = rs.getString("record_date");	
	newsOne=rs.getString("headline_1");	
	newsTwo=rs.getString("headline_2");	
	newsThree=rs.getString("headline_3");
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}	
	message="1."+newsOne+"2."+newsTwo+"3."+newsThree;
	
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
    out.println("<DATA>");
    out.println("<CONTENT>");
    out.println("<![CDATA["+message+"]]>");
    out.println("</CONTENT>");
    out.println("<DATE>"+date+"</DATE>");
    out.println("<EXPDATE></EXPDATE>");
    out.println("</DATA>");
	
	}else{
	
	messageId=rs3.getString("MSG_ID");	
	message=rs.getString("message1");	
	date = rs.getString("record_date");	
	if(category.equalsIgnoreCase("Sports News") || category.equalsIgnoreCase("Business News")|| category.equalsIgnoreCase("Intl News")){
	if(message.contains("Spo:")||message.contains("Biz:")){
	completeNews = message.substring(message.indexOf(":")+1, message.length()).trim();
	}else{
	completeNews=message;
	}	
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
	out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
    out.println("<DATA>");
    out.println("<CONTENT>");
    out.println("<![CDATA["+newsOne+newsTwo+newsThree+"]]>");
    out.println("</CONTENT>");
    out.println("<DATE>"+date+"</DATE>");
    out.println("<EXPDATE></EXPDATE>");
    out.println("</DATA>");
	}else{
		out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
    out.println("<DATA>");
    out.println("<CONTENT>");
    out.println("<![CDATA["+message+"]]>");
    out.println("</CONTENT>");
    out.println("<DATE>"+date+"</DATE>");
    out.println("<EXPDATE></EXPDATE>");
    out.println("</DATA>");

	}
	}
	}	
	}else{
	out.print("No Message");

	}	
	}		
	catch(Exception e)
	{
	
	FileInputStream fin;		

		try
		{	  
		    fin = new FileInputStream ("/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/"+categoryId+".xml");		 
		    out.println( new DataInputStream(fin).readLine().trim() );
		    fin.close();		
		}

		catch (IOException ee)
		{
			System.err.println ("Unable to read from file");			
		}
		try {
	String messageText=e.toString();
	String host = "mailer.indiatodaygroup.com";
	String to ="santosh.jena@intoday.com";
	String cc ="santosh.jena@intoday.com";
	String from = "santosh.jena@intoday.com"; 
	String subject ="cellnext errors";

	boolean sessionDebug = false;
	Properties props = System.getProperties();
	props.put("mail.smtp.host", "mailer.indiatodaygroup.com");
	Session mailSession = Session.getDefaultInstance(props, null);
	mailSession.setDebug(sessionDebug);
	Message msg = new MimeMessage(mailSession);
	msg.setFrom(new InternetAddress(from));
	InternetAddress[] address = {new InternetAddress(to)};
	msg.setRecipients(Message.RecipientType.TO, address);
	InternetAddress[] address1 = {new InternetAddress(cc)};
	msg.setRecipients(Message.RecipientType.CC, address1);
	msg.setSubject(subject);
	msg.setSentDate(new Date());
	msg.setText(messageText);
	msg.setContent(messageText,"text/html");
	Transport.send(msg);	
} catch(Exception ex) {
	System.err.println ("Unable to send mail");	
}
	
	
	e.printStackTrace();
	}
	finally
	{
	if(rs3!=null)
	rs3.close();
	if(stmt3!=null)
	stmt3.close();
	if(rs!=null)
	rs.close();
	if(stmt!=null)
	stmt.close();
	cn3.close();
	}
	}
	else{
	out.println("No Category Found");
	}
	}else{
	out.println(" Incorrect username,Password or service provider name in the parameter");
	}
%>
