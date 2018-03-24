<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<link href="styles/main.css" rel="stylesheet" type="text/css"></link>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
 <%
	String emp_role1=null; 
 	if(session.getAttribute("emp_role")!=null || session.getAttribute("emp_role")!="")
 	{
		 emp_role1  = (String)session.getAttribute("emp_role");
	}
	else
	{
		response.sendRedirect("index.jsp");
	}
	DateFormat dateFormatter = new SimpleDateFormat("dd-MMM-yyyy");	
%>
 <tr valign="middle" height="55">
  <td rowspan="3" width="10%" align="center" bgcolor="#dcdcdc">
   <a href="mobileHome.jsp">
    <img src="img/itg-logo.gif" border="0"></img>
   </a>
  </td>
  <td align="right" bgcolor="#dcdcdc">
   Role:
   <%=emp_role1.toLowerCase()%>&nbsp;&nbsp;
   <br></br>
   <b><%=dateFormatter.format(new Date())%></b>&nbsp;&nbsp;
  </td>
 </tr>
 <tr valign="middle" height="20">
  <td>
   <table width="100%">
    <tr valign="bottom">
     <td>
      <a href="showCategory.jsp">
       Insert Message
      </a>&nbsp;
       <a href="national_update_test.jsp">
       National News
      </a>
&nbsp;
&nbsp;
       <a href="election_update.jsp">
       Election Pack </a>
&nbsp;
      <a href="searchContent.jsp">
       Search Content
      </a>
&nbsp;
      <a href="astro.jsp">
       Insert Astro
      </a>


      <%
					if(!emp_role1.equalsIgnoreCase("AMT"))
					{
					%>
     
       <a href="regional_news_new.jsp">
       Regional News TESTING
      </a>&nbsp;
      <a href="selectDateForNews.jsp">
       Check Regional News
      </a>
	  &nbsp;
       <a href="regional_news_new_hinglish.jsp">
       Regional News Hinglish
      </a>
       
      <a href="showInsertCategory.jsp" class="lnkbld">
       Show/Insert Category
      </a> 
     &nbsp;
	   <a href="regional_news_new_one.jsp">
       Regional News IVR.
      </a>
      &nbsp;	  
	   <a href="select_section_for_rsss.jsp">
       News For Rss feed
      </a>
&nbsp;
      <a href="breaking_news.jsp">
       Breaking News 
      </a>
	  &nbsp;
<a href="select_section_for_voice_clips_onmobile.jsp">
       Regional Voice Clips
      </a>
	  &nbsp;
<a href="select_section_for_rsss_imi.jsp">
       <b>IMI RSS FEEDS</b> 
      </a>&nbsp;
<a href="onmobile_hinglish_roman_news_update.jsp">
       <b>ONMOBILE HINGLISH</b> 
      </a>
	  &nbsp;
	   <a href="videos_for_astro_percep.jsp">
       <b>Percep Astro Mrss</b> 
      </a>
	  &nbsp;      
      &nbsp;
	   <a href="videos_for_astro_vuclip.jsp">
       <b>Vuclip Astro Mrss</b> 
      </a>
	  &nbsp;

	   
      <%
					}
					if(emp_role1.equalsIgnoreCase("ADMINISTRATOR"))
					{
					%>
       
      <a href="checkTarot.jsp">
       Check Tarot
      </a>
       
      <a href="addEmployee.jsp" class="lnkbld">
       Add Employee
      </a>&nbsp;
     
       
     </td>
     <%
					}
					%>
    </tr>
   </table>
  </td>
 </tr>
 <tr bgcolor="#dcdcdc" valign="middle" height="20">
  <td align="right">
&nbsp;&nbsp;
   <a href="select_section_for_videos_cbc.jsp">
    Airtel 3g store videos 
   </a>&nbsp;&nbsp;

 <a href="select_section_for_videos_bsb.jsp">
    Video Rss News For BSB  
   </a>&nbsp;&nbsp;

 <a href="select_section_for_videos_percept.jsp">
    Video Rss News For Percep  
   </a>&nbsp;&nbsp;

  <a href="select_section_for_videos_vuclip.jsp">
    Video Rss News For VuClip  
   </a>&nbsp;&nbsp;
   
   <a href="select_section_for_videos_AP.jsp">
    Song For Devotional alarm AP
   </a>&nbsp;&nbsp;
   
<a href="select_section_for_rsss_rogerscanada.jsp">
    Rss News For Roger's Canada 
   </a>&nbsp;&nbsp;
   <a href="select_section_for_rsss_latinamerica.jsp">
    Rss News For Latin America 
   </a>&nbsp;&nbsp;

  <a href="sp/national_news.jsp">
    Check Symbiotic National News 
   </a>&nbsp;&nbsp;
   <a href="sp/regionalnewshtml.jsp">
     Check Symbiotic Local News 
   </a>&nbsp;&nbsp;
  <a href="airtellUssd_insert.jsp">
    AirTel USSD News Test
   </a>&nbsp;&nbsp;	<br />
     <a href="select_section_for_olympic2012.jsp">
    Olympic 2012 Content
   </a>&nbsp;&nbsp;
     <a href="select_section_for_rsss_spice.jsp">
    <b>Rss Feed For Spice</b>
   </a>&nbsp;&nbsp;   

   <a href="ChangePasswordRequest.jsp">
    Change Password
   </a>&nbsp;&nbsp;	
   <a href="cbc_states.jsp">
    CBC Regional News
   </a>&nbsp;&nbsp;	
   <a href="showCategory-unicode.jsp">
    Hindi Content 
   </a>
   &nbsp;&nbsp;	
   <a href="celltick-unicode-category-list.jsp">
    CellTick Content 
   </a>
&nbsp;&nbsp;	
   <a href="select_section_for_rsss_onmobile.jsp">
   Onmobile RSS News
   </a>  &nbsp;&nbsp;	
   <a href="gobindas_cricket-match-details-insert.jsp">
   Gobindas Cricket Match Details
   </a>&nbsp;&nbsp; 

   <a href="gobindas_cricket-match-details-insert_unicode.jsp">
   Gobindas Cricket Match Hindi Details
   </a>&nbsp;&nbsp;&nbsp;&nbsp;	

   <a href="gobindas_national_news-details-insert.jsp">
   Gobindas National News Details
   </a>&nbsp;&nbsp; 

   <a href="gobindas_national_news-details-insert_unicode.jsp">
   Gobindas National News Hindi Details
   </a>&nbsp;&nbsp;&nbsp;&nbsp;	
   
   <a href="gobindas_rs3-details-insert.jsp">
   Gobindas Rs.3 News Details
   </a>&nbsp;&nbsp; 

   <a href="gobindas_rs3-details-insert_unicode.jsp">
   Gobindas Rs.3 News Hindi Details
   </a>&nbsp;&nbsp;&nbsp;&nbsp;	
   
<!--
   <a href="gobindas_cricket-match-details-insert_unicode.jsp">
   Gobindas Cricket Match Hindi Details
   </a>&nbsp;&nbsp; 
-->
<a href="showsinhalese-unicode.jsp">
   Sinhalese News
   </a>&nbsp;&nbsp; 
<a href="showcelltick-unicode.jsp">
   Cell Tick News
   </a>&nbsp;&nbsp; 
<a href="select_section_for_lifestyle.jsp">
   Life style News
   </a>&nbsp;&nbsp; 
   
   <a href="select_section_for_videos_bsb_mrss.jsp">
   Video Rss News For BSB MRSS
   </a>&nbsp;&nbsp; 
 <a href="onmobile-news.jsp">
  onmobile news
 </a>
   <a href="logout.jsp">
    Log Out
   </a>
    
  </td>
 </tr>
 <tr height="5" bgcolor="#ffffff">
  <td colspan="2"></td>
 </tr>
</table>