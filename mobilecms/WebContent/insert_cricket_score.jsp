<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>

<%	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	
	
String series="";
String currentover="";
String status="";
String match="";
String currentscore="";
String totalover="";
String currentpartnership="";
String batteam="";
String bowlteam="";
String batsman_name1="";
String batsman_sname1="";
String batsman1_score="";
String bowler_name="";
String bowler_sname="";
String bowler_score="";
String top_batsman_name1="";
String top_batsman_sname1="";
String top_batsman1_score="";
String top_batsman_name2="";
String top_batsman_sname2="";
String top_batsman2_score="";
String top_bowler_name1="";
String top_bowler_sname1="";
String top_bowler1_score="";
String top_bowler_name2="";
String top_bowler_sname2="";
String top_bowler2_score="";
String last_batsman_name="";
String last_batsman_sname="";
String last_batsman_score="";
String last_batsman_status="";
String last_bowler_name="";
String last_bowler_sname="";
String filder_name="";
String crr="";
String rrr="";
String filder_sname="";
String batsman_name2="";
String batsman_sname2="";
String batsman2_score="";


if(request.getParameter("crr")!=null)	
crr=request.getParameter("crr");
if(request.getParameter("rrr")!=null)	
rrr=request.getParameter("rrr");


if(request.getParameter("batsman_name2")!=null)	
batsman_name2=request.getParameter("batsman_name2");
if(request.getParameter("batsman_sname2")!=null)	
batsman_sname2=request.getParameter("batsman_sname2");
if(request.getParameter("batsman2_score")!=null)	
batsman2_score=request.getParameter("batsman2_score");

if(request.getParameter("series")!=null)	
series=request.getParameter("series");
if(request.getParameter("currentover")!=null)	
currentover=request.getParameter("currentover");
if(request.getParameter("status")!=null)	
status=request.getParameter("status");
if(request.getParameter("match")!=null)	
match=request.getParameter("match");
if(request.getParameter("currentscore")!=null)	
currentscore=request.getParameter("currentscore");
if(request.getParameter("totalover")!=null)	
totalover=request.getParameter("totalover");
if(request.getParameter("currentpartnership")!=null)	
currentpartnership=request.getParameter("currentpartnership");
if(request.getParameter("batteam")!=null)	
batteam=request.getParameter("batteam");
if(request.getParameter("bowlteam")!=null)	
bowlteam=request.getParameter("bowlteam");
if(request.getParameter("batsman_name1")!=null)	
batsman_name1=request.getParameter("batsman_name1");
if(request.getParameter("batsman_sname1")!=null)	
batsman_sname1=request.getParameter("batsman_sname1");
if(request.getParameter("batsman1_score")!=null)	
batsman1_score=request.getParameter("batsman1_score");
if(request.getParameter("bowler_name")!=null)	
bowler_name=request.getParameter("bowler_name");
if(request.getParameter("bowler_sname")!=null)	
bowler_sname=request.getParameter("bowler_sname");
if(request.getParameter("bowler_score")!=null)	
bowler_score=request.getParameter("bowler_score");
if(request.getParameter("top_batsman_name1")!=null)	
top_batsman_name1=request.getParameter("top_batsman_name1");
if(request.getParameter("top_batsman_sname1")!=null)	
top_batsman_sname1=request.getParameter("top_batsman_sname1");
if(request.getParameter("top_batsman1_score")!=null)	
top_batsman1_score=request.getParameter("top_batsman1_score");
if(request.getParameter("top_batsman_name2")!=null)	
top_batsman_name2=request.getParameter("top_batsman_name2");
if(request.getParameter("top_batsman_sname2")!=null)	
top_batsman_sname2=request.getParameter("top_batsman_sname2");
if(request.getParameter("top_batsman2_score")!=null)	
top_batsman2_score=request.getParameter("top_batsman2_score");
if(request.getParameter("top_bowler_name1")!=null)	
top_bowler_name1=request.getParameter("top_bowler_name1");
if(request.getParameter("top_bowler_sname1")!=null)	
top_bowler_sname1=request.getParameter("top_bowler_sname1");
if(request.getParameter("top_bowler1_score")!=null)	
top_bowler1_score=request.getParameter("top_bowler1_score");
if(request.getParameter("top_bowler_name2")!=null)	
top_bowler_name2=request.getParameter("top_bowler_name2");
if(request.getParameter("top_bowler_sname2")!=null)	
top_bowler_sname2=request.getParameter("top_bowler_sname2");
if(request.getParameter("top_bowler2_score")!=null)	
top_bowler2_score=request.getParameter("top_bowler2_score");
if(request.getParameter("last_batsman_name")!=null)	
last_batsman_name=request.getParameter("last_batsman_name");
if(request.getParameter("last_batsman_sname")!=null)	
last_batsman_sname=request.getParameter("last_batsman_sname");
if(request.getParameter("last_batsman_score")!=null)	
last_batsman_score=request.getParameter("last_batsman_score");
if(request.getParameter("last_batsman_status")!=null)	
last_batsman_status=request.getParameter("last_batsman_status");
if(request.getParameter("last_bowler_name")!=null)	
last_bowler_name=request.getParameter("last_bowler_name");
if(request.getParameter("last_bowler_sname")!=null)	
last_bowler_sname=request.getParameter("last_bowler_sname");
if(request.getParameter("filder_name")!=null)	
filder_name=request.getParameter("filder_name");	
if(request.getParameter("filder_sname")!=null)	
filder_sname=request.getParameter("filder_sname");
	
try
{
					AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();	
						String sql="INSERT INTO cricket_score (`series`,`match`,`status`,`currentover`,`currentscore`,`totalover`,`currentpartnership`,`batteam`,`bowlteam`,`batsman_name1`,`batsman_sname1`,`batsman1_score`,`bowler_name`,`bowler_sname`,`bowler_score`,`top_batsman_name1`,`top_batsman_sname1`,`top_batsman1_score`,`top_batsman_name2`,`top_batsman_sname2`,`top_batsman2_score`,`top_bowler_name1`,`top_bowler_sname1`,`top_bowler1_score`,`top_bowler_name2`,`top_bowler_sname2`,`top_bowler2_score`,`last_batsman_name`,`last_batsman_sname`,`last_batsman_score`,`last_batsman_status`,`last_bowler_name`,`last_bowler_sname`,`filder_name`,crr,rrr,`batsman_name2`,`batsman_sname2`,`batsman2_score`,`filder_sname`) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						pstmt.setString(1,series);
pstmt.setString(2,match);
pstmt.setString(3,status);
pstmt.setString(4,currentover);
pstmt.setString(5,currentscore);
pstmt.setString(6,totalover);
pstmt.setString(7,currentpartnership);
pstmt.setString(8,batteam);
pstmt.setString(9,bowlteam);
pstmt.setString(10,batsman_name1);
pstmt.setString(11,batsman_sname1);
pstmt.setString(12,batsman1_score);
pstmt.setString(13,bowler_name);
pstmt.setString(14,bowler_sname);
pstmt.setString(15,bowler_score);
pstmt.setString(16,top_batsman_name1);
pstmt.setString(17,top_batsman_sname1);
pstmt.setString(18,top_batsman1_score);
pstmt.setString(19,top_batsman_name2);
pstmt.setString(20,top_batsman_sname2);
pstmt.setString(21,top_batsman2_score);
pstmt.setString(22,top_bowler_name1);
pstmt.setString(23,top_bowler_sname1);
pstmt.setString(24,top_bowler1_score);
pstmt.setString(25,top_bowler_name2);
pstmt.setString(26,top_bowler_sname2);
pstmt.setString(27,top_bowler2_score);
pstmt.setString(28,last_batsman_name);
pstmt.setString(29,last_batsman_sname);
pstmt.setString(30,last_batsman_score);
pstmt.setString(31,last_batsman_status);
pstmt.setString(32,last_bowler_name);
pstmt.setString(33,last_bowler_sname);
pstmt.setString(34,filder_name);
pstmt.setString(35,crr);
pstmt.setString(36,rrr);
pstmt.setString(37,top_batsman_name2);
pstmt.setString(38,top_batsman_sname2);
pstmt.setString(39,top_batsman2_score);
pstmt.setString(40,filder_sname);
						
						pstmt.executeUpdate();
						
					}
					
catch(Exception e)
{
	e.printStackTrace();
	System.out.println(e.toString());
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
