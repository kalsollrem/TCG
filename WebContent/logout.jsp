<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
session.removeAttribute("login");
%>

<script>
	alert("로그아웃되었습니다.");
	document.location = "first_view.jsp";
</script>