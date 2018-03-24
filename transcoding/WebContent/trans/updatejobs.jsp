<%-- 
    Document   : updatejobs
    Created on : Jun 7, 2013, 3:26:44 PM
    Author     : vijayendrar
--%>
<%@page import="com.itgd.transcoder.util.CommonUtil"%>
<%@page import="com.itgd.transcoder.util.JobStatusUpdaterCron"%>
<%

   out.println("Started....");
   out.println("  Running....");
int profileId=0;
if(CommonUtil.isInteger(CommonUtil.getProfileIdFromConfiguration("profileId")))
{
 profileId=Integer.parseInt(CommonUtil.getProfileIdFromConfiguration("profileId"));
}
if(CommonUtil.isInteger(request.getParameter("profileId")))
{
	   profileId =Integer.parseInt(request.getParameter("profileId"));
}
     new JobStatusUpdaterCron(1,profileId);
    //new JobStatusUpdater().updateJob(); 
	 out.println(" completed.");

%>
