<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
LoginVO login = (LoginVO)session.getAttribute("login");
if(login == null)
{
	%>
	<script>
		alert("접근 권한이 없습니다.");
		document.location = "index.jsp";
	</script>		
	<%
	return;
}

String pyungga  = request.getParameter("rate");
String tnum		= request.getParameter("tnum");
System.out.println("rate :" +pyungga);
System.out.println("tnum :" +tnum);

String gmnum 	= "";
String mnum		= "";
String gnum		= "";
String my_num   = login.getNo();					//나

if(pyungga != null)
{
	String sql = "select * from telroom where tnum=" + tnum;
	System.out.println("SQL:" + sql);
	dbms.OpenQuery(sql);
	
	if(dbms.GetNext() == true)
	{
		gmnum = dbms.GetValue("gmnum");
		mnum  = dbms.GetValue("mnum");
		gnum  = dbms.GetValue("gnum");
		System.out.println("gmnum :" +gmnum);
		System.out.println("mnum :"  +mnum);
	}
	
	
	double pares_pyungga = Double.parseDouble(pyungga); 						//정수로변환
		
	
	sql = "select mrank,mdelnum from info " ;
	if(!gmnum.equals(my_num)) {	sql += "where mnum = " + gmnum;		System.out.println("M");}
	else					  {	sql += "where mnum = " + mnum;		System.out.println("G");}
	dbms.OpenQuery(sql);
	dbms.GetNext();
	System.out.println("SQL:" + sql);
	String mrank 	= dbms.GetValue("mrank");		
	String mdelnum	= dbms.GetValue("mdelnum");		
	double rank		= Double.parseDouble(mrank);								//상대 평점
	double del		= Double.parseDouble(mdelnum) ;								//변환
	double delnum	= del +1					;								//실거래수
	double set_rank = (rank + pares_pyungga) / (delnum +1);						//새 평점계산
		
	
	
	if(gmnum.equals(my_num))
	{
		sql = "update info set mrank = '"+set_rank+"' , mdelnum = '"+delnum+"' where mnum = " + gmnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
		
		sql = "update product set gstate = 'D' where gnum = " + gnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
	}
	else
	{
		sql = "update info set mrank = '"+set_rank+"' , mdelnum = '"+delnum+"' where mnum = " + mnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
		
		sql = "insert into buylist (mnum,gnum,tnum) values(";
		sql += "'" + my_num+ "',";		
		sql += "'" + gnum+ "',";		
		sql += "'" + tnum+ "'";						
		sql += ")";
		System.out.println("SQL:" + sql);
		
		sql = "delete from poketlist where tnum = " +tnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
		
		sql = "update product set gstate = 'O' where gnum = '"+gnum+"' and mnum = "+ my_num;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
		
	}
	
	
}

%>

<script>
	document.location = "sel_list.jsp";
</script>

<%@ include file="./config/dbclose.jsp" %>
