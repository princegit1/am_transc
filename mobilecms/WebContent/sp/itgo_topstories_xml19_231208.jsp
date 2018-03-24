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
String rssKickerImage = "";
int tableTag = 0;
int tableTag1 = 0;
String strToFind = "<table";
String strToFind1 = "<a ";
int ctr = 0;
int lastPtag = 0;
int strLength = 0;
String createdDate = "";

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
	st = con.prepareStatement("select c.id as art_id, c.title as art_title, c.fulltext as story, DATE_FORMAT(c.created,'%d-%m-%Y %H:%i:%s') as crdat, c.created, c.kicker_Image, c.kicker_image_width, c.kicker_image_height FROM itgo.jos_content as c, jos_article_section as s WHERE  s.section_id=9 AND c.state=1 AND c.id=s.article_id AND article_featured_page=-1 AND c.created > subdate(now(), INTERVAL 7 DAY) GROUP BY c.id ORDER BY s.ordering DESC ,c.id desc limit 50");
	//out.println(st);
	rs=st.executeQuery();
		
	while(rs.next())
	{

		rssHeadline = (rs.getString("art_title")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replace("{mosimage}"," ").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","").replaceAll("<br />","").replaceAll("<strong>","").replaceAll("</strong>","").replaceAll("<em>","").replaceAll("</em>","").replaceAll("<b>","").replaceAll("</b>","").replaceAll("<i>","").replaceAll("</i>","").replaceAll("&amp;nbsp;","").replaceAll("<p><p>","</p></p>");

		rssIntrotext = (rs.getString("art_id")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replace("{mosimage}"," ").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","").replaceAll("<br />","").replaceAll("<strong>","").replaceAll("</strong>","").replaceAll("<em>","").replaceAll("</em>","").replaceAll("<b>","").replaceAll("</b>","").replaceAll("<i>","").replaceAll("</i>","").replaceAll("&amp;nbsp;","").replaceAll("<p><p>","</p></p>");

		rssBodyText = (rs.getString("story")).replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replace("{mosimage}"," ").replaceAll("&amp;#39;","").replaceAll("&amp;quot;","").replaceAll("&amp;amp;","").replaceAll("<br />","").replaceAll("<strong>","").replaceAll("</strong>","").replaceAll("<em>","").replaceAll("</em>","").replaceAll("<b>","").replaceAll("</b>","").replaceAll("<i>","").replaceAll("</i>","").replaceAll("&amp;nbsp;","").replaceAll("<p><p>","<p>").replaceAll("</p></p>","</p>");
	
		strLength = rssBodyText.length();
		lastPtag = rssBodyText.lastIndexOf("</p>");

		if(lastPtag > 0)
		{
			rssBodyText = rssBodyText.substring(0,lastPtag);
			createdDate = rs.getString("crdat");
			rssBodyText = rssBodyText + " " + createdDate + "</p>";
		}
		else
		{
			createdDate = rs.getString("crdat");
			rssBodyText = rssBodyText + createdDate + "";
		}

		tableTag = rssBodyText.indexOf(strToFind);
		tableTag1 = rssBodyText.indexOf(strToFind1);

		if((tableTag == -1) && (tableTag1 == -1) && (ctr < 10))
		{
	%>
			<item>
				<title><%=rssHeadline%></title>
				<guid><%=rssIntrotext%></guid>
				<text><%=rssBodyText%>
				<%
						if(rs.getString("kicker_Image")!=null)
						{
						//	out.println("<img><screen>");
							//out.println("http://mediaservice.digitaltoday.in/itgo/images/stories/"+rs.getString("kicker_Image").replaceAll("&rsquo;", "\'").replaceAll("&lsquo;","\'").replaceAll("&nbsp;"," ").replaceAll("&mdash;"," ").replaceAll("&amp;#39;","").replaceAll("&ldquo;"," ").replaceAll("&rdquo;"," ").replace("&","&amp;").replaceAll("&amp;quot;","").replaceAll("&amp;amp;",""));
							//out.println("</screen></img>");
						}
					%>
					
				</text>
			</item>
<%
			ctr = ctr + 1;
		}
		if(ctr == 10)
			break;
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