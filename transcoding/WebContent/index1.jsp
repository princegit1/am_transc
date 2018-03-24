<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 
<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
 String DB_URL = "jdbc:mysql://10.10.25.242:3306/itoday";

   //  Database credentials
 String USER = "itgd";
 String PASS = "itgd@nd@123";
   
  
   Connection conn = null;
   Statement stmt = null;
   try{
      //STEP 2: Register JDBC driver
      Class.forName("com.mysql.jdbc.Driver");

      //STEP 3: Open a connection
      System.out.println("Connecting to database...");
      conn = DriverManager.getConnection(DB_URL,USER,PASS);

      //STEP 4: Execute a query
      out.println("Creating statement...");
      stmt = conn.createStatement();
      String sql;
      sql = "SELECT id from jos_mtregular limit 1";
      ResultSet rs = stmt.executeQuery(sql);

      //STEP 5: Extract data from result set
      while(rs.next()){
         //Retrieve by column name
         int id  = rs.getInt("id");
         

         //Display values
           out.print("ID: " + id);
        
      }
      //STEP 6: Clean-up environment
      rs.close();
      stmt.close();
      conn.close();
  
   }catch(Exception e){
      //Handle errors for Class.forName
      e.printStackTrace();
   }finally{
      //finally block used to close resources
      try{
         if(stmt!=null)
            stmt.close();
      }catch(SQLException se2){
      }// nothing we can do
      try{
         if(conn!=null)
            conn.close();
      }catch(SQLException se){
         se.printStackTrace();
      }//end finally try
   }//end try
  out.println("Goodbye!");


%>
</body>
</html>