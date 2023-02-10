<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>


<%
request.setCharacterEncoding("euc-kr");
String prefer	= ""; 	//분류
String curpage 	= ""; 	//페이지
String gnum		= "";
String my_num   = "";
String your_num	= "";
String my_nick  = "";
String you_nick = "";
String tnum 	= request.getParameter("tnum"); 	//방번호
String sql		= "";
String playerA	= "";
String playerB	= "";

System.out.println("tnum:" 	+ tnum);

//제품번호 얻기
sql = "select * from telroom where tnum = "+tnum;
dbms.OpenQuery(sql);
if(dbms.GetNext() == true)
{
	gnum 	 = dbms.GetValue("gnum");		//품번
	your_num = dbms.GetValue("gmnum");		//판매자이름
	my_num 	 = dbms.GetValue("mnum");		//구매자이름
	
}
System.out.println("my_num:" 	+ my_num);
System.out.println("you_num :"  + your_num);
System.out.println("gnum : "	+ gnum);
dbms.CloseQuery();

if(my_num.equals(your_num))
{
	playerA = my_num;
	playerB = your_num;	
}
else
{
	playerA = your_num;	
	playerB = my_num;
}


//상단 게시 제품 정보
sql = "select gpic,gstate,gname,gvalue from product where gnum=" + gnum;
dbms.OpenQuery(sql);
dbms.GetNext();
String gpic	 	= dbms.GetValue("gpic");	//제품사진
String gstate 	= dbms.GetValue("gstate");	//제품판매여부	
String gname 	= dbms.GetValue("gname");	//품명
String gvalue 	= dbms.GetValue("gvalue");	//가격

System.out.println("gpic :"	 + gpic);
System.out.println("gstate:" + gstate);
System.out.println("gname:"	 + gname);
System.out.println("gvalue:" + gvalue);

for(int i = 1; i<=2; i++)
{
	sql = "select mnick from info where mnum = ";
	switch(i)
	{
		case 1:	sql += playerA;	 dbms.OpenQuery(sql);  dbms.GetNext();  my_nick  = dbms.GetValue("mnick"); break;
		case 2:	sql += playerB;	 dbms.OpenQuery(sql);  dbms.GetNext();  you_nick = dbms.GetValue("mnick"); break;
	}

}


sql = "select * from reply where tnum = " + tnum;
dbms.OpenQuery(sql);


%>
<script>
window.onload = function()
{
	var divdiv = document.getElementById("scrollDiv");
	divdiv.scrollTop = divdiv.scrollHeight;
	document.reply_in.rnote.focus();	

}
</script>

<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->
<table border="1" style="width:200px; height:40px; margin:auto; margin-bottom:30px;">
	<tr>
		<td style="text-align:center;">
			<a href="buy.jsp">목록으로 돌아가기</a>
		</td>
	</tr>
</table>

<table border="1" style="width:800px; margin:auto;">
<tr>
	<td style="width:100px; height:100px;">
		<div style="text-align:center;">
		<img src="gpic_down.jsp?gnum=<%=gnum %>&gpic=<%= gpic %>" style="height:100px">
		</div>
	</td>
	<td>
		<div style="font-size:40px; margin-left:10px"><%=gname %></div>
		<div style="font-size:30px; margin-left:10px"><%=gvalue %>원</div>		
	</td>
</tr>
</table>

<!---내 댓글 콘텐츠---- -->
<table border="1" style="width:800px; margin:auto;">
	<tr>
		<td>			
			<div id="scrollDiv" style="overflow:auto; height:600px;">
				<!---내 댓글 콘텐츠---- -->

				<%
				while(dbms.GetNext() == true)
				{
					String rnum 	= dbms.GetValue("rnum");		//댓글넘버
					String rnote 	= dbms.GetValue("rnote");		//댓글내용
					String rdate 	= dbms.GetValue("rdate");		//댓글작성시간
					String mnum		= dbms.GetValue("mnum");		//작성자
					String date		= dbms.GetDate(rdate);
					String clock	= dbms.GetTime(rdate); 
					
					if(my_num.equals(mnum))
					{
						
					
					%>
					<table class="my_reply" border="1">
						<tr>
							<td colspan="2">
								<div class="q">
									<span style="text-align:center;">&nbsp; <%=my_nick %> &nbsp;</span>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								&nbsp; <%=rnote %>
							</td>
						</tr>
						<tr>
							<td class="d" style="text-align:right; font-size:8px;"> 
								<span style="text-align:center; border-right: 1px solid black;">&nbsp; <%=date %> &nbsp;</span>
								<span style="text-align:center; ">&nbsp; <%=clock %> &nbsp;</span>
							</td>
						</tr>
					</table>
					<!---내 댓글 콘텐츠---- -->		
					<%
					}
					else
					{
					%>	
					<!---상대 댓글 콘텐츠---- -->			
					<table class="your_reply" border="1">
						<tr>
							<td colspan="2">
								<div class="q">
									<span style="text-align:center;">&nbsp;	<%=you_nick %> &nbsp;</span>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								&nbsp; <%=rnote %>
							</td>
						</tr>
						<tr>
							<td class="d" style="text-align:right; font-size:8px;"> 
								<span style="text-align:center; border-right: 1px solid black;">&nbsp; <%=date %> &nbsp;</span>
								<span style="text-align:center; ">&nbsp; <%=clock %> &nbsp;</span>
							</td>
						</tr>
					</table>
					<!---상대 댓글 콘텐츠---- -->
					<%
					}
				}
				%>	
			</div>							
		</td>
	</tr>
</table>


<form name="reply_in" method="post" action="reply_ok.jsp">
	<table border="1" style="width:800px; height:150px; margin:auto;">
		<tr>
			<td>
				<input type="hidden" name="tnum" value="<%=tnum%>">
				<textarea name="rnote" style="width:99%; height:150px;"></textarea>
			</td>
			<td style="text-align:center">
				<input type="submit" value="작성" style="width:95%; height:50%;">
			</td>
		</tr>
	</table>	
</form>

	
<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>