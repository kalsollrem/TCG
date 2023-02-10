<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>

<script>

window.onload = function()
{
	document.join_r.mid.focus();	
}

function Formcheck()
{
	if(document.join_r.mid.value == "")
	{
		alert("���̵� �Է��ϼ���");
		document.join_r.mid.focus();
		return false;
	}
	if(document.join_r.mpw.value == "")
	{
		alert("��й�ȣ�� �Է��ϼ���");
		document.join_r.mid.focus();
		return false;
	}
	if(document.join_r.mpw.value != document.join_r.mpwcheck.value)
	{
		alert("Ȯ�ε� ��й�ȣ�� ������ �ٸ��ϴ�.");
		document.join_r.mpwcheck.focus();
		return false;
	}
	if(document.join_r.mname.value == "")
	{
		alert("�̸��� �Է��ϼ���");
		document.join_r.mname.focus();
		return false;
	}
	if(document.join_r.mnick.value == "")
	{
		alert("�г����� �Է��ϼ���");
		document.join_r.mnick.focus();
		return false;
	}
	if(document.join_r.madd_a.value == "")
	{
		alert("�ּҸ� �Է��ϼ���");
		document.join_r.madd_a.focus();
		return false;
	}
	if(document.join_r.madd_b.value == "")
	{
		alert("�����ּҸ� �Է��ϼ���");
		document.join_r.madd_b.focus();
		return false;
	}
	if(document.join_r.mphone.value == "")
	{
		alert("��ȭ��ȣ�� �Է��ϼ���");
		document.join_r.mphone.focus();
		return false;
	}
	if(document.join_r.mmail.value == "")
	{
		alert("�����ּҸ� �Է��ϼ���");
		document.join_r.mmail.focus();
		return false;
	}
}

function CheckIDDup()
{
	var userid = document.join_r.mid.value;
	if(userid == "")
	{
		alert("���̵� �Է��ϼ���.");
		document.join_r.mid.focus();
		return;
	}
	window.open("idcheck.jsp?id=" + userid,"_idcheck", "width=400,height=400");
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

<!-- -----------���� ������--------------- -->
<form name="join_r" method="post" action="joinok.jsp" enctype="multipart/form-data" onsubmit="return Formcheck()">
	<table border="1" style="margin:auto; width:800px;">
		<tr>
			<td colspan="2" style="text-align:center;">���� ��û��</td>
		</tr>
		<tr>
			<td>���̵�</td>
			<td><input type="text"  name="mid" size="20">
			<input type="button" value="���̵� �ߺ�üũ" onclick = "CheckIDDup();"></td>
		</tr>
		<tr>
			<td>��й�ȣ</td>
			<td><input type="password" name="mpw"   size="20"></td>
		</tr>
		<tr>
			<td>��й�ȣ Ȯ��</td>
			<td><input type="password" name="mpwcheck"  size="20"></td>
		</tr>			
		<tr>
			<td>�̸�</td>
			<td><input type="text" name="mname"  style="width:30%"></td>
		</tr>		
		<tr>
			<td>�г���</td>
			<td><input type="text" name="mnick"  style="width:30%"></td>
		</tr>		
		<tr>
			<td>�ּ�</td>
			<td>
				<table>
					<tr>
						<td>���ֵ�  </td>
						<td><input type="text" name="maddr_a"  style="width:30%"></td>
					</tr>
					<tr>
						<td>������ �ּ�  </td>
						<td><input type="text" name="maddr_b"  style="width:300px"></td>
					</tr>
				</table>					
			</td>
		</tr>		
		<tr>
			<td>����</td>
			<td>
				<input type="radio" name="msex" value="M" checked>����
				<input type="radio" name="msex" value="F">����
			</td>
		</tr>	
		<tr>
			<td>��ȭ��ȣ</td>
			<td>
				<input type="text" name="mphone" style="width:55%">
			</td>
		</tr>
		<tr>
			<td>�̸���</td>
			<td>
				<input type="text" name="mmail" style="width:55%">
			</td>
		</tr>
<!-- 
				<tr>
					<td>���� �ø���</td>
					<td>
						<select name="prefer">
							<option value="1">MTG</option>
							<option value="2">�����</option>
							<option value="3">Ű����</option>
							<option value="4">��Ÿ</option>						
						</select>
					</td>
				</tr>	
 -->					
		<tr>
			<td>������ ���� </td> 
			<td style="text-align:left; height:35px;">
				<div > <img id = "preview" style="width:200px;"></div>		
				<div>
					<input type="file" name="mpic" onchange="readURL(this);">
				</div>
			</td>
		</tr> 				
		<tr>
			<td>�ڱ�Ұ�</td>
			<td><textarea name="mmyself" style="width:95%; height:200px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<input type="submit" value="���ԿϷ�"> <input type="button" value="�������" onclick="location.href='index.jsp'">
			</td>
		</tr>				
	</table>
</form>
<!-- -----------���� ������--------------- -->



<%@ include file = "Include/tail.jsp" %>