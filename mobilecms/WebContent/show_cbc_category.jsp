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
	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	String upQuery = "";
	String categoryType="";
	String serviceProvider="";
	int messageSize = 0;
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
<TABLE cellSpacing=2 cellPadding=2 width=600 align=center border=0 hspace="5" vspace="5">
<tr><td align="center" style="color:#d71920;font-size:18px;">
<%if(request.getParameter("status")!=null){
if(request.getParameter("status").equals("1")){
out.println("Data Inserted Successfully");
}else{
out.println("Data Insertion Failed, please try again");
}

}
int catid=0;
String option="";
if(request.getParameter("categoryId")!=null && !request.getParameter("categoryId").equals("")){
catid=Integer.parseInt(request.getParameter("categoryId"));

}
 %>
 </td></tr>
<form  method=post name="newsForm1" action="show_cbc_category.jsp">

		<tr valign="middle">
			<td align="center">
Select Region : &nbsp;&nbsp;&nbsp;
<select name="categoryId">
<%
String emp_role  = (String)session.getAttribute("emp_role");
		String stateName = request.getParameter("categorystate");

	try
	{
		
		
		upQuery="select * from category_master where  category_type like '%"+stateName+"%' and category_id>260 and service_provider='cbc'";
		System.out.println(upQuery);
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();
		stmt=cn.createStatement();
		rs=stmt.executeQuery(upQuery + " order by category_type");
		while(rs.next())
		{
		if(catid==rs.getInt("category_id")){
		option="selected=\"selected\"";
		}else{
		option="";
		}
%>
			<option value="<%=rs.getInt("category_id")%>" <%=option %>><%=rs.getString("category_type").replace("-"," ").replace(stateName,"")%> </option>
<%
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
		
	}
%>
</select>&nbsp;&nbsp;&nbsp;
<input type="submit" value= " Select Region &#187; ">

</td>
			</tr>
            <tr><td>&nbsp;</td></tr>
<input type="hidden" value="<%=stateName %>" name="categorystate" />
			</form>
			<%
			if(request.getParameter("categoryId")!=null && !request.getParameter("categoryId").equals("")){
			
			
			%>
			
			
<form  method=post name="newsForm" action="insert_cbc_message.jsp">

	<tr>		
			<td>
			<%
			String categoryId=request.getParameter("categoryId");
				try
				{	
					
					
					
					upQuery="select msg_id,message1,DATE_FORMAT(run_date,'%Y-%m-%d') run_date from message_details where msg_id=(select max(msg_id) from message_details where category_id="+categoryId+") and category_id="+categoryId;
					//messageSize=rs.getString("message1").length();
					stmt=cn.createStatement();
					rs=stmt.executeQuery(upQuery);
					if(rs.next())
					{
						
						
%>
							<INPUT maxLength=200 size=70 name="txtNews" value="<%=rs.getString("message1") %>" id="eBann" onKeyUp="Contar('eBann','sBann',' {CHAR} characters left.',200);"><span id="sBann" class="minitext">200 characters left.</span><br/>
<%	
						
					}else{%>
					<INPUT maxLength=200 size=70 name="txtNews" value="" id="eBann" onKeyUp="Contar('eBann','sBann',' {CHAR} characters left.',200);"><span id="sBann" class="minitext">200 characters left.</span><br/>
					<%
					
					}
					
				}
				
				catch(Exception e)
				{
					e.printStackTrace();
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
		</td>	
	</tr>
        <tr><td align="center"><input type="submit" value= " Insert Message &#187; "></td></tr>
		
			<input type="hidden" value="<%=categoryId%>" name="categoryId" />
			<input type="hidden" value="<%=stateName%>" name="categorystate" />
		
  </form><%} %>
		</table>

</BODY>
</HTML>
