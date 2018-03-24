<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*,conn.*"%><%@ page language="java" import="java.util.*,java.text.*" pageEncoding="ISO-8859-1"%><%
ResultSet rs=null;
Connection cn=null;
Statement stmt=null;
String fileName=""; 
String folderName=""; 
int categoryId=0;      
String path="";
String cat="";
String category=request.getParameter("category");
String[] categoryArr = {"beautytips-en","beautytips-hi","wordoftheday-en","wordoftheday-hi","automobiletips-en","automobiletips-hi","generalknowledge-en","generalknowledge-hi","traveltips-en","traveltips-hi","lifestylealerts-en","lifestylealerts-hi","regional-mp","regional-cg" };

if(category.substring(category.indexOf("-")+1,category.length()).equals("en")){
path="english";
cat=category.substring(0,category.indexOf("-"));
}if(category.substring(category.indexOf("-")+1,category.length()).equals("hi")){
path="hindi";
cat=category.substring(0,category.indexOf("-"));
}
if(category.substring(category.indexOf("-")+1,category.length()).equals("mp")){
path="mp";
cat=category.substring(0,category.indexOf("-"));
folderName="mp";
categoryId=259;
}

if(category.substring(category.indexOf("-")+1,category.length()).equals("cg")){
path="chhattisgarh";
cat=category.substring(0,category.indexOf("-"));
folderName="cg";
categoryId=260;
}

 DateFormat dateFormat = new SimpleDateFormat("ddMMyyyy");
 java.util.Date date1 = new java.util.Date();
 String  date_created = dateFormat.format(date1).toString();
 
 if(category.substring(category.indexOf("-")+1,category.length()).equals("mp")|| category.substring(category.indexOf("-")+1,category.length()).equals("cg")){
 
 
 
 try
{	
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String selectQuery="select nn.pic_1 from mobile_rss_news nn  where nn.msg_id=(select max(msg_id) from mobile_rss_news where category_id='"+categoryId+"')";
	stmt=cn.createStatement();
	System.out.println("---->"+selectQuery);
	rs=stmt.executeQuery(selectQuery);	
	
	while(rs.next()){
	
	  out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?><vap version=\"1.0\"><contentItem lang=\"en-in\" useOn=\""+date_created+"\" expires=\""+date_created+"\">");
        out.println("<obdaudio root=\"http://media1.intoday.in/mobile/"+cat+"/"+path+"/\">"+rs.getString("pic_1")+"</obdaudio>");        
        out.println("</contentItem></vap>");
	
	}
	
	
	}
catch(Exception e)
{
System.out.print(e.toString());
}
finally
{
	rs = null;
	stmt = null;
	cn=null;
}
        
 
 
 }else{
String date="",month="";
 int iYear=nullIntconv(request.getParameter("iYear"));
 int iMonth=nullIntconv(request.getParameter("iMonth"));

 Calendar ca = new GregorianCalendar();
 int iTDay=ca.get(Calendar.DATE);
 int iTYear=ca.get(Calendar.YEAR);
 int iTMonth=ca.get(Calendar.MONTH);
 
 


 
 
 fileName=date_created+"-2" ;
  Calendar calendar = new GregorianCalendar();
        String am_pm;
        int hour = calendar.get( Calendar.HOUR );
        int minute = calendar.get( Calendar.MINUTE );
        if( calendar.get( Calendar.AM_PM ) == 0 ){
            am_pm = "AM";
            if(hour >=10)
               fileName=date_created+"-1" ;
        }            
        else{
            am_pm = "PM";
            if(hour<5)
                fileName=date_created+"-1" ;
        }
 
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?><vap version=\"1.0\"><contentItem lang=\"en-in\" useOn=\""+date_created+"\" expires=\""+date_created+"\">");
        out.println("<obdaudio root=\"http://media1.intoday.in/mobile/"+cat+"/"+path+"/\">"+folderName+fileName+".wav</obdaudio>");        
        out.println("</contentItem></vap>");
        
        }
        
        %>
     
<%!
public int nullIntconv(String inv)
{   
    int conv=0;
        
    try{
        conv=Integer.parseInt(inv);
    }
    catch(Exception e)
    {}
    return conv;
}
%>
