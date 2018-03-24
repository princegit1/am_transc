<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
%>
<html>
	<head>
		<title>Login &gt; Mobile Service</title>
		<link href="styles/main.css" rel="stylesheet" type="text/css">
		<script language="javascript">
			function validateForm()
			{
				if(document.forms[0].username.value == "")
				{
					alert("Please Fill in User Name");
					document.forms[0].username.focus();
					return false;
				}
				if(document.forms[0].password.value == "")
				{
					alert("Please Fill in Password");
					document.forms[0].password.focus();
					return false;
				}
			}
		</script>
	</head>
	<body>
		<table width="100%" cellSpacing="0" cellPadding="0" border="0">
			<tr valign="middle" height="55">
				<td rowspan="3" width="10%" align="center" bgcolor="#dcdcdc">
					<a href="/content/mobileHome.jsp"><IMG src="img/itg-logo.gif" border="0"></a>
				</td>
				<td align="right" bgcolor="#dcdcdc">
					&nbsp;
				</td>
			</tr>
			<tr valign="middle" height="20">
				<td>
					<table width="100%">
						<tr valign="bottom">
							<td>
								<b>
								I N D I A&nbsp;&nbsp;&nbsp;T O D A Y&nbsp;&nbsp;&nbsp;M O B I L E&nbsp;&nbsp;&nbsp;S E R V I C E S
								</b>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr bgcolor="#dcdcdc" valign="middle" height="20">
				<td align="right">
					<font color="red">
					<%
						if(errorMessage != null)
						{
							out.println(java.net.URLDecoder.decode(request.getParameter("msg")));
						}
					%>&nbsp;
					</font>
				</td>
			</tr>
			<tr height="5" bgcolor="#ffffff">
				<td colspan="2"></td>
			</tr>
		</table>
		<form method=post action="checkUserName.jsp" onsubmit="return validateForm()">
			<table align="center" width="30%" cellspacing="0" cellpadding="0" border="0">
				<tr height="50">
					<td colspan="2" align="right">
					</td>
				</tr>
				<tr bgcolor="#dcdcdc" height="20" valign="middle">
					<td colspan="2" align="center">
						<b><u>Login Here
					</td>
				</tr>
				<tr height="35" valign="middle">
					<td align="right"><b>User Name :</td>
					<td align="left">&nbsp;&nbsp;<input type="text" name="username" size="30"></td>
				</tr>
				<tr bgcolor="#dcdcdc" height="1">
					<td colspan="2" align="right">
					</td>
				</tr>
				<tr height="35" valign="middle">
					<td align="right"><b>Password :</td>
					<td align="left">&nbsp;&nbsp;<input type="password" name="password" size="30"></td>
				</tr>
				<tr bgcolor="#dcdcdc" height="40" valign="middle">
					<td colspan="2" align="center">
						<input type="reset" value=" Clear ">&nbsp;&nbsp;
						<input type="submit" value=" Login ">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>