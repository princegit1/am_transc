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
	int categoryId = 47;
	int totalMsg = 0;
	int messageSize = 0;

		ResultSet rs=null;
		Connection cn=null;
		Statement stmt=null;
		AdminConn adminConn = AdminConn.getInstance();
		cn = adminConn.getConnection();

		String categoryType="";
		String serviceProvider="";
		
		try
		{
			String upQuery="";
			upQuery="select * from category_master where category_id="+categoryId;
			
			stmt=cn.createStatement();
			rs=stmt.executeQuery(upQuery);
			while(rs.next())
			{
				categoryId=rs.getInt("category_id");
				totalMsg=rs.getInt("total_message");
				categoryType = rs.getString("category_type");
				serviceProvider = rs.getString("service_provider");
				messageSize = rs.getInt("MESSAGE_SIZE");
			}
		}
		catch(Exception ee)
		{
			out.print("errr"+ee);
		}
		finally
		{
			rs = null;
			stmt = null;
		}

		int select_day = 0;
		try
		{
			try
			{
				select_day = Integer.parseInt(request.getParameter("select_day"));
			}
			catch(Exception ex)
			{
				select_day=1;
			}
			if(select_day == 31)
			{
				stmt=cn.createStatement();
				String upQuery="";
				try
				{	

					String date = request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-1";
					upQuery="SELECT DATE_FORMAT(LAST_DAY('"+date+"'),'%d') totalday from dual";
					//out.println(upQuery);
					rs=stmt.executeQuery(upQuery);
					if(rs.next())
					{
						select_day = Integer.parseInt(rs.getString("totalday"));
					}
				}
				catch(Exception e)
				{
					out.print(e.toString());
				}
				finally
				{
					rs = null;
					stmt = null;
				}
			}
%>


<HTML><HEAD><TITLE>Mobile Service </TITLE>
</HEAD>
<HEAD>
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

<SCRIPT type="text/javascript">
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
<BODY bgColor="#ffffff">
<!-- Added by Sachin Kumar Garg on 15th Jan 2008 -->
<jsp:include page="topBand.jsp" />
<FORM  method=post name="newsForm" onSubmit="return validate()">
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1>
  <TBODY>

  <TR>
    <TD align="center" width=125 height=64>
		Year 
		<SELECT name=select_year> 
			<OPTION value=2007>2007</OPTION> 
			<OPTION value=2008>2008</OPTION>
			<OPTION value=2009 selected>2009</OPTION> 

		</SELECT> 
	</TD>
    <TD align="center" width=140 height=64>
		Month 
		<SELECT name=select_month> 
			<OPTION>-Select Month-</OPTION> 
			<OPTION value=1>Jan</OPTION> 
			<OPTION value=2>Feb</OPTION> 
			<OPTION value=3>Mar</OPTION> 
			<OPTION value=4>Apr</OPTION> 
			<OPTION value=5>May</OPTION> 
			<OPTION value=6>Jun</OPTION> 
			<OPTION value=7>Jul</OPTION> 
			<OPTION value=8>Aug</OPTION> 
			<OPTION value=9>Sep</OPTION> 
			<OPTION value=10>Oct</OPTION> 
			<OPTION value=11>Nov</OPTION> 
			<OPTION value=12>Dec</OPTION>
		</SELECT> 
	</TD>
    <TD align="center" width=173 height=64>
		Select Day Range 
		<SELECT name=select_day> 
			<OPTION>-Days Range-</OPTION> 
			<OPTION value=10>1-10</OPTION> 
			<OPTION value=20>1-20</OPTION> 
			<OPTION value=1 selected>Tomorrow</OPTION> 
			<OPTION value=31>All Days</OPTION>
		</SELECT> 
	</TD>
    <TD align="center" width=92 colSpan=9 height=64>
		<input type="hidden" value="<%=categoryId%>" name="categoryId">
		<INPUT type=submit value=Submit name=btnSubmit1> 
	</TD>
</TR>
</TABLE>
</FORM>

<!-- Starting Buttom table -->
<center>Category Type: <%=categoryType%> &nbsp;&nbsp; | &nbsp;&nbsp; Service Provider: <%=serviceProvider%></center><br>
	<FORM action="insertTarot.jsp" method=post>
	<table align="center" border="0" cellspacing="0" cellpadding="0" >

<%
		for(int i=1;i<=select_day;i++)
		{
%>
			<tr>
			<TD colspan="2">
<%
			String date = request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-"+i;
			String date1 = "";
			String upQuery="";
			try
			{	
				if(select_day == 1)
					upQuery="select DATE_FORMAT(curdate()+1,'%Y-%m-%d') cur from dual";
				else
				{
					upQuery="SELECT MONTHNAME('"+date+"') cur;";
				}
				stmt=cn.createStatement();
				rs=stmt.executeQuery(upQuery);
				
				while(rs.next())
				{
					date1 = rs.getString("cur");
					if(select_day == 1)
					{
%>
						<INPUT size = 10 readOnly value=<%=date1%> name=txtDate<%=i%>> 
<%
					}
					else
					{
%>
						<INPUT readOnly value=<%=request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-"+i%> name=txtDate<%=i%>> 
<%
					}
				}
			}
			catch(Exception e)
			{
				out.print(e.toString());
			}
			finally
			{
				rs = null;
				stmt = null;
			}
%>
			</TD></tr>
<%
			for(int k=1;k<=totalMsg;k++)
			{
%>
				<tr>
				<TD ALIGN="CENTER">
				<td align="right">
<%
				if(k==1)out.println("Aries: ");
				if(k==2)out.println("Taurus: ");
				if(k==3)out.println("Gemini: ");
				if(k==4)out.println("Cancer: ");
				if(k==5)out.println("Leo: ");
				if(k==6)out.println("Virgo: ");
				if(k==7)out.println("Libra: ");
				if(k==8)out.println("Scorpio: ");
				if(k==9)out.println("Sagittarius: ");
				if(k==10)out.println("Capricorn: ");
				if(k==11)out.println("Aquarius: ");
				if(k==12)out.println("Pisces: ");

%>
				</td>
				<td>
<%
				try
				{	
					if(select_day == 1)
					{
						upQuery="select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date from message_details where run_date='"+date1+"' and category_id="+categoryId;
					}
					else
					{
						upQuery="select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date from message_details where run_date='"+date+"' and category_id="+categoryId;
					}
					stmt=cn.createStatement();
					rs=stmt.executeQuery(upQuery);
					if(rs.next())
					{
						if(rs.getString("message"+k+"").length()>0)
						{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="<%=rs.getString("message"+k+"")%>" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>','{CHAR} characters left.',<%=messageSize%>);"> <span id="sBann-<%=k%>-<%=i%>" class="minitext"> <%=messageSize%> characters left.</span>
<%
						}
						else
						{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>','{CHAR} characters left.',<%=messageSize%>);"> <span id="sBann-<%=k%>-<%=i%>" class="minitext"> <%=messageSize%> characters left.</span>
<%	
						}
					}
					else
					{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>','{CHAR} characters left.',<%=messageSize%>);"> <span id="sBann-<%=k%>-<%=i%>" class="minitext"> <%=messageSize%> characters left.</span>
<%	
					}
				}
				catch(NullPointerException nex)
				{
%>
					<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>','{CHAR} characters left.',<%=messageSize%>);"> <span id="sBann-<%=k%>-<%=i%>" class="minitext"> <%=messageSize%> characters left.</span>
<%
				}
				catch(Exception e)
				{
					out.println(e.toString());
				}
				finally
				{
					rs = null;
					stmt = null;
				}
%>
				</td>
<%
			}
%>
			</tr>
<%
		}	
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
		</TR>
		<TR>
			<TD height="35" colspan="3">
			<DIV align=center>
			<input type="hidden" name="select_day" value="<%=select_day%>">
			<input type="hidden" name="totalMsg" value="<%=totalMsg%>">
			<input type="hidden" name="categoryId" value="<%=categoryId%>">
			<INPUT type=submit value=Submit name=txtSubmit2> 
			</DIV>
			</TD>
		</TR>
    </table>
	</FORM>
</BODY>
</HTML>
