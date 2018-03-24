<%

try {
    String uname = request.getParameter("username");
    String password = request.getParameter("password");
    if(uname!=null && !uname.equals("") && uname.equals("tarun") && password!=null && !password.equals("") && password.equals("tarun")) {
        session.setAttribute("transcodesessionvalue", "logedINTrue");
        response.sendRedirect("transcoder.jsp");
    } else {
        response.sendRedirect("itgdtrans.jsp");
    }
}catch(Exception ex) {
    response.sendRedirect("itgdtrans.jsp");
}

    

%>


