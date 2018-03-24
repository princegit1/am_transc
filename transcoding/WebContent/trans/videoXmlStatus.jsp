<%@ page contentType="text/xml; charset=ISO-8859-1" %>
<%@page import="com.itgd.transcoder.bean.Joboutput"%>
<%@page import="java.util.List"%>
<%@page import="com.itgd.transcoder.util.CommonUtil"%>
<%@page import="com.itgd.transcoder.dao.AmazonTranscodingDAO"%>
<%@page import="com.itgd.transcoder.bean.AmazonAwsJobDesc"%>
<%@page import="com.itgd.transcoder.util.TranscodingVideoXml"%>
<%
String VideoNamePath="";
String defaultStatus="complete";
Joboutput joboutput=null;
String profileId=request.getParameter("profileId")==null?"":request.getParameter("profileId");
String videoName=request.getParameter("videoName")==null?"":request.getParameter("videoName");
if(CommonUtil.isInteger(profileId) && videoName!=null && videoName.length()>0)
{
AmazonTranscodingDAO atdao  = new AmazonTranscodingDAO();
AmazonAwsJobDesc amazonAwsJobDesc= atdao.getAmazonAwsJobDescByid(Integer.parseInt(profileId));
if(amazonAwsJobDesc!=null)
{
VideoNamePath=amazonAwsJobDesc.getProcessBasePath()+videoName;
if(VideoNamePath.indexOf("//")>0)
VideoNamePath=VideoNamePath.replace("//","/");
TranscodingVideoXml transcodingVideoXml=new TranscodingVideoXml();
List<Joboutput> joboutputs =transcodingVideoXml.videoXml(VideoNamePath,Integer.parseInt(profileId),defaultStatus);
if(joboutputs!=null && joboutputs.size()>0)
{
	for(int i=0; i<joboutputs.size(); i++)
	{
		joboutput=joboutputs.get(i);
		if(i==0)
		{
		%>
		<transcodes>
        <transcode>
		   <in>
		   <site_id><%=joboutput.getWebSiteId() %></site_id>
		   	   <website><%=joboutput.getWebSiteName()%></website>
		   	    <profile_id><%=joboutput.getProfileId()%></profile_id>
                       <trans_id><%=joboutput.getTransIntputId() %></trans_id>
                       <status><%=joboutput.getInputjobStatus() %></status>
                       <path><%=joboutput.getInputPath() %></path>
                       <duration><%=joboutput.getFileDuration() %></duration>
               </in>
               <out>
		<%
	   }
		%>
		                <video>
                               <path><%=joboutput.getOutputPath()%></path>
                               <bitrate><%=joboutput.getBitrateId() %></bitrate>
                               <status><%=joboutput.getOutputStatus() %></status>
                       </video>
		<%
}
}
if(joboutputs!=null && joboutputs.size()>0)
{
%>
  </out>
        </transcode>
</transcodes> 
<%
}
else
{
	%>
<transcodes><status>1</status><error_msg>video not found</error_msg></transcodes> 
<%	
}
%>
<%
}
}
else
{
%>
 
<transcodes><status>1</status><error_msg>Invalid ProfileId or videoName</error_msg></transcodes> 

<%} %>
    
