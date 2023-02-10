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
		alert("아이디를 입력하세요");
		document.join_r.mid.focus();
		return false;
	}
	if(document.join_r.mpw.value == "")
	{
		alert("비밀번호를 입력하세요");
		document.join_r.mid.focus();
		return false;
	}
	if(document.join_r.mpw.value != document.join_r.mpwcheck.value)
	{
		alert("확인된 비밀번호의 내용이 다릅니다.");
		document.join_r.mpwcheck.focus();
		return false;
	}
	if(document.join_r.mname.value == "")
	{
		alert("이름을 입력하세요");
		document.join_r.mname.focus();
		return false;
	}
	if(document.join_r.mnick.value == "")
	{
		alert("닉네임을 입력하세요");
		document.join_r.mnick.focus();
		return false;
	}
	if(document.join_r.madd_a.value == "")
	{
		alert("주소를 입력하세요");
		document.join_r.madd_a.focus();
		return false;
	}
	if(document.join_r.madd_b.value == "")
	{
		alert("남은주소를 입력하세요");
		document.join_r.madd_b.focus();
		return false;
	}
	if(document.join_r.mphone.value == "")
	{
		alert("전화번호를 입력하세요");
		document.join_r.mphone.focus();
		return false;
	}
	if(document.join_r.mmail.value == "")
	{
		alert("메일주소를 입력하세요");
		document.join_r.mmail.focus();
		return false;
	}
}

function CheckIDDup()
{
	var userid = document.join_r.mid.value;
	if(userid == "")
	{
		alert("아이디를 입력하세요.");
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

<!-- -----------이하 콘텐츠--------------- -->
<form name="join_r" method="post" action="joinok.jsp" enctype="multipart/form-data" onsubmit="return Formcheck()">
	<table border="1" style="margin:auto; width:800px;">
		<tr>
			<td colspan="2" style="text-align:center;">가입 신청서</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text"  name="mid" size="20">
			<input type="button" value="아이디 중복체크" onclick = "CheckIDDup();"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="mpw"   size="20"></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="mpwcheck"  size="20"></td>
		</tr>			
		<tr>
			<td>이름</td>
			<td><input type="text" name="mname"  style="width:30%"></td>
		</tr>		
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="mnick"  style="width:30%"></td>
		</tr>		
		<tr>
			<td>주소</td>
			<td>
				<table>
					<tr>
						<td>거주동  </td>
						<td><input type="text" name="maddr_a"  style="width:30%"></td>
					</tr>
					<tr>
						<td>나머지 주소  </td>
						<td><input type="text" name="maddr_b"  style="width:300px"></td>
					</tr>
				</table>					
			</td>
		</tr>		
		<tr>
			<td>성별</td>
			<td>
				<input type="radio" name="msex" value="M" checked>남자
				<input type="radio" name="msex" value="F">여자
			</td>
		</tr>	
		<tr>
			<td>전화번호</td>
			<td>
				<input type="text" name="mphone" style="width:55%">
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<input type="text" name="mmail" style="width:55%">
			</td>
		</tr>
<!-- 
				<tr>
					<td>관심 시리즈</td>
					<td>
						<select name="prefer">
							<option value="1">MTG</option>
							<option value="2">유희왕</option>
							<option value="3">키포지</option>
							<option value="4">기타</option>						
						</select>
					</td>
				</tr>	
 -->					
		<tr>
			<td>프로필 사진 </td> 
			<td style="text-align:left; height:35px;">
				<div > <img id = "preview" style="width:200px;"></div>		
				<div>
					<input type="file" name="mpic" onchange="readURL(this);">
				</div>
			</td>
		</tr> 				
		<tr>
			<td>자기소개</td>
			<td><textarea name="mmyself" style="width:95%; height:200px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<input type="submit" value="가입완료"> <input type="button" value="가입취소" onclick="location.href='index.jsp'">
			</td>
		</tr>				
	</table>
</form>
<!-- -----------이하 콘텐츠--------------- -->



<%@ include file = "Include/tail.jsp" %>