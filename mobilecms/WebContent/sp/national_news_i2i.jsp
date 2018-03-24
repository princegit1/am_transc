<%@ page import="java.sql.*"%><%@ page import="conn.*" %><%Connection cn=null;
ResultSet rs = null,rs1=null;
Statement stmt = null,stmt1=null;
AdminConn adminConn = AdminConn.getInstance();
String upQuery="";
String headline_1="",headline_2="",headline_3="",headline_4="",headline_5="",date="",time="";		
try
{				
	upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d-%M-%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate() and category_id=63";
	cn = adminConn.getConnection();
	stmt=cn.createStatement();
	rs=stmt.executeQuery(upQuery);
	if(rs.next()){
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d-%M-%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=curDate() and category_id=63";
			
		}else{
			
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,date_format(update_date,'%d-%M-%Y')record_date,time_format(update_date,'%r ')record_time FROM national_news where date(run_date)=date(curDate()-1) and category_id=63";
			
		}
		
		stmt1=cn.createStatement();
		rs1=stmt1.executeQuery(upQuery);
	if(rs1.next())
	{	
		date = rs1.getString("record_date");				
		time = rs1.getString("record_time");			
		if(rs1.getString("headline_1").length()>1){out.print("1-" + rs1.getString("headline_1")+ "<br/>" );}					
				
				if((rs1.getString("headline_2")).length()>1){out.print("2-" + rs1.getString("headline_2")+ "<br/>"  );}				

				if((rs1.getString("headline_3")).length()>1){
				
				String headline3=rs1.getString("headline_3");
				if(headline3.contains("Pwrd by IndiaToday.in"))
				{
				headline3=headline3.substring(0,headline3.indexOf("Pwrd by IndiaToday.in"));				
				}
				out.print("3-" + headline3+ "<br/>"  );							
				}		
				
				

	}

	

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
