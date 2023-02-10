<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
<%  LoginVO login = (LoginVO)session.getAttribute("login"); %>
<!-- ----------------------------------------- -->

<%
if( login == null)
{	%>
	<script>
		alert("로그인 되지 않았니다.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}

String gname 	= request.getParameter("gname");
String gmnum  	= request.getParameter("mnum");
String gnum 	= request.getParameter("gnum");
String mnum  	= login.getNo();
String sql 		= "";

System.out.println(gmnum);
System.out.println(mnum);


if(!mnum.equals(gmnum))
{
	%>
	<script>
		alert("비작성자는 삭제권한이 없습니다.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}


if(gnum == null || gnum.equals(""))
{%>
	<script>
		alert("잘못된 접근 방식입니다.");
		document.location = "index.jsp";
	</script>
	<%
	return;
}




sql = "delete from product where gnum =" + gnum;
System.out.println(sql);

dbms.RunSQL(sql);

%>
<script>
alert("삭제되었습니다.");
document.location = "index.jsp";
</script>


<!-- ----------------------------------------- -->
<%@ include file="../config/dbclose.jsp"%>
