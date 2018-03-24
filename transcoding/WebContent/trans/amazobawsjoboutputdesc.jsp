<%-- 
    Document   : amazobawsjoboutputdesc
    Created on : May 31, 2013, 8:32:56 PM
    Author     : vijayendrar
--%>




<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.itgd.transcoder.bean.AmazonAwsJobDesc"%>
<%@page import="com.itgd.transcoder.dao.AmazonTranscodingDAO"%>
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
	AmazonTranscodingDAO dAO = new AmazonTranscodingDAO();
    PresetService presetService = new PresetService();
    List<Preset> presetList = presetService.getPresetList(); 
    List<AmazonAwsJobDesc_12> amazonAwsJobDescsList = dAO.listAmazonAwsJobDesc(getProfileIdFromConfiguration());
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">        
            function validateFields() {
                var jobDescId = document.getElementById('jobDescId');
                var presetId = document.getElementById('presetId');
                var keySuffix = document.getElementById('keySuffix');
                var folderName = document.getElementById('folderName');

                if(!(jobDescId!=null && !jobDescId.value == '')) {
                    alert("Plese select Job Desc.");
                    return false;
                }else if(!(presetId!=null && !presetId.value == '')) {
                    alert("Please select preset.");
                    return false;
                }else if(!(keySuffix!=null && !keySuffix.value == '')) {
                    alert("Fill keySuffix Name.");
                    return false;
                }else if(!(folderName!=null && !folderName.value == '')) {
                    alert("Fill Folder Name.");
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
                                        <input type="hidden" name="dotransjob"  id="dotransjob" value="AmazobAwsJobOutputDesc"/>
                                    <div>
                                    <table>
                                        <tr>
                                            <td colspan="3"><center><h3>ADD Preset to job</h3></center></td>
                                        </tr>                                                                          
                                        <tr>
                                            <td align="left">Select Job Name</td>
                                            <td>:</td>
                                            <td align="left">
                                                <select name="jobDescId" id="jobDescId">
                                                    <option value="">-select-</option>
                                                    <%
                                                    	for(AmazonAwsJobDesc_12 o: amazonAwsJobDescsList) {
                                                    %>
                                                    <option value="<%= o.getAutoId() %>"><%= o.getJobDescName() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Select Preset ID to add</td>
                                            <td>:</td>
                                            <td align="left">
                                                <select name="presetId" id="presetId">
                                                    <option value="">-select-</option>
                                                    <% for(Preset p: presetList) { %>
                                                    <option value="<%= p.getId() %>"><%= p.getName() %></option>
                                                    <% } %>
                                                </select>
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td align="left">File name suffix to transcoded file </td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="keySuffix"  id="keySuffix"/></td>
                                        </tr>   
                                        <tr>
                                            <td align="left">Folder name to be created by default for output</td>
                                            <td>:</td>
                                            <td align="left"><input type="text" name="folderName"  id="folderName"/></td>
                                        </tr>   
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>   
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>   
                                        <tr>
                                            <td colspan="3">
                                                <input type="submit" value="Add Preset to Job" style="color: #FFFFFF; background-color: #800000"/>
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