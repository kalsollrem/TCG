<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

if( login == null)
{	%>
	<script>
		alert("���ٱ����� �����ϴ�.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}

String gnum 	= request.getParameter("gnum");			//��ǰ������ȣ
String gname 	= request.getParameter("gname");		//��ǰ������
String prefer	= request.getParameter("prefer"); 		//�з�
String curpage 	= request.getParameter("page"); 		//������
String sql		= "";

if(gnum == null || gnum.equals(""))
{%>
	<script>
		alert("�߸�ȣ��� �Խ����Դϴ�.");
		document.location = "index.jsp";
	</script>
<%
	return;
}

sql =  "select * from product ";
sql += "inner join info on product.mnum = info.mnum ";
sql += "where gnum =" + gnum;
System.out.println("SQL:" + sql);
dbms.OpenQuery(sql);

if(dbms.GetNext() == false)
{
	%>
	<script>
		alert("���̵� Ȥ�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		document.location = "login.jsp";
	</script>
	<%
	return;
}

String gdate 	= dbms.GetValue("gdate");		//�����
String gdir 	= dbms.GetValue("gdir");		//���ŷ�����
String gmail 	= dbms.GetValue("gmail");		//���� �ŷ� ����
String gmyself 	= dbms.GetValue("gmyself");		//��ǰ����
String gvalue 	= dbms.GetValue("gvalue");		//����
String gpic 	= dbms.GetValue("gpic");		//������
String gqty 	= dbms.GetValue("gqty");		//�Ǹż���
String gmnum 	= dbms.GetValue("mnum");		//�Ǹ��� ��ȣ
String mnick 	= dbms.GetValue("mnick");		//�Ǹ��� �г���
String mrank 	= dbms.GetValue("mrank");		//�Ǹ��� ����
String maddr_a  = dbms.GetValue("maddr_a");		//�Ǹ��� �ּ�(A)
String gstate   = dbms.GetValue("gstate");		//���� �Ǹſ���
String mnum 	= login.getNo();
dbms.CloseQuery();

%>

<script>
function removeCheck()
{
	if (confirm("���� �����Ͻðڽ��ϱ�??") == true	)
	{ 
		location.href="delete.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum%>"
	}
	else { return ;}
}

function getMyPoket()
{
	if (confirm("���Ͻðڽ��ϱ�?") == true	)
	{ 
		location.href="add_poket.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>"			
	}
	else { return ;}
}
</script>

<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->
<form name = "view" method="post" action="#">
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td style="width:300px; height:400px;">
			<div style="float:left;">
				<img src="gpic_down.jsp?gnum=<%=gnum %>&gpic=<%= gpic %>" style="width:100%">
			</div>
		</td>
		<td style="width:700px; height:400px;">
			<table border="1" style="width:100%; height:100%;">
				<tr>
					<td colspan="2" style="text-align:center;"><%=gname%></td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">�ۼ���</td>
					<td><%=mnick %> (��:<%=mrank %>)</td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">�����</td>
					<td><%=gdate %></td>
				</tr>
				<tr>
					<td style="text-align:center;">����</td>
					<td><%=gvalue %> ��</td>
				</tr>
				<tr>
					<td style="text-align:center; width:150px">���ŷ� </td>
					<td>
					<%
					switch(gdir)
					{
						case "no"   : out.print("�Ұ�");	 						break;
						default 	: out.print("(" + maddr_a + ")" + "�α� ");	break;
					}
					%>
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">����ŷ�</td>
					<td>
					<%
					switch(gmail)
					{
						case "no" 		: out.print("�Ұ�");	 					 break;
						case "Before"   : out.print("����");	 					 break;
						case "After"    : out.print("�ĺ�");	 					 break;
						default 		: out.print("�ù�� �߼��� �δ� ");			 break;
					}
					%>
					</td>							
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
					<%
					if(mnum.equals(gmnum)) 
					{%>	<input type="button" value="�� ����" onclick="location.href='modify.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum %>'"> &nbsp;
						<input type="button" value="�� ����" onclick="removeCheck();"><%} 
					else
					{%> <input type="button" value="�� �ϱ�" onclick="getMyPoket();"> &nbsp;
					<input type="button" value="�����ϱ�" onclick="location.href='tel_load.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>&gstate<%=gstate%>'"><%}
					%>				
					</td>
				</tr>
			</table>
		</td>
	</tr>		

</table>
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td colspan="5" style="background-color:#a7e3f2; text-align:center;">&nbsp;�Ǹ����� �ٸ���ǰ</td>
	</tr>
	<tr>
	<%
		sql = "select count(gnum) from product where mnum = '"+ gmnum +"' and gstate = 'A'";
		dbms.OpenQuery(sql);
		dbms.GetNext();
		int total_limit = dbms.GetInt("count(gnum)");
		dbms.CloseQuery();
		
		if(total_limit <= 5)
		{
			sql  = "select gname,gvalue,gnum,gpic from product where mnum = '"+ gmnum +"' order by gnum desc ";
			sql += "limit " + total_limit;
			dbms.OpenQuery(sql);

			while(dbms.GetNext() == true)
			{		
				String sub_gname  = dbms.GetValue("gname");
				String sub_gvalue = dbms.GetValue("gvalue");	
				String sub_gnum = dbms.GetValue("gnum");	
				String sub_gpic = dbms.GetValue("gpic");
				
			%>
			<td class="another_thing">
		 		<div style="width:190px; height:100px; text-align:center;">
		 			<a href="view.jsp?gname=<%=sub_gname%>&gnum=<%=sub_gnum %>"><img src="gpic_down.jsp?gnum=<%=sub_gnum %>&gpic=<%= sub_gpic %>" height="100%"></a><br>
		 		</div>
		 		<div style="width:190px; height:45px; text-align:center;"><%=sub_gname %><br>(<%=sub_gvalue %>��)</div>				
			</td>	
			<%
			}
			dbms.CloseQuery();
		}
		else
		{
			sql  = "select gname,gvalue,gnum,gpic from product where mnum = '"+ gmnum +"' order by gnum desc ";
			sql += "limit 5";
			dbms.OpenQuery(sql);

			while(dbms.GetNext() == true)
			{			
				String sub_gname  = dbms.GetValue("gname");
				String sub_gvalue = dbms.GetValue("gvalue");
				String sub_gnum   = dbms.GetValue("gnum");
				String sub_gpic   = dbms.GetValue("gpic");
			%>
			<td class="another_thing">
		 		<div style="width:190px; height:100px; text-align:center;">
		 			<a href="view.jsp?gname=<%=sub_gname%>&gnum=<%=sub_gnum %>"><img src="gpic_down.jsp?gnum=<%=sub_gnum %>&gpic=<%= sub_gpic %>" height="100%"></a><br>
		 		</div>
		 		<div style="width:190px; height:40px; text-align:center;"><%=sub_gname %> : <%=sub_gvalue %></div>				
			</td>	
			<%
			}
			dbms.CloseQuery();			
		}
	%>				
	</tr>
</table>	
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td style="text-align:center;">��ǰ ��</td>
	</tr>
	<tr>
		<td>
			<%=gmyself %>
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
			<%
			if(mnum.equals(gmnum)) 
			{%>	
			<input type="button" value="�� ����" onclick="location.href='modify.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum %>'"> &nbsp;
			<input type="button" value="�� ����" onclick="removeCheck();"><%} 
			else
			{%> 
			<input type="button" value="�� �ϱ�" onclick="getMyPoket();"> &nbsp;
			<input type="button" value="�����ϱ�" onclick="location.href='tel_load.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>&gstate<%=gstate%>'">
			<%}%>		
		</td>
	</tr>	
</table>
</form>
<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>