<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
request.setCharacterEncoding("euc-kr");
int size = 10 * 1024 * 1024;

LoginVO login = (LoginVO)session.getAttribute("login");
String mnum = login.getNo();

String prefer	= request.getParameter("prefer"); 	//분류
String curpage 	= request.getParameter("page"); 	//페이지


MultipartRequest multi = 
new MultipartRequest(request, goods_profile_Path ,size, "EUC-KR",new DefaultFileRenamePolicy());


String gname   = multi.getParameter("gname");		//제목
String gvalue  = multi.getParameter("gvalue");		//가격
String gqty    = multi.getParameter("gqty");		//장수
String gdir    = multi.getParameter("gdir");		//직거래 여부
String gmail   = multi.getParameter("gmail");		//우편거래 여부
String gmyself = multi.getParameter("gmyself");		//내용
String gpic	   = multi.getParameter("gpic");		//사진명

System.out.println("gname :" 		+ gname);
System.out.println("gvalue :" 		+ gvalue);
System.out.println("gqty : " 		+ gqty);
System.out.println("gdir :" 		+ gdir);
System.out.println("gmail :" 		+ gmail);
System.out.println("gmyself :" 		+ gmyself);
System.out.println("mnum :" 		+ mnum);
System.out.println("gpic :" 		+ gpic);

	
String sql  = "insert into product (gname,gvalue,gqty,gdir,gmail,gmyself,mnum,gpic) ";
sql += "values(";
sql += "'" + gname.replace("'","''") + "',";
sql += "'" + gvalue.replace("'","''") + "',";
sql += "'" + gqty.replace("'","''") + "',";
sql += "\"'" + gdir + "'\",";
sql += "\"'" + gmail + "'\",";
sql += "'" + gmyself.replace("'","''") + "',";
sql += "'" + mnum + "',";
sql += "'" + gpic + "'";
sql += ")";

System.out.println("SQL:" + sql);
dbms.RunSQL(sql);


sql = "select last_insert_id() as gnum";
dbms.OpenQuery(sql);
dbms.GetNext();
String gnum = dbms.GetValue("gnum");
dbms.CloseQuery();

sql  = "insert into sellist (mnum,gnum) ";
sql += "values('" + mnum + "',";
sql += "'" + gnum + "')";
dbms.RunSQL(sql);


Enumeration files = multi.getFileNames();
if(files != null)
{
	String fileid = (String)files.nextElement();
	String filename = (String)multi.getFilesystemName("gpic");
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
		
		String phyname 		= UUID.randomUUID().toString() + "." + fe;					//UUID = 범용고유식별자, 
		String srcName 		= goods_profile_Path + "/" + filename;						//경로상의 대상을
		String targetName	= goods_profile_Path + "/" + phyname;						//UUID로 얻은 이름으로 바꾼다.

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
	document.location = "index.jsp";
</script>

<%@ include file="./config/dbclose.jsp" %>
