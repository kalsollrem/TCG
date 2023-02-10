<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="db_class.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>  

<%


String my_profile_Path 		= "C:\\KJH\\WorkSpace\\TCG\\upload\\my_profile";
String goods_profile_Path	= "C:\\KJH\\WorkSpace\\TCG\\upload\\goods_profile";

DBManager dbms = new DBManager();
dbms.DBOpen();
%>