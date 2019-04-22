<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.guestbook.model.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" /> 
<meta http-equiv="Pragma" content="no-cache" /> 
<title>HOC Retreat 2018 - 完成</title>
<!--<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" /> -->
</head>

<body>
<!-- A&M -->
<%
	UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
	boolean isAdmin = false;
	if ((upv != null) && upv.isAdmin())
		isAdmin = true;
%>

<p>您的連線已過時，請回首頁重新登入。</p>
<p>Session has expired. Please start a new registration.</p>
<!-- <p><a href="index.html">回首頁 Home</a></p>
<p><a href="index-eng.html">English Home</a></p> -->
<% if (isAdmin) { %>
<p><a href="AddMod.jsp">回系統管理員首頁 Admin Home</a></p>
<% } %>

  </body>
</html>
