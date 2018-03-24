<%-- 
    Document   : process
    Created on : Jun 3, 2013, 3:57:37 PM
    Author     : vijayendrar
--%>


<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.amazonaws.services.elastictranscoder.model.Preset"%>
<%@page import="com.itgd.transcoder.service.PresetService"%>
<%@page import="com.itgd.transcoder.bean.AmazobAwsJobOutputDesc"%>
<%@page import="com.itgd.transcoder.dao.AmazonTranscodingDAO"%>
<%@page import="com.itgd.transcoder.bean.AmazonAwsJobDesc"%>
<%@page import="java.util.List"%>
<%@page import="com.itgd.transcoder.service.PipelineService"%>
<%@page import="com.amazonaws.services.elastictranscoder.model.Pipeline"%>
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
<%!String getProfileIdFromConfiguration() 
{

    Properties configProp = new Properties();
    InputStream in;
    String profileId="";
    in = this.getClass().getClassLoader().getResourceAsStream("appConfig.properties");
    try {
        configProp.load(in);
        profileId = configProp.getProperty("profileId");
    } catch (IOException e) {
        e.printStackTrace();
    }
    return profileId;
}%>
<%
	AmazonTranscodingDAO atdao = new AmazonTranscodingDAO();    
List<AmazonAwsJobDesc> amazonAwsJobDescsList = atdao.listAmazonAwsJobDesc(getProfileIdFromConfiguration());
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                
        
        <div>
            <table>
                <tr>
                    <td>
                        <h2>JOB Description</h2>
                        <form action="process.jsp" method="post">                            
                            <div style="float: left">Select job to execute: </div>
                            <div style="float: left"> : </div>
                            <div style="float: left">
                                <select name="jobdescid" id="jobdescid">
                                    <option value="">-select-</option>
                                    <%
                                    	for(AmazonAwsJobDesc o:amazonAwsJobDescsList) {
                                    %>
                                    <option value="<%=o.getAutoId()%>"><%=o.getJobDescName()%></option>
                                    <%
                                    	}
                                    %>
                                </select>
                        </div>
                                <div style="float: left"> <input type="submit" value="Select job to Execute" style="color: #FFFFFF; background-color: #800000" /> </div>       
                        </form>
                    </td>
                </tr>
                
                
                
<%
                                                	if(request.getParameter("jobdescid")!=null) { 
                                                    String id = request.getParameter("jobdescid");    
                                                    AmazonAwsJobDesc amazonAwsJobDescs = atdao.getAmazonAwsJobDescById(id);
                                                    List<AmazobAwsJobOutputDesc> amazobAwsJobOutputDescList = atdao.listAmazobAwsJobOutputDescByJobDescId(id);
                                                    PipelineService pipelineService = new PipelineService();
                                                    Pipeline pipeline = pipelineService.getPipelineById(amazonAwsJobDescs.getPipelineId());
                                                    PresetService presetService = new PresetService();
                                                %>                
                <tr>
                    <td>
                
                <div>
                    <table border="1" cellpadding="0" cellspacing="0">
                        <tr valign="top">
                            <td>
                                <!-- job desc parrent -->
                                <div>
                                <table border="0">
                                    <tr>
                                        <td align="left">JobDescName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getJobDescName() %></td>
                                    </tr>
                                    <tr>
                                        <td align="left">Pipeline</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= pipeline.getName() %></td>
                                    </tr>
                                    <tr>
                                        <td align="left">JobDescDiscription</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getJobDescDiscription()%></td>
                                    </tr>
                                    <tr>
                                        <td align="left">TranscodFolderName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getTranscodFolderName()%></td>
                                    </tr>
                                    <tr>
                                        <td align="left">UploadFolderName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getUploadFolderName()%></td>
                                    </tr>
                                    <tr>
                                        <td align="left">ProcessingFolderName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getProcessingFolderName()%></td>
                                    </tr>
                                    <tr>
                                        <td align="left">ProcessedFolderName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getProcessedFolderName()%></td>
                                    </tr>
                                    <tr>
                                        <td align="left">ErrorFolderName</td>
                                        <td>&nbsp;-:&nbsp;</td>
                                        <td align="left"><%= amazonAwsJobDescs.getErrorFolderName()%></td>
                                    </tr>
                                </table>
                                </div>    
                            </td>
                            <td>&nbsp;</td>
                            <td>
                                <!-- job child -->
                                <div>
                                    <table>
                                        <tr valign="top">
                                            <td>
                                                <span><b>OutPut Preset Details</b></span>
                                                <% 
                                                    for(AmazobAwsJobOutputDesc o:amazobAwsJobOutputDescList) 
                                                    { 
                                                        Preset preset = presetService.getPresetById(o.getPresetId());
                                                %>
                                                <p>
                                                <div>
                                                    <table border="0">
                                                        <tr>
                                                            <td align="left">JobDescId</td>
                                                            <td>&nbsp;-:&nbsp;</td>
                                                            <td align="left"><%= o.getJobDescId() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">Preset Name</td>
                                                            <td>&nbsp;-:&nbsp;</td>
                                                            <td align="left"><%= preset.getName() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">PresetId</td>
                                                            <td>&nbsp;-:&nbsp;</td>
                                                            <td align="left"><%= preset.getId() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">FolderName</td>
                                                            <td>&nbsp;-:&nbsp;</td>
                                                            <td align="left"><%= o.getFolderName() %></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">KeySuffix</td>
                                                            <td>&nbsp;-:&nbsp;</td>
                                                            <td align="left"><%= o.getKeySuffix()%></td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                </p>    
                                                <% } %>  
                                            </td>
                                        </tr>
                                    </table>
                                </div>                                
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <form action="doactiontrans.jsp" method="post" >
                                    <input type="hidden" name="dotransjob"  id="dotransjob" value="jobdescidforprocess"/>
                                    <input type="hidden" name="jobdescidforprocess" value="<%=id%>" />
                                    <input type="submit"  value="EXECUTE_JOB" style="color: #FFFFFF; background-color: #800000"/>
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>           
                        
                    </td>
                </tr>
<% } %>                
            </table>
        </div>
        
   
            

            
            
            
            
            
                                  
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
