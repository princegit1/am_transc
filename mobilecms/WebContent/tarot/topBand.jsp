<TABLE cellSpacing=0 cellPadding=0 width=600 align=center border=1 hspace="5" vspace="5">
  <TR>
    <TD vAlign=center align=middle height=40>
		<a href="/content/mobileHome.jsp"><IMG src="/content/img/itg-logo.gif" border="0"> </a>
	</TD>
	</TR>
	<TR>
		<TD>
			<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center">
			<tr align="center">
<%
			/*String emp_role = "";
			try
			{
				emp_role  = (String)session.getAttribute("emp_role");
			}
			catch(Exception ex)
			{
				emp_role  = "USER";
			}
			if(emp_role.equals("ADMINISTRATOR"))
			{*/
%>
				<td><a href="/content/showInsertCategory.jsp" class="lnkbld">Show/Insert New Category</a></td>
<%
			//}	
%>
				<td><a href="/content/showCategory.jsp">Insert Message</a></td>
				<td><a href="/content/astro/index.jsp">Insert Astro</a></td>
				<td><a href="/content/tarot/index.jsp">Insert Tarot</a></td>
				<!-- <td><a href="/content/todayMessage.jsp">Check Today</a></td> -->
				<td><a href="/content/ChangePassword.html">Change Password</a></td>
				<td><a href="/content/logout.jsp">Log Out</a></td>
			</tr>
			</table>
	</TD>
    </TR>
	</table>