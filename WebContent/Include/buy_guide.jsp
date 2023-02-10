<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
String prefer	= request.getParameter("prefer");
String curpage 	= request.getParameter("page");
%>

<table border="0" style="width:1000px; margin:auto;">
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