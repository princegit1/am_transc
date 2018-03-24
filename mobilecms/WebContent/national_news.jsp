<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	AdminConn adminConn = AdminConn.getInstance();
	String upQuery="";
	
		
try
		{	
			
		upQuery="SELECT headline_1,more_1,headline_2,more_2,headline_3,more_3,headline_4,more_4,headline_5,more_5,update_date as date FROM national_news where date(run_date)=curDate()";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
			if(rs.next())
			{
				
				if(rs.getString("headline_1").length()>1)
				{
					out.println("Headline 1: " + rs.getString("headline_1") );	
				}
				if((rs.getString("more_1")).length()>1) 
				{
					out.println("&nbsp; Kicker 1: " + rs.getString("more_1")+ "<br/><br/>");
				}
				
				
				if((rs.getString("headline_2")).length()>1){out.println("Headline 2: " + rs.getString("headline_2") );}
				if((rs.getString("more_2")).length()>1) {out.println("&nbsp; Kicker 2: " + rs.getString("more_2")+ "<br/><br/>");}

				if((rs.getString("headline_3")).length()>1){out.println("Headline 3: " + rs.getString("headline_3") );}
				if((rs.getString("more_3")).length()>1){out.println("&nbsp; Kicker 3: " + rs.getString("more_3")+ "<br/><br/>");}
				if((rs.getString("headline_4")).length()>1){out.println("Headline 4: " + rs.getString("headline_4") );}
				if((rs.getString("more_4")).length()>1){out.println("&nbsp; Kicker 4: " + rs.getString("more_4")+ "<br/><br/>");}
				if((rs.getString("headline_5")).length()>1){out.println("Headline 5: " + rs.getString("headline_5") );}
				if((rs.getString("more_5")).length()>1){out.println("&nbsp; Kicker 5: " + rs.getString("more_5")+ "<br/><br/><br><br>");}
				if((rs.getString("date")).length()>1){out.println("&nbsp; updated at: " + rs.getString("date")+ "<br/><br/>");}
			}
				else
				{
%>
					No Message..
<%	
				}
			}
			
	
		
		catch(Exception e)
		{
			out.println(e.toString());
		}
		finally
		{
			rs.close();
			stmt.close();
			cn.close();
		}
	

%>