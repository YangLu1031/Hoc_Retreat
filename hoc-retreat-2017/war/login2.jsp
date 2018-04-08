<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="java.util.List"%>
<%@ page import="javax.jdo.PersistenceManager"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="java.util.List"%>

<%@ page import="guestbook.Participant"%>
<%@ page import="guestbook.PMF"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>2017 退修會報名登入</title>
<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!-- /* specific for this page */
.oneColLiqCtrHdr #container {
	/*width: 80%;  this will create a container 80% of the browser width */
}

.oneColLiqCtrHdr #mainContent {
	text-align: center;
	vertical-align: middle;
}
-->
</style>
<script>
var is_safari = /Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor);
var is_ie = ((navigator.appName == 'Microsoft Internet Explorer') || ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null)));
if (window.top !== window.self && (is_ie || is_safari)) {
  window.top.location.replace(window.self.location.href);
}
</script>
</head>

<body class="oneColLiqCtrHdr">
<div id="container">
<div id="header">
<h1>2017 基督之家聯合退修會</h1>
<br />
<h3>The Home of Christ Church Joint Retreat Conference</h3>
<!-- end #header --></div>
<div id="mainContent">
<p>&nbsp;</p>
<p>&nbsp;</p>
<div id="to-register">
<fieldset>
<legend><span
	style="text-align: left; font-size: large">基督之家聯合退修會網路報名 Online Registration</span></legend>
<h1>&nbsp;</h1><h2><span class="font-large">您好！歡迎您使用網路報名，請輸入用戶名和密碼<br />
  (用戶名和密碼印在報名表的注意事項欄)
  網路報名已於六月三十日截止，目前只有系統管理員可登入。<br>The online registration ended on 6/30/2017. Only the hoc admin login is still available
</h2></span></p>
<p><span style="font-size:18px;">Hello! Welcome to register on line, please log in.</span><br />
  (username/password is listed on registration form)</p>
<p>&nbsp;</p>
<font size="2" face="Verdana" color="red"> <%
 	String errorMsg = (String) request.getSession().getAttribute("errorMsg");
	//bpan-clean up session variable errorMsg, otherwise it will be displayed in all subsequent logins
	request.getSession().setAttribute("errorMsg","");
	if(errorMsg!=null && !errorMsg.isEmpty()){ //bpan-minor fix-errorMsg always not null, but could be null string
 %>
<p><%="* " + "用户名或密碼錯誤。" %></p>
<% } %> </font>

<form action="/LoginAuthentication" method="post">
<TABLE align="center" border="0" cellspacing="0"  width=40>
<TR>
<TH align="center" valign="middle" width="40%">User: </TH>
<TH align="center" valign="middle" width="60%"><input type="text" name="user"></TH>
</TR>
<TR>
<TH align="center" valign="middle" width="40%"> Password:  </TH>
<TH align="center" valign="middle" width="60%"><input type="password" name="password"></TH> 
</TR>
<TR>
</TABLE>
<br>
<input type=submit	value="Login"></form>

<p>&nbsp;</p>
<p>&nbsp;</p>
</fieldset>
</div>

<!-- <p><a href="index.html">回首頁 Home</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="index-eng.html">English Home</a></p>
<p>&nbsp;</p>
<p>&nbsp;</p> -->
<!-- end #mainContent --></div>

<div id="footer">
<p>基督之家製作 Copyright 2017, The Home of Christ Church. All rights
reserved.</p>
<!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>