<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
    
<%
request.setCharacterEncoding("euc-kr");

String mid	 = request.getParameter("mid");
String mpw	 = request.getParameter("mpw");
String sql 	 = "";


sql  = "select mnum,mname from info ";
sql += "where mid = '"+ mid +"' ";
sql += "and mpw = md5('"+ mpw +"')";
sql += "and mlive = 'N' ";
System.out.println("SQL : "+ sql);
dbms.OpenQuery(sql);



if(dbms.GetNext() == false)
{
	dbms.CloseQuery();
	
	%>
	<script>
		alert("���̵� Ȥ�� ��й�ȣ�� ��ġ�����ʽ��ϴ�.");
		document.location = "login.jsp";
	</script>
	<%
}
else
{
	String mnum  = dbms.GetValue("mnum");
	String mname = dbms.GetValue("mname");
	
	dbms.CloseQuery();
	
	LoginVO vo = new LoginVO(mnum,mid,mname);
	
	session.setAttribute("login",vo);
	
	%>
	<script>
		alert("�α��εǾ����ϴ�.");
		document.location = "index.jsp";
	</script>
	<%
}
%>    
        
	
		


<%@ include file="../config/dbclose.jsp"%>
