<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>


<%
request.setCharacterEncoding("euc-kr");
String prefer	= ""; 	//�з�
String curpage 	= ""; 	//������
String gnum		= "";
String my_num   = "";
String your_num	= "";
String my_nick  = "";
String you_nick = "";
String tnum 	= request.getParameter("tnum"); 	//���ȣ
String sql		= "";
String playerA	= "";
String playerB	= "";

System.out.println("tnum:" 	+ tnum);

//��ǰ��ȣ ���
sql = "select * from telroom where tnum = "+tnum;
dbms.OpenQuery(sql);
if(dbms.GetNext() == true)
{
	gnum 	 = dbms.GetValue("gnum");		//ǰ��
	your_num = dbms.GetValue("gmnum");		//�Ǹ����̸�
	my_num 	 = dbms.GetValue("mnum");		//�������̸�
	
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


//��� �Խ� ��ǰ ����
sql = "select gpic,gstate,gname,gvalue from product where gnum=" + gnum;
dbms.OpenQuery(sql);
dbms.GetNext();
String gpic	 	= dbms.GetValue("gpic");	//��ǰ����
String gstate 	= dbms.GetValue("gstate");	//��ǰ�Ǹſ���	
String gname 	= dbms.GetValue("gname");	//ǰ��
String gvalue 	= dbms.GetValue("gvalue");	//����

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

<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->
<table border="1" style="width:200px; height:40px; margin:auto; margin-bottom:30px;">
	<tr>
		<td style="text-align:center;">
			<a href="buy.jsp">������� ���ư���</a>
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
		<div style="font-size:30px; margin-left:10px"><%=gvalue %>��</div>		
	</td>
</tr>
</table>

<!---�� ��� ������---- -->
<table border="1" style="width:800px; margin:auto;">
	<tr>
		<td>			
			<div id="scrollDiv" style="overflow:auto; height:600px;">
				<!---�� ��� ������---- -->

				<%
				while(dbms.GetNext() == true)
				{
					String rnum 	= dbms.GetValue("rnum");		//��۳ѹ�
					String rnote 	= dbms.GetValue("rnote");		//��۳���
					String rdate 	= dbms.GetValue("rdate");		//����ۼ��ð�
					String mnum		= dbms.GetValue("mnum");		//�ۼ���
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
					<!---�� ��� ������---- -->		
					<%
					}
					else
					{
					%>	
					<!---��� ��� ������---- -->			
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
					<!---��� ��� ������---- -->
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
				<input type="submit" value="�ۼ�" style="width:95%; height:50%;">
			</td>
		</tr>
	</table>	
</form>

	
<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>