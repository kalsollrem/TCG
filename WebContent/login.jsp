<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
    
    
<%
request.setCharacterEncoding("euc-kr");
%>
    
<!DOCTYPE html>

<html>
	<head>
		<meta charset="EUC-KR">
		<title>로그인</title>
		<script src="jquery-3.6.0.js"></script>
	</head>
	<script>
		window.onload = function()
		{
			document.login.mid.focus();
		}
		
		function logincheak()
		{
			if( document.login.mid.value == "")
			{
				alert("아이디가 비었습니다.")
				document.login.mid.focus();
				return false;
			}
			if( document.login.mpw.value == "")
			{
				alert("비빌번호가 비었습니다.")
				document.login.mpw.focus();
				return false;
			}
			return true;
		}
	</script>
	<!-- ----------------------- -->
	<div id ="wrap">		
		<form name=login method="post" action="loginok.jsp" onsubmit = "return logincheak()">
			<table border="0" style="margin:auto; margin-top:180px; border-collapse:collapse">
				<tr>
					<td colspan="2" style="width:600px; height:120px; text-align:center; background-color:#a1c3d6;"><a href="index.jsp"><img src="image/logo.png" height="100px";></a></td>
				</tr>
				<tr style="background-color:#cce0eb;">
					<td style="width:100px; height:50px; text-align:center; color:white; font-size:20px;">아이디</td>
					<td style="width:500px;"><input type="text" name="mid" style="height:30px; width:40%"></td>						
				</tr>
				<tr style="background-color:#cce0eb;">
					<td style="width:100px; height:50px; text-align:center; color:white; font-size:17px;">비밀번호</td>
					<td style="width:500px;"><input type="password" name="mpw" style="height:30px; width:40%"></td>						
				</tr>
				<tr style="background-color:#cce0eb;">
					<td colspan="2" style="width:600px; height:60px; text-align:center"> 
						<input type="submit" value="로그인" style="width:100px; height:50px">	
					</td>						
				</tr>
				<tr style="background-color:#cce0eb;">
					<td colspan="2" style="text-align:center; font-size:20px;"><a href="join.jsp">회원가입</a></td>						
				</tr>
			</table>
		</form>
	</div>	
	</body>
</html>

<%@ include file="../config/dbclose.jsp"%>
