<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
String gnum = request.getParameter("gnum");

String sql = "update product set gstate = 'E' where gnum=" + gnum;

dbms.RunSQL(sql);
%>

<script>
	document.location = "sel_list.jsp";
</script>

<%@ include file="./config/dbclose.jsp" %>
