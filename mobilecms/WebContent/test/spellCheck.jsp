<%@ taglib uri="/WEB-INF/RapidSpellWeb.tld" prefix="RapidSpellWeb" %>
<HTML>
   <HEAD>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

      <TITLE>Spell Check </TITLE>

<style>
/*  Layout lines */

body{
        font-family: arial, sans-serif, helvetica;
        font-size: 9pt;
}

p, li, ul, td{
        font-family: arial, sans-serif, helvetica;
        font-size: 9pt;
}


.osHead{
        color: #94ABD4;
}




.section .heading{
                font-family: arial, sans-serif, helvetica;
                font-size: 9pt;
                color: #006699;
                text-align: left;
                width: 100%;
                border-bottom: 1px solid #95A9D3;

                margin-bottom:4px;
}







h2{
        font-family: arial, sans-serif, helvetica;
        font-size: 16pt;
        font-weight: normal;
        color: #006699;
}

.pageTitle{
        font-family: arial, sans-serif, helvetica;
        font-size: 18pt;
        color: #006699;
}

.pageTitleVersion{
        font-family: arial, sans-serif, helvetica;
        font-size: 12pt;
        font-weight: normal;
        color: #006699;
}

a:link, a:visited {
        font-family: arial, sans-serif, helvetica;
        font-size: 9pt;
        text-decoration:none;
        color: #003366;
}

a:hover{
        font-family: arial, sans-serif, helvetica;
        color: #006699;
}


a.thumbnail:link, 	a.thumbnail:visited,	a.thumbnail:hover{
        font-family: arial, sans-serif, helvetica;
        font-size: 7pt;
        text-decoration:none;
        color: #006699;
}

td.topLinks{
        font-family: arial, sans-serif, helvetica;
        font-size: 8pt;
        text-decoration: none;
        color: #000000;

}



.copyrightMessage{
        text-align: center;
        font-family: arial, sans-serif, helvetica;
        font-size: 8pt;
        color: #006699;
}

</style>
      </HEAD>
   <BODY bgcolor="#EAEEF7" topmargin="0" marginheight="0" marginwidth="0" leftmargin="0" rightmargin="0" marginright="0" bottommargin="0" link="#a1aD00" vlink="#a1aD00" alink="#a1aD00">
   
									 

									 <form action='exampleTextBox1.jsp' method='post' name='myForm'>
										 <input type='hidden' name='fMessage' value='complete'>
										 <textarea name="sourceTextBox" wrap='true' cols='40' rows='10'>This this is some sample text with daliberate spelling errars</textarea>
										 <br>
										 <RapidSpellWeb:rapidSpellWebLauncher
											rapidSpellWebPage="RapidSpellCheckerPopUp.jsp"
											textComponentName="myForm.sourceTextBox"
											userDictionaryFile="/rapidspellweb-user-dictionary.txt"
											includeUserDictionaryInSuggestions="true"
											/>
										 <input type='submit'>
									 </form>
</BODY>
</HTML>

