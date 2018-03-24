<%

    String tmp = request.getRequestURI();
    String tmp1 =  request.getRequestURL().toString();
    String homePage = tmp1.substring(0,tmp1.lastIndexOf(tmp))+request.getContextPath()+"/trans/transcoder.jsp";    
    response.sendRedirect(homePage);
%>