<%@ page import="java.sql.*,java.util.*,java.util.Date,conn.*"%><%
	Connection cn=null;
	ResultSet rs = null,rs1=null;
	Statement stmt = null,stmt1=null;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
try
		{	
		upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,update_date as date FROM national_news where date(run_date)=curDate() and category_id=63";
		cn = adminConn.getConnection();
		stmt1=cn.createStatement();
		rs1=stmt1.executeQuery(upQuery);

		if(rs1.next()){
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,update_date as date FROM national_news where date(run_date)=curDate() and category_id=63";
			
		}else{
			
			
			upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,update_date as date FROM national_news where date(run_date)=date(curdate()-1) and category_id=63";
			
		}
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
		if(rs.next())
			{
				out.print("News<br/>"  );
				if(rs.getString("headline_1").length()>1){out.print("1-" + rs.getString("headline_1")+ "<br/>" );}					
				
				if((rs.getString("headline_2")).length()>1){out.print("2-" + rs.getString("headline_2")+ "<br/>"  );}				

				if((rs.getString("headline_3")).length()>1){
				
				String headline3=rs.getString("headline_3");
				if(headline3.contains("Pwrd by IndiaToday.in"))
				{
				headline3=headline3.substring(0,headline3.indexOf("Pwrd by IndiaToday.in"));				
				}
				out.print("3-" + headline3+ "<br/>"  );
				out.print("Pwrd by IndiaToday.in<br/>"  );				
				}
				
				if((rs.getString("headline_4")).length()>1){out.print("4-" + rs.getString("headline_4")+ "<br/><br/>"  );}
				
				if((rs.getString("headline_5")).length()>1){out.print("5-" + rs.getString("headline_5")+ "<br/><br/>"  );}
				
				if((rs.getString("date")).length()>1){out.print("updated at: " + rs.getString("date")+ "<br/><br/>");}
			}
				else
				{

					out.print("No Message..");
	
				}
			}
		catch(Exception e)
		{
			System.out.print(e.toString());
		}
		finally
		{
			rs.close();
			stmt.close();
			cn.close();
		}
%>