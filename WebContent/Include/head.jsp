<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
    
<%
LoginVO login = (LoginVO)session.getAttribute("login");

String key = request.getParameter("key"); 
if(key == null){ key = ""; }

%>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>메인뷰</title>
		<script src="jquery-3.6.0.js"></script>
	</head>
	
<link rel="stylesheet" href="css\\sheet.css">

<body>
	<form name="search" method="get" action="index.jsp?key=<%=key%>">
		<table border="0" style="text-align:center; width:1000px; height:100px; margin:auto; margin-bottom:30px; background-color:#a1c3d6;">
			<tr>
				<td width="180px"><a href="index.jsp"><img src="image/logo.png" height="100px";></a></td>
				<td width="640px">		
					<input type="text" name="key" size="10" value="<%=key %>" style="width:350px; height:40px;">
					<input type="submit" value="검색">
				</td>
				<% 
				if(login == null)
				{
				%>
				<td width="180px">
					<div>
					<span style="font-size:25px; color:white; backgorund-color:#4aa3d4;"><a href="login.jsp">로그인</a></span><br>
					</div>
				</td>
				<%	
				}
				else
				{%>
				<td width="180px">
					<span style="font-size:15px; color:white">어서오세요</span><br>
					<span style="font-size:25px; color:red;"><a href="my_info.jsp"><%=login.getName() %>님</a></span><br>
					<span><a href="logout.jsp">로그아웃</a></span>
				</td>
				<%	
				}
				%>
			</tr>
		</table>
	</form>	
			