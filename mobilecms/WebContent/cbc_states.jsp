<%
	String fname = (String)session.getAttribute("fname");
	if(fname == null)
	{
		response.sendRedirect("index.jsp?msg=session exp.");
	}
%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="conn.*" %>
<%
	ResultSet rs=null,rs1=null;
	Connection cn=null;
	Statement stmt=null,stmt1=null;
	String upQuery = "";
	String categoryType="";
	String serviceProvider="";
	int messageSize = 200;
	int i=1;
	int k=1;
	String option="";
%>
<HTML><HEAD><TITLE>Mobile Service</TITLE>
<script type="text/javascript">

<!--
function getObject(obj) {
  var theObj;
  if(document.all) {
    if(typeof obj=="string") {
      return document.all(obj);
    } else {
      return obj.style;
    }
  }
  if(document.getElementById) {
    if(typeof obj=="string") {
      return document.getElementById(obj);
    } else {
      return obj.style;
    }
  }
  return null;
}

//Contador de caracteres.
function Contar(entrada,salida,texto,caracteres) {
  var entradaObj=getObject(entrada);
  var salidaObj=getObject(salida);
  var longitud=caracteres - entradaObj.value.length;
  if(longitud <= 0) {
    longitud=0;
    texto='<span class="disable"> '+texto+' </span>';
    entradaObj.value=entradaObj.value.substr(0,caracteres);
  }
  salidaObj.innerHTML = texto.replace("{CHAR}",longitud);
}

//-->
</script>

<SCRIPT LANGUAGE="javascript">
function validate()
{
	if(document.newsForm.select_month.value=="")
	{
		alert("Please Select Month");
		document.newsForm.select_month.focus();
		return false;
	}
	if(document.newsForm.select_day.value=="")
	{
		alert("Please Select Day");
		document.newsForm.select_day.focus();
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY bgColor=#ffffff>
<jsp:include page="topBand.jsp" />

<FORM  method=post name="newsForm" action="cbc_states.jsp">
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=0 hspace="5" vspace="5">
		<tr valign="middle">
			<td align="center">
Select State : &nbsp;&nbsp;&nbsp;
<select name="categorystate">
		
			<OPTION>-Select State-</OPTION> 
			<OPTION value=AP>ANDHRA PRADESH</OPTION> 
			<OPTION value=TN>TAMILNADU</OPTION> 
			<OPTION value=MP>MADHYA PRADESH</OPTION> 
			<OPTION value=DELHI>DELHI</OPTION> 
			<OPTION value=RAJASTHAN>RAJASTHAN</OPTION> 
			<OPTION value=GUJARAT>GUJARAT</OPTION> 
			<OPTION value=ASSAM>ASSAM</OPTION> 
			<OPTION value=NE>NORTH EAST </OPTION> 
			<OPTION value=BIHAR>BIHAR</OPTION> 
			<OPTION value=KOLKATA>KOLKATA</OPTION> 
			<OPTION value=ROWB>ROWB</OPTION> 
			<OPTION value=MUMBAI>MUMBAI</OPTION>
			<OPTION value=MAHARASHTRA>MAHARASHTRA</OPTION>
            <OPTION value=ODISHA>ODISHA</OPTION>
		<OPTION value=PUNJAB>PUNJAB</OPTION>
             <OPTION value=HARYANA>HARYANA</OPTION>
             <OPTION value=UPE>UPE</OPTION>
             <OPTION value=UPW>UPW</OPTION>
             <OPTION value=ASSAM>ASSAM</OPTION>
 <OPTION value=KERALA>KERALA</OPTION>
</select>&nbsp;&nbsp;&nbsp;
<input type="submit" value= "Submit">
</td>
			</tr>
			</table>
</FORM>

<TABLE cellSpacing="0" cellPadding="2"  align="center" border="0" hspace="5" vspace="5">
<%
if(request.getParameter("categorystate")!=null && !request.getParameter("categorystate").equals("")){
if(request.getParameter("status")!=null){
if(request.getParameter("status").equals("1")){
out.println("Data Inserted Successfully");
}else{
out.println("Data Insertion Failed, please try again");
}

}
int catid=0;

int totalMessage=0;
if(request.getParameter("categoryId")!=null && !request.getParameter("categoryId").equals("")){
catid=Integer.parseInt(request.getParameter("categoryId"));

}

String emp_role  = (String)session.getAttribute("emp_role");
String stateName = request.getParameter("categorystate");

 %>
<form  method=post name="newsForm1" action="save_cbc_message.jsp" onSubmit="return checkTexts();">		
<tr><td align="center"></td><td align="center"><a href="cbc_states_fetchlink.jsp?categorystate=<%=stateName%>" 
style="color:blue;margin-left:20px;font-size:20px;" target="_blank"><b>check existing</b></a></td></tr>
<tr><td align="center"></td><td align="center"></td></tr><tr><td align="center"></td><td 
align="center"></td></tr><tr><td align="center"></td><td align="center"></td></tr><tr><td 
align="center"></td><td align="center"></td></tr>			

<%
String textBoxName="";

	try
	{
		
		
		upQuery="select * from category_master where  category_type like '%"+stateName+"%' and category_id>260 and service_provider='cbc' and STATUS='active'";
		System.out.println(upQuery);
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery + " order by category_type");
		while(rs.next())
		{
		totalMessage=rs.getRow();
		
		upQuery="select msg_id,message1,DATE_FORMAT(run_date,'%Y-%m-%d') run_date,run_date as run_time from message_details where msg_id=(select max(msg_id) from message_details where category_id="+rs.getString("category_id")+") and category_id="+rs.getString("category_id");
					//messageSize=rs.getString("message1").length();
					stmt1=cn.createStatement();
					rs1=stmt1.executeQuery(upQuery);
					if(rs1.next())
					{
						
						//k++;
%>
<tr><td align="center"><%=rs.getString("category_type") %></td><td align="center"><INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="<%=rs1.getString("message1")%>" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"></td><td><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span>  <b>Date:<%=rs1.getString("run_time") %></b> <br/></td></tr>
<td><input type="hidden" value=<%=rs.getString("category_id") %> name="category-<%=k%>-<%=i%>"/></td></tr><tr></tr>

<%	
	textBoxName= textBoxName+"txtNews-"+k+"-"+i+",";							
					}else{%>
				<tr><td align="center"><%=rs.getString("category_type") %></td><td align="center"><INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"></td><td><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span><br/>
				</td><input type="hidden" value=<%=rs.getString("category_id") %> name="category-<%=k%>-<%=i%>"/></td></tr><tr></tr>

					<%
					textBoxName= textBoxName+"txtNews-"+k+"-"+i+",";		
					}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		i++;
		
		
		}
	}
	catch(Exception ee)
	{
		out.print("errr"+ee);
	}
	finally
	{
		if(rs!=null)
		rs.close();
		if(stmt!=null)
		stmt.close();
		if(rs1!=null)
		rs1.close();
		if(stmt1!=null)
		stmt1.close();
		if(cn!=null)
		cn.close();
		
	}
%>
<tr><td align="center" colspan="2">
<input type="hidden" value=<%=totalMessage %> name="totalMessage"/>
<input type="hidden" value=<%=stateName %> name="stateName"/>
<input type="hidden" name="theFields" value=<%=textBoxName %>>
<input type="submit" value= " Insert Message">

</td></tr>
			
</form><%} %>
		</table>
<script language="javascript">
	function checkTexts() {
		var fieldString = document.newsForm1.theFields.value;
		var fieldArray = fieldString.split(",");
		for (i = 0; i < fieldArray.length; i++) {
			var thisOne = fieldArray[i]
			if (document.newsForm1[thisOne].value=="") {
				alert("You left a field empty.");
				return false;
				break;
			}
		}
	}
</script>
</BODY>
</HTML>
