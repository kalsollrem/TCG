<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ include file = "Include/head.jsp" %>


<script>
function joinCheck()
{
	if(document.join_do_it.read_cheak.value == 2)
		{	
			alert("약관에 승인해주세요.");
			return false;
		}
}

</script>

<!-- -----------이하 콘텐츠--------------- -->
<table class="space"><tr><td></td></tr></table>

<form name="join_do_it" method="post" action="join_r.jsp" onsubmit="return joinCheck()">	
	<table name="join_cho" style="width:640px; margin:auto;" border="1" >	
		<tr>
			<td>회원가입</td>
		</tr>
		<tr style="text-align:left;">
			<td height="200px" width="640px">
				<div class="join_cheak" style="height:100%; width:100%; overflow-y:scroll;"> 
				
<!-- -대충 이용약관-- -->						
제1조(목적) ...	<br>
제2조 (약관의 효력) ... <br>
제3조 (약관 이외의 준칙) ... <br>
제4조 (이용계약의 체결) 회원 가입 시 회원 약관 밑에 있는 동의버튼을 누르면 약관에 동의하여 이 계약이 체결된 것으로 간주한다. <br>
제5조 (용어의 정의) ... <br>
제6조 (이용신청) ... <br>
제7조 (회원가입의 승낙) <br>
제1조(목적) ...	<br>
제2조 (약관의 효력) ... <br>
제3조 (약관 이외의 준칙) ... <br>
제4조 (이용계약의 체결) 회원 가입 시 회원 약관 밑에 있는 동의버튼을 누르면 약관에 동의하여 이 계약이 체결된 것으로 간주한다. <br>
제5조 (용어의 정의) ... <br>
제6조 (이용신청) ... <br>
제7조 (회원가입의 승낙) <br>
<!-- -대충 이용약관-- -->						



				</div>											
			</td>
		</tr>		
		<tr>
			<td style="text-align:center">							
			악관에 승낙하시겠습니까?<br><br>
				<input type="radio" id="join_yes" value="1" name="read_cheak"><label for="1">약관에 승낙합니다.</label>
				<input type="radio" id="join_no"  value="2" name="read_cheak" checked><label for="2">약관을 거절합니다.</label>
			</td>
		</tr>		
	</table>
	<table style="margin:auto">
		<tr>
			<td><input type="submit" value="가입" style="width:120px; height:40px"></td>	
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>			
			<td><input type="button" value="가입취소" style="width:120px; height:40px" onclick="location.href='index.jsp'"></td>
		</tr>
	</table>
</form>						

<table class="space"><tr><td></td></tr></table>
<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>