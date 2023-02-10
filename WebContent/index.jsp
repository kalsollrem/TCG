<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>

<%


String sql 	  = ""; 
String prefer = request.getParameter("prefer"); 	
if(prefer == null) {prefer = "new";}

int total  		= 0;  //전체 게시물 갯수
int maxpage		= 0;  //최대 페이지 갯수
int curpage 	= 0;  //현재 페이지 번호
int startno 	= 0;  //SQL limit 시작 번호
int startBlock  = 0;  //페이징 시작 블럭 번호
int endBlock    = 0;  //페이징 끝 블럭 번호

//(5) "index.jsp?page=1" 에서 넘어온 page를 분석한다.
if( request.getParameter("page") != null)
{
	curpage = Integer.parseInt(request.getParameter("page"));
}
else
{
	curpage = 1;
}
				
//전체 계시물수 계산				
sql  = "select count(*) as count ";
sql += "from product ";
if(!key.equals(""))	
{	
	sql += "where gname like '%" + key + "%' ";	
}
dbms.OpenQuery(sql);
dbms.GetNext();

total = dbms.GetInt("count");
dbms.CloseQuery();


maxpage = total / 15;
if( total % 15 != 0) maxpage++;

startno = (curpage - 1) * 15;


sql  = "select gname,gvalue,gnum,gpic from product where gstate = 'A' ";
if(!key.equals(""))  
{	sql += "and gname like '%" + key + "%' ";}
switch(prefer)
{
case"new":  sql += " order by gnum desc";		break;
case"old":  sql += " order by gnum asc";	 	break;
case"high": sql += " order by gvalue asc";   	break;	
case"low":	sql += " order by gvalue desc";		break;	
}
sql += " limit " + startno + ",15";
dbms.OpenQuery(sql);

startBlock = ( (curpage - 1)  / 15) * 15 + 1;
endBlock   = startBlock + 15 - 1; 

if( endBlock > maxpage)
{	
	endBlock = maxpage;
}

key = URLEncoder.encode(key);

%>
<script>
function selcet_count()
{
	var prefer = $("#prefer").val();
	document.location = "index.jsp?prefer="+prefer+"&key=<%=key%>";
}
</script>


<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->

<form name="view_table" method="get" action="#">
<input type="hidden" name="prefer" value="<%=prefer %>">
	<table border="0" style="width:1000px; margin:auto;">
		<tr >
			<td style="text-align:center; height:70px"> 
				<div style="font-size:24px; background-color:#56cbe8; ">최신매물</div>
				<div style="margin-left:850px;">
					<select id="prefer" name="prefer" onchange="selcet_count();">
						<option value="new" 
						<% if(prefer.equals("new")) out.print("selected"); %>>최신순</option>
						<option value="old"
						<% if(prefer.equals("old")) out.print("selected"); %>>오래된순</option>
						<option value="high"
						<% if(prefer.equals("high"))out.print("selected"); %>>가격(오름차순)</option>					
						<option value="low"
						<% if(prefer.equals("low")) out.print("selected"); %>>가격(내림차순)</option>					
					</select>
				</div>
			</td>
		</tr>
	</table>
	<table border="0" style="width:1001px; margin:auto; text-align:center;">
		<tr>
			<% 
			while(dbms.GetNext() == true)
			{
			
				String gname  = dbms.GetValue("gname");
				String gvalue = dbms.GetValue("gvalue");
				String gnum   = dbms.GetValue("gnum");
				String gpic   = dbms.GetValue("gpic");
				
			%>
			<td class="box" style="background-color:#71bed1;">
		 		<div style="width:190px; height:200px; text-align:center;">
		 			<a href="view.jsp?prefer=<%=prefer %>&page=<%=curpage %>&gname=<%=gname%>&gnum=<%=gnum %>"><img src="gpic_down.jsp?gnum=<%=gnum %>&gpic=<%=gpic %>" style="height:100%; width:80%"></a><br>
		 		</div>
		 		<div><span>품목명 : </span> <span><%=gname %></span></div>
		 		<div><span>가격 :</span> <span><%=gvalue %>원</span></div>
			 </td>
			<%}%>
		</tr>
	</table>

	<table border="0" style="width:1000px; margin:auto; text-align:center;">
		<tr>
			<td height="30px">
				<%
				if( startBlock >= 15 )
				{
					%><a href="index.jsp?prefer=<%=prefer %>&page=<%= startBlock - 1 %>">이전 페이지</a> &nbsp; <% 
				}		
				for(int pageno = startBlock; pageno <= endBlock; pageno++)
				{
					if(curpage == pageno)  //현재 페이지와 같은 경우 빨간색으로 표시
					{	%><a href="index.jsp?prefer=<%=prefer %>&page=<%=pageno %>" style="color:red;"><%= pageno %></a> &nbsp; <%	}
					else
					{	%><a href="index.jsp?prefer=<%=prefer %>&page=<%=pageno %>" style="color:red;"><%= pageno %></a> &nbsp; <%	}
				}	
				if( endBlock < maxpage)
				{
					%><a href="index.jsp?prefer=<%=prefer %>&page=<%= endBlock + 1 %>">다음 페이지</a><%
				}	
				%>
			</td>
		</tr>	
	</table>	
</form>
<!-- -----------이하 콘텐츠--------------- -->
<%@ include file = "Include/tail.jsp" %>