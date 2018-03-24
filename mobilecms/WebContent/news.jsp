<%@ page import="java.io.*, conn.*"  %>
<%
String str = "print me";
//always give the path from root. This way it almost always works.
//String nameOfTextFile = "/home/apache-tomcat-5.5.23/webapps/content/sp/news.html";
String nameOfTextFile = Utils.getProperty("news.file.name");///home/apache-tomcat-5.5.23/webapps/content/sp/news.html";
try {   
    PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile));
    pw.println(str);
    //clean up
    pw.close();
} catch(IOException e) {
   out.println(e.getMessage());
}
%>