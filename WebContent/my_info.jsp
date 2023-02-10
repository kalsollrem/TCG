<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>
<%

request.setCharacterEncoding("euc-kr");

String mnum  = login.getNo();
String sql   = "";	
String prefer	= request.getParameter("prefer");
String curpage 	= request.getParameter("page");

sql  = "select mname,mrank,maddr_a,mdelnum,mpic ";
sql += "from info where mnum =" + mnum ; 

dbms.OpenQuery(sql);
dbms.GetNext();

String mname	 = dbms.GetValue("mname");
String mrank	 = dbms.GetValue("mrank");
String maddr_a	 = dbms.GetValue("maddr_a");
String mpic		 = dbms.GetValue("mpic");
String mdelnum	 = dbms.GetValue("mdelnum");

dbms.CloseQuery();

%>
<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td rowspan="3" style="height:250px; width:250px">
			<img src="pic_down.jsp?mpic=<%= mpic %>" style="height:250px; width:250px">
		</td>
		<td><%=mname %>(<%=maddr_a %>)</td>
	</tr> 
	<tr>
		<td>☆:<%=mrank %>(거래수:<%=mdelnum %>)</td>
	</tr>
	<tr>
		<td>전주시 송천동</td>
	</tr>
	<tr>
		<td colspan="2"> 
			<table border="1" style="margin:auto; margin-top:30px; margin-bottom:30px; width:50%; text-align:center;">
				<tr>
					<td style="height:50px; width:180px;"><a href="sel_list.jsp">판매 목록</a></td> 
					<td style="height:50px; width:180px;"><a href="buy_list.jsp">구매 목록</a></td> 
					<td style="height:50px; width:180px;"><a href="my_poket.jsp">찜목록</a></td> 
				</tr>
			</table>
		</td>
		
	</tr>
</table>	

<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>