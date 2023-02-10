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
String gmnum  	= request.getParameter("gmnum");
String gnum 	= request.getParameter("gnum");
String type		= request.getParameter("type");
String mnum  	= login.getNo();
String sql		= "";
System.out.println(gmnum);
System.out.println(mnum);
System.out.println(gnum);
System.out.println(type);




if(gnum == null || gnum.equals(""))
{%>
	<script>
		alert("잘못된 접근 방식입니다.");
		document.location = "index.jsp";
	</script>
	<%
	return;
}



switch(type)
{
	case "poket" : sql = "delete from poketlist where mnum = '"+mnum+"' and gnum = '"+gnum+"'"; break;
	case "sel"   : sql = "delete from sellist where mnum = '"+mnum+"' and gnum = '"+gnum+"'";	break;
	case "buy"   : sql = "delete from buylist where mnum = '"+mnum+"' and gnum = '"+gnum+"'"; 	break;
}
dbms.RunSQL(sql);



switch(type)
{
	case "poket" :	
		{%><script> alert("삭제되었습니다."); document.location = "my_poket.jsp"; </script><%};		break;
		
	case "sel" :	
		{%><script> alert("삭제되었습니다."); document.location = "sel_list.jsp"; </script><%};		break;
		
	case "buy" :	
		{%><script> alert("삭제되었습니다."); document.location = "buy_list.jsp"; </script><%};		break;
}


%>






<!-- ----------------------------------------- -->
<%@ include file="../config/dbclose.jsp"%>