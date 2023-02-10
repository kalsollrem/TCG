<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="./config/dbopen.jsp"%>

<%

String mid = request.getParameter("id");
String sql = "select mid from info where mid = '"+ mid + "' ";
dbms.OpenQuery(sql);

boolean isdup = false;

if(dbms.GetNext() == true )
{
	isdup = true;	
}
else
{
	isdup = false;
}

dbms.CloseQuery();

%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="EUC-KR">
		<title>아이디 중복 검사</title>
	</head>
	<body>
		<script>
			function SetIDCheckDone(value)
			{
				opener.IsDupCheck = value;
				window.close();
			}			
		</script>	
	<%
	if(isdup == true)
	{
	%>
		"<%=mid %>"는 사용할 수 없는 ID 입니다.
		<br>
		<input type = "button" value ="닫기" onclick="SetIDCheckDone(2);">
	<%
	}
	else
	{
	%>
	"<%=mid %>"는 사용할 수 있는 ID 입니다.
		<br>
		<input type = "button" value ="아이디 사용" onclick="SetIDCheckDone(1);">
	<%
	}
	%>
	</body>
</html>


<%@ include file="./config/dbclose.jsp"%>
