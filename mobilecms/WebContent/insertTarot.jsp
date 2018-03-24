<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="conn.*"%>
<html>
  <head>
    <title>
      Mobile Service
    </title>
  </head>
  <head></head>
  <body bgcolor="#ffffff">
    <jsp:include page="topBand.jsp"/>
    <%
    String fname = (String)session.getAttribute("fname");
    if(fname == null)
    {
      response.sendRedirect("index.jsp?msg=session exp.");
    }
    int empId = Integer.parseInt((String)session.getAttribute("empId"));
    int select_day = Integer.parseInt(request.getParameter("select_day"));
    int totalMsg = Integer.parseInt(request.getParameter("totalMsg"));
    int categoryId= Integer.parseInt(request.getParameter("categoryId"));
    
    Connection cn=null;
    
    String txtDate =  "";
    String txtNews =  "";
    AdminConn adminConn = AdminConn.getInstance();
    cn = adminConn.getConnection();
    Statement stmt = null;
    ResultSet rs= null;
    try
    {
      for(int i=1;i<=select_day;i++)
      {
        txtDate = request.getParameter("txtDate"+i);
        //out.println(txtDate);
        for(int k=1;k<=totalMsg;k++)
        {
          txtNews = request.getParameter("txtNews-"+k+"-"+i);
          //out.println(txtNews);
          int lenNews = 0;
          try
          {
            lenNews = txtNews.length();
          }
          catch(NullPointerException nex)
          {
            lenNews =0;
          }
          if(lenNews>10)
          {
            String upQuery="select count(*) count from message_details where run_date='"+txtDate+"' and category_id="+categoryId;
            stmt=cn.createStatement();
            rs=stmt.executeQuery(upQuery);
            int count = 0;
            if(rs.next())
            {
              count = rs.getInt("count");
            }
            
            if(count<=0)
            {
              try
              {
                String sql="INSERT INTO message_details (CATEGORY_ID,MESSAGE"+k+",RUN_DATE,UPDATE_EMP_ID) VALUES (?,?,?,?)";
                PreparedStatement pstmt = cn.prepareStatement(sql);
                pstmt.setInt(1,categoryId);
                pstmt.setString(2,txtNews);
                pstmt.setString(3,txtDate);
                pstmt.setInt(4,empId);
                pstmt.executeUpdate();
                //cn.commit();
              }
              catch(Exception e)
              {
                out.println(e.toString());
              }
              finally
              {
                rs = null;
                stmt = null;
              }
            }//end if
            else
            {
              try
              {
                String sql="UPDATE message_details set MESSAGE"+k+"=? , UPDATE_EMP_ID=?, update_date=now() where category_id=? and RUN_DATE=?";
                PreparedStatement pstmt = cn.prepareStatement(sql);
                pstmt.setString(1,txtNews);
                pstmt.setString(4,txtDate);
                pstmt.setInt(2,empId);
                pstmt.setInt(3,categoryId);
                pstmt.executeUpdate();
                //cn.commit();
              }
              catch(Exception e)
              {
                out.println(e.toString());
              }
              finally
              {
                rs = null;
                stmt = null;
              }
            }
          }
        }
      }
    }
    catch(Exception ex)
    {
      out.println(ex.toString());
    }
    finally
    {
      if(rs!=null)
      rs.close();
      if(stmt!=null)
      stmt.close();
      if(cn!=null)
      cn.close();
    }
    %>
    <table cellspacing="0" cellpadding="0" width="550" align="center"
           border="1">
      <tr>
        <td align="center">
          Successfully insterted.
          <br></br>
          <br></br>
        </td>
      </tr>
    </table>
  </body>
</html>