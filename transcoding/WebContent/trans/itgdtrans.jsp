<%-- 
    Document   : itgdtrans
    Created on : Jun 3, 2013, 4:21:57 PM
    Author     : vijayendrar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form action="login.jsp" method="post"> 
        <table>
            <tr>
                <td>User Name</td>
                <td>:</td>
                <td><input type="text" name="username" /></td>
            </tr>
            <tr>
                <td>Password</td>
                <td>:</td>
                <td><input type="password" name="password" /></td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <input type="submit" value="login" />
                </td>
            </tr>
        </table>
        </form>    
    </body>
</html>
