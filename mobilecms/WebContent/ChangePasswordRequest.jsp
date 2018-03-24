<html>
	<head>
		<title>Change Password</title>
		<SCRIPT LANGUAGE="JavaScript">
			function validatePwd()
			{
				var invalid = " "; // Invalid character is a space
				var minLength = 6; // Minimum length
				var pw1 = document.form1.newpassword.value;
				var pw2 = document.form1.confirmnewpassword.value;
				// check for a value in both fields.
				if (pw1 == '' || pw2 == '')
				{
					alert('Please enter new password twice.');
					document.form1.confirmnewpassword.focus();
					return false;
				}
				// check for minimum length
				if (document.form1.newpassword.value.length < minLength)
				{
					alert('Your new password must be at least ' + minLength + ' characters long. Enter again.');
					document.form1.confirmnewpassword.focus();
					return false;
				}
				// check for spaces
				if (document.form1.newpassword.value.indexOf(invalid) > -1)
				{
					alert("Sorry, spaces in passwords are not allowed.");
					document.form1.confirmnewpassword.focus();
					return false;
				}
				else
				{
					if (pw1 != pw2)
					{
					alert ("The two values for the New Password do not match.\n\n Please Enter again.");
					document.form1.confirmnewpassword.select();
					document.form1.confirmnewpassword.focus();
					return false;
					}
				}
			}
	
			function validate(form)
			{				
				if (form.oldpassword.value=="")
				{
					alert("Please Enter Old Password.")
					form.oldpassword.focus();
					return(false);
				}
				var pwold = document.form1.oldpassword.value;
				var pwnew = document.form1.newpassword.value;
				var pwlength = document.form1.newpassword.value.length;
				var no_of_num =  0;
				var no_of_chrup = 0;
				var no_of_chrlo = 0;
				var no_of_chr = 0;
				for(var i=0;i<pwlength;i++)
				{
					var ch = pwnew.substring(i, i + 1);
					var ch_up = pwnew.substring(i, i + 1);
					var ch_lo = pwnew.substring(i, i + 1);
					var ch_la = pwnew.substring(i, i + 1);
					//alert(ch);
					//alert(pwlength);
					if(ch == "0" || ch == "1" || ch == "2" || ch == "3" || ch == "4" || ch == "5" || ch == "6" || ch == "7" || ch == "8" || ch=="9" ) 
					{
						no_of_num++;
					}
					if(ch == "A" || ch == "B" || ch == "C" || ch == "D" || ch == "E" || ch == "F" || ch == "G" || ch == "H" || ch == "I" || ch=="J" || ch == "K" || ch == "L" || ch == "M" || ch == "N" || ch == "O" || ch == "P" || ch == "Q" || ch == "R" || ch=="S" || ch == "T" || ch == "U" || ch == "V" || ch == "W" || ch == "X" || ch == "Y" || ch == "Z" || ch == "a" || ch == "b" || ch == "c" || ch == "d" || ch == "e" || ch == "f" || ch == "g" || ch == "h" || ch == "i" || ch=="j" || ch == "k" || ch == "l" || ch == "m" || ch == "n" || ch == "o" || ch == "p" || ch == "q" || ch == "r" || ch=="s" || ch == "t" || ch == "u" || ch == "v" || ch == "w" || ch == "x" || ch == "y" || ch == "z")
					{
						no_of_chr++;
					}
				}
				if(no_of_num < 2)
				{
					alert("\nThe New Password must have at least 2 alphabets and 2 digits.\n\nPlease re-enter your New Password.");
					document.forms[0].newpassword.select();
					document.forms[0].newpassword.focus();
					ch++;
					return false;
					}
					if (no_of_chr < 2){
					alert("\nThe New Password must have at least 2 alphabets and 2 digits.\n\nPlease re-enter your New Password.");
					document.forms[0].newpassword.select();
					document.forms[0].newpassword.focus();
					no_of_chr++;
					return false;
				}
				if(pwold == pwnew) 
				{
					alert ("New Password cannot be the same as your Old Password.\n\n Please enter another new password.");
					document.forms[0].newpassword.select();
					document.form1.newpassword.focus();
					return false;
				}
				return true;
			}
		</script>
		<link rel="stylesheet" href="/styles/style.css" type="text/css">
		<script LANGUAGE="JavaScript" src="/jscript/itgo_functions.js"></script>
	</head>
	<body bgcolor="#FFFFFF" text="#000000">
		<jsp:include page="topBand.jsp" />
		<form  method="POST" action="ChangePassword.jsp" name="form1" onSubmit="return validatePwd()"> 
			<table align="center" width="50%" cellspacing="0" cellpadding="0" border="0">
				<tr height="50">
					<td colspan="2" align="center">
						<IMG src="img/airtel.bmp">
					</td>
				</tr>
				<tr bgcolor="#dcdcdc" height="20" valign="middle">
					<td colspan="2" align="center">
						<b><u>Change Your Password
					</td>
				</tr>
				<tr height="35" valign="middle">
					<td align="right" width="45%"><b>Old Password :</td>
					<td align="left" width="55%">&nbsp;&nbsp;<input type="password" name="oldpassword" size="20" maxlength="10"></td>
				</tr>
				<tr bgcolor="#dcdcdc" height="1">
					<td colspan="2" align="right">
					</td>
				</tr>
				<tr height="35" valign="middle">
					<td align="right"><b>New Password :</td>
					<td align="left">&nbsp;&nbsp;<input type="password" name="newpassword" size="20" maxlength="10"></td>
				</tr>
				<tr bgcolor="#dcdcdc" height="1">
					<td colspan="2" align="right">
					</td>
				</tr>
				<tr height="35" valign="middle">
					<td align="right"><b>Confirm New Password :</td>
					<td align="left">&nbsp;&nbsp;<input type="password"  name="confirmnewpassword" size="20" maxlength="10"></td>
				</tr>
				<tr bgcolor="#dcdcdc" height="1">
					<td colspan="2" align="right">
					</td>
				</tr>
				<tr height="55" valign="middle">
				    <TD colspan="2" align="center">
					  	<b>Note : </b>
					  	1. The New Password must have at least 2 alphabets and 2 digits.<br>
					  	&nbsp;&nbsp;&nbsp;2. New Password cannot be the same as your Old   Password.<br>
					  	3. Password must be at least six (6)characters long.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</TD>
				</TR>
				
				<tr bgcolor="#dcdcdc" height="40" valign="middle">
					<td colspan="2" align="center">
						<input type="reset" value="Reset" name="B2">&nbsp;&nbsp;
						<input type="Submit" value="Submit" name="B1" onClick="return validate(this.form)">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>