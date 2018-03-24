<%
	//System.out.println("i");
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	int empId = Integer.parseInt((String)session.getAttribute("empId"));

%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="conn.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%
	int select_day = Integer.parseInt(request.getParameter("select_day"));
	int totalMsg = Integer.parseInt(request.getParameter("totalMsg"));
	int categoryId= Integer.parseInt(request.getParameter("categoryId"));
	String completeNews = "", newsOne = "", newsTwo = "", newsThree = "";
	String xmlData="";
	String fileName=request.getParameter("categoryId");
	//String xmlPath="C:\\jboss-4.2.2.GA\\server\\default\\deploy\\smscms.war\\xml\\";
	String xmlPath="/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/";
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
try
{ 
	String txtDate =  "";
	String txtNews =  "";
	for(int i=1;i<=select_day;i++)
	{
		txtDate = request.getParameter("txtDate"+i);
		for(int k=1;k<=totalMsg;k++)
		{
			txtNews = request.getParameter("txtNews-"+k+"-"+i);
				
			int lenNews = 0;
			try
			{
				lenNews = txtNews.length();
			}
			catch(NullPointerException nex)
			{
				lenNews =0;
			}
			//out.println("Length New " +lenNews);
			if(lenNews>10)
			{
			
				//AdminConn adminConn = AdminConn.getInstance();
			    Class.forName("com.mysql.jdbc.Driver").newInstance();
    			cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");

				//cn = adminConn.getConnection();
				String upQuery="select count(*) count from message_details_unicode where run_date='"+txtDate+"' and category_id="+categoryId;
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
						
						String sql="INSERT INTO message_details_unicode (CATEGORY_ID,MESSAGE"+k+",RUN_DATE,UPDATE_EMP_ID) VALUES (?,?,?,?)";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						pstmt.setInt(1,categoryId);
						//pstmt.setString(2,new String(new String(txtNews).getBytes("UTF-8")));
						pstmt.setString(2,txtNews);
						//pstmt.setString(2,new String(new String(txtNews).getBytes("ISO-8859-1"), "UTF-8"));

						pstmt.setString(3,txtDate);
						pstmt.setInt(4,empId);
						pstmt.executeUpdate();
						//cn.commit();
					}
					catch(Exception e)
					{
						out.println(e.toString());
					}
				}//end if
				else
				{
					
					try
					{
						String sql="UPDATE message_details_unicode set MESSAGE"+k+"=? , UPDATE_EMP_ID=?, update_date=now() where category_id=? and RUN_DATE=?";
						PreparedStatement pstmt = cn.prepareStatement(sql);
						pstmt.setString(1,txtNews);

						pstmt.setInt(2,empId);
						pstmt.setInt(3,categoryId);
						pstmt.setString(4,txtDate);
						pstmt.executeUpdate();
						//cn.commit();
					}
					catch(Exception ee)
					{
						out.println("Exception :- "+ee.toString());
					}
				}
			}//End if 
			
	if(categoryId==75|| categoryId==85){
	
	if(categoryId==75 || categoryId==85){
	if(txtNews.contains("Spo:")||txtNews.contains("Biz:")){
	completeNews = txtNews.substring(txtNews.indexOf(":")+1, txtNews.length()).trim();
	}else{
	completeNews=txtNews;
	}	
	newsOne = completeNews.substring(0, completeNews.indexOf("2#"));	
	if(newsOne.contains("1#")){
	newsOne=newsOne.replace("1#", "1.");
	}
	newsTwo = completeNews.substring(newsOne.length(),completeNews.indexOf("3#"));	
	if(newsTwo.contains("2#")){
	newsTwo=newsTwo.replace("2#", "2.");
	}
	newsThree = completeNews.substring(newsOne.length()+ newsTwo.length(), completeNews.length());	
	if(newsThree.contains("3#")){
	newsThree=newsThree.replace("3#", "3.");
	}
	if(newsThree.contains("Pwrd by IndiaToday.in")){
	newsThree=newsThree.substring(0,newsThree.indexOf("Pwrd by IndiaToday.in"));
	}
	xmlData=newsOne+"<BR>"+newsTwo+"<BR>"+newsThree;
	//makeXmlFile(xmlData,fileName,xmlPath);
	System.out.print(newsOne+"<BR>"+newsTwo+"<BR>"+newsThree+"");	
	}else{	
	//makeXmlFile(txtNews,fileName,xmlPath);
	}
	
	}	
		if(categoryId==206){
	//makeXmlFileForVodaFone();
	}	
		}
	}

}
catch(NullPointerException nex)
{
	out.println(nex.toString());
}
catch(Exception e)
{
	out.println(e.toString());
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
