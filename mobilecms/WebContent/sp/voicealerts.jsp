<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page language="java" import="java.util.*,java.text.*" pageEncoding="ISO-8859-1"%><%
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
}

if(category.substring(category.indexOf("-")+1,category.length()).equals("cg")){
path="chhattisgarh";
cat=category.substring(0,category.indexOf("-"));
}
String date="",month="";
 int iYear=nullIntconv(request.getParameter("iYear"));
 int iMonth=nullIntconv(request.getParameter("iMonth"));

 Calendar ca = new GregorianCalendar();
 int iTDay=ca.get(Calendar.DATE);
 int iTYear=ca.get(Calendar.YEAR);
 int iTMonth=ca.get(Calendar.MONTH);
 
 System.out.println("--->"+new SimpleDateFormat("dd").format(new Date(2008,iTDay,01)));

 if(iYear==0 && iTDay>20)
 {
      iYear=iTYear;
      iMonth=iTMonth+1;
 }else  if(iYear==0)
 {
      iYear=iTYear;
      iMonth=iTMonth;
 }
 iTMonth=4;
 GregorianCalendar cal = new GregorianCalendar (iYear, iMonth, 1); 

 int days=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
 int weekStartDay=cal.get(Calendar.DAY_OF_WEEK);
 
 cal = new GregorianCalendar (iYear, iMonth, days); 
 int iTotalweeks=cal.get(Calendar.WEEK_OF_MONTH);
  
 
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?><vap version=\"1.0\"><contentItem lang=\"en-in\">");

        int cnt =1;
        for(int i=1;i<=iTotalweeks;i++)
        {
        
            for(int j=1;j<=7;j++)
            {
                if(cnt<weekStartDay || (cnt-weekStartDay+1)>days)
                {
                
                }
                else
                {
                if((cnt-weekStartDay+1)>0 && (cnt-weekStartDay+1)<10){
  date="0"+(cnt-weekStartDay+1);
 }else{
 date=Integer.toString(cnt-weekStartDay+1);
 }
           
               
                out.println("<obdaudio keyword=\""+cat+"\" root=\"http://media1.intoday.in/mobile/"+cat+"/"+path+"/\">"+iYear+new SimpleDateFormat("MM").format(new Date(2008,iTMonth,01))+(date)+".wav</obdaudio>");
                
                }
                cnt++;
              }
           
        }
        
        out.println("</contentItem></vap>");
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
