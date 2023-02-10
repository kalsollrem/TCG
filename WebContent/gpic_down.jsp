<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ include file="../config/dbopen.jsp"%>

<%


String gnum  = request.getParameter("gnum");
String sql   = "select gpic from product where gnum =" + gnum ; 
dbms.OpenQuery(sql);
dbms.GetNext();

String gpic = dbms.GetValue("gpic");

dbms.CloseQuery();

String fullname = goods_profile_Path + "/" + gpic;

gpic = URLEncoder.encode(gpic, "utf-8");
response.setContentType("application/binary");  
response.setHeader("Content-Transper-Encoding", "binary");
response.setHeader("Content-Disposition","attachment; filename=" + gpic + "");   

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
