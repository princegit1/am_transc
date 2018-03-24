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
    int categoryId= Integer.parseInt(request.getParameter("categoryId"));
    
    Connection cn=null;
    
    String txtDate =  "";
    String txtNews =  "";
	String txtOrderingGet = "";
	int txtOrdering=0;

    AdminConn adminConn = AdminConn.getInstance();
    cn = adminConn.getConnection();
    Statement stmt = null;
    ResultSet rs= null;
    try
    {
     
	        String upQuery="select count(*) count from message_special where date(insert_date)=curdate() and category_id="+categoryId ;
			//out.println(upQuery);
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
				 for(int i=0;i<6;i++)
				  {
					 String message = request.getParameter("N1"+i);
					 int ordering =Integer.parseInt( request.getParameter("ord"+i));
                String sql="INSERT INTO message_special (category_id,message,update_emp_id,ordering,insert_date) VALUES (?,?,?,?,now())";
                PreparedStatement pstmt = cn.prepareStatement(sql);
                pstmt.setInt(1,categoryId);
                pstmt.setString(2,message);
                pstmt.setInt(3,empId);
				pstmt.setInt(4,ordering);
                pstmt.executeUpdate();
                //cn.commit();
				 //out.println(sql);
              }
			  }
              catch(Exception e)
              {
				 
                e.printStackTrace();
              }
              finally
              {
                rs = null;
                stmt = null;
              }
            }
            else
            {
              try
              {
				 for(int i=0;i<6;i++)
				  {
					 String message = request.getParameter("N1"+i);
					 int ordering =Integer.parseInt( request.getParameter("ord"+i));
					 int messageId =Integer.parseInt( request.getParameter("messageId"+i));

			    String sql="UPDATE message_special set message=? , update_emp_id=?, update_date=now(),ordering=? where category_id=? and message_id=? ";
                PreparedStatement pstmt = cn.prepareStatement(sql);
                pstmt.setString(1,message);
                pstmt.setInt(2,empId);
                pstmt.setInt(4,categoryId);
				 pstmt.setInt(5,messageId);
				pstmt.setInt(3,ordering);
                pstmt.executeUpdate();
				//out.println("MESAGE " +message);
				//out.println("QUERY " +sql);
                //cn.commit();
              }
			  }
              catch(Exception e)
              {
               e.printStackTrace();
              }
              finally
              {
                rs = null;
                stmt = null;
              }
            }
          }
    
    catch(Exception ex)
    {
      ex.printStackTrace();
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
    <table cellspacing="0" cellpadding="0" width="550" align="center" border="1">
      <tr>
        <td align="center">Successfully insterted.</td>
      </tr>
    </table>
  </body>
</html>