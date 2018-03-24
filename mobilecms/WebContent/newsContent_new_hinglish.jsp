<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%
	String firstname = (String)session.getAttribute("fname");
	String emp_Id = (String)session.getAttribute("empId");
	if(firstname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	//String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
	//String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "Jammu Kashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UP East", "UPW", "WESTBENGAL"};
String[] cCodeArr = {"UPW","UPE","ORI","BHR","RAJ","MP","GUJ","MUM","MAH", "HRY","PUN","DEL","KOL","JK"};
String[] cNameArr = {"UPW","UPE","ORISSA","BIHAR","Rajasthan","MP","Gujarat","Mumbai","Maharastra","HARYANA", "PUNJAB", "DELHI", "KOLKATA","Jammu Kashmir"};
	int myCount = 0;
	//AdminConn adminProp = AdminConn.getInstance();

  	String nameOfTextFile = "/home/jboss-4.2.2.GA/server/default/deploy/smscms.war/sp/news_new_hinglish.html";
  		//String nameOfTextFile = "C:\\jboss-4.2.2.GA\\server\\default\\deploy\\content1.war\\sp\\news_new_hinglish.html";
  	//Utils.getValue("news.file.name");
  	out.println("File Location: "+nameOfTextFile);
	String newsStr	=	"";
	String str = "";
	PreparedStatement pstmt = null;
	Connection cn=null;

	try
	{
		PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile));

		String updateDate = request.getParameter("dates");
		for(int i=0; i<14; i++)
		{
			String news1 =   request.getParameter("N1"+cCodeArr[i]);
			String circleCode =  request.getParameter("hidden"+cCodeArr[i]);
			newsStr = circleCode+ ":";
			if(news1.length()<1)
			{
				newsStr = newsStr+"<br><br>";
			}
			if(news1.length()>1)
			{
				newsStr	=	newsStr+""+news1+"<br><br>";
			}
			if(newsStr.length() > 320)
			{
				String msg = "ERROR: Total News Length for a circle > 310 - "+cCodeArr[i];
				response.sendRedirect("regional_news_new_hinglish.jsp?msg="+msg);
			}
			myCount++;
			str = str+""+newsStr;
			if(i==22)
			{
				str= str+""+newsStr+"<br> Updated on "+updateDate;
			}
		}
		try
		{
			AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();
			String sql1="insert into mobile_news_hinglish (news,emp_id) values (?,?)";
			out.println(str);
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
		String msg = (myCount == 14) ? "News Inserted Successfully for All Circles" : "Try Again - News Not Inserted Successfully for Some Circles";
		pw.close();
		response.sendRedirect("regional_news_new_hinglish.jsp?msg="+msg);
	}
	catch(IOException e)
	{
	   out.println(e.getMessage());
	}
%>