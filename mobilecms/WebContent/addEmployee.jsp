<%
	String firstname = (String)session.getAttribute("fname");
	String emp_Id = (String)session.getAttribute("empId");
	if(firstname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<html>
<head>
<title>Create your account</title>
    <LINK HREF="stylesheet.css" REL="stylesheet" TYPE="text/css">
<script LANGUAGE="JavaScript" src="jscript/itgo_functions.js"></script>
<script language="JavaScript">
<!--
	function fnValidate()
	{
		if (ChkBlank("userDetails.fname","Please enter your first name.") == false) 
			return false
		if (ChkBlank("userDetails.lname","Please enter your last name.") == false) 
			return false
		if (ChkBlank("userDetails.uname","Please write your  name .") == false) 
			return false
		if (ChkBlankSpace("userDetails.uname","Please write your user name without any space.") == false) 
			return false
		if (ChkBlank("userDetails.pwd","Please write password.") == false) 
			return false
		if (ChkBlank("userDetails.email","Please write email address") == false) 
			return false
		if (ChkEmail("userDetails.email","Please include a proper email address.") == false) 
			return false
		if (ChkBlank("userDetails.mobile_no","Please enter mobile number.") == false) 
			return false
		if (ChkNumber("userDetails.mobile_no","Please enter mobile number(number only).") == false) 
			return false
	}
//-->
</script>
<script type="text/javascript">
// Removes leading whitespaces
function LTrim( value ) {
	
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
	
}

// Removes ending whitespaces
function RTrim( value ) {
	
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
	
}

// Removes leading and ending whitespaces
function trim( value ) {
	
	return LTrim(RTrim(value));
	
}

function handleHttpResponse2()
{
	if (http2.readyState == 4)
    {
		var results = http2.responseText
			results = trim(results);
		//alert('alert '+results.length);
		if (trim(results) == "WRONG")
		{
			alert("Please chose another user name")
			document.userDetails.uname.select();
		}

		//alert("result = " + results);
		//document.getElementById("response").value = results
     }
}

function checkUser()
{
	var email = document.getElementById("uname").value;
	//alert(email);
	var url="checkUser.jsp?email=" + encodeURI(email);
	//alert(url);
	 http2.open("GET", url, true);
     http2.onreadystatechange = handleHttpResponse2;
     http2.send(null);
}

function getHTTPObject()
{
	var xmlhttp;
    if(window.XMLHttpRequest)
    {
		xmlhttp = new XMLHttpRequest();
    }
	else if (window.ActiveXObject)
    {
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		if (!xmlhttp)
        {
			xmlhttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
	}
    return xmlhttp;
}

    var http2 = getHTTPObject();
</script>

</head>
<body>
 
<jsp:include page="topBand.jsp" />

<center><br>
<form method=post action="createNewEmployee.jsp" name="userDetails">
  <TABLE WIDTH="779" BORDER="1" CELLSPACING="0" CELLPADDING="3" 
    ALIGN="CENTER" STYLE="border-collapse:collapse;" BORDERCOLOR="#ECECEC" 
    CLASS="text1">

<%
		if(request.getParameter("msg") != null)
		{
%>
			 <tr>
	<td colspan="2" align="center">
		<font size="2" color="red" face="verdana"><b>
			<center><font size="2" color="red" face="verdana"><b><%=request.getParameter("fname")%> <%=request.getParameter("msg")%></b></font></center>
				</b></font>
	</td>
</tr>
<%
		}
%>

<tr>
	<td>Name</td>
	<td><input type="text" name="fname" size="12" maxlength="50"> <input type="text" name="mname" size="10" maxlength="50"> <input type="text" name="lname" size="10" maxlength="50"></td>
</tr>

<tr>
	<td>User Name</td>
	<td><input type="text" name="uname" size="12" maxlength="50" ONBLUR="checkUser()"></td>
</tr>
<tr>
	<td>Password</td>
	<td><input type="password" name="pwd" size="12" maxlength="50"></td>
</tr>

<tr>
	<td>Email :</td>
	<td><input type="text" name="email" onblur="checkUser()" size="20" maxlength="50"></td>
</tr>
<tr>
	<td>Date Of Birth</td>
	<td>
		<SELECT NAME="day" CLASS="fldnew" SIZE="1">
            <OPTION VALUE="1">01</OPTION>
            <OPTION VALUE="2">02</OPTION>
            <OPTION VALUE="3">03</OPTION>
            <OPTION VALUE="4">04</OPTION>
            <OPTION VALUE="5">05</OPTION>
            <OPTION VALUE="6">06</OPTION>
            <OPTION VALUE="7">07</OPTION>
            <OPTION VALUE="8">08</OPTION>
            <OPTION VALUE="9">09</OPTION>
            <OPTION VALUE="10">10</OPTION>
            <OPTION VALUE="11">11</OPTION>
            <OPTION VALUE="12">12</OPTION>
            <OPTION VALUE="13">13</OPTION>
            <OPTION VALUE="14">14</OPTION>
            <OPTION VALUE="15">15</OPTION>
            <OPTION VALUE="16">16</OPTION>
            <OPTION VALUE="17">17</OPTION>
            <OPTION VALUE="18">18</OPTION>
            <OPTION VALUE="19">19</OPTION>
            <OPTION VALUE="20">20</OPTION>
            <OPTION VALUE="21">21</OPTION>
            <OPTION VALUE="22">22</OPTION>
            <OPTION VALUE="23">23</OPTION>
            <OPTION VALUE="24">24</OPTION>
            <OPTION VALUE="25">25</OPTION>
            <OPTION VALUE="26">26</OPTION>
            <OPTION VALUE="27">27</OPTION>
            <OPTION VALUE="28">28</OPTION>
            <OPTION VALUE="29">29</OPTION>
            <OPTION VALUE="30">30</OPTION>
            <OPTION VALUE="31">31</OPTION></SELECT>
			
			<SELECT NAME="month" CLASS="fldnew" SIZE="1">
            <OPTION VALUE="1">Jan</OPTION>
            <OPTION VALUE="2">Feb</OPTION>
            <OPTION VALUE="3">Mar</OPTION>
            <OPTION VALUE="4">Apr</OPTION>
            <OPTION VALUE="5">May</OPTION>
            <OPTION VALUE="6">Jun</OPTION>
            <OPTION VALUE="7">Jul</OPTION>
            <OPTION VALUE="8">Aug</OPTION>
            <OPTION VALUE="9">Sep</OPTION>
            <OPTION VALUE="10">Oct</OPTION>
            <OPTION VALUE="11">Nov</OPTION>
            <OPTION VALUE="12">Dec</OPTION></SELECT>
            
			<SELECT NAME="year" CLASS="fldnew" SIZE="1">
            <OPTION VALUE="1988">1988</OPTION>
            <OPTION VALUE="1987">1987</OPTION>
            <OPTION VALUE="1986">1986</OPTION>
            <OPTION VALUE="1985">1985</OPTION>
            <OPTION VALUE="1984">1984</OPTION>
            <OPTION VALUE="1983">1983</OPTION>
            <OPTION VALUE="1982">1982</OPTION>
            <OPTION VALUE="1981">1981</OPTION>
            <OPTION VALUE="1980">1980</OPTION>
            <OPTION VALUE="1979">1979</OPTION>
            <OPTION VALUE="1978">1978</OPTION>
            <OPTION VALUE="1977">1977</OPTION>
            <OPTION VALUE="1976">1976</OPTION>
            <OPTION VALUE="1975" SELECTED="SELECTED">1975</OPTION>
            <OPTION VALUE="1974">1974</OPTION>
            <OPTION VALUE="1973">1973</OPTION>
            <OPTION VALUE="1972">1972</OPTION>
            <OPTION VALUE="1971">1971</OPTION>
            <OPTION VALUE="1970">1970</OPTION>
            <OPTION VALUE="1969">1969</OPTION>
            <OPTION VALUE="1968">1968</OPTION>
            <OPTION VALUE="1967">1967</OPTION>
            <OPTION VALUE="1966">1966</OPTION>
            <OPTION VALUE="1965">1965</OPTION>
            <OPTION VALUE="1964">1964</OPTION>
            <OPTION VALUE="1963">1963</OPTION>
            <OPTION VALUE="1962">1962</OPTION>
            <OPTION VALUE="1961">1961</OPTION>
            <OPTION VALUE="1960">1960</OPTION>
            <OPTION VALUE="1959">1959</OPTION>
            <OPTION VALUE="1958">1958</OPTION>
            <OPTION VALUE="1957">1957</OPTION>
            <OPTION VALUE="1956">1956</OPTION>
            <OPTION VALUE="1955">1955</OPTION>
            <OPTION VALUE="1954">1954</OPTION>
            <OPTION VALUE="1953">1953</OPTION>
            <OPTION VALUE="1952">1952</OPTION>
            <OPTION VALUE="1951">1951</OPTION>
            <OPTION VALUE="1950">1950</OPTION>
            <OPTION VALUE="1949">1949</OPTION>
            <OPTION VALUE="1948">1948</OPTION>
            <OPTION VALUE="1947">1947</OPTION>
            <OPTION VALUE="1946">1946</OPTION>
            <OPTION VALUE="1945">1945</OPTION>
            <OPTION VALUE="1944">1944</OPTION>
            <OPTION VALUE="1943">1943</OPTION>
            <OPTION VALUE="1942">1942</OPTION>
            <OPTION VALUE="1941">1941</OPTION>
            <OPTION VALUE="1940">1940</OPTION>
            <OPTION VALUE="1939">1939</OPTION>
            <OPTION VALUE="1938">1938</OPTION>
            <OPTION VALUE="1937">1937</OPTION>
            <OPTION VALUE="1936">1936</OPTION>
            <OPTION VALUE="1935">1935</OPTION></SELECT>
	</td>
</tr>

<tr>
	<td>Mobile No</td>
	<td><input type="text" name="mobile_no" size="20" maxlength="10"></td>
</tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="Submit" onclick ="return fnValidate();"></td>
</tr>
</table>
</form>
</center>
</body>
</html>