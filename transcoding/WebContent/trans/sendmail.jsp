<%-- 
    Document   : sendmail
    Created on : Jun 4, 2013, 3:45:48 PM
    Author     : vijayendrar
--%>

<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>


<%
    out.println("Test Email<br />");

      // Recipient's email ID needs to be mentioned.
      String to = "vijayendra.ratrey@intoday.com";

      // Sender's email ID needs to be mentioned
      String from = "awstranscode@intoday.in";

      // Assuming you are sending email from localhost
      String host = "220.226.193.41";

      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      properties.setProperty("mail.smtp.host", host);

      // Get the default Session object.
      Session mSsession = Session.getDefaultInstance(properties);

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(mSsession);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress("vijayendra.ratrey@intoday.com"));//new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("This is the Subject Line!");

         // Now set the actual message
         message.setText("This is actual message");

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
      }catch (MessagingException mex) {
         mex.printStackTrace();
      }
%>