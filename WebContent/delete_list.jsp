<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
<%  LoginVO login = (LoginVO)session.getAttribute("login"); %>
<!-- ----------------------------------------- -->

<%
if( login == null)
{	%>
	<script>
		alert("�α��� ���� �ʾҴϴ�.");
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
		alert("�߸��� ���� ����Դϴ�.");
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
		{%><script> alert("�����Ǿ����ϴ�."); document.location = "my_poket.jsp"; </script><%};		break;
		
	case "sel" :	
		{%><script> alert("�����Ǿ����ϴ�."); document.location = "sel_list.jsp"; </script><%};		break;
		
	case "buy" :	
		{%><script> alert("�����Ǿ����ϴ�."); document.location = "buy_list.jsp"; </script><%};		break;
}


%>






<!-- ----------------------------------------- -->
<%@ include file="../config/dbclose.jsp"%>