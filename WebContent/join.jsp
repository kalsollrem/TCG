<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "Include/head.jsp" %>


<script>
function joinCheck()
{
	if(document.join_do_it.read_cheak.value == 2)
		{	
			alert("����� �������ּ���.");
			return false;
		}
}

</script>

<!-- -----------���� ������--------------- -->
<table class="space"><tr><td></td></tr></table>

<form name="join_do_it" method="post" action="join_r.jsp" onsubmit="return joinCheck()">	
	<table name="join_cho" style="width:640px; margin:auto;" border="1" >	
		<tr>
			<td>ȸ������</td>
		</tr>
		<tr style="text-align:left;">
			<td height="200px" width="640px">
				<div class="join_cheak" style="height:100%; width:100%; overflow-y:scroll;"> 
				
<!-- -���� �̿���-- -->						
��1��(����) ...	<br>
��2�� (����� ȿ��) ... <br>
��3�� (��� �̿��� ��Ģ) ... <br>
��4�� (�̿����� ü��) ȸ�� ���� �� ȸ�� ��� �ؿ� �ִ� ���ǹ�ư�� ������ ����� �����Ͽ� �� ����� ü��� ������ �����Ѵ�. <br>
��5�� (����� ����) ... <br>
��6�� (�̿��û) ... <br>
��7�� (ȸ�������� �³�) <br>
��1��(����) ...	<br>
��2�� (����� ȿ��) ... <br>
��3�� (��� �̿��� ��Ģ) ... <br>
��4�� (�̿����� ü��) ȸ�� ���� �� ȸ�� ��� �ؿ� �ִ� ���ǹ�ư�� ������ ����� �����Ͽ� �� ����� ü��� ������ �����Ѵ�. <br>
��5�� (����� ����) ... <br>
��6�� (�̿��û) ... <br>
��7�� (ȸ�������� �³�) <br>
<!-- -���� �̿���-- -->						



				</div>											
			</td>
		</tr>		
		<tr>
			<td style="text-align:center">							
			�ǰ��� �³��Ͻðڽ��ϱ�?<br><br>
				<input type="radio" id="join_yes" value="1" name="read_cheak"><label for="1">����� �³��մϴ�.</label>
				<input type="radio" id="join_no"  value="2" name="read_cheak" checked><label for="2">����� �����մϴ�.</label>
			</td>
		</tr>		
	</table>
	<table style="margin:auto">
		<tr>
			<td><input type="submit" value="����" style="width:120px; height:40px"></td>	
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>			
			<td><input type="button" value="�������" style="width:120px; height:40px" onclick="location.href='index.jsp'"></td>
		</tr>
	</table>
</form>						

<table class="space"><tr><td></td></tr></table>
<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>