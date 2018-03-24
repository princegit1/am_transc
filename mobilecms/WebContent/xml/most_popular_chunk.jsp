<%@page import="com.itgd.utils.CommonFunctions"%>
<%@page import="com.itgd.dto.CoverStoryBean"%>
<%@page import="java.util.ArrayList"%>

<tr><td height="20"></td></tr>
<tr><td>
<div id="tabs_new_photodiv_new">
<h1 sytle="border:none;margin-bottom:0px;">Most Popular</h1>
<table style="border: 0px solid rgb(173, 17, 25);" width="300" border="0" cellpadding="0" cellspacing="0">

  <tr>
   <td><table width="300" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="100"><div id="first_tab" align="left"><a href="javascript:tabit_stories1_new();" id="tabstr1_new" class="active" onclick="javascript:tabit_stories1_new();">Stories</a></div></td>
        <td width="1" bgcolor="#d71920"></td>
        <td><div id="second_tab" align="left"><a id="tabstr2_new" class="inactive" href="javascript:tabit_stories2_new();" onclick="javascript:tabit_stories2_new();">Photos</a></div></td>
        <td width="1" bgcolor="#d71920"></td>
        <td><div id="third_tab" align="left"><a id="tabstr3_new" class="inactive" href="javascript:tabit_stories3_new();" onclick="javascript:tabit_stories3_new();">Videos</a></div></td>
      </tr>
    </table></td>

  </tr>

  <tr>

    <td style="border:5px solid #d71920" ><div id="tabit_story1_new" style="display: block; width: 290px;">

      <div id="stries_str">
<ul>
<%
		ArrayList mostPopularStories = (ArrayList) CommonFunctions.MostPopular(114,3 ,43,4);	
		StringBuffer storyData=new StringBuffer();
		StringBuffer photoData=new StringBuffer();		StringBuffer videoData=new StringBuffer();
		if (mostPopularStories != null && mostPopularStories.size() > 0) {
			for (int i = 0; i < mostPopularStories.size(); i++) {
				CoverStoryBean topStories = (CoverStoryBean) mostPopularStories.get(i);
				//System.out.println("topStories.getCommnet()->" + topStories.getCommnet());	
				//System.out.println("headlines ->" + topStories.getTitle());	
				if(topStories.getCommnet().equals("story"))
				{
					storyData.append("<li><a href='Story/"+topStories.getSectionid()+"/"+topStories.getSection()+"/"+topStories.getSefUrl()+"'>"+topStories.getTitle()+"</a></li>");
				}
				else if(topStories.getCommnet().equals("photo"))
				{
					photoData.append("<li class='p_rel'><a href='Photo/"+topStories.getSectionid()+"/"+topStories.getSecid()+"/"+topStories.getSefUrl()+"'>"+topStories.getTitle()+"</a></li>");
				}

				else if(topStories.getCommnet().equals("video"))
				{
					videoData.append("<li class='v_rel'><a href='Video/"+topStories.getSectionid()+"/"+topStories.getSecid()+"/"+topStories.getSefUrl()+"'>"+topStories.getTitle()+"</a></li>");
				}
	}}%>
<%=storyData.toString()%>
</ul>
</div></div>

 <div id="tabit_story2_new" style="width: 290px; display: none;" >
<div id="stries_str">
<ul>
<%=photoData.toString()%>
</ul>
</div></div>
<div id="tabit_story3_new" style="width: 290px; display: none;" >
<div id="stries_str">
<ul>
<%=videoData.toString()%>	
</ul>
</div></div>
 </td> </tr>

</table>
</div>


</td></tr>
<tr><td height="20"></td></tr>