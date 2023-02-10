<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>



<script>
$(document).ready(function(){ 
	$("#spread_menu").click(function(){ 
		if($("#my_memu").is(":visible")){ 
			$("#my_memu").slideUp(); 
		}
		else
		{ 
			$("#my_memu").slideDown(); 
		} 
	}); 
});

$(document).ready(function() {

	var floatPosition = parseInt($("#floatMenu").css('top'));

	$(window).scroll(function() {
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";
		$("#floatMenu").css('top', newPosition);
		$("#floatMenu").stop().animate({
		"top" : newPosition
		}, 500);
	}).scroll();
});
</script>
	
<div id="floatMenu">
	<button id="spread_menu" class="btn01"><img src="image/guide.png" style="width:150px;"></button> 
	<div id="my_memu" class="hold_on" style="display: none;">
		<div id="my_memu_1"> <a href="my_info.jsp?prefer=<%=prefer %>&page=<%=curpage %>">내 정보</a></div><br>
		<div id="my_memu_2"> <a href="my_poket.jsp?prefer=<%=prefer %>&page=<%=curpage %>">찜 목록</a></div><br>
		<div id="my_memu_3"> <a href="write.jsp?prefer=<%=prefer %>&page=<%=curpage %>">판매하기</a></div>
	</div>
</div>