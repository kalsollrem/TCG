<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

if( login == null)
{	%>
	<script>
		alert("접근권한이 없습니다.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}

String gnum 	= request.getParameter("gnum");			//상품고유번호
String gname 	= request.getParameter("gname");		//상품고유명
String prefer	= request.getParameter("prefer"); 		//분류
String curpage 	= request.getParameter("page"); 		//페이지
String sql		= "";

if(gnum == null || gnum.equals(""))
{%>
	<script>
		alert("잘못호출된 게시판입니다.");
		document.location = "index.jsp";
	</script>
<%
	return;
}

sql =  "select * from product ";
sql += "inner join info on product.mnum = info.mnum ";
sql += "where gnum =" + gnum;
System.out.println("SQL:" + sql);
dbms.OpenQuery(sql);

if(dbms.GetNext() == false)
{
	%>
	<script>
		alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
		document.location = "login.jsp";
	</script>
	<%
	return;
}

String gdate 	= dbms.GetValue("gdate");		//등록일
String gdir 	= dbms.GetValue("gdir");		//직거래여부
String gmail 	= dbms.GetValue("gmail");		//우편 거래 여부
String gmyself 	= dbms.GetValue("gmyself");		//제품설명
String gvalue 	= dbms.GetValue("gvalue");		//가격
String gpic 	= dbms.GetValue("gpic");		//사진명
String gqty 	= dbms.GetValue("gqty");		//판매수량
String gmnum 	= dbms.GetValue("mnum");		//판매자 번호
String mnick 	= dbms.GetValue("mnick");		//판매자 닉네임
String mrank 	= dbms.GetValue("mrank");		//판매자 평점
String maddr_a  = dbms.GetValue("maddr_a");		//판매자 주소(A)
String gstate   = dbms.GetValue("gstate");		//물건 판매여부
String mnum 	= login.getNo();
dbms.CloseQuery();

%>

<script>
function removeCheck()
{
	if (confirm("정말 삭제하시겠습니까??") == true	)
	{ 
		location.href="delete.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum%>"
	}
	else { return ;}
}

function getMyPoket()
{
	if (confirm("찜하시겠습니까?") == true	)
	{ 
		location.href="add_poket.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>"			
	}
	else { return ;}
}
</script>

<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->
<form name = "view" method="post" action="#">
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td style="width:300px; height:400px;">
			<div style="float:left;">
				<img src="gpic_down.jsp?gnum=<%=gnum %>&gpic=<%= gpic %>" style="width:100%">
			</div>
		</td>
		<td style="width:700px; height:400px;">
			<table border="1" style="width:100%; height:100%;">
				<tr>
					<td colspan="2" style="text-align:center;"><%=gname%></td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">작성자</td>
					<td><%=mnick %> (☆:<%=mrank %>)</td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">등록일</td>
					<td><%=gdate %></td>
				</tr>
				<tr>
					<td style="text-align:center;">가격</td>
					<td><%=gvalue %> 원</td>
				</tr>
				<tr>
					<td style="text-align:center; width:150px">직거래 </td>
					<td>
					<%
					switch(gdir)
					{
						case "no"   : out.print("불가");	 						break;
						default 	: out.print("(" + maddr_a + ")" + "인근 ");	break;
					}
					%>
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">우편거래</td>
					<td>
					<%
					switch(gmail)
					{
						case "no" 		: out.print("불가");	 					 break;
						case "Before"   : out.print("선불");	 					 break;
						case "After"    : out.print("후불");	 					 break;
						default 		: out.print("택배비 발송자 부담 ");			 break;
					}
					%>
					</td>							
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
					<%
					if(mnum.equals(gmnum)) 
					{%>	<input type="button" value="글 수정" onclick="location.href='modify.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum %>'"> &nbsp;
						<input type="button" value="글 삭제" onclick="removeCheck();"><%} 
					else
					{%> <input type="button" value="찜 하기" onclick="getMyPoket();"> &nbsp;
					<input type="button" value="연락하기" onclick="location.href='tel_load.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>&gstate<%=gstate%>'"><%}
					%>				
					</td>
				</tr>
			</table>
		</td>
	</tr>		

</table>
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td colspan="5" style="background-color:#a7e3f2; text-align:center;">&nbsp;판매자의 다른상품</td>
	</tr>
	<tr>
	<%
		sql = "select count(gnum) from product where mnum = '"+ gmnum +"' and gstate = 'A'";
		dbms.OpenQuery(sql);
		dbms.GetNext();
		int total_limit = dbms.GetInt("count(gnum)");
		dbms.CloseQuery();
		
		if(total_limit <= 5)
		{
			sql  = "select gname,gvalue,gnum,gpic from product where mnum = '"+ gmnum +"' order by gnum desc ";
			sql += "limit " + total_limit;
			dbms.OpenQuery(sql);

			while(dbms.GetNext() == true)
			{		
				String sub_gname  = dbms.GetValue("gname");
				String sub_gvalue = dbms.GetValue("gvalue");	
				String sub_gnum = dbms.GetValue("gnum");	
				String sub_gpic = dbms.GetValue("gpic");
				
			%>
			<td class="another_thing">
		 		<div style="width:190px; height:100px; text-align:center;">
		 			<a href="view.jsp?gname=<%=sub_gname%>&gnum=<%=sub_gnum %>"><img src="gpic_down.jsp?gnum=<%=sub_gnum %>&gpic=<%= sub_gpic %>" height="100%"></a><br>
		 		</div>
		 		<div style="width:190px; height:45px; text-align:center;"><%=sub_gname %><br>(<%=sub_gvalue %>원)</div>				
			</td>	
			<%
			}
			dbms.CloseQuery();
		}
		else
		{
			sql  = "select gname,gvalue,gnum,gpic from product where mnum = '"+ gmnum +"' order by gnum desc ";
			sql += "limit 5";
			dbms.OpenQuery(sql);

			while(dbms.GetNext() == true)
			{			
				String sub_gname  = dbms.GetValue("gname");
				String sub_gvalue = dbms.GetValue("gvalue");
				String sub_gnum   = dbms.GetValue("gnum");
				String sub_gpic   = dbms.GetValue("gpic");
			%>
			<td class="another_thing">
		 		<div style="width:190px; height:100px; text-align:center;">
		 			<a href="view.jsp?gname=<%=sub_gname%>&gnum=<%=sub_gnum %>"><img src="gpic_down.jsp?gnum=<%=sub_gnum %>&gpic=<%= sub_gpic %>" height="100%"></a><br>
		 		</div>
		 		<div style="width:190px; height:40px; text-align:center;"><%=sub_gname %> : <%=sub_gvalue %></div>				
			</td>	
			<%
			}
			dbms.CloseQuery();			
		}
	%>				
	</tr>
</table>	
<table border="1" style="width:1000px; margin:auto;">
	<tr>
		<td style="text-align:center;">제품 상세</td>
	</tr>
	<tr>
		<td>
			<%=gmyself %>
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
			<%
			if(mnum.equals(gmnum)) 
			{%>	
			<input type="button" value="글 수정" onclick="location.href='modify.jsp?gname=<%=gname%>&gnum=<%=gnum %>&mnum=<%=gmnum %>'"> &nbsp;
			<input type="button" value="글 삭제" onclick="removeCheck();"><%} 
			else
			{%> 
			<input type="button" value="찜 하기" onclick="getMyPoket();"> &nbsp;
			<input type="button" value="연락하기" onclick="location.href='tel_load.jsp?gname=<%=gname%>&gnum=<%=gnum %>&gmnum=<%=gmnum %>&gstate<%=gstate%>'">
			<%}%>		
		</td>
	</tr>	
</table>
</form>
<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>