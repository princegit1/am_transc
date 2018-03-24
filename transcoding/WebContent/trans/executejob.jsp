<%@page import="com.itgd.transcoder.util.CommonUtil"%>
<%@page import="com.itgd.transcoder.util.TranscoderJobCron"%>
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
   
     new TranscoderJobCron(1,profileId);
	 
	 out.println("completed.");
%>
