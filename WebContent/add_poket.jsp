<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>
<%
LoginVO login = (LoginVO)session.getAttribute("login");
request.setCharacterEncoding("euc-kr");

if(login == null)
{	%>
	<script>
		alert("접근권한이 없습니다.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}


String my_num  	  = login.getNo();
String sql   	  = "";	
String gnum   	  = request.getParameter("gnum");
String gmnum	  = request.getParameter("gmnum");
String plnum 	  = "";
System.out.println(gnum);
System.out.println(gmnum);


sql = "select * from poketlist where gnum = '"+ gnum +"' and mnum = '"+ my_num +"' order by plnum desc"; 
dbms.OpenQuery(sql);

if(dbms.GetNext()==true)
{
	plnum = dbms.GetValue("plnum");
	System.out.print(plnum);
}
else
{
	plnum = "";
}
dbms.CloseQuery();

if(plnum.equals(""))
{
	sql = "insert into poketlist (mnum, gnum) values ('"+ my_num +"','"+ gnum +"')";
	dbms.RunSQL(sql);
	System.out.println("SQL:" + sql);
}




%>

<script>
alert("찜 리스트에 추가되었습니다.");
document.location = "my_poket.jsp";
</script>

<%@ include file="../config/dbclose.jsp"%>
