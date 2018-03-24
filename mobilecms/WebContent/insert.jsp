<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="conn.*" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"></meta>
    <title>
      Insert Message
    </title>
  </head>
  <body>
    <jsp:include page="topBand.jsp" />
    <center>
      <FORM  method=post name="newsForm" action="check.jsp">
      <TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=0>
          <tr valign="middle">
            <td align="center">
              Select Category: &nbsp;&nbsp;&nbsp;
              <select name="categoryId">
              <%
                ResultSet rst = null;
                Connection cn = null;
                Statement stmt = null;
                String upQuery = null;
                try
                {
                  if("AMT".equalsIgnoreCase((String)session.getAttribute("emp_role")))
                    upQuery = "select * from category_master where status='ACTIVE' and category_id in (9,10,32,40,41)";
                  else
                    upQuery = "select * from category_master where status='ACTIVE'";
                  upQuery += " order by category_type";
                  
                  cn = Utils.getConnection();
                  stmt = cn.createStatement();
                  rst = stmt.executeQuery(upQuery);
                  out.println(upQuery);
                  while(rst.next())
                  {
              %>
                    <option value="<%=rst.getInt("category_id")%>"><%=rst.getString("category_type")%> - <%=rst.getString("service_provider")%>
              <%
                  }
                }
                catch(Exception ee)
                {
                  out.print("Error!! "+ee.getMessage());
                }
                finally
                {
                  Utils.closeDBObjects(cn, stmt, null, rst);
                }
              %>
              </select>&nbsp;&nbsp;&nbsp;
              <input type="submit" value= " Insert Message &#187; ">
            </td>
          </tr>
        </table>
      </FORM>
    </center>
  </body>
</html>