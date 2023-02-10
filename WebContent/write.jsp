<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>

<%


//kind=J 또는 kind=H를 분석한다.
if(login == null)
{
	%>
	<script>
		alert("글쓰기 권한이 없습니다.");
		document.location = "index.jsp";
	</script>		
	<%
	return;
}


String prefer	= request.getParameter("prefer"); 		//분류
String curpage 	= request.getParameter("page"); 		//페이지

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
			document.getElementById('preview').src = "";
		}
	}

</script>	
<!------------------사이드바 메뉴 --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------이하 콘텐츠--------------- -->

<form name="write" id="write"  method="post" enctype="multipart/form-data" action="writeok.jsp?prefer=<%=prefer %>&page=<%=curpage %>" >
	<table border="0" style="text-align:center; width:1000px; height:100px; margin:auto;">
		<tr>
			<td><br></td>
		</tr>
		<tr>
			<td style="text-align:right;">
				<span>필요 리스트 </span>
				<input type="text" name="write_num" value="1" style="width:3%">장
				<input type="button" value="확인" onclick="location.href='write.jsp'">
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>		
		
<!-- ------------------ 반복시작점 --------------------------------- -->	
				
		<tr>
			<td>
				<table border="0" id="sub_doc" style="width:700px; margin:auto;">
					<tr>
						<td>상품명  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gname" style="width:90%; height:50%"></td>
					</tr>
					<tr>
						<td>가격  </td> 
						<td style="text-align:left; height:35px;"><input type="text" name="gvalue" style="width:30%; height:50% " onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/></td>
					</tr>
					<tr>
						<td>장수  </td> 
						<td style="text-align:left; height:35px;">
							<input type="text" name="gqty" value="1" style="width:5%; height:50%">
						</td>
					</tr>
					<tr>
						<td>첨부파일  </td> 
						<td style="text-align:left; height:35px;">
							<div > <img id = "preview" style="width:200px;"></div>		
							<div>
								<input type="file" name="gpic" onchange="readURL(this);">
							</div>						
						</td>
					</tr>
					<tr>
						<td>직거래여부 </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gdir" form="write" style="width:40%; height:50%;"> 
								<option value="No" selected>불가</option>
								<option value="Yes">가능</option>
							 </select> 	
						</td>
					</tr>
					<tr>
						<td>우편거래 여부 </td>
						<td style="text-align:left; height:35px;"> 
							<select name="gmail" form="write" style="width:40%; height:50%;"> 
								<option value="No" selected>불가</option>
								<option value="Before">선불</option>
								<option value="After">후불</option>
								<option value="Free">택배비 포함</option>
							 </select> 	
						</td>
					</tr>
					<tr style="height:150px;">
						<td style="width:95%; height:150px;">상품 상세</td>
						<td> 
							<textarea > </textarea>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><br></td>
		</tr>					
<!-- ------------------ 반복끝 --------------------------------- -->	
		<tr>
			<td>
				<input type="submit" value="작성 완료">&nbsp;&nbsp;&nbsp; 
				<input type="button" value="취소" onclick="location.href='view.jsp'">
			</td>
		</tr>
	</table>
</form>
<!-- -----------이하 콘텐츠--------------- -->


<%@ include file = "Include/tail.jsp" %>