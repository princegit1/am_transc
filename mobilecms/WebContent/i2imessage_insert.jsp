<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
String errorMessage = request.getParameter("msg");
%>
<html>
<head>
<title>Send Regional News Content - ITGO</title></head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="JavaScript" type="text/JavaScript" src="spellcheck.js"></script>
<SCRIPT LANGUAGE="JavaScript">

function textCounter(field,cntfield,maxlimit) {
if (field.value.length > maxlimit) 
field.value = field.value.substring(0, maxlimit);
else
cntfield.value = maxlimit - field.value.length;
}
function resetTextAreas()
{
	<%
	for(int i=1;i<25;i++)
	{
	%>
		document.myNews.txt<%=i%>.value = "";
	<%
	}
	%>
}
</script>

<link href="styles/main.css" rel="stylesheet" type="text/css">
<body>
<jsp:include page="topBand.jsp" />
<%
	Connection cn=null;
	ResultSet rs = null;
	Statement stmt = null;
	String name = "";
	String date = "",MSG_ID="",time="",datetime="";
	String Na_MESSAGE1 = "",Na_MESSAGE2 = "",Na_MESSAGE3 = "",Na_MESSAGE4 = "",Na_MESSAGE5 = "",Na_MESSAGE6 = "";
	String In_MESSAGE1 = "",In_MESSAGE2 = "",In_MESSAGE3 = "",In_MESSAGE4 = "",In_MESSAGE5 = "",In_MESSAGE6 = "";
	String Sp_MESSAGE1 = "",Sp_MESSAGE2 = "",Sp_MESSAGE3 = "",Sp_MESSAGE4 = "",Sp_MESSAGE5 = "",Sp_MESSAGE6 = "";
	String Bu_MESSAGE1 = "",Bu_MESSAGE2 = "",Bu_MESSAGE3 = "",Bu_MESSAGE4 = "",Bu_MESSAGE5 = "",Bu_MESSAGE6 = "";
	

	AdminConn adminConn = AdminConn.getInstance();
	try
	{
		cn = adminConn.getConnection();	
		String upQuery1 = "SELECT m.MSG_ID as MSG_ID,m.Na_MESSAGE1 as Na_MESSAGE1,m.Na_MESSAGE2 as Na_MESSAGE2,m.Na_MESSAGE3 as Na_MESSAGE3,m.Na_MESSAGE4 as Na_MESSAGE4,m.Na_MESSAGE5 as Na_MESSAGE5,m.Na_MESSAGE6 as Na_MESSAGE6,m.In_MESSAGE1 as In_MESSAGE1,m.In_MESSAGE2 as In_MESSAGE2,m.In_MESSAGE3 as In_MESSAGE3,m.In_MESSAGE4 as In_MESSAGE4,m.In_MESSAGE5 as In_MESSAGE5,m.In_MESSAGE6 as In_MESSAGE6,m.Sp_MESSAGE1 as Sp_MESSAGE1,m.Sp_MESSAGE2 as Sp_MESSAGE2,m.Sp_MESSAGE3 as Sp_MESSAGE3,m.Sp_MESSAGE4 as Sp_MESSAGE4,m.Sp_MESSAGE5 as Sp_MESSAGE5,m.Sp_MESSAGE6 as Sp_MESSAGE6,m.Bu_MESSAGE1 as Bu_MESSAGE1,m.Bu_MESSAGE2 as Bu_MESSAGE2,m.Bu_MESSAGE3 as Bu_MESSAGE3,m.Bu_MESSAGE4 as Bu_MESSAGE4,m.Bu_MESSAGE5 as Bu_MESSAGE5,m.Bu_MESSAGE6 as Bu_MESSAGE6,m.category_id,date_format(m.RECORD_DATE,'%Y-%m-%d') record_date,time_format(m.RECORD_DATE,'%r ') record_time, em.FNAME as fname,em.EMP_ID as empId FROM i2i_message_details m, employee em where  m.update_emp_id=em.EMP_ID order by msg_id desc limit 1";
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery1);
		if(rs.next())
		{		MSG_ID=rs.getString("MSG_ID");
				Na_MESSAGE1 =rs.getString("Na_MESSAGE1"); 
				Na_MESSAGE2 =rs.getString("Na_MESSAGE2");
				Na_MESSAGE3 =rs.getString("Na_MESSAGE3") ;
				Na_MESSAGE4 =rs.getString("Na_MESSAGE4");
				Na_MESSAGE5 =rs.getString("Na_MESSAGE5");
				Na_MESSAGE6 =rs.getString("Na_MESSAGE6");
				/*international*/
				In_MESSAGE1 =rs.getString("In_MESSAGE1"); 
				In_MESSAGE2 =rs.getString("In_MESSAGE2");
				In_MESSAGE3 =rs.getString("In_MESSAGE3") ;
				In_MESSAGE4 =rs.getString("In_MESSAGE4");
				In_MESSAGE5 =rs.getString("In_MESSAGE5");
				In_MESSAGE6 =rs.getString("In_MESSAGE6");
				/*Sports*/
				Sp_MESSAGE1 =rs.getString("Sp_MESSAGE1"); 
				Sp_MESSAGE2 =rs.getString("Sp_MESSAGE2");
				Sp_MESSAGE3 =rs.getString("Sp_MESSAGE3") ;
				Sp_MESSAGE4 =rs.getString("Sp_MESSAGE4");
				Sp_MESSAGE5 =rs.getString("Sp_MESSAGE5");
				Sp_MESSAGE6 =rs.getString("Sp_MESSAGE6");
				/*Business*/
				Bu_MESSAGE1 =rs.getString("Bu_MESSAGE1"); 
				Bu_MESSAGE2 =rs.getString("Bu_MESSAGE2");
				Bu_MESSAGE3 =rs.getString("Bu_MESSAGE3") ;
				Bu_MESSAGE4 =rs.getString("Bu_MESSAGE4");
				Bu_MESSAGE5 =rs.getString("Bu_MESSAGE5");
				Bu_MESSAGE6 =rs.getString("Bu_MESSAGE6");
				
				name = rs.getString("fname");
				//rs.getString("fname")
				date = rs.getString("record_date");
				
				time=rs.getString("record_time");
				//rs.getString("record_date");
				datetime=date+" "+time;
				
				
				 String empId=rs.getString("empId");

		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
	finally
	{
		if(rs!=null)
			rs.close();
		if(stmt!=null)
			stmt.close();
		if(cn!=null)
			cn.close();
			
	} 

%>

<form action="i2imessage_success.jsp" name="myNews" onSubmit="return checkEmpty()" method="post">
<input type="hidden" name="MSG_ID" value='MSG_ID' />
<input type="hidden" name="fname" value='name' />
<input type="hidden" name="empId" value='empId' />
	<table align="center" border="0" cellPadding=0 cellSpacing=0 width="100%">
		<tr valign="top">
			<td width="3%"></td>
		  <td width="44%"></td>
		  <td width="8%"></td>
		  <td width="24%"></td>
		  <td width="17%"></td>
		  <td width="4%"></td>
	  </tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="50">
			<td colspan="6" align="center">
			  <P class="topic">Send I2I News<BR>
			  <a href="sp/i2iall?catId=99" target="_blank">Check Existing</a></P>
			</td>
		</tr>
		<tr valign="middle" bgcolor="#dcdcdc" height="20">
			<td colspan="6" align="right">By: <b><%=name%></b>&nbsp;(<%=datetime%>)&nbsp;</td>
		</tr>
		<tr height="5">
			<td>
			</td>
		</tr>
		<tr valign="top">
			<td>&nbsp;
				
			</td>
			<td colspan="5" align="left">
			<font color="red"><b>
			<%
				if(errorMessage != null)
				{
					out.println(java.net.URLDecoder.decode(request.getParameter("msg")));
				}
			%>
			</b></font>
			</td>
		</tr>
  <tr>
	<td height="5">
	</td>
		</tr>
		<table width="622" align="center" cellpadding="0" cellspacing="0">

<tr valign="top">
			<td width="500" align="center">
		  <input type="button" value="Clear Content" name="resetButton" onClick="javascript:resetTextAreas()">		  </td>
			
		    <td width="122" align="center">&nbsp;</td>
</tr>
<tr valign="top">
  <td height="10" align="center"></td>
  <td height="10" align="center"></td>
</tr>
</table>
		<tr height="8">
			<td>
			</td>
		</tr>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><strong> &nbsp;Natioanal News&nbsp;</strong></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <table width="622" border="0" cellspacing="0" cellpadding="0" align="center" >
<tr align="left">
<td></td>
</tr>
  <tr>
    <td width="397" valign="top"><textarea name="txt1"  cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt1,document.myNews.remLen1,120)"
onKeyUp="textCounter(document.myNews.txt1,document.myNews.remLen1,120)" style="width:450px;" ><%=Na_MESSAGE1%></textarea></td>
<td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen1" size="3" maxlength="3" value="120">
characters left</td>
  
 </tr>
<tr>
<td>&nbsp;</td>
</tr>

  <tr>
  
    <td width="397" valign="top"><textarea name="txt2"  cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt2,document.myNews.remLen2,120)"
onKeyUp="textCounter(document.myNews.txt2,document.myNews.remLen2,120)" style="width:450px;"  ><%=Na_MESSAGE2%></textarea></td>


    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen2" size="3" maxlength="3" value="120">
characters left</td>

     

  </tr>
<tr>
<td>&nbsp;</td>
</tr>


  <tr>

   
    <td width="397" valign="top"><textarea name="txt3"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt3,document.myNews.remLen3,120)"
onKeyUp="textCounter(document.myNews.txt3,document.myNews.remLen3,120)" style="width:450px;"  ><%=Na_MESSAGE3%></textarea></td>
    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen3" size="3" maxlength="3" value="120">
characters left</td>

  </tr>
<tr>
<td>&nbsp;</td>
</tr>


  <tr>

    
 
    <td width="397" valign="top"><textarea name="txt4"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt4,document.myNews.remLen4,120)"
onKeyUp="textCounter(document.myNews.txt4,document.myNews.remLen4,120)" style="width:450px;"  ><%=Na_MESSAGE4%></textarea></td>


    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen4" size="3" maxlength="3" value="120">
characters left</td>

  </tr>
<tr>
<td>&nbsp;</td>
</tr>


  <tr>

  
    <td width="397" valign="top"><textarea name="txt5"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt5,document.myNews.remLen5,120)"
onKeyUp="textCounter(document.myNews.txt5,document.myNews.remLen5,120)" style="width:450px;"  ><%=Na_MESSAGE5%></textarea></td>


    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen5" size="3" maxlength="3" value="120">
characters left</td>

  </tr>
<tr>
<td>&nbsp;</td>
</tr>


      
  <tr>

    <td width="397" valign="top"><textarea name="txt6"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt6,document.myNews.remLen6,120)"
onKeyUp="textCounter(document.myNews.txt6,document.myNews.remLen6,120)" style="width:450px;" ><%=Na_MESSAGE6%></textarea></td>


    <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen6" size="3" maxlength="3" value="120">
characters left</td>

  </tr>

     

</table>


		
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><strong> &nbsp;International News&nbsp;</strong></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
    <table width="622" border="0" cellspacing="0" cellpadding="0" align="center">
<tr align="center">
<td align="left"></td>
</tr>

  <tr>

       <td width="397" valign="top"><textarea name="txt7"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt7,document.myNews.remLen7,120)"
onKeyUp="textCounter(document.myNews.txt7,document.myNews.remLen7,120)" style="width:450px;"  ><%=In_MESSAGE1%></textarea></td>
  <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen7" size="3" maxlength="3" value="120">characters left</td>



  </tr>

 
  
<tr>
<td>&nbsp;</td>
</tr>

   <tr>

    <td width="397" valign="top"><textarea name="txt8"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt8,document.myNews.remLen8,120)"
onKeyUp="textCounter(document.myNews.txt1,document.myNews.remLen8,120)" style="width:450px;"  ><%=In_MESSAGE2%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen8" size="3" maxlength="3" value="120">
characters left</td>

  </tr>
<tr>
<td>&nbsp;</td>
</tr>

  <tr>

       <td width="397" valign="top"><textarea name="txt9"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt9,document.myNews.remLen9,120)"
onKeyUp="textCounter(document.myNews.txt9,document.myNews.remLen9,120)" style="width:450px;" ><%=In_MESSAGE3%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen9" size="3" maxlength="3" value="120">
characters left</td>

     </tr>

     

    

<tr>
<td>&nbsp;</td>
</tr>

  <tr>

    <td width="397" valign="top"><textarea name="txt10"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt10,document.myNews.remLen10,120)"
onKeyUp="textCounter(document.myNews.txt10,document.myNews.remLen10,120)" style="width:450px;" ><%=In_MESSAGE4%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen10" size="3" maxlength="3" value="120">
characters left</td>

     </tr>

     
 
<tr>
<td>&nbsp;</td>
</tr>

  <tr>
   <td width="397" valign="top"><textarea name="txt11"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt11,document.myNews.remLen11,120)"
onKeyUp="textCounter(document.myNews.txt11,document.myNews.remLen11,120)" style="width:450px;"  ><%=In_MESSAGE5%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen11" size="3" maxlength="3" value="120">
characters left</td>

     </tr>

      

<tr>
<td>&nbsp;</td>
</tr>

   <tr>

   <td width="397" valign="top"><textarea name="txt12"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt12,document.myNews.remLen12,120)"
onKeyUp="textCounter(document.myNews.txt12,document.myNews.remLen12,120)" style="width:450px;"  ><%=In_MESSAGE6%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen12" size="3" maxlength="3" value="120">
characters left</td>

  </tr>

     

</table>


		
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><strong> &nbsp;Sports News&nbsp;</strong></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
	<table width="622" border="0" cellspacing="0" cellpadding="0" align="center">
<tr align="center">
<td align="left"></td>
</tr>

  <tr>

       <td width="397" valign="top"><textarea name="txt13"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt13,document.myNews.remLen13,120)"
onKeyUp="textCounter(document.myNews.txt13,document.myNews.remLen13,120)" style="width:450px;"  ><%=Sp_MESSAGE1%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen13" size="3" maxlength="3" value="120">
characters left</td>

 
     

  </tr>

 

<tr>
<td>&nbsp;</td>
</tr>
   <tr>

  
   <td width="397" valign="top"><textarea name="txt14"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt14,document.myNews.remLen14,120)"
onKeyUp="textCounter(document.myNews.txt14,document.myNews.remLen14,120)"  style="width:450px;" ><%=Sp_MESSAGE2%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen14" size="3" maxlength="3" value="120">
characters left</td>

  

     

  </tr>

  

<tr>
<td>&nbsp;</td>
</tr>
  <tr>


 
      <td width="397" valign="top"><textarea name="txt15"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt15,document.myNews.remLen15,120)"
onKeyUp="textCounter(document.myNews.txt15,document.myNews.remLen15,120)" style="width:450px;"  ><%=Sp_MESSAGE3%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen15" size="3" maxlength="3" value="120">
characters left</td>

     </tr>

     

      

<tr>
<td>&nbsp;</td>
</tr>

  <tr>

    <td width="397" valign="top"><textarea name="txt16"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt16,document.myNews.remLen16,120)"
onKeyUp="textCounter(document.myNews.txt16,document.myNews.remLen16,120)" style="width:450px;" ><%=Sp_MESSAGE4%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen16" size="3" maxlength="3" value="120">
characters left</td>

     </tr>

     

<tr>
<td>&nbsp;</td>
</tr>

  <tr>

 
    <td width="397" valign="top"><textarea name="txt17"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt17,document.myNews.remLen17,120)"
onKeyUp="textCounter(document.myNews.txt17,document.myNews.remLen17,120)" style="width:450px;" ><%=Sp_MESSAGE5%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen17" size="3" maxlength="3" value="120">
characters left</td>

   

     </tr>

      

<tr>
<td>&nbsp;</td>
</tr>

   <tr>

  
      <td width="397" valign="top"><textarea name="txt18"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt18,document.myNews.remLen18,120)"
onKeyUp="textCounter(document.myNews.txt18,document.myNews.remLen18,120)" style="width:450px;"  ><%=Sp_MESSAGE6%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen18" size="3" maxlength="3" value="120">
characters left</td>

    

  </tr>

     

</table>


		
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><strong> &nbsp;Bussiness News&nbsp;</strong></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
  <table width="622" border="0" cellspacing="0" cellpadding="0" align="center">
<tr align="center">

<td align="left"></td>
</tr>

  <tr>

  
   <td width="397" valign="top"><textarea name="txt19"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt19,document.myNews.remLen19,120)"
onKeyUp="textCounter(document.myNews.txt19,document.myNews.remLen19,120)" style="width:450px;"  ><%=Bu_MESSAGE1%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen19" size="3" maxlength="3" value="120">
characters left</td>


  

     

  </tr>

 

<tr>
<td>&nbsp;</td>
</tr>

   <tr>

 
  <td width="397" valign="top"><textarea name="txt20"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt21,document.myNews.remLen22,120)"
onKeyUp="textCounter(document.myNews.txt22,document.myNews.remLen22,120)" style="width:450px;" ><%=Bu_MESSAGE2%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen22" size="3" maxlength="3" value="120">
characters left</td>



   

     

  
  </tr>
<tr>
<td>&nbsp;</td>
</tr>

  <tr>

    

  
   <td width="397" valign="top"><textarea name="txt21"  cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt21,document.myNews.remLen21,120)"
onKeyUp="textCounter(document.myNews.txt21,document.myNews.remLen23,120)" style="width:450px;"  ><%=Bu_MESSAGE3%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen21" size="3" maxlength="3" value="120">
characters left</td>


  

    </tr>

     


<tr>
<td>&nbsp;</td>
</tr>

  <tr>

   
  
    <td width="397" valign="top"><textarea name="txt22"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt22,document.myNews.remLen22,120)"
onKeyUp="textCounter(document.myNews.txt22,document.myNews.remLen22,120)" style="width:450px;"  ><%=Bu_MESSAGE4%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen22" size="3" maxlength="3" value="120">
characters left</td>


   

    </tr>


<tr>
<td>&nbsp;</td>
</tr>

  <tr>

   
  
    <td width="397" valign="top"><textarea name="txt23"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt23,document.myNews.remLen23,120)"
onKeyUp="textCounter(document.myNews.txt23,document.myNews.remLen25,120)" style="width:450px;"  ><%=Bu_MESSAGE5%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen23" size="3" maxlength="3" value="120">
characters left</td>



    </tr>

     

<tr>
<td>&nbsp;</td>
</tr>

   <tr>

  
    <td width="397" valign="top"><textarea name="txt24"   cols="80" rows="2" onKeyDown="textCounter(document.myNews.txt24,document.myNews.remLen24,120)"
onKeyUp="textCounter(document.myNews.txt24,document.myNews.remLen24,120)" style="width:450px;" ><%=Bu_MESSAGE6%></textarea></td>
 <td width="225" valign="top" style="padding-left:20px;"><input readonly type="text" name="remLen24" size="3" maxlength="3" value="120">
characters left</td>


    
  </tr>

     

</table>

	<table width="622" align="center" cellpadding="0" cellspacing="0">		
<tr valign="top">
  <td height="10" align="center"></td>
  <td height="10" align="center"></td>
</tr>
<tr valign="top">
			
			<td width="500" align="center">
		  <input type="submit" value="Send Content" name="newscontent">		  </td>
	  
		    <td width="122" align="center">&nbsp;</td>
</tr>
  </table>
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
  <td class="bottband">
    <div align="center"> All Rights Reserved &copy; ITGO</div>
  </td>
  </tr>
</table>
</body>
</html>