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
		upQuery="SELECT headline_1,headline_2,headline_3,headline_4,headline_5,update_date as date FROM national_news where date(run_date)=curDate()";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery);
			if(rs.next())
			{
				if(rs.getString("headline_1").length()>1){out.println("1: "+rs.getString("headline_1")+ "<br/><br/>" );	}
				if((rs.getString("headline_2")).length()>1){out.println("2: "+rs.getString("headline_2") + "<br/><br/>");}
				if((rs.getString("headline_3")).length()>1){out.println("3: "+rs.getString("headline_3")+ "<br/><br/>" );}
				if((rs.getString("headline_4")).length()>1){out.println("4: "+rs.getString("headline_4")+ "<br/><br/>" );}
				if((rs.getString("headline_5")).length()>1){out.println("5: "+rs.getString("headline_5")+ "<br/><br/>" );}
				if((rs.getString("date")).length()>1){out.println("updated at: " + rs.getString("date")+ "<br/><br/>");}
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