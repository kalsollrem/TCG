<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file = "Include/head.jsp" %>

	<!-- ----------------------- -->

<%
request.setCharacterEncoding("euc-kr");
int size = 20 * 1024 * 1024;


MultipartRequest multi = 
new MultipartRequest(request, my_profile_Path ,size, "EUC-KR",new DefaultFileRenamePolicy());



String mid 		= multi.getParameter("mid");		//아이디
String mpw 		= multi.getParameter("mpw");		//비밀번호
String mname 	= multi.getParameter("mname");		//이름
String mnick 	= multi.getParameter("mnick");		//닉네임
String maddr_a 	= multi.getParameter("maddr_a");	//주소(시+동)
String maddr_b 	= multi.getParameter("maddr_b");	//주소(남은주소)
String msex 	= multi.getParameter("msex");		//성별
String mphone 	= multi.getParameter("mphone");		//전화번호
String mmail 	= multi.getParameter("mmail");		//메일주소
String mmyself 	= multi.getParameter("mmyself");	//자기소개
String mpic		= multi.getParameter("mpic");

System.out.println("아이디 :"			 + mid);
System.out.println("비밀번호 :"		 + mpw);
System.out.println("이름 :" 			 + mname);
System.out.println("닉네임 :" 			 + mnick);
System.out.println("주소(시+동) :" 	 + maddr_a);
System.out.println("주소(남은주소) :" 	 + maddr_b);
System.out.println("성별 :" 	 		 + msex);
System.out.println("전화번호 :"		 + mphone);
System.out.println("메일주소 :"		 + mmail);
System.out.println("자기소개 :"		 + mmyself);



	
	
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
	System.out.print("파일명 : " + filename + "<br>");

	
//이름을 바꾸고 파일업로드.	
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
		
		String phyname 		= UUID.randomUUID().toString() + "." + fe;				//UUID = 범용고유식별자, 
		String srcName 		= my_profile_Path + "/" + filename;						//경로상의 대상을
		String targetName	= my_profile_Path + "/" + phyname;						//UUID로 얻은 이름으로 바꾼다.

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