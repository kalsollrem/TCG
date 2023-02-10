<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%
LoginVO login = (LoginVO)session.getAttribute("login");


String mnum  = login.getNo();
String sql   = "select mpic from info where mnum =" + mnum ; 
dbms.OpenQuery(sql);
dbms.GetNext();

String mpic = dbms.GetValue("mpic");

dbms.CloseQuery();

String fullname = my_profile_Path + "/" + mpic;

mpic = URLEncoder.encode(mpic, "utf-8");
response.setContentType("application/binary");  
response.setHeader("Content-Transper-Encoding", "binary");
response.setHeader("Content-Disposition","attachment; filename=" + mpic + "");   

File file = new File(fullname);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}

fileIn.close();
ostream.flush();
ostream.close();
%>
<%@ include file="./config/dbclose.jsp" %>
