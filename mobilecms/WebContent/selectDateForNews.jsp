<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<html>
	<head>
		<title>Select Date for news</title>
	    <LINK HREF="stylesheet.css" REL="stylesheet" TYPE="text/css">
		<script type="text/javascript" language="javascript" src="jscript/popcalendar.js"></script>
		<script language="javascript">
			function resetForm()
			{
				document.forms[0].fromDate.value = "";
				document.forms[0].toDate.value = "";
			}
		</script>
	</head>
	<body>
		<jsp:include page="topBand.jsp" />
		<center>
			<%
				String fromDate = (String)request.getParameter("fromDate");
				String toDate = (String)request.getParameter("toDate");
				String keyword = (String)request.getParameter("keyword");
				if(fromDate == null)
					fromDate = "";
				if(toDate == null)
					toDate = "";
				if(keyword == null)
					keyword = "";
				boolean isKeyword = keyword != null && keyword.length()>0;
			%>
			<form action="selectDateForNews.jsp" method="post">
				<TABLE WIDTH="50%" BORDER="0" CELLSPACING="0" CELLPADDING="3" ALIGN="CENTER" STYLE="border-collapse:collapse;" BORDERCOLOR="#ECECEC" CLASS="text1">
					<tr valign="middle">
						<td align="center">
							Keyword:
							&nbsp;<input type="text" name="keyword" size="30" value="<%=keyword%>"/>
						</td>
					</tr>
					<tr valign="middle">
						<td align="center">
							From:
							&nbsp;<input type="text" name="fromDate" size="10" readonly="readonly" value="<%=fromDate%>"/>
							&nbsp;<a href="javascript:showCalendar(document.forms[0], document.forms[0].fromDate, 'yyyy/mm/dd',null,0,400,180)"><img src="img/calendar.gif" border="0" align="top" height="23" width="22"></a>
							&nbsp;&nbsp;
							To:
							&nbsp;<input type="text" name="toDate" size="10" readonly="readonly" value="<%=toDate%>"/>
							&nbsp;<a href="javascript:showCalendar(document.forms[0], document.forms[0].toDate, 'yyyy/mm/dd',null,0,625,180)"><img src="img/calendar.gif" border="0" align="top" height="23" width="22"></a>
							&nbsp;&nbsp;<input type="button" name="resetButton" value="Clear" onclick="javascript:resetForm()"/>
							&nbsp;&nbsp;<input type="submit" name="goButton" value=" Submit "/>
						</td>
					</tr>
				</table>
			</form>
			<TABLE WIDTH="80%" BORDER="1" CELLSPACING="0" CELLPADDING="3" ALIGN="CENTER" STYLE="border-collapse:collapse;" BORDERCOLOR="#000000" CLASS="text1">
				<tr bgcolor="#ececec">
					<td width="17%"><b>Date & Time</b></td>
					<td><b>News</b></td>
					<td width="15%"><b>By</b></td>
				</tr>
				<%
					String upQuery = "select news_id,date_format(a.record_date,'%d-%m-%Y %r')record_date, fname, lname, news from mobile_news a, employee b where a.emp_id=b.emp_id";
					if(fromDate != null && fromDate.length()>0)
						upQuery += " and date_format(a.record_date,'%Y/%m/%d') >= '"+fromDate+"'";
					if(toDate != null  && toDate.length()>0)
						upQuery += " and date_format(a.record_date,'%Y/%m/%d') <= '"+toDate+"'";
					if(isKeyword)
						upQuery += " and news like '%"+keyword+"%'";
					upQuery += " order by a.record_date desc";

					Connection cn=null;
					ResultSet rs = null;
					Statement stmt = null;
					ResultSet rs1 = null;
					Statement stmt1 = null;
					AdminConn adminConn = AdminConn.getInstance();
					try
					{
						cn = adminConn.getConnection();	
						stmt=cn.createStatement();
						rs=stmt.executeQuery(upQuery);
						String news = "";
						String smlKeyword = keyword.toLowerCase();
						int endIndex = 75;
						while(rs.next())
						{
							news = rs.getString("news");
							if(isKeyword)
								endIndex = news.toLowerCase().indexOf(smlKeyword)+smlKeyword.length();
				%>
							<tr valign="top">
								<!-- <td><a href="showNews.jsp?newsId=<%=rs.getString("news_id")%>"><%=rs.getString("record_date")%></a></td> -->
								<td><b><%=rs.getString("record_date")%></b></td>
								<td><table width="100%" border="0"><tr><td>
										<%=news.substring(0,endIndex)+" . . . "%>
								</td></tr><tr><td align="right">
										<a href="showNews.jsp?newsId=<%=rs.getString("news_id")%>&keyword=<%= keyword %>">More &#187;</a> &nbsp;&nbsp;
								</td></tr></table></td>
								<td><%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
							</tr>			
				<%
						}
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
						if(rs1!=null)
							rs1.close();
						if(stmt1!=null)
							stmt1.close();
						if(cn!=null)
							cn.close();
					} 
				%>
			</table>
		</center>
	</body>
</html>