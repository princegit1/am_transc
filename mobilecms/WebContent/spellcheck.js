/*
 * Software is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 *
 * The Initial Developer of this code is SoftCorporation LLC.
 * Usage of this code allowed only with reference to SoftCorporation LLC.
 * including the link to SoftCorporation LLC. web site: http://www.softcorporation.com
 * Copyright (C) 2005 SoftCorporation LLC. All Rights Reserved.
 */
var brid = "";
var spellCheckField;
var spellCheckText;
var resultID = 0;
var spellCheckLimit = 10; // default maximum number of suggestions
if (parseInt(navigator.appVersion)>=3)
{
  if (navigator.appName.indexOf("Microsoft")!=-1) brid = "IE"
  else if (navigator.appName.indexOf("Mac")!=-1) brid = "MAC"
  else if (navigator.appName.indexOf("Netscape")!=-1) brid = "NC";
}
if (brid != "IE") alert("Attention! This version works only with Microsoft Internet Explorer.");

function spellcheck(field, text, offset, limit) 
{
  spellCheckField=field;
  spellCheckText=text;
  spellCheckOffset=offset;
  spellCheckLimit=limit;
  var popupwindow=window.open('spellPopup.html','mywin','left=20,top=20,width=466,height=273,toolbar=0,resizable=0');
}

function ver() 
{
  alert(spellCheckApplet.getAppletInfo());
}

function check() 
{
  spellCheckApplet.check(opener.spellCheckText, opener.spellCheckOffset, opener.spellCheckLimit);
  refresh();
}

function checkNext() 
{
  spellCheckApplet.checkNext();
  refresh();
}

function refresh()
{
  spellCheckForm.changeBtn.disabled=true;
  spellCheckForm.changeAllBtn.disabled=true;
  spellCheckForm.ignoreBtn.disabled=true;
  spellCheckForm.ignoreAllBtn.disabled=true;
  spellCheckForm.suggestions.options.length=0;
  spellCheckForm.recommend.value="";

  resultID=spellCheckApplet.getResultID();
  if(resultID<0) // internal error
  {
    writeText("Suggester Error: " + resultID);
  }
  else if(resultID==0) // no errors found
  {
    writeText("No Spelling Errors Found.");
//    alert("No Spelling Errors Found.");
  }
  else if(resultID==1) // misspelings and suggestions found
  {
    writeText(getMisspeltText());
    selectRange(getMisspeltOffset(), getMisspeltLength());
    var sugs=spellCheckApplet.getSuggestions();
    var n=sugs.size()
    for (var i=0; i<n; i++)
    {
   	  spellCheckForm.suggestions.options[i]=new Option(sugs.get(i));
    }
    spellCheckForm.recommend.value=spellCheckForm.suggestions.options[0].text;
    spellCheckForm.changeBtn.disabled=false;
    spellCheckForm.changeAllBtn.disabled=false;
    spellCheckForm.ignoreBtn.disabled=false;
    spellCheckForm.ignoreAllBtn.disabled=false;
  }
  else if(resultID==2) // misspelings and no suggestions found
  {
    writeText(getMisspeltText());
    selectRange(getMisspeltOffset(), getMisspeltLength());
    spellCheckForm.recommend.value=spellCheckApplet.getMisspelt();
    spellCheckForm.suggestions.options[0]=new Option("No Suggestions.");
    spellCheckForm.changeBtn.disabled=false;
    spellCheckForm.changeAllBtn.disabled=false;
    spellCheckForm.ignoreBtn.disabled=false;
    spellCheckForm.ignoreAllBtn.disabled=false;
  }
  else if(resultID==3) // check complete
  {
    writeText("The Spelling Check is Complete.");
//    alert("The Spelling Check is Complete.");
  }
  else if(resultID>3) // special case
  {
    writeText(getMisspeltText());
    selectRange(getMisspeltOffset(), getMisspeltLength());
    spellCheckForm.recommend.value=spellCheckApplet.getMisspelt();
    spellCheckForm.suggestions.options[0]=new Option("Other options.");
    spellCheckForm.changeBtn.disabled=false;
    spellCheckForm.changeAllBtn.disabled=false;
    spellCheckForm.ignoreBtn.disabled=false;
    spellCheckForm.ignoreAllBtn.disabled=false;
  }
}

function getMisspeltOffset()
{
  var o=0;
  var text = spellCheckApplet.getText();
  var off = spellCheckApplet.getMisspeltOffset();
  for (i=0;i<off&&i<text.length;i++)
  { 
    if (text.charAt(i)=='\r')
	{ 
      o++;
    } 
  }
  return off-o;
}

function getMisspeltLength()
{
  return spellCheckApplet.getMisspeltLength();
}

function getMisspeltText()
{
  return spellCheckApplet.getMisspeltText(10, "<span id=\"highlight\" class=\"badWordHighlight\">", "</span>", 20);
}

function getMisspeltText1()
{
  var misText = spellCheckApplet.getMisspeltText(20, "<span id=\"highlight\" class=\"badWordHighlight\">", "</span>", 20);
  if (misText == null)
  {
    return "Suggester Internal Error";
  }
  return misText;
}

function writeText(text)
{
  var html='<html>';
  html+='<head>';
  html+='<link rel="stylesheet" href="spellPopup.css" type="text/css"/>';
  html+='<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>';
  html+='</head>';
  html+='<body marginwidth="4" marginheight="4" topmargin="4" leftmargin="4" onclick="setOriginal()">';
  html+="<pre-wrap>";
  html+='<font style="font-size:10pt; font-family:\'Courier New, Courier, arial, helvetica, sans-serif\';">';
  html+=text;
  html+='</font>';
  html+="</pre-wrap>";
  html+='</body></html>';
  iframeText.document.open();
  iframeText.document.write(html);
  iframeText.document.close();
  iframeText.focus();
  var elem = iframeText.document.getElementById("highlight");
  if (elem != null)
  {
    elem.scrollIntoView(false);
  }
}

function selectRange(pos, len)
{
  var tr=opener.spellCheckField.createTextRange();
  tr.move("character", pos);
  tr.moveEnd("character", len);
  tr.select();
}

function ignore()
{
//  spellCheckApplet.ignore();
  spellCheckApplet.checkNext();
  refresh();
}

function ignoreAll()
{
  spellCheckApplet.ignoreAll();
  spellCheckApplet.checkNext();
  refresh();
}

function change()
{
  if (spellCheckForm.changeBtn.disabled == false)
  {
    spellCheckApplet.change(spellCheckForm.recommend.value);
    opener.spellCheckEdit(opener.spellCheckField, spellCheckApplet.getText());
    spellCheckApplet.check();
    refresh();
  }
}

function changeAll()
{
  if (spellCheckForm.changeAllBtn.disabled == false)
  {
    spellCheckApplet.changeAll(spellCheckForm.recommend.value);
    opener.spellCheckEdit(opener.spellCheckField, spellCheckApplet.getText());
    spellCheckApplet.check();
    refresh();
  }
}

function finish()
{
//  opener.spellCheckEdit(opener.spellCheckField, spellCheckApplet.getText());
  window.close();
}

function cancel()
{
  opener.spellCheckEdit(opener.spellCheckField, opener.spellCheckText);
  window.close();
}

function saveWord()
{
  if (document.cookie.length>0)
  {
    cStart=document.cookie.indexOf("words=")
    if (cStart!=-1)
    { 
      cStart+=6; 
      cEnd=document.cookie.indexOf(";",cStart)
    if (c_end==-1) c_end=document.cookie.length
    return unescape(document.cookie.substring(c_start,c_end))
    } 
  }
}

function getSavedWords()
{
  if (document.cookie.length>0)
  {
    cStart=document.cookie.indexOf("words=")
    if (cStart!=-1)
    { 
      cStart+=6; 
      cEnd=document.cookie.indexOf(";",cStart)
    if (c_end==-1) c_end=document.cookie.length
    return unescape(document.cookie.substring(c_start,c_end))
    } 
  }
}

function setSuggestion()
{
  if (spellCheckForm.suggestions.selectedIndex >= 0)
  {
    var suggestion=spellCheckForm.suggestions.options[spellCheckForm.suggestions.selectedIndex].text;
    if(resultID == 1 && suggestion!="")
    {
      spellCheckForm.recommend.value=suggestion;
    }
  }
}

function setOriginal()
{
  var word=parent.document.spellCheckApplet.getMisspelt();
  if (word != null)
  {
    parent.document.spellCheckForm.recommend.value=word;
  }
}

function escapeText(text, removeLineBreak)
{
  text = replace(text, "<", "&lt;");
  text = replace(text, ">", "&gt;");
  text = replace(text, "'", "\\'");
  text = replace(text, "\"", "&quot;");
  text = replace(text, "&", "&amp;");
  if (removeLineBreak)
  {
    text = replace(text, "\n", " ");
    text = replace(text, "\r", "");
  }
  return text; 
}

function textToHtml(text)
{
  text = replace(text, "\n", "<br />");
  text = replace(text, "\r", "");
  text = replace(text, "\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
  return text; 
}

function replace(text, oVal, nVal)
{
  var i = text.indexOf(oVal);
  if (i == -1) return text;
  var res = text.substring(0, i) + nVal;
  i += oVal.length;
  if (i < text.length)
  {
    res += replace(text.substring(i, text.length), oVal, nVal);
  }
  return res;
}

function setCookie(c_name,value,expiredays)
{
  var exdate=new Date();
  exdate.setDate(expiredays);
  document.cookie=c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate);
} 

function onMouseOver(btn)
{
  btn.style.backgroundColor='#b5bed5';
  btn.style.borderColor='#08256d';
} 

function onMouseOut(btn)
{
  btn.style.backgroundColor='#dddddd';
  btn.style.borderColor='#b5bed5';
} 

/*
function getWinCoords(win)
{
  var coords = {x: 0, y: 0};
  do 
  {
    coords.x += win.offsetLeft;
    coords.y += win.offsetTop;
  }
  while ((win = win.offsetParent));
  return coords;
}

function scrollWindow(win)
{
  var coords = getWinCoords(win);
  window.scrollTo(coords.x, coords.y);
}
*/
