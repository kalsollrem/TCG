<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String gnum 	= request.getParameter("gnum");			
String gname 	= request.getParameter("gname");		
String gmnum 	= request.getParameter("mnum");		
String mnum 	= login.getNo();
String sql		= "";

String prefer	= request.getParameter("prefer"); 		//분류
String curpage 	= request.getParameter("page"); 		//페이지


if( login == null )
{
	%>
	<script>
		alert(" 권한이 없습니다.");
		document.location = "index.jsp";
	</script>
	<%
	return ;
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
		alert("페이지에 대한 정보가 옳바르지않습니다.");
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
String mnick 	= dbms.GetValue("mnick");		//판매자 닉네임
String mrank 	= dbms.GetValue("mrank");		//판매자 평점
String maddr_a  = dbms.GetValue("maddr_a");		//판매자 주소(A)

dbms.CloseQuery();

%>
<script>
	
	window.onload = function()
	{
		document.write.gname.focus();
	}
	
	//입력 폼 검사
	function FormCheck()
	{
		if( document.write.gname.value == "" )
		{
			alert("제목을 입력하세요.");
			document.write.gname.focus();
			return false;
		}
		if( document.write.gvalue.value == "" )
		{
			alert("가격을 입력하세요.");
			document.write.gvalue.focus();
			return false;
		}
		if( document.write.gmyself.value == "" )
		{
			alert("내용을 입력하세요.");
			document.write.gmyself.focus();
			return false;
		}
		if(confirm("작성된 게시물을 저장하시겠습니까?") !=1 )
		{
			return false;	
		}
		return true;
	}

	window.onload = function readURL(input)
	{
		document.getElementById('preview').src = "gpic_down.jsp?gnum=<%=gnum %>&gpic=<%=gpic %>";
	}

	function readURL(input) 
	{
		if (input.files && input.files[0]) 
		{
			var reader = new FileReader();
			
			reader.onload = function(e) 
			{
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} 
		else 
		{
			document.getElementById('preview').src = "gpic_down.jsp?gnum=<%=gnum %>&gpic=<%=gpic %>";
		}
	}

</script>	

<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->

<form name="modify" id="modify"  method="post" enctype="multipart/form-data" action="modifyok.jsp?prefer=<%=prefer %>&page=<%=curpage %>&gname=<%=gname%>&gnum=<%=gnum%>&mnum=<%=gmnum%>" >
	<table border="0" style="text-align:center; width:1000px; height:100px; margin:auto;">
		<tr>
			<td>	
				<input type="hidden" name="gmnum" value="<%=gmnum %>"><br>
				<input type="hidden" name="prefer" value="<%=prefer %>"><br>
				<input type="hidden" name="page" value="<%=curpage %>"><br>
			</td>
		</tr>		
		
<!-- ------------------ 반복시작점 --------------------------------- -->	
				
		<tr>
			<td>
				<table border="1" style="width:700px; height:400px; margin:auto;">
					<tr>
						<td colspan="2">
							<div ><img id = "preview" style="height:500px;"></div>
						</td>
					</tr>
					<tr>
						<td>상품명  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gname" value="<%=gname %>" style="width:90%; height:50%"></td>
					</tr>
					<tr>
						<td>가격  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gvalue" value="<%=gvalue %>" style="width:30%; height:50%"></td>
					</tr>
						
					<tr>
						<td>장수  </td> 
						<td style="text-align:left; height:35px;">
							<input type="text" name="gqty" value="<%=gqty %>" style="width:5%; height:50%">
						</td>
					</tr>
					<tr>
						<td>첨부파일  </td> 
						<td style="text-align:left; height:35px;"><input type="file" name="n_gpic" onchange="readURL(this);"></td>
					</tr>
					<tr>
						<td>직거래여부 </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gdir" form="modify" style="width:40%; height:50%;"> 
							<%
							if(gmail.equals("No"))
							{
							%>							
								<option value="No" selected>불가</option>
								<option value="Yes">가능</option>
							<%
							}
							else
							{
							%>
								<option value="No">불가</option>
								<option value="Yes" selected>가능</option>
							<%
							}
							%>							
							 </select> 	
						</td>
					</tr>
					<tr>
						<td>우편거래 여부 </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gmail" form="modify" style="width:40%; height:50%;"> 
							<%
							if(gmail.equals("no"))
							{
							%>
								<option value="No" selected>불가</option>
								<option value="Before">선불</option>
								<option value="After">후불</option>
								<option value="free">택배비 포함</option>
							<%
							}
							else if(gmail.equals("Before"))
							{
							%>
								<option value="No">불가</option>
								<option value="Before" selected>선불</option>
								<option value="After">후불</option>
								<option value="free">택배비 포함</option>
							<%
							}
							else if(gmail.equals("After"))
							{
							%>
								<option value="No">불가</option>
								<option value="Before">선불</option>
								<option value="After" selected>후불</option>
								<option value="free">택배비 포함</option>
							<%
							}
							else
							{
							%>
								<option value="No">불가</option>
								<option value="Before">선불</option>
								<option value="After">후불</option>
								<option value="free" selected>택배비 포함</option>
							<%
							}
							%>
							
							 </select> 	
						</td>
					</tr>
					<tr>
						<td> 상품 상세</td>
						<td> <textarea name="gmyself" style="width:95%; height:90%"><%=gmyself %></textarea>	</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>					
<!-- ------------------ 반복끝 --------------------------------- -->	
		<tr>
			<td style="height:30px">
				<input type="submit" value="수정 완료">&nbsp;&nbsp;&nbsp;
				<input type="button" value="취소" onclick="location.href='view.jsp'">
			</td>
		</tr>
	</table>
</form>
<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>