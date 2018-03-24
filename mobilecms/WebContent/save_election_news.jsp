<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>

<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;

try
{
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String headline1 =  request.getParameter("hdln1");
	String kicker1 = request.getParameter("kkr1");
	String headline2 =  request.getParameter("hdln2");
	String kicker2 = request.getParameter("kkr2");
	String headline3 =  request.getParameter("hdln3");
	String kicker3 = request.getParameter("kkr3");
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);
    //out.println("Current Date Time : " + datetime);


try{
			
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();
				String upQuery="select count(*) count from national_news where date(run_date)=curdate() and category_id=98";
				//out.println("DATES"+txtDate);
				//out.println(upQuery);
				stmt=cn.createStatement();
				rs=stmt.executeQuery(upQuery);
				int count = 0;
				if(rs.next())
				{
					count = rs.getInt("count");
				}

				if(count<=0)
				{
					try
					{
						String sql="INSERT INTO national_news (category_id,headline_1,more_1,headline_2,more_2,headline_3,more_3, run_date,update_date,emp_id) VALUES (?,?,?,?,?,?,?,?,?,?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						//out.println(sql);
						pstmt.setInt(1,98);
						pstmt.setString(2,headline1);
						pstmt.setString(3,kicker1);
						pstmt.setString(4,headline2);
						pstmt.setString(5,kicker2);
						pstmt.setString(6,headline3);
						pstmt.setString(7,kicker3);
						pstmt.setString(8,datetime);
						pstmt.setString(9,datetime);
						pstmt.setInt(10,empId);
						pstmt.executeUpdate();
						
						cn.commit();
					}
					catch(Exception e)
					{
						out.println(e.toString());
					}
				}//end if
				else
				{
					String sql="UPDATE national_news set headline_1=? , more_1=? ,headline_2=? , more_2=? ,headline_3=? , more_3=? , emp_id=? , update_date=now()  where run_date=? and category_id=98";
					PreparedStatement pstmt = cn.prepareStatement(sql);
					
					pstmt.setString(1,headline1);
					pstmt.setString(2,kicker1);
					pstmt.setString(3,headline2);
					pstmt.setString(4,kicker2);
					pstmt.setString(5,headline3);
					pstmt.setString(6,kicker3);
					pstmt.setInt(7,empId);
					pstmt.setString(8,datetime);
					pstmt.executeUpdate();
					//out.println(sql);
					cn.commit();
					
				}
			}
catch (Exception nn)
	{
	out.println(nn.toString());
	}
		}
	


catch(NullPointerException nex)
{
	out.println(nex.toString());
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


<HTML><HEAD><TITLE>Mobile Service</TITLE>
</HEAD>
<HEAD>

</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1 hspace="5" 
vspace="5">
  <TBODY>
    <TD align=center>
		Successfully inserted.<br><br>
		</td>
	</tr>
	</table>
	
</BODY>
</HTML>
