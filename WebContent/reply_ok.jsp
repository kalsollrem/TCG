<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
request.setCharacterEncoding("euc-kr");
LoginVO login = (LoginVO)session.getAttribute("login");

String my_num   = login.getNo();					//나
String tnum  	= request.getParameter("tnum");		//상대
String prefer	= request.getParameter("prefer"); 	//분류
String curpage 	= request.getParameter("page"); 	//페이지
String rnote 	= request.getParameter("rnote"); 	//방번호
String sql 		= "";

System.out.println("나:" 	+ my_num);
System.out.println("방번호:"  + tnum);
System.out.println("댓글내용:" + rnote);

sql = "insert into reply (mnum,tnum,rnote) ";
sql += "values(";
sql += "'" + my_num + "',";
sql += "'" + tnum + "',";
sql += "'" + rnote.replace("'","''") + "' )";
dbms.RunSQL(sql);

%>

<script>
	location.href="tel.jsp?tnum=<%=tnum%>"
</script>
	
<%@ include file="../config/dbclose.jsp"%>
