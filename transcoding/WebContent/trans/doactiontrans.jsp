<%-- 
    Document   : doactiontrans
    Created on : May 31, 2013, 7:49:28 PM
    Author     : vijayendrar
--%>
<%@page import="com.itgd.transcoder.service.TransCoderUtil"%>
<%@page import="com.itgd.transcoder.bean.AmazobAwsJobOutputDesc"%>
<%@page import="com.itgd.transcoder.dao.AmazonTranscodingDAO"%>
<%@page import="com.itgd.transcoder.bean.AmazonAwsJobDesc"%>

<%
	try {     
String logedIn = (String) session.getAttribute("transcodesessionvalue");
if(!(logedIn!=null && logedIn.equals("logedINTrue"))) {
    response.sendRedirect("itgdtrans.jsp");
} else {
%>

<%
	AmazonTranscodingDAO dAO = new AmazonTranscodingDAO();
    
    
String dotransjob = request.getParameter("dotransjob");

System.out.println("log .....1");
if(dotransjob!=null && !dotransjob.equals("")) {

    System.out.println("log .....2");
    //add job desc description
    if(dotransjob.equals("AmazonAwsJobDesc")) {
        System.out.println("log .....3");
        AmazonAwsJobDesc amazonAwsJobDesc = new AmazonAwsJobDesc();
        amazonAwsJobDesc.setJobDescName(request.getParameter("jobDescName"));
        amazonAwsJobDesc.setJobDescDiscription(request.getParameter("jobDescDiscription"));
        amazonAwsJobDesc.setJobDescCreatedBy(request.getParameter("jobDescCreatedBy"));
        amazonAwsJobDesc.setPipelineId(request.getParameter("pipelineId"));
        amazonAwsJobDesc.setUploadFolderName(request.getParameter("uploadFolderName"));
        amazonAwsJobDesc.setTranscodFolderName(request.getParameter("transcodFolderName"));
        amazonAwsJobDesc.setProcessingFolderName(request.getParameter("processingFolderName"));
        amazonAwsJobDesc.setProcessedFolderName(request.getParameter("processedFolderName"));
        amazonAwsJobDesc.setErrorFolderName(request.getParameter("errorFolderName"));
        amazonAwsJobDesc.setUploadBucketName(request.getParameter("uploadBucketName"));
        dAO.saveOrUpdateAmazonAwsJobDesc(amazonAwsJobDesc);
        response.sendRedirect("transcoder.jsp");
    } else if(dotransjob.equals("AmazobAwsJobOutputDesc")) {
        AmazobAwsJobOutputDesc amazobAwsJobOutputDesc = new AmazobAwsJobOutputDesc();
        amazobAwsJobOutputDesc.setJobDescId(Integer.parseInt(request.getParameter("jobDescId")));
        amazobAwsJobOutputDesc.setPresetId(request.getParameter("presetId"));
        amazobAwsJobOutputDesc.setFolderName(request.getParameter("folderName"));
        amazobAwsJobOutputDesc.setKeySuffix(request.getParameter("keySuffix"));
        dAO.saveOrUpdateAmazobAwsJobOutputDesc(amazobAwsJobOutputDesc);
        response.sendRedirect("transcoder.jsp");
    }else if(dotransjob.equals("jobdescidforprocess")) {
        String jobdescId = request.getParameter("jobdescidforprocess").trim();
        TransCoderUtil coderUtil = new TransCoderUtil();
            coderUtil.transcodeObject(jobdescId,"");
        response.sendRedirect("transcode_result.jsp");
//            response.sendRedirect("transcoder.jsp");
    } else {
        response.sendRedirect("transcoder.jsp");
    }
    
}else {
    System.out.println("log .....last");
    response.sendRedirect("transcoder.jsp");
}
%>

<% 
}
}catch(Exception ex) {
    ex.printStackTrace();
    response.sendRedirect("itgdtrans.jsp");
}    
%>

