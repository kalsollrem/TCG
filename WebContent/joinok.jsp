<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>

	<!-- ----------------------- -->

<%
request.setCharacterEncoding("euc-kr");
int size = 20 * 1024 * 1024;


MultipartRequest multi = 
new MultipartRequest(request, my_profile_Path ,size, "EUC-KR",new DefaultFileRenamePolicy());



String mid 		= multi.getParameter("mid");		//���̵�
String mpw 		= multi.getParameter("mpw");		//��й�ȣ
String mname 	= multi.getParameter("mname");		//�̸�
String mnick 	= multi.getParameter("mnick");		//�г���
String maddr_a 	= multi.getParameter("maddr_a");	//�ּ�(��+��)
String maddr_b 	= multi.getParameter("maddr_b");	//�ּ�(�����ּ�)
String msex 	= multi.getParameter("msex");		//����
String mphone 	= multi.getParameter("mphone");		//��ȭ��ȣ
String mmail 	= multi.getParameter("mmail");		//�����ּ�
String mmyself 	= multi.getParameter("mmyself");	//�ڱ�Ұ�
String mpic		= multi.getParameter("mpic");

System.out.println("���̵� :"			 + mid);
System.out.println("��й�ȣ :"		 + mpw);
System.out.println("�̸� :" 			 + mname);
System.out.println("�г��� :" 			 + mnick);
System.out.println("�ּ�(��+��) :" 	 + maddr_a);
System.out.println("�ּ�(�����ּ�) :" 	 + maddr_b);
System.out.println("���� :" 	 		 + msex);
System.out.println("��ȭ��ȣ :"		 + mphone);
System.out.println("�����ּ� :"		 + mmail);
System.out.println("�ڱ�Ұ� :"		 + mmyself);



	
	
String sql = "insert into info (mid,mpw,mname,mnick,maddr_a,maddr_b,msex,mphone,mmail,mmyself) ";
sql += "values (";
sql += "'" + mid     + "',";
sql += "md5('" + mpw + "'),";
sql += "'" + mname   + "',";
sql += "'" + mnick   + "',";
sql += "'" + maddr_a  + "',";
sql += "'" + maddr_b  + "',";
sql += "'" + msex 	 + "',";
sql += "'" + mphone  + "',";
sql += "'" + mmail   + "',";
sql += "'" + mmyself + "')";

System.out.println("SQL:" + sql);
dbms.RunSQL(sql);


sql = "select last_insert_id() as mnum";
dbms.OpenQuery(sql);
dbms.GetNext();
String mnum = dbms.GetValue("mnum");
dbms.CloseQuery();


Enumeration files = multi.getFileNames();
if(files != null)
{
	String fileid = (String)files.nextElement();
	String filename = (String)multi.getFilesystemName("mpic");
	System.out.print("���ϸ� : " + filename + "<br>");

	
//�̸��� �ٲٰ� ���Ͼ��ε�.	
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
		
		String phyname 		= UUID.randomUUID().toString() + "." + fe;				//UUID = ��������ĺ���, 
		String srcName 		= my_profile_Path + "/" + filename;						//��λ��� �����
		String targetName	= my_profile_Path + "/" + phyname;						//UUID�� ���� �̸����� �ٲ۴�.

		File srcFile		= new File(srcName);
		File targetFile		= new File(targetName);
		srcFile.renameTo(targetFile);
		
		sql  = "update info set mpic = '" + phyname + "' where mnum =" + mnum;
		System.out.println("SQL:" + sql);
		dbms.RunSQL(sql);
	}
}



%>


		
		
		
	<!-- ----------------------- -->
<script>
	document.location = "index.jsp";
</script>




<%@ include file = "Include/tail.jsp" %>		