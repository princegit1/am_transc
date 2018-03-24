<?xml version="1.0" encoding="UTF-8"?>

<togoText version="1.0">

<%@ page contentType="text/xml;charset=ISO-8859-1" %>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
String rssBodyText = "";
String rssHeadline = "";
String rssIntrotext = "";
String rssSection = "";

int rssId;
Connection con = null;
String url = "jdbc:mysql://220.226.203.59:3306/";
String db = "itgo";
String driver = "com.mysql.jdbc.Driver";
String user = "moneytoday";
String pass = "vt13itgd";
PreparedStatement st = null;
ResultSet rs = null; 

try
{
	Class.forName(driver).newInstance();
    con = DriverManager.getConnection(url+db, user, pass);
%>
<%
	st = con.prepareStatement("select c.id as art_id, c.title as art_title, c.fulltext as story, DATE_FORMAT(c.created,'%d-%m-%Y %H:%i:%s') as crdat, c.created, c.kicker_Image, c.kicker_image_width, c.kicker_image_height FROM itgo.jos_content as c, jos_article_section as s WHERE  s.section_id=9 AND c.state=1 AND c.id=s.article_id AND article_featured_page=-1 AND c.created > subdate(now(), INTERVAL 7 DAY) GROUP BY c.id ORDER BY s.ordering DESC ,c.id desc limit 10");
	//out.println(st);
	rs=st.executeQuery();
			
	while(rs.next())
	{
		rssHeadline = (rs.getString("art_title")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","");

		rssIntrotext = (rs.getString("art_id")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","");

		rssBodyText = (rs.getString("story")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replace("{mosimage}"," ").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","");
	%>
		<item>
			<title><%=rssHeadline%></title>
			<guid><%=rssIntrotext%></guid>
			<text><p><%=rssBodyText%>
			<%=rs.getString("crdat")%>
			<%
					if(rs.getString("kicker_Image")!=null)
					{
						out.println("<img>");
						out.println("http://mediaservice.digitaltoday.in/itgo/images/stories/"+rs.getString("kicker_Image").replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&amp;#39;","").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","")+" <Width>" +rs.getInt("kicker_image_width") +" </Width><Height> " +rs.getInt("kicker_image_height")+"</Height>");
						out.println("</img>");
					}
					 
				%>
				</p>
			</text>
		</item>
<%
	}	
}
catch(NullPointerException nex)
{
	out.println("zz"+nex.toString());
}
catch(Exception e)
{
	out.println(e.toString());
}
finally
{
	if(rs!=null)
		rs.close();
	if(st!=null)
		st.close();
	if(con!=null)
	con.close();
}
%>
</togoText>