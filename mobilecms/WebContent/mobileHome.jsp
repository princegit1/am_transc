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
<HTML><HEAD><TITLE>Mobile Service</TITLE>
</HEAD>
<HEAD>

</HEAD>
<BODY bgColor=#ffffff>
<FORM  method=post name="newsForm" onSubmit="return validate()">
<jsp:include page="topBand.jsp" />
<%
	int categoryId = 16;
	int totalMsg = 0;

	ResultSet rs=null;
	Connection cn=null;
	Statement stmt=null;
	AdminConn adminConn = AdminConn.getInstance();
	cn = adminConn.getConnection();
	String emp_role  = (String)session.getAttribute("emp_role");

		try
		{
			stmt=cn.createStatement();
			if(emp_role.equals("AMT"))
			{
				rs=stmt.executeQuery("select * from category_master where status = 'ACTIVE' and category_id in (9,10,32,40,41,72) and category_id="+categoryId);
			}
			else
			{
				rs=stmt.executeQuery("select * from category_master where status = 'ACTIVE' and category_id="+categoryId);
			}
			while(rs.next())
			{
				categoryId=rs.getInt("category_id");
				totalMsg=rs.getInt("total_message");
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
	<table align="center" border="0" cellspacing="0" cellpadding="0" >
<%
		int select_day=1;
		for(int i=1;i<=select_day;i++)
		{
%>
			<tr>
			<TD colspan="2">
<%
			String date = request.getParameter("select_year")+"-"+request.getParameter("select_month")+"-"+i;
			String date1 = "";
			String upQuery2="";
			try
			{	
				if(select_day == 1)
					upQuery2="select DATE_FORMAT(curdate(),'%Y-%m-%d') cur from dual";
				else
				{
					upQuery2="SELECT MONTHNAME('"+date+"') cur;";
				}
				stmt=cn.createStatement();
				rs=stmt.executeQuery(upQuery2);
				
				while(rs.next())
				{
					date1 = rs.getString("cur");
					if(select_day == 1)
					{
%>
						<INPUT size = 10 readOnly value=<%=date1%> name=txtDate<%=i%>> 
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
					stmt=cn.createStatement();
					if(emp_role.equals("AMT"))
					{
						rs=stmt.executeQuery("select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date,fname,lname from message_details a, employee b where a.update_emp_id = b.emp_id and run_date='"+date1+"' and category_id in (9,10,32,40,41,72) and category_id="+categoryId);
					}
					else
					{
						rs=stmt.executeQuery("select msg_id,message"+(k)+",DATE_FORMAT(run_date,'%Y-%m-%d') run_date,fname,lname from message_details a, employee b where a.update_emp_id = b.emp_id and run_date='"+date1+"' and category_id="+categoryId);
					}

					
					if(rs.next())
					{
						if(rs.getString("message"+k+"").length()>0)
						{
%>
							<INPUT maxLength=320 size=70 name="txtNews<%=k%><%=i%>" value="<%=rs.getString("message"+k+"")%>"> <br>
<%
						}
						else
						{
%>
							<INPUT maxLength=320 size=70 name="txtNews<%=k%><%=i%>" value=""><br>
<%	
						}
%>				
						</td>
						<td><%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
<%	
					}
				}
				catch(NullPointerException nex)
				{
%>
					<INPUT maxLength=320 size=70 name=txtNews<%=k%><%=i%> value=""> <br>
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
			
<%
			}
%>
			</tr>
<%
		}	
%>
		</TR>
		</table><br><br>

		<table align="center" border="1" cellspacing="0" cellpadding="0" >
		<tr>
			<td  colspan="3" align="center"><font size="2" color="navy" face="verdana"><b>Content Available</b></font></td>
	</tr>
<%
	try
	{

		stmt=cn.createStatement();

			if(emp_role.equals("AMT"))
			{
				rs=stmt.executeQuery("SELECT * FROM message_details a, category_master b, service_provider c, employee d where a.update_emp_id = d.emp_id and a.category_id=b.category_id and b.service_provider = c.sp_name and a.run_date=curdate() and a.category_id in (9,10,32,40,41,72) and b.status='ACTIVE'");
			}
			else
			{
				rs=stmt.executeQuery("SELECT * FROM message_details a, category_master b, service_provider c, employee d where a.update_emp_id = d.emp_id and a.category_id=b.category_id and b.service_provider = c.sp_name and a.run_date=curdate() and a.category_id != 16 and b.status='ACTIVE'");
			}

	while(rs.next())
	{
%>
		<tr>
			<td align="right" width="15%"><%=rs.getString("service_provider")%> - <%=rs.getString("category_type")%></td>
			<td><INPUT size=70 name=aa value="<%=rs.getString("message1")%>"></td>
			<td><%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
		</tr>
<%
	}
	}
	catch(Exception ex)
	{
		out.println(ex.toString());
	}
	finally
	{
		rs = null;
		stmt = null;
	}
%>

</table>

<table align="center" border="1" cellspacing="0" cellpadding="0" width="60%">
	<!-- <tr>
			<td  colspan="2" align="center"><font size="2" color="red" face="verdana"><b>Content Not Available</b></font></td>
	</tr> -->
<%
	try
	{
			int i=0;
		stmt=cn.createStatement();
		if(emp_role.equals("AMT"))
			{
				rs=stmt.executeQuery("select * from category_master where status='ACTIVE' and category_id in (9,10,32,40,41,72) and category_id not in(SELECT category_id FROM message_details where run_date=curdate())");
			}
			else
			{
				rs=stmt.executeQuery("select * from category_master where status='ACTIVE' and category_id not in(SELECT category_id FROM message_details where run_date=curdate())");

			}
	while(rs.next())
	{

		if(i==0)
		{
%>
	<tr>
			<td  colspan="2" align="center"><font size="2" color="red" face="verdana"><b>Content Not Available</b></font></td>
	</tr>
<%
		}	
%>
		<tr>
			<td align="right" width="25%"><%=rs.getString("service_provider")%> - <%=rs.getString("category_type")%></td>
			<td>Content Not Available</td>
		</tr>
<%
	i++;
	}
	}
	catch(Exception ex)
	{
		out.println(ex.toString());
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

</table>

</BODY>
</HTML>
