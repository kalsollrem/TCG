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
<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td rowspan="3" style="height:250px; width:250px">
			<img src="pic_down.jsp?mpic=<%= mpic %>" style="height:250px; width:250px">
		</td>
		<td><%=mname %>(<%=maddr_a %>)</td>
	</tr> 
	<tr>
		<td>��:<%=mrank %>(�ŷ���:<%=mdelnum %>)</td>
	</tr>
	<tr>
		<td>���ֽ� ��õ��</td>
	</tr>
	<tr>
		<td colspan="2"> 
			<table border="1" style="margin:auto; margin-top:30px; margin-bottom:30px; width:50%; text-align:center;">
				<tr>
					<td style="height:50px; width:180px;"><a href="sel_list.jsp">�Ǹ� ���</a></td> 
					<td style="height:50px; width:180px;"><a href="buy_list.jsp">���� ���</a></td> 
					<td style="height:50px; width:180px;"><a href="my_poket.jsp">����</a></td> 
				</tr>
			</table>
		</td>
		
	</tr>
</table>	

<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>