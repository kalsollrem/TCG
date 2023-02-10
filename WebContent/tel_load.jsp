<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ include file = "Include/head.jsp" %>

<%
if(login == null)
{	%>
	<script>
		alert("접근권한이 없습니다.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}

String my_num   = login.getNo();					//나
String you_num  = request.getParameter("gmnum");	//상대
String gnum 	= request.getParameter("gnum");		//품번
String gstate 	= request.getParameter("gstate");	//판매상태
String prefer	= request.getParameter("prefer"); 	//분류
String curpage 	= request.getParameter("page"); 	//페이지
String sql		="";
String plnum 	= "";


System.out.println("my_num" + my_num);
System.out.println("you_num" +you_num);
System.out.println("gnum" +gnum);



//포켓추가
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

//




sql = "select * from product where gnum=" + gnum;
dbms.OpenQuery(sql);
dbms.GetNext();
String gpic	 	= dbms.GetValue("gpic");	//제품사진
String gname 	= dbms.GetValue("gname");	//품명
String gvalue 	= dbms.GetValue("gvalue");	//가격
String tnum 	= "";

System.out.println("gpic" +gpic);
System.out.println("gstate" +gstate);
System.out.println("gname" +gname);
System.out.println("gvalue" +gvalue);


sql  = "select * from telroom "; 
sql += "where mnum = '"+my_num+"' ";
sql += "and gmnum = '"+you_num+"' ";
sql += "and gnum = "+ gnum ;
dbms.OpenQuery(sql);
if(dbms.GetNext() == true)
{
	tnum = dbms.GetValue("tnum");
	System.out.println("tnum" +tnum);
}
else
{
	sql = "insert into telroom (mnum, gmnum, gnum) ";
	sql += "values ('"+ my_num +"','"+ you_num +"','"+ gnum +"')";
	dbms.RunSQL(sql);
	System.out.println("SQL:" + sql);
	
	sql = "select tnum from telroom ";
	sql += "where mnum = '"+my_num+"' and gmnum = '"+you_num+"' and gnum = "+ gnum ;
	dbms.OpenQuery(sql);
	dbms.GetNext();
	
	tnum = dbms.GetValue("tnum");
	System.out.println("tnum" +tnum);

	sql = "select slnum from sellist where mnum = '"+you_num+"' and gnum = '"+gnum+"' " ;
	System.out.println("SQL:" + sql);
	dbms.OpenQuery(sql);
	dbms.GetNext();
	
	String slnum = dbms.GetValue("slnum");
	System.out.println("slnum :" +slnum);
	
	sql = "update sellist set tnum = '"+tnum+"' where slnum = " +slnum;
	dbms.RunSQL(sql);
	System.out.println("SQL:" + sql);

	sql = "update poketlist set tnum = '"+tnum+"' where mnum = '"+my_num+"' and gnum = " + gnum;
	dbms.RunSQL(sql);
	System.out.println("SQL:" + sql);
	
}




%>
<script>
	document.location = "tel.jsp?tnum=<%=tnum%>";
</script>

<%@ include file="../config/dbclose.jsp"%>
