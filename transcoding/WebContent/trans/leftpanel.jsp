<%-- 
    Document   : leftpanel
    Created on : Jun 3, 2013, 3:00:58 PM
    Author     : vijayendrar
--%>
<%
try {     
String logedIn = (String) session.getAttribute("transcodesessionvalue");
if(!(logedIn!=null && logedIn.equals("logedINTrue"))) {
    response.sendRedirect("itgdtrans.jsp");
} else {   
%>

<table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td align="left">
            <form action="transcode_result.jsp" method="get">
                <input type="submit" value="Transcode_results" style="color: #FFFFFF; background-color: #800000; width: 170px; height: 30px; font-weight: bold; cursor: pointer; width: 100%; text-align: left;">                                 
            </form>           
        </td>
    </tr>      
    <tr>
        <td align="left">
            <form action="amazonawsjobdesc.jsp" method="get">
                <input type="submit" value="ADD JOB DESC" style="color: #FFFFFF; background-color: #800000; width: 170px; height: 30px; font-weight: bold; cursor: pointer; width: 100%; text-align: left;">                                 
            </form>
        </td>
    </tr>    
    <tr>
        <td align="left">
            <form action="amazobawsjoboutputdesc.jsp" method="get">
                <input type="submit" value="ADD OUTPUT" style="color: #FFFFFF; background-color: #800000; width: 170px; height: 30px; font-weight: bold; cursor: pointer; width: 100%; text-align: left;">                                 
            </form>
        </td>  
    </tr>
    <tr>
        <td align="left">
            <form action="process.jsp" method="get">
                <input type="submit" value="EXECUTE JOB" style="color: #FFFFFF; background-color: #800000; width: 170px; height: 30px; font-weight: bold; cursor: pointer; width: 100%; text-align: left;">                                 
            </form>
        </td>          
    </tr>    
    <tr>
        <td align="left">
            <form action="activatejob.jsp" method="get">
                <input type="submit" value="ACTIVATE JOB" style="color: #FFFFFF; background-color: #800000; width: 170px; height: 30px; font-weight: bold; cursor: pointer; width: 100%; text-align: left;">                                 
            </form>
        </td>          
    </tr>      
  
</table>
<% 
}
}catch(Exception ex) {
    ex.printStackTrace();
    response.sendRedirect("itgdtrans.jsp");
}    
%>
