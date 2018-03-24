<%@page import="com.itgd.transcoder.util.JobStatusUpdaterCron"%>
<%@page import="com.itgd.transcoder.util.CommonUtil"%>
<%@page import="com.itgd.transcoder.util.TranscoderJobCron"%>
<%
    out.println("Transcode job Started....");
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
    try
    {
     new TranscoderJobCron(1,profileId);
     out.println("  Running....");
     out.println("completed.");
     Thread.sleep(40000);
     System.out.println("  updated job stared....");
     out.println("<br>");
     out.println(" update status job Started....");
     new JobStatusUpdaterCron(1,profileId);
     out.println("  Running....");
     out.println("completed.");
    }
    catch(Exception exception)
    {
    	
    }
%>
