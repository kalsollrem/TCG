<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
request.setCharacterEncoding("euc-kr");
LoginVO login = (LoginVO)session.getAttribute("login");

String my_num   = login.getNo();					//��
String tnum  	= request.getParameter("tnum");		//���
String prefer	= request.getParameter("prefer"); 	//�з�
String curpage 	= request.getParameter("page"); 	//������
String rnote 	= request.getParameter("rnote"); 	//���ȣ
String sql 		= "";

System.out.println("��:" 	+ my_num);
System.out.println("���ȣ:"  + tnum);
System.out.println("��۳���:" + rnote);

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
