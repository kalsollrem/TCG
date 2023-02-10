<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
request.setCharacterEncoding("euc-kr");
int size = 10 * 1024 * 1024;

MultipartRequest multi = 
new MultipartRequest(request, goods_profile_Path ,size, "EUC-KR",new DefaultFileRenamePolicy());

LoginVO login  = (LoginVO)session.getAttribute("login");
String gmnum   = multi.getParameter("gmnum");		//����
String mnum	   = login.getNo();

String prefer  = multi.getParameter("prefer"); 		//�з�
String curpage = multi.getParameter("page"); 		//������

String gname   = multi.getParameter("gname");		//����
String gnum    = multi.getParameter("gnum");		//����
String gvalue  = multi.getParameter("gvalue");		//����
String gqty    = multi.getParameter("gqty");		//���
String gdir    = multi.getParameter("gdir");		//���ŷ� ����
String gmail   = multi.getParameter("gmail");		//����ŷ� ����
String gmyself = multi.getParameter("gmyself");		//����
String n_gpic  = multi.getParameter("n_gpic");		//������


System.out.println("gname :" 		+ gname);
System.out.println("gnum :" 		+ gnum);
System.out.println("gvalue :" 		+ gvalue);
System.out.println("gqty : " 		+ gqty);
System.out.println("gdir :" 		+ gdir);
System.out.println("gmail :" 		+ gmail);
System.out.println("gmyself :" 		+ gmyself);
System.out.println("n_gpic :" 		+ n_gpic);


String sql  = "update product ";
sql += "set gname = '"+ gname +"', gvalue = '"+ gvalue +"', gqty = '"+ gqty +"', gdir = '"+ gdir +"', gmail = '" + gmail + "', gmyself = '" + gmyself + "' ";
sql += "where gnum = " + gnum;

System.out.println("SQL:" + sql);
dbms.RunSQL(sql);


Enumeration files = multi.getFileNames();
if(files != null)
{
String fileid = (String)files.nextElement();
String filename = (String)multi.getFilesystemName("n_gpic");
System.out.print("���ϸ� : " + filename + "<br>");


	if(filename != null)
	{
	
		String fileName = filename;
		String fe = "";
		int i = fileName.lastIndexOf('.');
		
		if (i > 0) 
		{
		    fe = fileName.substring(i+1);
		}
		
		fe = fileName.toLowerCase();
		
		System.out.println("File extension is : " +fe);		
		
		String phyname 		= UUID.randomUUID().toString() + "." + fe;					//UUID = ��������ĺ���, 
		String srcName 		= goods_profile_Path + "/" + filename;						//��λ��� �����
		String targetName	= goods_profile_Path + "/" + phyname;						//UUID�� ���� �̸����� �ٲ۴�.
	
		File srcFile		= new File(srcName);
		File targetFile		= new File(targetName);
		srcFile.renameTo(targetFile);
		
		sql  = "update product set gpic = '" + phyname + "' where gnum =" + gnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
	}
}

%>
<script>
	alert("������ �Ϸ�Ǿ����ϴ�.");
	document.location = "view.jsp?prefer=<%=prefer%>&page=<%=curpage%>&gname=<%=gname%>&gnum=<%=gnum %>";
</script>
