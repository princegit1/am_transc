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
<%@ page contentType="text/html; charset=utf-8" %>
<%
	//String categoryGet=request.getParameter("category");
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	//int categoryId = 0;
	int totalMsg = 0;

		ResultSet rs=null;
		Connection cn=null;
		Statement stmt=null;
		//AdminConn adminConn = AdminConn.getInstance();
		//cn = adminConn.getConnection();
	     Class.forName("com.mysql.jdbc.Driver").newInstance();
    	cn = DriverManager.getConnection("jdbc:mysql://220.226.193.58:3306/content?useUnicode=true&characterEncoding=UTF-8","db1_mobile", "o0ywR!urPT+t");
		String categoryType="";
		String serviceProvider="";
		int messageSize = 0;

		int yearGet= 0;
		try
		{
			yearGet = Integer.parseInt(request.getParameter("select_year"));
		}
		catch(Exception ex)
		{
			yearGet = 0;
		}
		int monthGet= 0;
		try
		{
			monthGet = Integer.parseInt(request.getParameter("select_month"));
		}
		catch(Exception ex)
		{
			monthGet = 0;
		}
		
		try
		{
			stmt=cn.createStatement();
			rs=stmt.executeQuery("select * from category_master where category_id="+categoryId);
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
%>


<HTML><HEAD><TITLE>Mobile Service</TITLE>
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
<FORM  method=post name="newsForm" onSubmit="return validate()">
<TABLE cellSpacing=0 cellPadding=0 width=550 align=center border=1 hspace="5" 
vspace="5">
  <TBODY>

  <TR>
    <TD align=middle width=125 height=64>
		Year 
		<SELECT name=select_year> 
			<OPTION>-Select Year-</OPTION> 
			<OPTION value=2007>2007</OPTION> 
			<OPTION value=2008>2008</OPTION>
			<OPTION value=2009 >2009</OPTION> 
			<OPTION value=2010 >2010</OPTION> 
			<OPTION value=2011 >2011</OPTION> 
			<OPTION value=2012 >2012</OPTION> 
			<OPTION value=2013 selected>2013</OPTION> 
			<OPTION value=2014>2014</OPTION>
		</SELECT> 
	</TD>
    <TD align=middle width=140 height=64>
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
    <TD align=middle width=173 height=64>
		Select Day Range 
		<SELECT name=select_day value=""> 
			<OPTION>-Days Range-</OPTION> 
			<OPTION value=10>1-10</OPTION> 
			<OPTION value=20>1-20</OPTION> 
			<OPTION value=1 selected>Today</OPTION> 
			<OPTION value=31>All Days</OPTION>
		</SELECT> 
	</TD>
    <TD align=middle width=92 colSpan=9 height=64>
		<input type="hidden" value="<%=categoryId%>" name="categoryId">
		<INPUT type=submit value=Submit name=btnSubmit1> 
	</TD>
</TR>
</TABLE>
</FORM>

<!-- Starting Buttom table -->
<center>Category Type: <%=categoryType%> &nbsp;&nbsp; | &nbsp;&nbsp; Service Provider: <%=serviceProvider%></center><br>
	<table align="center" border="0" cellspacing="0" cellpadding="0" >
	<FORM action="insertMessage-unicode.jsp" method=post>

<%
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
			ResultSet rs2=null;
			Connection cn2=null;
			Statement stmt2=null;
			
			String upQuery="";
			try
			{	

				String date = request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-1";
				upQuery="SELECT DATE_FORMAT(LAST_DAY('"+date+"'),'%d') totalday from dual";
				stmt=cn.createStatement();
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
	
		for(int i=1;i<=select_day;i++)
		{
%>
			<tr>
			<TD>
<%
			String date = request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-"+i;
			String date1 = "";
			String upQuery="";
			try
			{	
				if(select_day == 1)
					upQuery="select DATE_FORMAT(curdate(),'%Y-%m-%d') cur from dual";
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
						<INPUT readOnly value=<%=date1%> name=txtDate<%=i%>> 
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
				<tr><TD ALIGN="CENTER">
<%
				try
				{	
					if(select_day == 1)
					{
						upQuery="select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date from message_details_unicode where run_date='"+date1+"' and category_id="+categoryId;
					}
					else
					{
						upQuery="select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date from message_details_unicode where run_date='"+date+"' and category_id="+categoryId;
					}
					stmt=cn.createStatement();
					rs=stmt.executeQuery(upQuery);
					if(rs.next())
					{
						if(rs.getString("message"+k+"").length()>0)
						{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="<%=new String(new String(rs.getString("message"+k+"")).getBytes("ISO-8859-1"), "UTF-8")%>" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span><br/>
<%
						}
						else
						{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span><br/>
<%	
						}
					}
					else
					{
%>
							<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span><br/>
<%	
					}
				}
				catch(NullPointerException nex)
				{
%>
					<INPUT maxLength=<%=messageSize%> size=70 name="txtNews-<%=k%>-<%=i%>" value="" id="eBann-<%=k%>-<%=i%>" onKeyUp="Contar('eBann-<%=k%>-<%=i%>','sBann-<%=k%>-<%=i%>',' {CHAR} characters left.',<%=messageSize%>);"><span id="sBann-<%=k%>-<%=i%>" class="minitext"><%=messageSize%> characters left.</span><br/>
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
				
				</td></tr>
<%
			}
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
	</FORM>
</BODY>
</HTML>
