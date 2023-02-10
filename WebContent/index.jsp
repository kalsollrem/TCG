<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>

<%


String sql 	  = ""; 
String prefer = request.getParameter("prefer"); 	
if(prefer == null) {prefer = "new";}

int total  		= 0;  //��ü �Խù� ����
int maxpage		= 0;  //�ִ� ������ ����
int curpage 	= 0;  //���� ������ ��ȣ
int startno 	= 0;  //SQL limit ���� ��ȣ
int startBlock  = 0;  //����¡ ���� �� ��ȣ
int endBlock    = 0;  //����¡ �� �� ��ȣ

//(5) "index.jsp?page=1" ���� �Ѿ�� page�� �м��Ѵ�.
if( request.getParameter("page") != null)
{
	curpage = Integer.parseInt(request.getParameter("page"));
}
else
{
	curpage = 1;
}
				
//��ü ��ù��� ���				
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


<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->

<form name="view_table" method="get" action="#">
<input type="hidden" name="prefer" value="<%=prefer %>">
	<table border="0" style="width:1000px; margin:auto;">
		<tr >
			<td style="text-align:center; height:70px"> 
				<div style="font-size:24px; background-color:#56cbe8; ">�ֽŸŹ�</div>
				<div style="margin-left:850px;">
					<select id="prefer" name="prefer" onchange="selcet_count();">
						<option value="new" 
						<% if(prefer.equals("new")) out.print("selected"); %>>�ֽż�</option>
						<option value="old"
						<% if(prefer.equals("old")) out.print("selected"); %>>�����ȼ�</option>
						<option value="high"
						<% if(prefer.equals("high"))out.print("selected"); %>>����(��������)</option>					
						<option value="low"
						<% if(prefer.equals("low")) out.print("selected"); %>>����(��������)</option>					
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
		 		<div><span>ǰ��� : </span> <span><%=gname %></span></div>
		 		<div><span>���� :</span> <span><%=gvalue %>��</span></div>
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
					%><a href="index.jsp?prefer=<%=prefer %>&page=<%= startBlock - 1 %>">���� ������</a> &nbsp; <% 
				}		
				for(int pageno = startBlock; pageno <= endBlock; pageno++)
				{
					if(curpage == pageno)  //���� �������� ���� ��� ���������� ǥ��
					{	%><a href="index.jsp?prefer=<%=prefer %>&page=<%=pageno %>" style="color:red;"><%= pageno %></a> &nbsp; <%	}
					else
					{	%><a href="index.jsp?prefer=<%=prefer %>&page=<%=pageno %>" style="color:red;"><%= pageno %></a> &nbsp; <%	}
				}	
				if( endBlock < maxpage)
				{
					%><a href="index.jsp?prefer=<%=prefer %>&page=<%= endBlock + 1 %>">���� ������</a><%
				}	
				%>
			</td>
		</tr>	
	</table>	
</form>
<!-- -----------���� ������--------------- -->
<%@ include file = "Include/tail.jsp" %>