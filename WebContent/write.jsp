<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>

<%


//kind=J �Ǵ� kind=H�� �м��Ѵ�.
if(login == null)
{
	%>
	<script>
		alert("�۾��� ������ �����ϴ�.");
		document.location = "index.jsp";
	</script>		
	<%
	return;
}


String prefer	= request.getParameter("prefer"); 		//�з�
String curpage 	= request.getParameter("page"); 		//������

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
			document.getElementById('preview').src = "";
		}
	}

</script>	
<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->

<form name="write" id="write"  method="post" enctype="multipart/form-data" action="writeok.jsp?prefer=<%=prefer %>&page=<%=curpage %>" >
	<table border="0" style="text-align:center; width:1000px; height:100px; margin:auto;">
		<tr>
			<td><br></td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<span>�ʿ� ����Ʈ </span>
				<input type="text" name="write_num" value="1" style="width:3%">��
				<input type="button" value="Ȯ��" onclick="location.href='write.jsp'">
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>		
		
<!-- ------------------ �ݺ������� --------------------------------- -->	
				
		<tr>
			<td>
				<table border="0" id="sub_doc" style="width:700px; margin:auto;">
					<tr>
						<td>��ǰ��  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gname" style="width:90%; height:50%"></td>
					</tr>
					<tr>
						<td>����  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gvalue" style="width:30%; height:50% " onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/></td>
					</tr>
					<tr>
						<td>���  </td> 
						<td style="text-align:left; height:35px;">
							<input type="text" name="gqty" value="1" style="width:5%; height:50%">
						</td>
					</tr>
					<tr>
						<td>÷������  </td> 
						<td style="text-align:left; height:35px;">
							<div > <img id = "preview" style="width:200px;"></div>		
							<div>
								<input type="file" name="gpic" onchange="readURL(this);">
							</div>						
						</td>
					</tr>
					<tr>
						<td>���ŷ����� </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gdir" form="write" style="width:40%; height:50%;"> 
								<option value="No" selected>�Ұ�</option>
								<option value="Yes">����</option>
							 </select> 	
						</td>
					</tr>
					<tr>
						<td>����ŷ� ���� </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gmail" form="write" style="width:40%; height:50%;"> 
								<option value="No" selected>�Ұ�</option>
								<option value="Before">����</option>
								<option value="After">�ĺ�</option>
								<option value="Free">�ù�� ����</option>
							 </select> 	
						</td>
					</tr>
					<tr style="height:150px;">
						<td style="width:95%; height:150px;">��ǰ ��</td>
						<td> 
							<textarea > </textarea>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>					
<!-- ------------------ �ݺ��� --------------------------------- -->	
		<tr>
			<td>
				<input type="submit" value="�ۼ� �Ϸ�">&nbsp;&nbsp;&nbsp; 
				<input type="button" value="���" onclick="location.href='view.jsp'">
			</td>
		</tr>
	</table>
</form>
<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>