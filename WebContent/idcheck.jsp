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
		<title>���̵� �ߺ� �˻�</title>
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
		"<%=mid %>"�� ����� �� ���� ID �Դϴ�.
		<br>
		<input type = "button" value ="�ݱ�" onclick="SetIDCheckDone(2);">
	<%
	}
	else
	{
	%>
	"<%=mid %>"�� ����� �� �ִ� ID �Դϴ�.
		<br>
		<input type = "button" value ="���̵� ���" onclick="SetIDCheckDone(1);">
	<%
	}
	%>
	</body>
</html>


<%@ include file="./config/dbclose.jsp"%>
