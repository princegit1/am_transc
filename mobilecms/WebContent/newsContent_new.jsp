<%@ page import="java.io.*"  %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*"%>
<%@ page import="java.util.Date" %>
<%@ page import ="java.text.SimpleDateFormat"%>
<%
	String firstname = (String)session.getAttribute("fname");
	String emp_Id = (String)session.getAttribute("empId");
	String xmlPath="/home/jboss-4.2.2.GA/server/default/deploy/content.war/xml/";	
	if(firstname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
	String[] cCodeArr = {"AP", "ASM", "BHR", "CHN", "DEL", "GUJ", "HRY", "HP", "JK", "KER", "KK", "KOL", "MP", "MAH", "MUM", "NE", "ORI", "PUN", "RAJ", "TN", "UPE", "UPW", "WB"};
	String[] cNameArr = {"AP", "ASSAM", "BIHAR", "CHENNAI", "DELHI", "Gujarat", "HARYANA", "HP", "Jammu Kashmir", "KERALA", "KK", "KOLKATA", "MP", "Maharastra", "Mumbai", "NORTHEAST", "ORISSA", "PUNJAB", "Rajasthan", "TN", "UP East", "UPW", "WESTBENGAL"};
	int myCount = 0;
	//AdminConn adminProp = AdminConn.getInstance();

  	String nameOfTextFile = "/home/jboss-4.2.2.GA/server/default/deploy/smscms.war/sp/news_new.html";//Utils.getValue("news.file.name");
  	out.println("File Location: "+nameOfTextFile);
	String newsStr	=	"";
	String str = "";
	PreparedStatement pstmt = null;
	Connection cn=null;

	try
	{
		PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile));

		String updateDate = request.getParameter("dates");
		for(int i=0; i<23; i++)
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
				response.sendRedirect("regional_news_new.jsp?msg="+msg);
			}
			myCount++;
			str = str+""+newsStr;
			if(i==22)
			{
				str= str+""+newsStr+"<br> Updated on "+updateDate;
			}
			Date dateNow = new Date ();      
      		SimpleDateFormat dateformatDDMMYYYY = new SimpleDateFormat("MMM dd KK:mm a");
      		StringBuilder nowDate = new StringBuilder( dateformatDDMMYYYY.format( dateNow ) );
			makeXmlFile(cCodeArr[i] + " News:"+news1.replaceAll("#",".").replaceAll("Pwrd by IndiaToday.in","")+"On "+nowDate,cCodeArr[i],xmlPath);
		}
		try
		{
			AdminConn adminConn = AdminConn.getInstance();
			cn = adminConn.getConnection();
			String sql1="insert into mobile_news_new (news,emp_id) values (?,?)";
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
		String msg = (myCount == 23) ? "News Inserted Successfully for All Circles" : "Try Again - News Not Inserted Successfully for Some Circles";
		pw.close();
		response.sendRedirect("regional_news_new.jsp?msg="+msg);
	}
	catch(IOException e)
	{
	   out.println(e.getMessage());
	}
%>
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
				//System.out.println("xml file name :::::" + fileName);
				//System.out.println("xml data :::::" + xmlData);
				FileOutputStream out = new FileOutputStream(xmllocalpath);
				out.write(xmlData.getBytes());
				out.close();

			} else {
				xmllocalpath = xmlPath + fileName + ".xml";
				//System.out.println("xml file path :::::" + xmllocalpath);
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