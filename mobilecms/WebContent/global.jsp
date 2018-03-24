<%!


String replaceSpCharacters(String strToReplace) 
{
	
    String str1 = strToReplace.replaceAll("\\{", "").replaceAll("\\}", "").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("'", "").replaceAll("`", "").replaceAll("/\"", "").replaceAll("&", "").replaceAll("$", "").replaceAll("@", "");
    
    return str1;
}


%>