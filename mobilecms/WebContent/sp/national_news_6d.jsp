<%@ page contentType="text/xml;charset=ISO-8859-1"%><%@ page import="java.sql.*"%><%@ page import="conn.*" %><%Connection cn=null;
ResultSet rs = null,rs1=null;
Statement stmt = null,stmt1=null;
AdminConn adminConn = AdminConn.getInstance();
String upQuery="";
String headline_1="",headline_2="",headline_3="",headline_4="",headline_5="",date="",time="";		
try
{				
	upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%m%d%Y%T')record_date FROM national_news where date(run_date)=curDate() and category_id=63";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	if(rs.next()){
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%m%d%Y%T')record_date FROM national_news where date(run_date)=curDate() and category_id=63";
			
		}else{
			
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%m%d%Y%T')record_date FROM national_news where date(run_date)=date(curDate()-1) and category_id=63";
			
		}
		
		stmt1=cn.createStatement();
		rs1=stmt1.executeQuery(upQuery);
	if(rs1.next())
	{	
		date = rs1.getString("record_date");			
				
		if(rs1.getString("headline_1").length()>1)
		{
		headline_1="1."+rs1.getString("headline_1");
		}
		if((rs1.getString("headline_2")).length()>1){
		headline_2="2."+rs1.getString("headline_2");
		}
		if((rs1.getString("headline_3")).length()>1){
		String headline3=rs1.getString("headline_3");
		if(headline3.contains("Pwrd by IndiaToday.in"))
		{
		headline3=headline3.substring(0,headline3.indexOf("Pwrd by IndiaToday.in"));				
		}			
		headline_3="3."+rs1.getString("headline_3");						
		}					

	}
out.println("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>");
out.println("<DATA>");
out.println("<CONTENT>");
out.println("<![CDATA["+headline_1+headline_2+headline_3+"]]>");
out.println("</CONTENT>");
out.println("<DATE>"+date+"</DATE>");
out.println("<EXPDATE></EXPDATE>");
out.println("</DATA>");

}
catch(Exception e)
{
	e.printStackTrace();
	out.println("");
}
finally
{
	rs.close();
	stmt.close();
	cn.close();
}
%>
