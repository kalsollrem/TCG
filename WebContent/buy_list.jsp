<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file = "Include/head.jsp" %>
<%@ include file = "Include/buy_guide.jsp" %>

<%
request.setCharacterEncoding("euc-kr");

if(login == null)
{	%>
	<script>
		alert("���ٱ����� �����ϴ�.");
		document.location = "first_view.jsp";
	</script>
	<%
	return ;
}

String mnum  	  = login.getNo();
String sql   	  = "";	
String type  	  = "buy";
String add_gnum   = request.getParameter("gnum");
List<String> data = new ArrayList<String>();
List<String> room = new ArrayList<String>();



%>


<!------------------���̵�� �޴� --------------- -->
<%@ include file = "Include/sideM.jsp" %>		
<!-------------------���� ������--------------- -->

<form name = "buy_list" method="post" action="rank_changer.jsp">
<table border="1" style="width:500px; margin:auto;">
	<tr>
		<td colspan="3" style="height:30px; text-align:center; font-size:20px;"  >�� ���</td>
	</tr>
	<%
	sql  = "select * from buylist where mnum = '"+mnum+"' order by blnum desc";
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
		
		String gdate 	= dbms.GetValue("gdate");		//�����
		String gnum 	= dbms.GetValue("gnum");		//��ǰ��ȣ
		String gname 	= dbms.GetValue("gname");		//��ǰ��
		String gdir 	= dbms.GetValue("gdir");		//���ŷ�����
		String gmail 	= dbms.GetValue("gmail");		//���� �ŷ� ����
		String gmyself 	= dbms.GetValue("gmyself");		//��ǰ����
		String gvalue 	= dbms.GetValue("gvalue");		//����
		String gpic 	= dbms.GetValue("gpic");		//������
		String gqty 	= dbms.GetValue("gqty");		//�Ǹż���
		String gmnum 	= dbms.GetValue("mnum");		//�Ǹ��� ��ȣ
		String mnick 	= dbms.GetValue("mnick");		//�Ǹ��� �г���
		String mrank 	= dbms.GetValue("mrank");		//�Ǹ��� ����
		String maddr_a  = dbms.GetValue("maddr_a");		//�Ǹ��� �ּ�(A)	
		String gstate   = dbms.GetValue("gstate");		//��ǰ�� �Ǹſ���(A:���� / E:���� / D:�ι�°�� / O:�ƿ�)	
		
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
		{%>	<table border="1" style="width:100%; height:100%; background-color: #808080;"><%}%>
				<tr>
					<td colspan="2" style="text-align:center; background-color: #808080;"><%=gname %> <span style="color:red;">(�ŷ��Ϸ�)</span></td>
					</tr>
				<tr>
					<td style="text-align:center; height:30px">�ۼ���</td>
					<td><%=mnick %></td>
				</tr>
				<tr>
					<td style="text-align:center; height:30px">�����</td>
					<td><%=gdate %></td>
				</tr>
				<tr>
					<td style="text-align:center;">����</td>
					<td><%=gvalue %>��</td>
				</tr>
				<tr>
					<td style="text-align:center; width:70px">���ŷ� </td>
					<td>
					<%
					switch(gdir)
					{
						case "no"   : out.print("�Ұ�");	 						break;
						default 	: out.print("(" + maddr_a + ")" + "�α� ");	break;
					}
					%>
					</td>
				</tr>
				<tr>
					<td style="text-align:center;">�����ŷ�</td>
					<td>
					<%
					switch(gmail)
					{
						case "no" 		: out.print("�Ұ�");	 					 break;
						case "Before"   : out.print("����");	 					 break;
						case "After"    : out.print("�ĺ�");	 					 break;
						default 		: out.print("�ù�� �߼��� �δ� ");			 break;
					}
					%>
					</td>							
				</tr>
			</table>
		</td>
		<td style="width:15%; text-align:center; background-color: #808080;">
			<div> <input type="button" value="����" onClick="location.href='tel_load.jsp?gnum=<%=gnum %>&gstate=<%=gstate%>&gmnum=<%=gmnum%>'"> </div><br>
			<div> <input type="button" value="����" onClick="location.href='delete_list.jsp?gnum=<%=gnum %>&gmnum=<%=gmnum %>&type=<%=type%>'"> </div>	
			<input type="hidden" name="gnum" value="<%=gnum%>">
			<input type="hidden" name="gmnum" value="<%=gmnum%>">
			<input type="hidden" name="tnum" value="<%=tnum%>">
		</td>
	</tr>		
	<%
	}
	%>	
</table>
</form>

<!-- -----------���� ������--------------- -->


<%@ include file = "Include/tail.jsp" %>