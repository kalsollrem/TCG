<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String gnum 	= request.getParameter("gnum");			
String gname 	= request.getParameter("gname");		
String gmnum 	= request.getParameter("mnum");		
String mnum 	= login.getNo();
String sql		= "";

String prefer	= request.getParameter("prefer"); 		//�з�
String curpage 	= request.getParameter("page"); 		//������


if( login == null )
{
	%>
	<script>
		alert(" ������ �����ϴ�.");
		document.location = "index.jsp";
	</script>
	<%
	return ;
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
		alert("�������� ���� ������ �ǹٸ����ʽ��ϴ�.");
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
String mnick 	= dbms.GetValue("mnick");		//�Ǹ��� �г���
String mrank 	= dbms.GetValue("mrank");		//�Ǹ��� ����
String maddr_a  = dbms.GetValue("maddr_a");		//�Ǹ��� �ּ�(A)

dbms.CloseQuery();

%>
<script>
	
	window.onload = function()
	{
		document.write.gname.focus();
	}
	
	//�Է� �� �˻�
	function FormCheck()
	{
		if( document.write.gname.value == "" )
		{
			alert("������ �Է��ϼ���.");
			document.write.gname.focus();
			return false;
		}
		if( document.write.gvalue.value == "" )
		{
			alert("������ �Է��ϼ���.");
			document.write.gvalue.focus();
			return false;
		}
		if( document.write.gmyself.value == "" )
		{
			alert("������ �Է��ϼ���.");
			document.write.gmyself.focus();
			return false;
		}
		if(confirm("�ۼ��� �Խù��� �����Ͻðڽ��ϱ�?") !=1 )
		{
			return false;	
		}
		return true;
	}

	window.onload = function readURL(input)
	{
		document.getElementById('preview').src = "gpic_down.jsp?gnum=<%=gnum %>&gpic=<%=gpic %>";
	}

	function readURL(input) 
	{
		if (input.files && input.files[0]) 
		{
			var reader = new FileReader();
			
			reader.onload = function(e) 
			{
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} 
		else 
		{
			document.getElementById('preview').src = "gpic_down.jsp?gnum=<%=gnum %>&gpic=<%=gpic %>";
		}
	}

</script>	

<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->

<form name="modify" id="modify"  method="post" enctype="multipart/form-data" action="modifyok.jsp?prefer=<%=prefer %>&page=<%=curpage %>&gname=<%=gname%>&gnum=<%=gnum%>&mnum=<%=gmnum%>" >
	<table border="0" style="text-align:center; width:1000px; height:100px; margin:auto;">
		<tr>
			<td>	
				<input type="hidden" name="gmnum" value="<%=gmnum %>"><br>
				<input type="hidden" name="prefer" value="<%=prefer %>"><br>
				<input type="hidden" name="page" value="<%=curpage %>"><br>
			</td>
		</tr>		
		
<!-- ------------------ �ݺ������� --------------------------------- -->	
				
		<tr>
			<td>
				<table border="1" style="width:700px; height:400px; margin:auto;">
					<tr>
						<td colspan="2">
							<div ><img id = "preview" style="height:500px;"></div>
						</td>
					</tr>
					<tr>
						<td>��ǰ��  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gname" value="<%=gname %>" style="width:90%; height:50%"></td>
					</tr>
					<tr>
						<td>����  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gvalue" value="<%=gvalue %>" style="width:30%; height:50%"></td>
					</tr>
						
					<tr>
						<td>���  </td> 
						<td style="text-align:left; height:35px;">
							<input type="text" name="gqty" value="<%=gqty %>" style="width:5%; height:50%">
						</td>
					</tr>
					<tr>
						<td>÷������  </td> 
						<td style="text-align:left; height:35px;"><input type="file" name="n_gpic" onchange="readURL(this);"></td>
					</tr>
					<tr>
						<td>���ŷ����� </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gdir" form="modify" style="width:40%; height:50%;"> 
							<%
							if(gmail.equals("No"))
							{
							%>							
								<option value="No" selected>�Ұ�</option>
								<option value="Yes">����</option>
							<%
							}
							else
							{
							%>
								<option value="No">�Ұ�</option>
								<option value="Yes" selected>����</option>
							<%
							}
							%>							
							 </select> 	
						</td>
					</tr>
					<tr>
						<td>����ŷ� ���� </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gmail" form="modify" style="width:40%; height:50%;"> 
							<%
							if(gmail.equals("no"))
							{
							%>
								<option value="No" selected>�Ұ�</option>
								<option value="Before">����</option>
								<option value="After">�ĺ�</option>
								<option value="free">�ù�� ����</option>
							<%
							}
							else if(gmail.equals("Before"))
							{
							%>
								<option value="No">�Ұ�</option>
								<option value="Before" selected>����</option>
								<option value="After">�ĺ�</option>
								<option value="free">�ù�� ����</option>
							<%
							}
							else if(gmail.equals("After"))
							{
							%>
								<option value="No">�Ұ�</option>
								<option value="Before">����</option>
								<option value="After" selected>�ĺ�</option>
								<option value="free">�ù�� ����</option>
							<%
							}
							else
							{
							%>
								<option value="No">�Ұ�</option>
								<option value="Before">����</option>
								<option value="After">�ĺ�</option>
								<option value="free" selected>�ù�� ����</option>
							<%
							}
							%>
							
							 </select> 	
						</td>
					</tr>
					<tr>
						<td> ��ǰ ��</td>
						<td> <textarea name="gmyself" style="width:95%; height:90%"><%=gmyself %></textarea>	</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>					
<!-- ------------------ �ݺ��� --------------------------------- -->	
		<tr>
			<td style="height:30px">
				<input type="submit" value="���� �Ϸ�">&nbsp;&nbsp;&nbsp;
				<input type="button" value="���" onclick="location.href='view.jsp'">
			</td>
		</tr>
	</table>
</form>
<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>