<%
	String firstname = (String)session.getAttribute("fname");
	String emp_Id = (String)session.getAttribute("empId");
	if(firstname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%
	String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
	String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "Jammu Kashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UP East", "UPW", "WESTBENGAL"};

	int myCount = 0;
	//String nameOfTextFile = "/home/apache-tomcat-5.5.23/webapps/content/sp/news.html";
  String nameOfTextFile = Utils.getProperty("news.file.name");
	//String nameOfTextFile = "c:\\news.html";
	String newsStr	=	"";
	String str = "";
	PreparedStatement pstmt = null;
	Connection cn=null;
%>
<%
try 
{  
	PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile));

	for(int i=0; i<23; i++)
	{
		String news1 =   request.getParameter("N1"+cCodeArr[i]);
		String circleCode =  request.getParameter("hidden"+cCodeArr[i]);
		newsStr = circleCode+ "#";
		if(news1.length()<1)
		{
			newsStr = newsStr+"$";
		}
		if(news1.length()>1)
		{
			newsStr	=	newsStr+""+news1+"$";
		}
		if(newsStr.length() > 320)
		{
			String msg = "ERROR: Total News Length for a circle > 310 - "+cCodeArr[i];
			response.sendRedirect("regional_news.jsp?msg="+msg);
		}
		myCount++;
		//pw.println(newsStr);
		str = str+""+newsStr;
	}

	try
		{
			AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();
			String sql1="insert into mobile_news (news,emp_id) values (?,?)";
			pstmt = cn.prepareStatement(sql1);
			pstmt.setString(1,str);
			pstmt.setString(2,emp_Id);
			pstmt.executeUpdate();
			//cn.commit();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
		finally
		{
			if(pstmt!=null)
				pstmt.close();
			if(cn!=null)
				cn.close();
		}

	pw.println(str);
	String msg = (myCount == 23 ) ? "News Inserted Successfully for All Circles" : "Try Again - News Not Inserted Successfully for Some Circles";
	pw.close();

	response.sendRedirect("regional_news.jsp?msg="+msg);
} 
catch(IOException e) 
{
   out.println(e.getMessage());
}
%>