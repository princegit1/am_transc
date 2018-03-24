<%-- 
    Document   : amazonawsjobdesc
    Created on : May 31, 2013, 8:26:17 PM
    Author     : vijayendrar
--%>


<%@page import="com.itgd.transcoder.service.AWSS3BucketService"%>
<%@page import="com.amazonaws.services.s3.model.Bucket"%>
<%@page import="java.util.List"%>
<%@page import="com.itgd.transcoder.service.PipelineService"%>
<%@page import="com.amazonaws.services.elastictranscoder.model.Pipeline"%>
<%@page import="com.itgd.transcoder.service.PresetService"%>
<%@page import="com.amazonaws.services.elastictranscoder.model.Preset"%>
<%@page import="com.itgd.transcoder.service.AmazonClientService"%>

<%
try {     
String logedIn = (String) session.getAttribute("transcodesessionvalue");
if(!(logedIn!=null && logedIn.equals("logedINTrue"))) {
    response.sendRedirect("itgdtrans.jsp");
} else {   
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<!--<!DOCTYPE html>-->

<%
    AWSS3BucketService awsS3BucketService = new AWSS3BucketService();
    PipelineService pipelineService = new PipelineService();
    List<Pipeline> pipelineList = pipelineService.listPipeline();
    //List<Bucket> bucketList =  awsS3BucketService.listS3Bucket();    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function validateFields() {
                var jobDescName = document.getElementById('jobDescName');
                var pipelineId = document.getElementById('pipelineId');
                var uploadFolderName = document.getElementById('uploadFolderName');
                var transcodFolderName = document.getElementById('transcodFolderName');
                var processingFolderName = document.getElementById('processingFolderName');
                var processedFolderName = document.getElementById('processedFolderName');
                var errorFolderName = document.getElementById('errorFolderName');
                var uploadBucketName = document.getElementById('uploadBucketName');
                if(!(jobDescName!=null && !jobDescName.value == '')) {
                    alert("Fill Job Desc.");
                    return false;
                }else if(!(pipelineId!=null && !pipelineId.value == '')) {
                    alert("Please select pipeline.");
                    return false;
                }else if(!(uploadFolderName!=null && !uploadFolderName.value == '')) {
                    alert("Fill Upload Folder Name.");
                    return false;
                }else if(!(transcodFolderName!=null && !transcodFolderName.value == '')) {
                    alert("Fill Transcod Folder Name.");
                    return false;
                }else if(!(processingFolderName!=null && !processingFolderName.value == '')) {
                    alert("Fill Processing Folder Name.");
                    return false;
                }else if(!(processedFolderName!=null && !processedFolderName.value == '')) {
                    alert("Fill Processed Folder Name.");
                    return false;
                }else if(!(errorFolderName!=null && !errorFolderName.value == '')) {
                    alert("Fill Error Folder Name.");
                    return false;
                }else if(!(uploadBucketName!=null && !uploadBucketName.value == '')) {
                    alert("please select upload bucket.");
                    return false;
                }else {
                    return true;
                }
            }
        </script>    
    </head>
    <body>
        <div align="center">
            <table border="2" cellspacing="1" width="800px" bordercolor="#800000">
               <tr>
                   <td align="center" colspan="2">
                       <!-- top section --> 
                       <div><jsp:include page="header.jsp" /></div> 
                   </td>
               </tr>
               <tr valign="top">
                   <td width="135px">
                       <!-- left panel -->
                       <div><jsp:include page="leftpanel.jsp" /></div>

                   </td>
                   <td>
                       <!-- right panel -->
                       <table border="0">
                           <tr>
                               <td>
                                   
                                   

        
        
        
        
        
        
        
        
        
        
        
        <table>
            <tr>
                <td>
                        <table>
                            <tr valign="top">
                                <td align="center">
                                    <form action="doactiontrans.jsp" method="post" onsubmit="return validateFields();">
                                        <input type="hidden" name="dotransjob"  id="dotransjob" value="AmazonAwsJobDesc"/>
                                    <div>
                                    <table>
                                        <tr>
                                            <td colspan="3"><center><h2>ADD JOB</h2></center></td>
                                        </tr>
                                        <tr>
                                            <td align="left">Job Name</td>
                                            <td>:</td>
                                            <td align="left"> <input type="text" name="jobDescName"  id="jobDescName"/></td>
                                        </tr>                        
                                        <tr>
                                            <td align="left">Description</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="jobDescDiscription"  id="jobDescDiscription"/></td>
                                        </tr>                                                                             
                                        <tr>
                                            <td align="left">Created By</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="jobDescCreatedBy"  id="jobDescCreatedBy"/></td>
                                        </tr>                                                                             
                                        <tr>
                                            <td align="left">Select Pipeline</td>
                                            <td>:</td>
                                            <td align="left">
                                                <select name="pipelineId" id="pipelineId">
                                                    <option value="">-select-</option>
                                                    <% for(Pipeline pipeline: pipelineList) { %>
                                                    <option value="<%= pipeline.getId() %>"><%= pipeline.getName() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Input Upload Folder Name( e.g. xyz/upload/)</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="uploadFolderName"  id="uploadFolderName"/></td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Output Folder Name( e.g. xyz/video/)</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="transcodFolderName"  id="transcodFolderName"/></td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Processing Folder Name( e.g. xyz/processing/)</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="processingFolderName"  id="processingFolderName"/></td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Processed Folder Name( e.g. xyz/processed/)</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="processedFolderName"  id="processedFolderName"/></td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Error Folder Name( e.g. xyz/error/)</td>
                                            <td>:</td>
                                            <td align="left">
                                                <input type="text" name="errorFolderName"  id="errorFolderName"/>
                                                <input type="hidden" name="uploadBucketName"  id="uploadBucketName" value="videotranscoding1"/>
                                            </td>
                                        </tr>   
                                        <%--<tr>
                                            <td align="left">Select Upload Bucket Name</td>
                                            <td>:</td>
                                            <td align="left">
                                                
                                                <select name="uploadBucketName" id="uploadBucketName">
                                                    <option value="">-select-</option>
                                                    <% for(Bucket bucket: bucketList) { %>
                                                    <option value="<%= bucket.getName() %>"><%= bucket.getName() %></option>
                                                    <% } %>
                                                </select>   
                                            </td>
                                        </tr>   --%>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>   
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>   
                                        <tr>
                                            <td colspan="3">
                                                <input type="submit" value="ADD_JOB" style="color: #FFFFFF; background-color: #800000"/>
                                            </td>
                                        </tr>                        
                                    </table>
                                    </div>  
                                    </form>            
                                </td>
                            </tr>
                        </table>                    
                </td>
            </tr>
            
            
            
            <tr>
                <td>
                     <!--  Delete code -->
                </td>
            </tr>
        </table>

        
                                                
                                                
                                                

                                                
                                                
                                                
                               </td>
                           </tr>
                       </table>
                   </td>
               </tr>
            </table>
        </div>                              
    </body>
</html>


<% 
}
}catch(Exception ex) {
    ex.printStackTrace();
    response.sendRedirect("itgdtrans.jsp");
}    
%>