<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %> 

<%@ page import="guestbook.Participant" %> 
<%@ page import="guestbook.UserPrivilege" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" /> 
<meta http-equiv="Pragma" content="no-cache" /> 
<title>2017 退修會系統管理員主頁</title>
<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
/* specific for this page */
.oneColLiqCtrHdr #container {
	width: 80%;  /* this will create a container 80% of the browser width */
}
.oneColLiqCtrHdr #mainContent {
	text-align: center;
	vertical-align: middle;
}
#form-add {
	padding-top: 20px;
	padding-right: 5px;
	padding-bottom: 20px;
	padding-left: 5px;
	margin: 5px;
	background-color: #eef;
}
#form-update {
	padding-top: 20px;
	padding-right: 5px;
	padding-bottom: 20px;
	padding-left: 5px;
	margin: 5px;
	background-color: #efe;
}
#form-query {
	padding-top: 20px;
	padding-right: 5px;
	padding-bottom: 20px;
	padding-left: 5px;
	margin: 5px;
	background-color: #ffe;
}
div.chinese {
	padding-top: 20px;
	padding-right: 5px;
	padding-bottom: 10px;
	padding-left: 5px;
	margin: 0px;
	font-size: 14pt;
	font-weight: bold;
}
div.eng {
	padding-top: 0px;
	padding-right: 20px;
	padding-bottom: 10px;
	padding-left: 20px;
	margin: 0px;
	font-size: 10pt;
}
div.button {
	padding-top: 0px;
	padding-right: 20px;
	padding-bottom: 0px;
	padding-left: 20px;
	margin: 0px;
	font-size: 10pt;
}
div.color_add {
	width: 100%;
	height: inherit;
	background-color: #eef;
}
div.color_update {
	background-color: #efe;
}
div.color_query {
	background-color: #ffe;
}
-->
</style></head>

<body class="oneColLiqCtrHdr">
<div id="container">
  <div id="header">
    <h1>2017 基督之家聯合退修會</h1><br />
      <h3>The Home of Christ Church Joint Retreat Conference    </h3>
  <!-- end #header --></div>
  <div id="mainContent">
<p>&nbsp;</p>
<p>
<%
	if ( request.getSession().getAttribute("userId") == null ) {
		response.sendRedirect(response.encodeRedirectURL("login2.jsp"));
		return;
	}
%>
<%
	UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
	if (!upv.isAdmin()) {
		// give a user message!!
%>		
<!--<script type="text/javascript"> 
alert("Administration Priviledge Needed!"); 
</script> -->
<%		
		response.sendRedirect(response.encodeRedirectURL("login2.jsp"));
		return;
	}
%>

<% 
		// clear or initiate session attributes, b/c it may comes back from other pages (admin)
		// list all session attributes here
		//  userPriv
		//	userId
		//	reg_state
		List<Participant> emptyList = null;
		List<String> emptyErrorList = null;
		request.getSession().setAttribute("participantList", emptyList);
		request.getSession().setAttribute("errorList", emptyErrorList);
		request.getSession().setAttribute("errorMsg", null); 
		request.getSession().setAttribute("mainEmail", null);
		request.getSession().setAttribute("hoc", null);
		request.getSession().setAttribute("confirmationNumber", null);
		request.getSession().setAttribute("submittedParticipantList", emptyList);
		request.getSession().setAttribute("participantNotes", null);
		request.getSession().setAttribute("HOC_Family", null);	//for SearchByHome servlet
		request.getSession().setAttribute("contactInfo", null);	//for contact info of each home
		
		request.getSession().setAttribute("reg_state", "AddMod");
		
		// clean modify flag
		upv.setModify(false);
%>

</p>
    
 <p align="center"><font size="6">您好，系統管理員！</font><br/><font size="5">Hello, Administrator!</font></p>
 <p>&nbsp;</p>

 <!--<div id="form-add">
 <p>&nbsp;</p>
 </div>

 <div id="form-update">
 <p>&nbsp;</p>
 </div>
 
 <div id="form-query">
 <p>&nbsp;</p>
 </div> -->
 
 


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="33%" align="center">
    	<div class="chinese">欲增加新報名資料<br />請按下列新增鍵：</div></td>
    <td width="33%" align="center">
    	<div class="chinese">如欲更改報名資料<br />請輸入確認號碼：</div></td>
    <td align="center">
    	<div class="chinese">查詢報名資料請選<br />
    	  基督之家第幾家：</div></td>
  </tr>
  <tr>
    <td align="center" valign="top">
    	<div class="eng">To register new participant(s), please press Add botton:</div></td>
    <td align="center" valign="top">
    	<div class="eng">To modify a registration, please enter confirmation number then press Modify button:</div></td>
    <td align="center" valign="top">
    	<div class="eng">To search the participant list, please specify the HOC number then press Query button:</div></td>
  </tr>
  <tr>
    <td align="center" valign="bottom">
    	<div class="button">
        <form id="add_reg" name="add_reg" method="post" action="/RegistrationForm.jsp">
	    <p>
        <input type="image" name="submit_add" src="images/button-add-reg.gif" border="0" />
      	</p>
    	</form>
        </div>
    </td>
    <td align="center" valign="bottom">
    	<div class="button">
        <form id="update_reg" name="update_reg" method="post" action="/SearchConfirmation">
      	<p>
        <input name="ConfirmID" type="text" id="ConfirmID" size="20" maxlength="18" />
      	</p>
      	<p>&nbsp;</p>
      	<p>
        <input type="image" name="submit_update" src="images/button-update-reg.gif" border="0" />
      	</p>
    	</form>
        </div>
    </td>
    <td align="center" valign="bottom">
    	<div class="button">
    	<form id="query_reg" name="query_reg" method="post" action="/SearchParticipantsByHome">
      	<p>基督之家第
        <select name="HOC_Family" size="1">
          <option value="" >All</option>
          <option value="1" >1</option>
          <option value="2" >2</option>
          <option value="3" >3</option>
          <option value="4" >4</option>
          <option value="5" >5</option>
          <option value="6" >6</option>
          <option value="7" >7</option>
        </select>家
      	</p>
      	<p>顯示格式
        <select name="ResFormat" size="1">
          <option value="1" >表格</option>
          <option value="2" >文字</option>
        </select>
      	</p>
      	<p>&nbsp;</p>
      	<p>
        <input type="image" name="participantSearch" src="images/button-query-reg.gif" border="0" />
      	</p>
    	</form>
        </div>
	</td>
  </tr>
</table>
 
<p>



</div> 
  
  
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<!--
<p><a href="index.html">回首頁 Home</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="index-eng.html">English Home</a></p> -->
  <p>&nbsp;</p>
  <p>&nbsp;</p>
	<!-- end #mainContent --></div>
    
  <div id="footer">
    <p>基督之家製作 Copyright 2017, The Home of Christ Church. All rights reserved.</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>