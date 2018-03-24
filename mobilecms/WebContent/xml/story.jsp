<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>
<%@ page language="java" import="java.util.*,com.itgd.dto.*,com.itgd.content.story.*,com.itgd.helper.*,com.itgd.utils.*"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.itgd.conn.Dbconnection"%>
<%
String path = request.getContextPath();

String baseUrl = request.getRequestURL().substring(0,request.getRequestURL().indexOf(request.getServletPath()))+"/";

%>

 <%
   
   		String sId = session.getAttribute("artId").toString();
		
		String cacheURL = Constants.cacheURL+"/specials/asiacup2010/Story/"+sId;
		session.setAttribute("storyId",sId);

		String pathwayCatIds[]=new String[4];
String pathwayCatNames[]=new String[4];
String sectionLink = "";

		
		Connection conn3 = null;
		Statement stmt3 = null;
		ResultSet rs3= null;
		String title = "";
		String fulltext = "";
		String sefurl = "";
		String byline = "";
		String city = "";
		String dateline = "";
		String metaDesc = "";
		String metaKeywords = "";
		String introText = "";
		String catname = "";
		String Imagepath = "";
		int syndicate = 0;
		String syndicateDate = "";
		String syndicateByline = "";
		String syndicateTitle = "";
		int catid = 0;
		String primaryCatName = "";
		int primaryCatId = 0;
		String staticImgPath = "http://media2.intoday.in/indiatoday/static/common/";
		String primaryCategory = "";
		ArrayList RELATED = new ArrayList();
	    ArrayList pathWay = new ArrayList();	    
	    ArrayList COMMENT = new ArrayList();
String storyPrimaryCatId = "4";		
		try {

							Dbconnection connect = null;
							String sql = "SELECT a.sef_url,a.images as imagepath,a.title,a.introtext,a.fulltext,a.strap_headline,a.metadesc,a.metakey,a.title_alias,a.story_syndication,a.byline,a.city,a.courtesy,date_format( a.created,'%M %e, %Y' ) AS crt,date_format( a.created,'%Y-%m-%e' ) AS snd,s.name as catname,s.id as catid, a.primary_category FROM jos_content  a,jos_sections s,jos_article_section js  WHERE a.id ='"	+ sId + "' and js.article_id=a.id and s.id=js.section_id";
					
							connect = Dbconnection.getInstance();
							conn3 = connect.getConnection();
							stmt3 = conn3.createStatement();
							rs3 = stmt3.executeQuery(sql);
							// System.out.println(sql);
							if (rs3.next()) {
							
							title = rs3.getString("title");
							fulltext = rs3.getString("fulltext");
							sefurl = rs3.getString("sef_url");
							byline = rs3.getString("byline");
							city = rs3.getString("city");
							dateline = rs3.getString("crt");
							catname = rs3.getString("catname");
							catid = rs3.getInt("catid");
							primaryCategory = rs3.getString("primary_category");
							Imagepath = rs3.getString("imagepath");
							syndicate = rs3.getInt("story_syndication");
							syndicateDate = rs3.getString("snd");
							syndicateByline = byline.replace(" ","+");
							syndicateTitle = sefurl.replace(".html","");
							storyPrimaryCatId = rs3.getString("primary_category"); 
							metaDesc= rs3.getString("metadesc"); 
							metaKeywords= rs3.getString("metakey"); 
							introText= rs3.getString("introtext"); 

							
							if(primaryCategory.length() == 0 ){
	        				primaryCategory="0";}
	        				else {primaryCategory = primaryCategory;}
							
							}
							rs3.close();
							stmt3.close();
							conn3.close();
						} catch (Exception e) {
							System.out.println("Exception is ;" + e);
						}
						
		try {
		    RELATED = CommonFunctions.relatedContent(sId);
	      }catch(Exception e){
	    	  	e.printStackTrace();
			    request.setAttribute("ERROR", path);			   
	            ForwardPage.forwardRequestToPage("error.jsp", request, response);
	            return ;
	      }

	      try {
	    	  pathWay = CommonFunctions.pathway(primaryCategory);
		  }catch(Exception e){
			  	e.printStackTrace();
			    request.setAttribute("ERROR", path);			   
	            ForwardPage.forwardRequestToPage("error.jsp", request, response);
	            return ;
		  }
   	
    %>
    
 
 <%
int check = 0;
String body ="";
int checkPagebreak =0;

	
		String storyFullBody = fulltext;
		int checkimage = 0;
		String ab = Imagepath;
		if(ab.equals(""))
		{
			checkimage = 1;
		}
		if(checkimage != 1){
			body = StoryFunction.mosimageToimages(fulltext, Imagepath);
		} else {
			body = fulltext;
		}
		if(body.contains("mospagebreak"))
		{
			checkPagebreak = 1;
		}
	

//Singleview of story. 0 means single view
String sCompleteView = request.getParameter("complete");
int iCompleteView = 0;
if(sCompleteView == null) {
	iCompleteView = 0;
} else {
	iCompleteView = Integer.parseInt(sCompleteView);
}

%>
<cache:cache key="<%=cacheURL%>" scope="application" time="0" refresh="t">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <base href="<%=baseUrl%>"/>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 
<title><%=title %>:Asia Cup 2010 in Sri Lanka - India Today's Special Coverage</title>
<meta name="description" content="<%=introText.replace("<ul>","").replace("</ul>" , "").replace("<li>","").replace("</li>" , "").replace("<" , "").replace(">" , "")%><%=metaDesc.replace("<ul>","").replace("</ul>" , "").replace("<li>","").replace("</li>" , "").replace("<" , "").replace(">" , "")%>"  />

<meta name="keywords" content="<%=metaKeywords.replace("<ul>","").replace("</ul>" , "").replace("<li>","").replace("</li>" , "").replace("<" , "").replace(">" , "")%>" />


<script type="text/javascript" src="http://indiatoday.intoday.in/site/specials/asiacup2010/menu.js"/></script>
<script type="text/javascript" src="http://indiatoday.intoday.in/site/specials/asiacup2010/asiacup2010.js"/></script>
<link href="specials/asiacup2010/asiacup2010.css" rel="stylesheet" type="text/css">
<script>
function ajaxinclude(url) {
var page_request = false
if (window.XMLHttpRequest) // if Mozilla, Safari etc
page_request = new XMLHttpRequest()
else if (window.ActiveXObject){ // if IE
try {
page_request = new ActiveXObject("Msxml2.XMLHTTP")
} 
catch (e){
try{
page_request = new ActiveXObject("Microsoft.XMLHTTP")
}
catch (e){}
}
}
else
return false
page_request.open('GET', url, false) //get page synchronously 
page_request.send(null)
writecontent(page_request)
}
</script>
  </head>
  
<body>
  <table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff">
   <tr>
 <td valign="top">
<%@include file="topnav.html"%>
</td>
    </tr>
    </table>
  <table width="1003" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff">
  <tr>
    <td><table width="1003" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="682" align="left" valign="top"><table width="682" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"  colspan="2" width="682">
      
      <%
      if (pathWay != null && pathWay.size() > 0) {
//Sanjay 140210 from
			for (int pw = 0; pw < pathWay.size(); pw++) {
				PathwayBean pathWayBean1 = (PathwayBean) pathWay.get(pw);
				pathwayCatIds[0] = ""+pathWayBean1.getSec1Id();
				pathwayCatNames[0] = pathWayBean1.getSec1Title();
				pathwayCatIds[1] = ""+pathWayBean1.getSec2Id();
				pathwayCatNames[1] = pathWayBean1.getSec2Title();
				pathwayCatIds[2] = ""+pathWayBean1.getSec3Id();
				pathwayCatNames[2] = pathWayBean1.getSec3Title();
				pathwayCatIds[3] = ""+pathWayBean1.getSec4Id();
				pathwayCatNames[3] = pathWayBean1.getSec4Title();
				for(int pwCtr=0; pwCtr < pathwayCatNames.length; pwCtr++) {
					if(pathwayCatNames[pwCtr]!=null) {
						primaryCatName = pathwayCatNames[pwCtr];
						primaryCatId = Integer.parseInt(pathwayCatIds[pwCtr]);
					}
				}
					//primaryCatName = story.getCatName();
					//primaryCatId = story.getCatId();
			}
%>
			<table class="page_title" width="670" border="0" cellpadding="0" cellspacing="0" style="border-bottom:5px solid #373737;  margin:0 0 10px 10px;; float:left;"><tr><td class="section_title" valign="top"><%=primaryCatName %></td><td width="">&nbsp;</td></tr></table>
			<div id="pathway"><span class="pathway"><a href="http://indiatoday.intoday.in/site/specials/asiacup2010/index.jsp" class="pathway">Home</a>
<%
			for(int pwCtr=0; pwCtr < pathwayCatNames.length; pwCtr++) {
				if(pathwayCatNames[pwCtr]!=null) {
					out.println("<img src=\"http://indiatoday.intoday.in/site/static/arrow_breadcrmps.gif\" hspace=\"5\" />");
					if(pwCtr==0) {
						out.println("<a href=\"http://indiatoday.intoday.in/site/section?secId="+pathwayCatIds[pwCtr]+"&page=0\">"+pathwayCatNames[pwCtr]+"</a>");
						sectionLink="http://indiatoday.intoday.in/site/section?secId="+pathwayCatIds[pwCtr]+"&page=0";
					} else if(pwCtr==1) {	
						out.println("<a href=\"http://indiatoday.intoday.in/site/specials/asiacup2010/subsection.jsp?sn="+pathwayCatNames[0]+"&sid="+pathwayCatIds[0]+"&cid="+pathwayCatIds[pwCtr]+"&cn="
							+pathwayCatNames[pwCtr]+"&page=0"+"\">"+ pathwayCatNames[pwCtr]+"</a>");
						sectionLink="http://indiatoday.intoday.in/site/specials/asiacup2010/subsection.jsp?sn="+pathwayCatNames[0]+"&sid="+pathwayCatIds[0]+"&cid="+pathwayCatIds[pwCtr]+"&cn="
							+pathwayCatNames[pwCtr]+"&page=0";
					} else if(pwCtr==2) {	
						out.println("<a href=\"http://indiatoday.intoday.in/site/specials/asiacup2010/subcategory?sid="+pathwayCatIds[0]+"&sn="+pathwayCatNames[0]+"&cn="+pathwayCatNames[1]+"&cid="
							+pathwayCatIds[1]+"&scatn="+pathwayCatNames[pwCtr]+"&scid="+pathwayCatIds[pwCtr]+"\">"+pathwayCatNames[pwCtr]+"</a>");
						sectionLink="http://indiatoday.intoday.in/site/specials/asiacup2010/subcategory?sid="+pathwayCatIds[0]+"&sn="+pathwayCatNames[0]+"&cn="+pathwayCatNames[1]+"&cid="
							+pathwayCatIds[1]+"&scatn="+pathwayCatNames[pwCtr]+"&scid="+pathwayCatIds[pwCtr];
					} else {	
						out.println("<a 				href=\"http://indiatoday.intoday.in/site/specials/asiacup2010/subsubcategory?sscatid="+pathwayCatIds[pwCtr]+"&sid="+pathwayCatIds[0]+"&sn="+pathwayCatNames[0]+"&cn="
							+pathwayCatNames[1]+"&cid="+pathwayCatIds[1]+"&scatn="+pathwayCatNames[pwCtr]+"&sscn="+pathwayCatNames[2]+"&scid="
							+pathwayCatIds[2]+"\">"+pathwayCatNames[pwCtr]+"</a>");
						sectionLink="http://indiatoday.intoday.in/site/specials/asiacup2010/subsubcategory?sscatid="+pathwayCatIds[pwCtr]+"&sid="+pathwayCatIds[0]+"&sn="+pathwayCatNames[0]+"&cn="
							+pathwayCatNames[1]+"&cid="+pathwayCatIds[1]+"&scatn="+pathwayCatNames[pwCtr]+"&sscn="+pathwayCatNames[2]+"&scid="
							+pathwayCatIds[2];
					}
						
				}
			}
%>
			<img src="http://indiatoday.intoday.in/site/static/arrow_breadcrmps.gif" hspace="5" />Story
			</span></div>
<%
//Sanjay 140210 till
} %>
      
      <table class="" id="fullstory" style="padding: 0pt 0pt 0pt 10px;" width="670" border="0" cellpadding="0" cellspacing="0">
					<tbody><tr><td id="content_story_title" class="contenttitle" colspan="3" width="670"><%=title %></td></tr>
				 
		<tr><td class="byline" colspan="3" id="byline"><%=byline %></td></tr>
		<tr><td class="dateline" colspan="3" id="dateline"><%=dateline %></td></tr>
        <tr><td colspan="3" align="left" valign="top"><table border="0" cellpadding="0" cellspacing="0" id="share_links" style="border:0px solid #000; width:670px; float:left; $margin-bottom:20px; "> 
<tr><td width="90" style="border-right:1px solid #cccccc;"><img src="<%=staticImgPath%>comment_icon.jpg" style="border: medium none; margin: 0pt 5px 0pt 0pt;" align="absmiddle" />
<a href="#comment">Comment</a></td>

<td width="100" style="border-right:1px solid #cccccc;padding-left:15px;"><script showbranding="0" src="http://d.yimg.com/ds/badge2.in.js"  badgetype="text-votes">india_today21:<%=Constants.SITE_URL%>Story/<%=sId %>/<%=catname %>/<%=sefurl%> </script></td>


<td width="110" style="border-right:1px solid #cccccc;"><div id="chromemenu3" class="ddcolortabs" style="float: left; margin-left:15px;">
<!-- AddThis Button BEGIN -->
<script type="text/javascript">var addthis_pub="indiatoday";
var addthis_options = 'Digg,MySpace,facebook,twitter,Delicious,StumbleUpon,more';
</script>
<a href="http://www.addthis.com/bookmark.php?v=20" onmouseover="return addthis_open(this, '', '[URL]', '[TITLE]')" onmouseout="addthis_close()" onclick="return addthis_sendto()"><img src="<%=staticImgPath%>share_btn_black.gif"  alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/200/addthis_widget.js"></script>
<!-- AddThis Button END -->  </div></td>

<td width="117" style='border-right:1px solid #cccccc;padding-left:8px;'><img src="<%=staticImgPath%>font_size_icon.jpg" style="border: medium none; margin: 0pt 5px 0pt 5pt;_margin:0 5pt 0 5pt;" align="absmiddle" /><a href="javascript:decreaseFontSize();" class="small" style="font-size: 9px;">A</a>&nbsp;
<a href="javascript:resetFontSize()" class="normal" style="font-size: 11px;">A</a>&nbsp;
<a href="javascript:increaseFontSize();" class="larg" style="font-size: 12px;">A</a></td>

<td width="97" style="border-right:1px solid #cccccc; padding-left:15px;"><img src="<%=staticImgPath%>email_icon.gif" style="border: medium none; margin: 0pt 5px 0pt 0pt;" align="absmiddle" /><a href="#" onClick="javascript:window.open('<%=Constants.SITE_URL%>send_mail.jsp?email=0&sid=<%=sId %>&secid=<%=catid %>','window','status=no,resize=no,toolbar=no,scrollbars=no,width=478,height=367'); return false;">Email</a></td>

<td width="90" style="border-right:0px solid #cccccc;padding-left:10px; "><img src="<%=staticImgPath%>print_icon.gif" style="border: medium none; margin: 0pt 5px 0pt 0pt;" align="absmiddle" /><a href="#"
onClick="javascript:Open_win('<%=Constants.SITE_URL%>StoryPrint?sId=<%=sId %>&secid=<%=catid %>&page=<%=request.getParameter("page")%>',710,700);return false;">Print</a></td>
<td  width="90"  style=" border-left:1px solid #cccccc;padding-top:5px;padding-left:15px;">
<% if( iCompleteView >0) {%><img src="<%=staticImgPath%>pageview_icon.jpg"
style="border: medium none; margin: 0pt 5px 0pt 0pt;"
align="absmiddle" /><%} %>
<% if(iCompleteView == 1  ) { %>
	<a href="Story/<%=sId %>/<%=sefurl %>?complete=2" title="View" target="_parent">Normal View</a>
<% } else if(iCompleteView > 0 ) {%>
	<a href="Story/<%=session.getAttribute("sId") %>/<%=sefurl %>?complete=1" title="View" target="_parent">Single View</a>	
<%
} 
%></td>
<% if(syndicate !=0) { %><td width="50"  style="padding-top:0px;padding-left:15px; border-left:1px solid #cccccc;"><img src="<%=staticImgPath%>buy-cart_icon.gif" align="absmiddle" style="margin:0 5px 0 0; border:none;" /><a  href="http://syndicationstoday.com/syndicationstoday/validate.jsp?aid=<%=sId %>&sid=1&article='<%=syndicateTitle.replaceAll("'","")%>'&byline='<%=syndicateByline%>'&idate=<%=syndicateDate%>" title="Buy article!" target="_blank">Buy article</a></td> <%} %>
</tr>

<tr> <td height=1 bgcolor="#cccccc" colspan=6></td></tr><td height=4  colspan=9></td></tr>


</table>  </td></tr>

<tr> <td colspan="3">&nbsp;</td></tr>
  <tr><td colspan="3" class="fullstorytext" valign="top" align="left">
<%
//int count=0;
String pagenum = request.getParameter("page");
if(pagenum==null)
pagenum="0";

//String pagenum=null;
String full2=""; 
//pagenum="0";
String contentbody = "";
if(iCompleteView == 1) {
	if(fulltext.contains("mosimage")) {
		contentbody = StoryFunction.mosimageToimages(fulltext.replace("mospagebreak",""), Imagepath);
	} else {
		contentbody = fulltext.replace("mospagebreak","").replace("{","").replace("}","");
	}
} else {
	if(fulltext.contains("mosimage")) {
		contentbody = body;
	} else {
		contentbody = body.replace("{","").replace("}","");
	}
}

if(checkPagebreak ==1){
	int[] xyz  = StoryFunction.strToarray(contentbody, "mospagebreak");
	if(Integer.parseInt(pagenum) > 0) 
	{	
		if(Integer.parseInt(pagenum) < xyz.length -1) 
		{
			full2=contentbody.substring((xyz[Integer.parseInt(pagenum)-1])+12, xyz[Integer.parseInt(pagenum)]);
		} 
		else if(Integer.parseInt(pagenum) == xyz.length -1) 
		{
			full2=contentbody.substring(xyz[Integer.parseInt(pagenum)]);
		}
		
		} else {
			full2=contentbody.substring(0, xyz[Integer.parseInt(pagenum)]);
	}
%>
	<p style="font:normal 14px arial; line-height:22px;"><%=full2 %></p>
	<!-- Pagination starts -->

	<div class="last" align="right" style="color:#d71920; font:bold 11px arial" >
<%
	if(xyz.length > 1) {	
		if(Integer.parseInt(pagenum) > 0) {%>
			&#171;&nbsp;<a href="<%=baseUrl %>specials/asiacup2010/Story/<%=sId %>/<%=sefurl %>?page=<%=Integer.parseInt(pagenum)-1%>"><strong>Previous</strong></a>
<%	} 
	for(int abc=0; abc < xyz.length; abc++) {
		if(abc == Integer.parseInt(pagenum)) {%>
			<%=abc + 1%>
<%		} else { %>
			<a href="<%=baseUrl %>specials/asiacup2010/Story/<%=sId %>/<%=sefurl %>?page=<%=abc%>"><%=abc+1%></a>
<%		} 
	} 
	if(Integer.parseInt(pagenum) < (xyz.length -1)) {%>
		<a href="<%=baseUrl %>specials/asiacup2010/Story/<%=sId %>/<%=sefurl %>?page=<%=Integer.parseInt(pagenum)+1%>"><strong>Next</strong></a>&nbsp;&#187;
<%	} 
}%>
</div>
<%}else {
	full2=body;
%>
<p style="font:normal 14px arial; line-height:22px;"><%=full2 %></p>
<%
}
%>
<!-- Pagination ends -->
</td></tr></tbody></table>  
      
				</td>
		</tr>
	
		           
		
<tr>
     <td id="oth_stories">
     <table style="margin: 10px 0pt; width:670px; $width:650px;_width:650px;" border="0" cellpadding="0" cellspacing="0">
      <tbody>
    <%--  <tr><td style="width: 490px; padding-left: 10px;"><!-- Rate this Article Code Start Here -->

<form method=post action="">
<table width="669" height="29" border="0" cellpadding="0" cellspacing="0" style="background-image:url(<%=staticImgPath%>ratestrip.jpg); background-repeat:x-repeat; font:normal 12px Arial; text-align:left; margin-top:25px">
<tr>
<td width="120" valign="middle" class="rate">&nbsp;Rate this article      </td>
<td width="50" valign="middle" >Bad</td>
<td width="150" valign="middle" class="rate">
<input name="radiobutton" type="radio" value="" onclick="showStar('1','<%=sId %>')" />
<input name="radiobutton" type="radio" value="" onclick="showStar('2','<%=sId %>')" />
<input name="radiobutton" type="radio" value="" onclick="showStar('3','<%=sId %>')" />
<input name="radiobutton" type="radio" value="" onclick="showStar('4','<%=sId %>')" />
<input name="radiobutton" type="radio" value="" onclick="showStar('5','<%=sId %>')" />	</td>
<td width="50" valign="middle" class="rate">Good</td>
<td width="200" class="rate">
Current rating &nbsp;&nbsp;|&nbsp;&nbsp;<div id="score" style="display:inline;"></div>	</td>
</tr>
</table>  
</form>			
<!-- Rate this Article Code End Here --></td></tr>--%>
      <tr><td style="width: 490px; padding-left: 10px;"><%

String relatedtype = "";
if (RELATED != null && RELATED.size() > 0) {
	for (int ctr = 0; ctr < RELATED.size(); ctr++) {
		RelatedStoryBean RSB = (RelatedStoryBean) RELATED.get(ctr);
		relatedtype = RSB.getRelatedTypes(); 
		String fullRelatedUrl="";
		fullRelatedUrl=RSB.getSefUrl();

		if(ctr==0) {
%>
			<h1 style="margin:10px 0 5px 0; padding:0; font: bold 12px arial; text-transform:uppercase;">Related Stories</h1>
			<ul>
<%
		}
		if(relatedtype.trim().equals("text")) {			
%>
			<li style="list-style:none; background:url(<%=staticImgPath%>story_icon.jpg) no-repeat left 5px; color:#000000; font:normal 12px arial; line-height:18px; margin:0px 0 0px 0;_margin:0px 0 0px 0; padding:0 2px 0 20px;_padding:0px 2px 0 20px;">
			<a href="<%=baseUrl %>specials/asiacup2010/Story/<%=RSB.getRelatedArticleId()%>/<%=RSB.getRelatedSectionName() %>/<%=fullRelatedUrl %>"><%=RSB.getRelatedTitle()%></a></li>
<%
		} else if(relatedtype.trim().equals("photo"))	{
%>
			<li style="list-style:none; background:url(<%=staticImgPath%>photo_icon.jpg) no-repeat left 5px; color:#000000; font:normal 12px arial; line-height:18px; margin:0px 0 0px 0;_margin:0px 0 0px 0; padding:0 2px 0 20px;_padding:0px 2px 0 20px;"><a href="<%=baseUrl %>Photo/<%=RSB.getRelatedArticleId()%>/<%=RSB.getRelatedSection()%>/<%=fullRelatedUrl %>"><%=RSB.getRelatedTitle()%></a></li>
<%			
		} else if(relatedtype.trim().equals("video"))	{
%>
			<li style="list-style:none; background:url(<%=staticImgPath%>video_icon.jpg) no-repeat left 5px; color:#000000; font:normal 12px arial; line-height:18px; margin:0px 0 0px 0;_margin:0px 0 0px 0; padding:0 3px 0 20px;_padding:0px 2px 0 20px;"><a href="<%=baseUrl %>Video/<%=RSB.getRelatedArticleId()%>/<%=RSB.getRelatedSection()%>/<%=fullRelatedUrl %>"><%=RSB.getRelatedTitle()%></a></li>
<%			
	}
	if(ctr==RELATED.size()-1) {
		out.println("</ul>");
	}
	}
}
%>
<!-- Related ends --></td></tr>
      <tr>
	  	       <td style="width: 490px; padding-left: 10px;">

<% 
		session.setAttribute("pcatid",primaryCatId);
		session.setAttribute("PrimeryCategoryId",primaryCatId);
//sectionLink = sectionLink.replaceAll("&","~");
%>
<%@include file="story_more.jsp"%>
</td> 
	    
	    </tr>
	   
     
     </tbody></table>  
     </td>
    </tr>
						<tr>
<td>

<%@include file="story_comment.jsp"%>
					
  
</td>
</tr>
</tbody></table>  </td>

<td width="21" align="left" valign="top">&nbsp;</td>
    <td width="300" valign="top"> 
    
    <table width="300" border="0" cellspacing="0" cellpadding="0">
  
  <tr>
    <td align="left" valign="top"> <%@include file="right.jsp"%></td>
  </tr>
</table>
    
    
    </td>
  </tr>
</table>  
</td>
  </tr>
</table>
  <table border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#ffffff">
  <tr>
    <td><%@include file="bottom.html"%></td>
  </tr>
</table>  
</body>
</html>
</cache:cache>

