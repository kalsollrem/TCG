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
		alert("아이디 혹은 비밀번호가 일치하지않습니다.");
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
		alert("로그인되었습니다.");
		document.location = "index.jsp";
	</script>
	<%
}
%>    
        
	
		


<%@ include file="../config/dbclose.jsp"%>
