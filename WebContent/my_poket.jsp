<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>
<%@ include file = "Include/buy_guide.jsp" %>

<%
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

String mnum  	  = login.getNo();
String sql   	  = "";	
String type  	  = "poket";
String add_gnum   = request.getParameter("gnum");
List<String> data = new ArrayList<String>();
List<String> room = new ArrayList<String>();



%>


<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->

<form name = "mypoket" method="post" action="rank_changer.jsp">
<table border="1" style="width:500px; margin:auto;">
	<tr>
		<td colspan="3" style="height:30px; text-align:center; font-size:20px;"  >찜 목록</td>
	</tr>
	<%
	sql  = "select * from poketlist where mnum = '"+mnum+"' order by plnum desc";
	dbms.OpenQuery(sql);
		
	while(dbms.GetNext()==true)
	{
		String gnum = dbms.GetValue("gnum");
		String into_room = dbms.GetValue("tnum");		
		data.add(gnum);
		room.add(into_room);		
		System.out.print(data);
	}			
	
	for(int i = 0 ; i<data.size(); i++)
	{
		String key_data = data.get(i); 
		String tnum 	= room.get(i); 
		
		sql =  "select * from product ";
		sql += "inner join info on product.mnum = info.mnum ";
		sql += "where gnum =" + key_data; 
		System.out.println("SQL:" + sql);
		dbms.OpenQuery(sql);
		dbms.GetNext();
		
		String gdate 	= dbms.GetValue("gdate");		//등록일
		String gnum 	= dbms.GetValue("gnum");		//제품번호
		String gname 	= dbms.GetValue("gname");		//제품명
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
		String gstate   = dbms.GetValue("gstate");		//제품의 판매여부(a생존 / d판매완료)	
		
	%>		
	<tr>
		<td style="width:30%; height:70px; <% if(gstate.equals("D") || gstate.equals("O") ) {%>background-color: #808080;<%}%>" >
			<div style="float:left;">
				<a href="view.jsp?gname=<%=gname%>&gnum=<%=gnum %>">
				<img src="gpic_down.jsp?gnum=<%=gnum %>&gpic=<%= gpic %>" width="100%">
				</a>
			</div>
		</td>
		<td style="width:55%; height:70px;">
		<input type="hidden" name="plnum" value="<%=type%>">
		<input type="hidden" name="gnum" value="<%=gnum%>">
		<% if(gstate.equals("D") || gstate.equals("O") )
		{%>	<table border="1" style="width:100%; height:100%; background-color: #808080;"><%}
		else
		{%>	<table border="1" style="width:100%; height:100%;">	<%}	%>
				<tr>
					<% if(gstate.equals("O"))
					{%>	<td colspan="2" style="text-align:center; background-color: #808080;"><%=gname %> <span style="color:red;">(거래완료)</span></td>	<%}
					else if(gstate.equals("D"))
					{%>	<td colspan="2" style="text-align:center; background-color: #808080;"><%=gname %> <span style="color:red;">(거래완료 평가해주세요.)</span></td>	<%}
					else
					{%>	<td colspan="2" style="text-align:center;"><%=gname %></td><%}	%>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">작성자</td>
					<td><%=mnick %></td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">등록일</td>
					<td><%=gdate %></td>
				</tr>
				<tr>
					<td style="text-align:center;">가격</td>
					<td><%=gvalue %>원</td>
				</tr>
				<tr>
					<td style="text-align:center; width:70px">직거래 </td>
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
			</table>
		</td>
		<% if(gstate.equals("O"))
		{%>	
		<td style="width:15%; text-align:center; background-color: #808080;">
			<div> <input type="button" value="삭제" onClick="location.href='delete_list.jsp?gnum=<%=gnum %>&gmnum=<%=gmnum %>&type=<%=type%>'"> </div>	
		</td>
		<%}
		else if(gstate.equals("D"))
		{%>	
		<td style="width:15%; text-align:center; background-color: #808080;">
			<div style="margin-bottom:10px"> 
				<select name="rate">
					<option value="1.0">1.0</option>
					<option value="1.5">1.5</option>
					<option value="2.0">2.0</option>
					<option value="2.5">2.5</option>
					<option value="3.0">3.0</option>
					<option value="3.5">3.5</option>
					<option value="4.0">4.0</option>						
					<option value="4.5">4.5</option>						
					<option value="5.0" selected>5.0</option>		
				</select>
			</div>
			<div>
				<input type="hidden" name="gnum" value="<%=gnum%>">
				<input type="hidden" name="gmnum" value="<%=gmnum%>">
				<input type="hidden" name="tnum" value="<%=tnum%>">
				<input type="submit" value="평가">
			</div>
		</td>
		<%}	
		else
		{%>	
		<td style="width:15%; text-align:center;">
			<div> <input type="button" value="연락" onClick="location.href='tel_load.jsp?gnum=<%=gnum %>&gstate=<%=gstate%>&gmnum=<%=gmnum%>'"> </div><br>
			<div> <input type="button" value="삭제" onClick="location.href='delete_list.jsp?gnum=<%=gnum %>&gmnum=<%=gmnum %>&type=<%=type%>'"> </div>	
		</td>
		<%}	%>		
	</tr>		
	<%
	}
	%>
		
</table>
</form>

<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>