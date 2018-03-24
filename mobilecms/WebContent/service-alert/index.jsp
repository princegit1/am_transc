<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	ResultSet rs=null,rs1=null;
	Connection cn=null;
	Statement stmt=null,stmt1=null;
	String upQuery = "";
	String categoryType="";
	String serviceProvider="";
	int messageSize = 200;
	int i=1;
	int k=1;
	String option="";
	AdminConn adminConn = null;
%>
<!doctype html>
<html lang="en">
<head>
  
  <meta charset="utf-8" />
  <title>Elements Partial &middot; Isotope Demo</title>
  
  <!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
  
  <link rel="stylesheet" href="style.css" />
  
  <!-- scripts at bottom of page -->

</head>
<body >

  
  
   <!-- #site-nav -->
  
  <section id="content">
   




<div id="container" class="clickable clearfix">
  
        
        
        <%

 

	try
	{
	
	
	Calendar calendar = new GregorianCalendar();
        	String am_pm="";
			int am_pm_hour=0;
			int hour = 0;
			am_pm_hour=calendar.get( Calendar.AM_PM );			
			hour = calendar.get( Calendar.HOUR ); 			
        	int minute = calendar.get( Calendar.MINUTE );
        	
        	
        	
        	
        	if(am_pm_hour == 0 ){
            	am_pm = "AM";
            	
        	}            
        	else{
            	am_pm = "PM";
            	
        	}	
        	
        	// out.println("@@@@@@@@@@@"+hour+":"+minute+" "+am_pm);		
		//for(int a=0;circleId.length>0;a++){
		
		upQuery="SELECT md.msg_id,md.message1, DATE_FORMAT(md.RECORD_DATE,'%Y/%m/%d %H:%i') as date,DATE_FORMAT(md.RECORD_DATE,'%Y/%m/%d') as currdate,cm.category_type FROM message_details md, category_master cm WHERE cm.`SERVICE_PROVIDER`='CBC'  AND DATE(md.run_date)=CURDATE() AND md.category_id=cm.category_id  GROUP BY md.category_id ORDER BY md.msg_id";
		//System.out.println(upQuery);
		 adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		while(rs.next())
		{
		
	java.text.DateFormat formatter1 = new java.text.SimpleDateFormat("yyyy/MM/dd");	
			
		
		
		String dateString1 ="";
       //get current date time with Date()
              Date date1 = new Date();
       //System.out.println(formatter1.format(date1));
       //dateString1 = "2013/07/15";
       dateString1=rs.getString("currdate");
        //System.out.println("@@@@@@@@@"+dateString1);
		 // System.out.println("################");
		boolean isNow=dateString1.equals(formatter1.format(date1));
	if(isNow){
java.text.DateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");
String dateString = rs.getString("DATE") ;
//String dateString = "2013/07/15 15:34";
Date date = formatter.parse(dateString);
int comparison = date.compareTo(new Date());

//out.println("@@@@@@@@@@"+comparison);

//out.println("@@@@@@@@@@"+isNow);

//out.println("@@@@@@@@@@"+rs.getString("DATE"));

if(date.compareTo(new Date())>=0){

%>


 <div class="element transition metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}else{
	
%>


 <div class="element transition metal   " data-symbol="Hg" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}

}else{

%>


 <div class="element alkali metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%


}
}
//}
	}
	catch(Exception ee)
	{
		out.print("errr"+ee);
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
   
  
    
        
   
    
   
    
        
  
  
     
        <%

 upQuery=null;
adminConn =null;
cn=null;
stmt=null;
rs=null;
	try
	{
		//for(int a=0;circleId.length>0;a++){
		
		upQuery="SELECT b.category_type,a.message1,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d %H:%i') as date,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d') as currdate FROM message_details a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='AIRTEL' AND  STATUS='ACTIVE' AND b.category_type IN ('Hinglish-Cri-News','Hinglish-National-News','National-Hnglsh-Bngrno') GROUP BY a.category_id ORDER BY a.msg_id LIMIT 3";
		//System.out.println(upQuery);
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		while(rs.next())
		{
		
	java.text.DateFormat formatter1 = new java.text.SimpleDateFormat("yyyy/MM/dd");	
			
		
		
		String dateString1 ="";
       //get current date time with Date()
              Date date1 = new Date();
      // System.out.println(formatter1.format(date1));
       //dateString1 = "2013/07/15";
       dateString1=rs.getString("currdate");
        //System.out.println("@@@@@@@@@"+dateString1);
		 // System.out.println("################");
		boolean isNow=dateString1.equals(formatter1.format(date1));
	if(isNow){
java.text.DateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");
String dateString = rs.getString("DATE") ;
//String dateString = "2013/07/15 15:34";
Date date = formatter.parse(dateString);
int comparison = date.compareTo(new Date());

//out.println("@@@@@@@@@@"+comparison);

//out.println("@@@@@@@@@@"+isNow);

//out.println("@@@@@@@@@@"+rs.getString("DATE"));

if(date.compareTo(new Date())>=0){

%>


 <div class="element transition metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}else{
	
%>


 <div class="element transition metal   " data-symbol="Hg" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Last Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}

}else{

%>


 <div class="element alkali metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%


}
}
//}
	}
	catch(Exception ee)
	{
		out.print("errr"+ee);
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

  
     <%

 upQuery=null;
adminConn =null;
cn=null;
stmt=null;
rs=null;
	try
	{
		//for(int a=0;circleId.length>0;a++){
		
		upQuery="SELECT b.category_type,a.message1,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d %H:%i') as date,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d') as currdate FROM message_details a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='ITGD' AND  STATUS='ACTIVE' AND b.category_type in ('Delhi-News-Pack-Hinglish','upw-unicode-sms','Regional-Gujrati','Regional-Marathi') GROUP BY a.category_id ORDER BY a.msg_id LIMIT 4";
		//System.out.println(upQuery);
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		while(rs.next())
		{
		
	java.text.DateFormat formatter1 = new java.text.SimpleDateFormat("yyyy/MM/dd");	
			
		
		
		String dateString1 ="";
       //get current date time with Date()
              Date date1 = new Date();
       //System.out.println(formatter1.format(date1));
       //dateString1 = "2013/07/15";
       dateString1=rs.getString("currdate");
       // System.out.println("@@@@@@@@@"+dateString1);
		 // System.out.println("################");
		boolean isNow=dateString1.equals(formatter1.format(date1));
	if(isNow){
java.text.DateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");
String dateString = rs.getString("DATE") ;
//String dateString = "2013/07/15 15:34";
Date date = formatter.parse(dateString);
int comparison = date.compareTo(new Date());

//out.println("@@@@@@@@@@"+comparison);

//out.println("@@@@@@@@@@"+isNow);

//out.println("@@@@@@@@@@"+rs.getString("DATE"));

if(date.compareTo(new Date())>=0){

%>


 <div class="element transition metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}else{
	
%>


 <div class="element transition metal   " data-symbol="Hg" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}

}else{

%>


 <div class="element alkali metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%


}
}
//}
	}
	catch(Exception ee)
	{
		out.print("errr"+ee);
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
    
    

    
   <%

 upQuery=null;
adminConn =null;
cn=null;
stmt=null;
rs=null;
	try
	{
		//for(int a=0;circleId.length>0;a++){
		
		upQuery="SELECT b.category_type,a.message1,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d %H:%i') as date,DATE_FORMAT(a.RECORD_DATE,'%Y/%m/%d') as currdate FROM message_details a, category_master b WHERE a.category_id=b.category_id AND b.service_provider='ONMOBILE' AND  STATUS='ACTIVE' AND b.category_type in('onmobile-orissa-hindi','onmobile-kolkata-hindi') GROUP BY a.category_id ORDER BY a.msg_id LIMIT 2";
		//System.out.println(upQuery);
		adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		while(rs.next())
		{
		
	java.text.DateFormat formatter1 = new java.text.SimpleDateFormat("yyyy/MM/dd");	
			
		
		
		String dateString1 ="";
       //get current date time with Date()
              Date date1 = new Date();
       //System.out.println(formatter1.format(date1));
       //dateString1 = "2013/07/15";
       dateString1=rs.getString("currdate");
       // System.out.println("@@@@@@@@@"+dateString1);
		 // System.out.println("################");
		boolean isNow=dateString1.equals(formatter1.format(date1));
	if(isNow){
java.text.DateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");
String dateString = rs.getString("DATE") ;
//String dateString = "2013/07/15 15:34";
Date date = formatter.parse(dateString);
int comparison = date.compareTo(new Date());

//out.println("@@@@@@@@@@"+comparison);

//out.println("@@@@@@@@@@"+isNow);

//out.println("@@@@@@@@@@"+rs.getString("DATE"));

if(date.compareTo(new Date())>=0){

%>


 <div class="element transition metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}else{
	
%>


 <div class="element transition metal   " data-symbol="Hg" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%
}

}else{

%>


 <div class="element alkali metal   " data-symbol="Rb" data-category="transition">
      <h3 class="symbol"><%=rs.getString("category_type")  %></h3>
      <h2 class="name">Updated @ <%=rs.getString("DATE") %></h2>
     
    </div>

<%


}
}
	}
	catch(Exception ee)
	{
		out.print("errr"+ee);
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
    
        
    
    
        
  
</div>
    
   
    
  </section> <!-- #content -->
  

</body>
</html>