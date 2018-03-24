<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="conn.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String fileName="378";
	String xmlPath="/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/";

try
{
	int empId = Integer.parseInt((String)session.getAttribute("empId"));
	String headline1 =  request.getParameter("hdln1");
	String kicker1 = request.getParameter("kkr1");
	String headline2 =  request.getParameter("hdln2");
	String kicker2 = request.getParameter("kkr2");
	String headline3 =  request.getParameter("hdln3");
	String kicker3 = request.getParameter("kkr3");
	String headline4 =  request.getParameter("hdln4");
	String kicker4 = request.getParameter("kkr4");
	String headline5 =  request.getParameter("hdln5");
	String kicker5 = request.getParameter("kkr5");
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date date = new java.util.Date();
    String datetime = dateFormat.format(date);
    //out.println("Current Date Time : " + datetime);


try{
			
				AdminConn adminConn = AdminConn.getInstance();
				cn = adminConn.getConnection();
				String upQuery="select count(*) count from national_news where date(run_date)=curdate() and category_id=378";
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
						String sql="INSERT INTO national_news (category_id,headline_1,more_1,headline_2,more_2,headline_3,more_3,headline_4,more_4,headline_5,more_5, run_date,update_date,emp_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						//out.println(sql);
						pstmt.setInt(1,378);
						pstmt.setString(2,headline1);
						pstmt.setString(3,kicker1);
						pstmt.setString(4,headline2);
						pstmt.setString(5,kicker2);
						pstmt.setString(6,headline3);
						pstmt.setString(7,kicker3);
						pstmt.setString(8,headline4);
						pstmt.setString(9,kicker4);
						pstmt.setString(10,headline5);
						pstmt.setString(11,kicker5);
						pstmt.setString(12,datetime);
						pstmt.setString(13,datetime);
						pstmt.setInt(14,empId);
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
					String sql="UPDATE national_news set headline_1=? , more_1=? ,headline_2=? , more_2=? ,headline_3=? , more_3=? , headline_4=? , more_4=? ,headline_5=? , more_5=? , emp_id=? , update_date=now()  where run_date=? and category_id=378";
					PreparedStatement pstmt = cn.prepareStatement(sql);
					
					pstmt.setString(1,headline1);
					pstmt.setString(2,kicker1);
					pstmt.setString(3,headline2);
					pstmt.setString(4,kicker2);
					pstmt.setString(5,headline3);
					pstmt.setString(6,kicker3);
					pstmt.setString(7,headline4);
					pstmt.setString(8,kicker4);
					pstmt.setString(9,headline5);
					pstmt.setString(10,kicker5);
					pstmt.setInt(11,empId);
					pstmt.setString(12,datetime);
					pstmt.executeUpdate();
					//out.println(sql);
					cn.commit();
					
				}
			String message="1."+headline1+"2."+headline2+"3."+headline3;	
			makeXmlFile(message,fileName,xmlPath);	
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
<%!
public void makeXmlFile(String xmlData, String fileName, String xmlPath) {
		ArrayList ar = null;

		try {
			String xmllocalpath = "";
			File sourceFile = new File(xmlPath);
			if (sourceFile.exists()) {
				File file = (new File(xmlPath));

				fileName = fileName.replaceAll("%20", "").replaceAll(":", "");
			
				xmllocalpath = xmlPath + fileName + ".xml";// reviews.xml";
				//xmllocalpath = xmlPath + fileName;// reviews.xml";
				System.out.println("xml file name :::::" + fileName);
				System.out.println("xml data :::::" + xmlData);
				FileOutputStream out = new FileOutputStream(xmllocalpath);
				out.write(xmlData.getBytes());
				out.close();

			} else {
				xmllocalpath = xmlPath + fileName + ".xml";
				System.out.println("xml file path :::::" + xmllocalpath);
				FileOutputStream fos1 = new FileOutputStream(xmllocalpath);
				fos1.write(xmlData.getBytes());
				fos1.flush();
				fos1.close();

			}
		} catch (IOException ioe) {
			ioe.printStackTrace();
			
		}

	}
	
 %>

