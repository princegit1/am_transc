/*
  -- Filename itgo_functions.js
  -- Version 1.0
  -- Author Giten Mitra
  -- Date 1/18/2007
*/

var PopWin;

var chrsz   = 8;

function binl2hex(binarray)
{
  var hexcase = 0;
  var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
  var str = "";
  for(var i = 0; i < binarray.length * 4; i++)
  {
    str += hex_tab.charAt((binarray[i>>2] >> ((i%4)*8+4)) & 0xF) +
           hex_tab.charAt((binarray[i>>2] >> ((i%4)*8  )) & 0xF);
  }
  return str;
}

function core_md5(x, len)
{
  /* append padding */
  x[len >> 5] |= 0x80 << ((len) % 32);
  x[(((len + 64) >>> 9) << 4) + 14] = len;

  var a =  1732584193;
  var b = -271733879;
  var c = -1732584194;
  var d =  271733878;

  for(var i = 0; i < x.length; i += 16)
  {
    var olda = a;
    var oldb = b;
    var oldc = c;
    var oldd = d;

    a = md5_ff(a, b, c, d, x[i+ 0], 7 , -680876936);
    d = md5_ff(d, a, b, c, x[i+ 1], 12, -389564586);
    c = md5_ff(c, d, a, b, x[i+ 2], 17,  606105819);
    b = md5_ff(b, c, d, a, x[i+ 3], 22, -1044525330);
    a = md5_ff(a, b, c, d, x[i+ 4], 7 , -176418897);
    d = md5_ff(d, a, b, c, x[i+ 5], 12,  1200080426);
    c = md5_ff(c, d, a, b, x[i+ 6], 17, -1473231341);
    b = md5_ff(b, c, d, a, x[i+ 7], 22, -45705983);
    a = md5_ff(a, b, c, d, x[i+ 8], 7 ,  1770035416);
    d = md5_ff(d, a, b, c, x[i+ 9], 12, -1958414417);
    c = md5_ff(c, d, a, b, x[i+10], 17, -42063);
    b = md5_ff(b, c, d, a, x[i+11], 22, -1990404162);
    a = md5_ff(a, b, c, d, x[i+12], 7 ,  1804603682);
    d = md5_ff(d, a, b, c, x[i+13], 12, -40341101);
    c = md5_ff(c, d, a, b, x[i+14], 17, -1502002290);
    b = md5_ff(b, c, d, a, x[i+15], 22,  1236535329);

    a = md5_gg(a, b, c, d, x[i+ 1], 5 , -165796510);
    d = md5_gg(d, a, b, c, x[i+ 6], 9 , -1069501632);
    c = md5_gg(c, d, a, b, x[i+11], 14,  643717713);
    b = md5_gg(b, c, d, a, x[i+ 0], 20, -373897302);
    a = md5_gg(a, b, c, d, x[i+ 5], 5 , -701558691);
    d = md5_gg(d, a, b, c, x[i+10], 9 ,  38016083);
    c = md5_gg(c, d, a, b, x[i+15], 14, -660478335);
    b = md5_gg(b, c, d, a, x[i+ 4], 20, -405537848);
    a = md5_gg(a, b, c, d, x[i+ 9], 5 ,  568446438);
    d = md5_gg(d, a, b, c, x[i+14], 9 , -1019803690);
    c = md5_gg(c, d, a, b, x[i+ 3], 14, -187363961);
    b = md5_gg(b, c, d, a, x[i+ 8], 20,  1163531501);
    a = md5_gg(a, b, c, d, x[i+13], 5 , -1444681467);
    d = md5_gg(d, a, b, c, x[i+ 2], 9 , -51403784);
    c = md5_gg(c, d, a, b, x[i+ 7], 14,  1735328473);
    b = md5_gg(b, c, d, a, x[i+12], 20, -1926607734);

    a = md5_hh(a, b, c, d, x[i+ 5], 4 , -378558);
    d = md5_hh(d, a, b, c, x[i+ 8], 11, -2022574463);
    c = md5_hh(c, d, a, b, x[i+11], 16,  1839030562);
    b = md5_hh(b, c, d, a, x[i+14], 23, -35309556);
    a = md5_hh(a, b, c, d, x[i+ 1], 4 , -1530992060);
    d = md5_hh(d, a, b, c, x[i+ 4], 11,  1272893353);
    c = md5_hh(c, d, a, b, x[i+ 7], 16, -155497632);
    b = md5_hh(b, c, d, a, x[i+10], 23, -1094730640);
    a = md5_hh(a, b, c, d, x[i+13], 4 ,  681279174);
    d = md5_hh(d, a, b, c, x[i+ 0], 11, -358537222);
    c = md5_hh(c, d, a, b, x[i+ 3], 16, -722521979);
    b = md5_hh(b, c, d, a, x[i+ 6], 23,  76029189);
    a = md5_hh(a, b, c, d, x[i+ 9], 4 , -640364487);
    d = md5_hh(d, a, b, c, x[i+12], 11, -421815835);
    c = md5_hh(c, d, a, b, x[i+15], 16,  530742520);
    b = md5_hh(b, c, d, a, x[i+ 2], 23, -995338651);

    a = md5_ii(a, b, c, d, x[i+ 0], 6 , -198630844);
    d = md5_ii(d, a, b, c, x[i+ 7], 10,  1126891415);
    c = md5_ii(c, d, a, b, x[i+14], 15, -1416354905);
    b = md5_ii(b, c, d, a, x[i+ 5], 21, -57434055);
    a = md5_ii(a, b, c, d, x[i+12], 6 ,  1700485571);
    d = md5_ii(d, a, b, c, x[i+ 3], 10, -1894986606);
    c = md5_ii(c, d, a, b, x[i+10], 15, -1051523);
    b = md5_ii(b, c, d, a, x[i+ 1], 21, -2054922799);
    a = md5_ii(a, b, c, d, x[i+ 8], 6 ,  1873313359);
    d = md5_ii(d, a, b, c, x[i+15], 10, -30611744);
    c = md5_ii(c, d, a, b, x[i+ 6], 15, -1560198380);
    b = md5_ii(b, c, d, a, x[i+13], 21,  1309151649);
    a = md5_ii(a, b, c, d, x[i+ 4], 6 , -145523070);
    d = md5_ii(d, a, b, c, x[i+11], 10, -1120210379);
    c = md5_ii(c, d, a, b, x[i+ 2], 15,  718787259);
    b = md5_ii(b, c, d, a, x[i+ 9], 21, -343485551);

    a = safe_add(a, olda);
    b = safe_add(b, oldb);
    c = safe_add(c, oldc);
    d = safe_add(d, oldd);
  }
  return Array(a, b, c, d);

}
function safe_add(x, y)
{
  var lsw = (x & 0xFFFF) + (y & 0xFFFF);
  var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
  return (msw << 16) | (lsw & 0xFFFF);
}

function md5_cmn(q, a, b, x, s, t)
{
  return safe_add(bit_rol(safe_add(safe_add(a, q), safe_add(x, t)), s),b);
}
function bit_rol(num, cnt)
{
  return (num << cnt) | (num >>> (32 - cnt));
}

function md5_ff(a, b, c, d, x, s, t)
{
  return md5_cmn((b & c) | ((~b) & d), a, b, x, s, t);
}
function md5_gg(a, b, c, d, x, s, t)
{
  return md5_cmn((b & d) | (c & (~d)), a, b, x, s, t);
}
function md5_hh(a, b, c, d, x, s, t)
{
  return md5_cmn(b ^ c ^ d, a, b, x, s, t);
}
function md5_ii(a, b, c, d, x, s, t)
{
  return md5_cmn(c ^ (b | (~d)), a, b, x, s, t);
}

function str2binl(str)
{
  var bin = Array();
  var mask = (1 << chrsz) - 1;
  for(var i = 0; i < str.length * chrsz; i += chrsz)
    bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (i%32);
  return bin;
}

function hex_md5(s){ return binl2hex(core_md5(str2binl(s), s.length * chrsz));}

//This function will check the blank field.
function ChkBlank(frmFieldName,errorMsg)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	var i;
	for(i=0;i<tmpString.length;i++)
	{
			if (tmpString.charAt(i) != ' ')
			break;
	}
	if (i == tmpString.length)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	else
		return true;
}

//This function check spacial character only
function ChkSpChars(frmFieldName, errorMsg)
{
	spchar = new Array("`","~","#","$","%","^","&","*","(",")","-","+","=","|","/",",","<",">","'",":",";","\\","\"","@","!","_","{","}","[","]",".","?");
	var emailtext = eval("String(document."+frmFieldName+".value)");
	for (var i = 0; i < spchar.length; i++)
	{
		if (emailtext.indexOf(spchar[i]) != -1)
		{	alert(errorMsg);
			//frmFieldName.focus();
			return false;
		}
	}
}

//This function check Blank space
function ChkBlankSpace(frmFieldName, errorMsg)
{
	spchar = new Array(" ");
	var value = eval("String(document."+frmFieldName+".value)");

	for (var i = 0; i < spchar.length; i++)
	{	
		if (value.indexOf(spchar[i]) != -1)
		{	
			alert(errorMsg);
			eval("String(document."+frmFieldName+".focus())");
			//frmFieldName.focus();
			return false;
		}
	}
}
///////////End

//This function check Email field. Like @,.,etc...........
function ChkEmail(frmFieldName,errorMsg)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	if (tmpString.search('@') == -1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}		
	if (tmpString.indexOf('.') == -1 || tmpString.indexOf('.') == tmpString.length-1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	if (tmpString.indexOf("@.") != -1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	if (tmpString.indexOf(".@") != -1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	if (tmpString.indexOf("<") != -1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	if (tmpString.indexOf(">") != -1)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	if (tmpString.charAt(tmpString.length-1) == ".")
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	
	var firstoccur = tmpString.indexOf("@");
	if (tmpString.indexOf("@",firstoccur+1) != -1)
	{	alert(errorMsg);
		eval("document."+frmFieldName+".focus()");
		return false;
	}
	
	
	return true;
}

//This function check Number field only............
function ChkNumber(frmFieldName,errorMsg)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	for(i=0;i < tmpString.length;i++)
	{			
		if((tmpString.charAt(i) < "0" || tmpString.charAt(i) > "9") && tmpString.charAt(i) != ".")
		break;
	}
	if(i < tmpString.length)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	else
		return true; 
}

///////////////
function ChkStartWithNumber(frmFieldName,errorMsg,startWith)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	var tstring = tmpString.substring(0,1);
	if(tstring == startWith )
	{
		return true; 
	}
	else
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
		
}
///////////////
function ChkFloat(frmFieldName,errorMsg)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	var i;

	if(tmpString.indexOf('.')!=tmpString.lastIndexOf('.'))
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	for(i=0;i < tmpString.length;i++)
	{			
		if((tmpString.charAt(i) < "0" || tmpString.charAt(i) > "9") && tmpString.charAt(i) != ".")
		break;
	}
	if(i < tmpString.length)
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	else
		return true;		
}

//This function check Combo field...........
function ChkCombo(frmFieldName,errorMsg)
{
	var selectedIndex = eval("String(document."+frmFieldName+".selectedIndex)");

	var tmpString = eval("String(document."+frmFieldName+".options["+selectedIndex+"].value)");
	if(tmpString == "0")
	{
		alert(errorMsg);
		eval("String(document."+frmFieldName+".focus())");
		return false;
	}
	else
		return true;
}

//This function check Date of birth field. Like Leap year, Feb. Month etc..............
function ChkDOB(frmDayField,frmMonthField,frmYearField)
{	
	var day = eval("document."+frmDayField+"[document."+frmDayField+".selectedIndex].value");
	var month = eval("document."+frmMonthField+"[document."+frmMonthField+".selectedIndex].value");
	var year = eval("document."+frmYearField+"[document."+frmYearField+".selectedIndex].value");

	if(month == 'JAN')
	{
		month = 01
	}
	else if(month == 'FEB')
	{
		month = 02
	}
	else if(month == 'MAR')
	{
		month = 03
	}
	else if(month == 'APR')
	{
		month = 04
	}
	else if(month == 'MAY')
	{
		month = 05
	}
	else if(month == 'JUN')
	{
		month = 06
	}
	else if(month == 'JUL')
	{
		month = 07
	}
	else if(month == 'AUG')
	{
		month = 08
	}
	else if(month == 'SEP')
	{
		month = 09
	}
	else if(month == 'OCT')
	{
		month = 10
	}
	else if(month == 'NOV')
	{
		month = 11
	}
	else if(month == 'DEC')
	{
		month = 12
	}

	
	if (day < 1 || day > 31)
	{
		alert("Day must be between 1 and 31.");
		eval("document."+frmDayField+".focus()");
		return false;
	}
	if (month < 1 || month > 12) 
	{ // check month range
		alert("Month must be between 1 and 12." + eval("document."+frmMonthField+".selected.value"));
		eval("document."+frmMonthField+".focus()");
		return false;
	}	
	if ((month==4 || month==6 || month==9 || month==11) && day==31) 
	{
		//alert(month+" does not have 31 days.");
		alert("This month does not have 31 days.");
		eval("document."+frmMonthField+".focus()");
		return false;
	}
	if (month == 2) 
	{ // check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			alert("February " + year + "  does not have " + day + " days.");
			eval("document."+frmMonthField+".focus()");
			return false;
		}
	}
	return true;
}


//This function check Date of birth field. Like Leap year, Feb. Month etc..............
function ChkDate(frmDayField,frmMonthField,frmYearField)
{	
	var day = eval("document."+frmDayField+"[document."+frmDayField+".selectedIndex].value");
	var month = eval("document."+frmMonthField+"[document."+frmMonthField+".selectedIndex].value");
	var year = eval("document."+frmYearField+"[document."+frmYearField+".selectedIndex].value");

	if (day < 1 || day > 31)
	{
		alert("Day must be between 1 and 31.");
		eval("document."+frmDayField+".focus()");
		return false;
	}
	if (month < 1 || month > 12) 
	{ // check month range
		alert("Month must be between 1 and 12." + eval("document."+frmMonthField+".selected.value"));
		eval("document."+frmMonthField+".focus()");
		return false;
	}	
	if ((month==4 || month==6 || month==9 || month==11) && day==31) 
	{
		//alert(month+" does not have 31 days.");
		alert("This month does not have 31 days.");
		eval("document."+frmMonthField+".focus()");
		return false;
	}
	if (month == 2) 
	{ // check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			alert("February " + year + "  does not have " + day + " days.");
			eval("document."+frmMonthField+".focus()");
			return false;
		}
	}
	return true;
}


//This function will open new window.
function OpenWindow(url,winName,wid,hig)
{
 win = open(url,winName,"width="+wid+",height="+hig+", toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=yes,resizable=1,left=2,top=0");
}

//Open window in Full Screen mode
function OpenWindowFullScreen(url,winName)
{
 win = open(url,winName,"fullscreen=1,toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=yes,resizable=0");
}

function OpenFixWindow(url,winName,wid,hig)
{
 win = open(url,winName,"width="+wid+",height="+hig+", toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=yes,resizable=0,left=2,top=0");
}

function openPopup(filename,winName)
{
	if (!PopWin || PopWin.closed)
		PopWin = window.open(filename,winName,'width=640,height=400,status=yes,scrollbars=yes');
	else
		PopWin.focus();
		
}

function SetZero(frmFieldName)
{
	var tmpString = eval("String(document."+frmFieldName+".value)");
	var i;
	for(i=0;i<tmpString.length;i++)
	{
			if (tmpString.charAt(i) != ' ')
			break;
	}
	if (i == tmpString.length)
	{
		eval("String(document."+frmFieldName+".value=0)");
	}
	else
		return true;
}

function validateDates(frmFieldName, message)
{
	var strDate = eval("String(document."+frmFieldName+".value)");
	if(strDate.indexOf("-")!=-1)
	{
		seperator = "-";
	}
	else
	{
		seperator = "/";
	}

	if(strDate.length != 0)
	{
		var strBDate = new String(strDate);
		var slashIndex = strBDate.indexOf(seperator);
		var strDay = strBDate.substring(0, slashIndex);
		strBDate = strBDate.substring(slashIndex + 1);
		slashIndex = strBDate.indexOf(seperator);
		var strMonth = strBDate.substring(0, slashIndex);
		strBDate = strBDate.substring(slashIndex + 1);
		var strYear = strBDate;

		if(!(strDay > 0 && strDay < 32))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if(!(strMonth > 0 && strMonth < 13))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if((!(strYear > 1900)) ||(strYear.length < 4))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if(!(checkDay(strDay, strMonth, strYear)))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
	}
	if(strDate.length != 0)
	{
		var strBDate = new String(strDate);
		var slashIndex = strBDate.indexOf(seperator);
		var strDay = strBDate.substring(0, slashIndex);
		strBDate = strBDate.substring(slashIndex + 1);
		slashIndex = strBDate.indexOf(seperator);
		var strMonth = strBDate.substring(0, slashIndex);
		strBDate = strBDate.substring(slashIndex + 1);
		var strYear = strBDate;

		if(!(strDay > 0 && strDay < 32))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if(!(strMonth > 0 && strMonth < 13))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if((!(strYear > 1900)) ||(strYear.length < 4))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
		if(!(checkDay(strDay, strMonth, strYear)))
		{
			alert(message);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
	}
	return true;
}

function checkDay(strDay, strMonth, strYear)
{
	var month = [1,2,3,4,5,6,7,8,9,10,11,12];
	var days = "";

	if(strYear%4 == 0)
	{
		days = [31,29,31,30,31,30,31,31,30,31,30,31];
	}
	else
	{
		days = [31,28,31,30,31,30,31,31,30,31,30,31];
	}

	var maxDay = days[strMonth-1];

	if(strDay > maxDay)
		return false;
	return true;
}

function dateRange(today,finy1,finy2,dateField)
{
	var date1 = eval("String(document."+dateField+".value)");
	var tmpval = date1.replace("/","-");
	tmpval = tmpval.replace("/","-");

	x2 = tmpval.lastIndexOf("-");
	x1 = tmpval.indexOf("-");

	var month = tmpval.substring(x1+1,x2)-1;
	var tmpdt = new Date(tmpval.substring(x2+1,tmpval.length),month,tmpval.substring(0,x1));

	if (tmpdt>today)
	{
		alert("Please give valid bill date. Bill Date can not exceed today's date.");
		eval("document."+dateField+".focus()");
		return false;
	}

	if(tmpdt<finy1 || tmpdt>finy2)
	{
		alert("Please enter the bill only for this financial year.");
		eval("document."+dateField+".focus()");
		return false;
	}
	return true;
}

function simpleDateRange(date1,date2,message)
{
	var tmpval1 = date1.replace("/","-");
	tmpval1 = tmpval1.replace("/","-");

	var tmpval2 = date2.replace("/","-");
	tmpval2 = tmpval2.replace("/","-");

	x2 = tmpval1.lastIndexOf("-");
	x1 = tmpval1.indexOf("-");
	var month = tmpval1.substring(x1+1,x2)-1;
	var tmpdt1 = new Date(tmpval1.substring(x2+1,tmpval1.length),month,tmpval1.substring(0,x1));

	x2 = tmpval2.lastIndexOf("-");
	x1 = tmpval2.indexOf("-");
	var month = tmpval2.substring(x1+1,x2)-1;
	var tmpdt2 = new Date(tmpval2.substring(x2+1,tmpval2.length),month,tmpval2.substring(0,x1));

	if (tmpdt1>tmpdt2) // Will reject same date also Ashish Yaduka 7/8/2005
	{
		alert(message);
		return false;
	}
	return true;
}

function advanceDateRange(today,finy1,finy2,dateField)
{
	var date1 = eval("String(document."+dateField+".value)");
	var tmpval = date1.replace("/","-");
	
	tmpval = tmpval.replace("/","-");

	x2 = tmpval.lastIndexOf("-");
	x1 = tmpval.indexOf("-");
	var month = tmpval.substring(x1+1,x2)-1;
	var tmpdt = new Date(tmpval.substring(x2+1,tmpval.length),month,tmpval.substring(0,x1));

	if (tmpdt>today)
	{
		alert("Please give valid payment date. Payment Date can not exceed today's date.");
		eval("document."+dateField+".focus()");
		return false;
	}

	if(tmpdt < finy1 || tmpdt > finy2)
	{
		alert("Please enter the payment only for this financial year.");
		eval("document."+dateField+".focus()");
		return false;
	}
	return true;

	//do nothing function to help managing the anchor tag incase on click is used
	function nothing(){}
}

/* Ashish 29-03-2005*/
//This function checks for the length in form fields 

function ChkLength(frmFieldName,errorMsg,len)
	{
		var tmpString = eval("String(document."+frmFieldName+".value)");
		
		if(tmpString.length >len)
			{
			alert(errorMsg);
			eval("document."+frmFieldName+".focus()");
			return false;
			}
	}
function ChkExactLength(frmFieldName,errorMsg,len)
	{
		
		var tmpString = eval("String(document."+frmFieldName+".value)");
		
		if(tmpString.length != len)
		{
			alert(errorMsg);
			eval("document."+frmFieldName+".focus()");
			return false;
		}
	}
function ChkMinLength(frmFieldName,errorMsg,len)
	{
		
		var tmpString = eval("String(document."+frmFieldName+".value)");
		
		if(tmpString.length <len)
			{
			alert(errorMsg);
			eval("document."+frmFieldName+".focus()");
			return false;
			}
	}

// check Dot Character in Mobile No.
function ChkDotInMobile(frmFieldName,errorMsg,len)
{
		var j=0;
		for(var i=0;i<len;i++)
		{
			var tmpString = eval("String(document."+frmFieldName+".value)");
			var tstring = tmpString.substring(j,++j);
			if(tstring == ".")
			{
				alert(errorMsg);
				eval("document."+frmFieldName+".focus()");
				return false;
			}
		}
}

	//Delete leading and trailing spaces
	function strTrim(frmfield)
		{
			// Delete leading sapces
			var j=(frmfield.value.length);
			var sum=0;
			var p;
			for(p=0;p<=j;p++)
				{
				if(frmfield.value.charAt(p)==' ')
					sum++;
				else
					break;
				}
			var st= frmfield.value.substring(sum,j);
			
			// Delete trailing sapces
			var x=(st.length)-1; // take length one less to tackle subscript
			var y=x+1;
			var len=0;	
			var i;
			for(i=x; i>=0; i--)
				{
				if(st.charAt(i)==' ')
					len++;
				else
					break;
				}
								
			y= y-len;
			var str= st.substring(0,y);
			frmfield.value= str;				
			
		}// Method closed
	function callAlert()
	{
		return confirm('If you choose this operation. You will loose the data of the form.\nAre your Sure ?.')
	}

// check the digits
function ChkDgChars(frmFieldName, errorMsg)
{
	dgchar = new Array("0","1","2","3","4","5","6","7","8","9");
	var check=0;
	var emailtext = eval("String(document."+frmFieldName+".value)");
	for (var i = 0; i < dgchar.length; i++)
	{	if (emailtext.indexOf(dgchar[i]) != -1)
		{	alert(errorMsg);
		//	frmFieldName.focus();
			return false;
		}
	}
}
