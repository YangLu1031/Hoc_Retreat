<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %> 
<%@ page import="com.guestbook.model.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" /> 
<meta http-equiv="Pragma" content="no-cache" /> 
<title>HOC Retreat 2018 - 確認</title>
<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
/* specific for this file only */
.oneColLiqCtrHdr #container {
	width: 90%;  /* this will create a container 80% of the browser width */
}
div.cost {
	font-weight:bold;
	/*text-align:right; */
	width:100%;
	margin-right:3px;
}
-->
</style></head>

<body class="oneColLiqCtrHdr">
<%
	if (request.getSession().getAttribute("userId") == null) {
		response.sendRedirect(response.encodeRedirectURL("login2.jsp"));
		return;
	}
%>

<div id="container">
  <div id="header">
    <h1>2018 基督之家聯合退修會報名表</h1><br />
    <h3>The Home of Christ Church Joint Retreat Conference</h3>
  <!-- end #header --></div>
  <div id="mainContent">
<p>&nbsp;</p>

<!-- A&M -->
<%
	String conf_id = null;
	String bgcolor = null;
	String mod_action = null;
	
	UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
	boolean isAdmin = false;
	if ((upv != null) && upv.isAdmin())
		isAdmin = true;
	boolean isAdminModify = false;
	if ((upv != null) && upv.isAdmin() && upv.isModify())
		isAdminModify = true;

	if (isAdminModify) {
		conf_id = (String) request.getSession().getAttribute("confirmationNumber"); // could it be null?
		bgcolor = "#eeffdd";
		mod_action = "/ModifyRegForm.jsp";
	}
	else {
		bgcolor = "#eef"; 
		mod_action = "/RegistrationForm.jsp";
	}
	
	List<Participant> participants = (List<Participant>)request.getSession().getAttribute("participantList");
	ParticipantNotes participant_notes = null;
	boolean isEmptyList = false;
	if (participants == null || participants.size() == 0) {
		isEmptyList = true;
	}
	else {
	  	participant_notes = (ParticipantNotes)request.getSession().getAttribute("participantNotes");
	}
%>

<% if (isAdminModify) { %>
<p align="center"><font size="6" style="color:red">系統管理員—請確認修改資料</font><br/><font color="red" size="5">Admin - Please confirm modifications</font></p>
<% } %>

<div style="background-color:#ffffff">
  <fieldset><legend><span style="font-weight:bold;">&nbsp;請確認資料是否正確？ Please confirm</span></legend>
<div style="padding-left:1%; padding-right:1%">
<%
    //UserService userService = UserServiceFactory.getUserService();
    //User user = userService.getCurrentUser();
    //if (user != null) {
		//out.print(user.getNickname());
		//out.print(", "); 
    //}
%>
  
  <!-- A&M check if confirmation number present -->
  <% 	if (isAdminModify) {   %>
	<p style="color:blue; font-weight: bold; font-size:16px;">確認號碼 Confirmation Number: <%=conf_id%></p>
  <%	
  			// check if empty list (i.e. delete all)
			if (isEmptyList) {
  %>
<p class="font-red-bold"><span style="text-decoration: blink;">!!! 請注意：所有報名者已被刪除 Note: ALL participants are deleted !!!</span></p>
<p class="font-red-bold">  若按&quot;確認鍵&quot;的話，會永久移除這個確認號碼及其報名者資料<br />
  This confirmation number and its record will be removed permanently if &quot;Confirm&quot; key pressed</p>
<p class="font-red-bold">  若要放棄這項更改，請回<a href="AddMod.jsp">系統管理員首頁</a><br />
  To abort  modifications, please go back to <a href="AddMod.jsp">Admin Home</a></p>
  <%				
			} //if empty list
		} //if AdminModify
		else {
  %>
  <p>您好！以下是您輸入的資料。<br />
    Hello! Here is information you entered.</p>
  <% 	} //else !isAdminModify%>

  <% if (!isEmptyList) { %>
  <p>  請確定無誤後，按“<span class="font-red-bold">Confirm</span>”鍵進行登記。若欲修改資料，請按"<span class="font-red-bold">Modify</span>"鍵進行修改。<br />
  Please verify. If correct, press &quot;Confirm&quot;  to register; otherwise, press &quot;Modify&quot;.</p>

  <% 	if (!isAdminModify) {   %>
  <p>請注意：預估報名費用僅供參考，實際費用依照各家收費規定可能有所不同，詳情請聯絡各家報名組同工。。謝謝！<br />
    &quot;Estimated Registration Fee&quot; is for reference only.  The actual registration fee may be different for each home church, please contact retreat coworkers at your home church for details. </p>
  <% } // if not AdminModify %>
  <% } //if not empty list %>
  <% 
  String isPaid = "No";
  
  if(upv.isAdmin()) { 
  	  if (participants != null && participants.size()>0) 
	  {
		Participant participant = participants.get(0);
		if ( 	participant != null )
		{
			if (participant.getPaid())
			{
				isPaid = "Yes";
			}
		}
	  }
 %>
<p>
<Font color=orange style="font-size: 24px; font-weight: bold">Admin Only: </Font> <Font color=black style="font-size: 24px;">已付費 ?
<%=isPaid%>  
 </Font> 
</p>
<%} %>
<div style="background-color: <%=bgcolor%>; font-size:small; color:black; padding-top: 10px; padding-bottom: 3px;">
<TABLE width="100%" border="1" cellspacing="0">
  <TBODY>
  <TR>
  <TH width="6%" align="center" valign="middle">基督之家</TH>
  <TH width="10%" align="center" valign="middle">中文姓名</TH>
  <TH width="10%" align="center" valign="middle">Last Name </TH>
  <TH width="10%" align="center" valign="middle">First Name</TH>
  <TH width="2%" align="center" valign="middle">性別<br />
    M/F</TH>
  <TH width="14%" align="center" valign="middle">電話<br />
    Tel</TH>
  <TH width="11%" align="center" valign="middle">電子郵件<br />
    E-mail</TH>
  <TH width="10%" align="center" valign="middle">Program Code</TH>
  <TH width="14%" align="center" valign="middle">專題 Workshop</TH>
  <TH width="2%"  align="center" valign="middle">床位<br />
    Bed?</TH>
  <TH width="2%" align="center" valign="middle">接送<br />
    Ride?</TH>
  <TH width="2%" align="center" valign="middle">費用<br />
  	Fee</TH>
  </TR>
  <%
	//List<Participant> participants = (List<Participant>)request.getSession().getAttribute("participantList");

	int total_cost = 0;

	if (participants != null ) 
	{
		for ( int i = 0; i < participants.size() ; i++ )
		{
			Participant participant = participants.get(i);
		
			if ( 	participant != null )
			{
				// bpan - hard code program code and special topic
				String prog = "";
				String stopic = "";
				
				char pcode = participant.getProgram().charAt(0); // must be int or char
				switch(pcode) {
					case 'M': prog = "中文成人"; break;
					case 'E': prog = "English Adult"; break;
					case 'Y': prog = "12~18 yr"; break;
					case 'N': prog = "9-11 yr"; break;
					case 'S': prog = "7-8 yr"; break;
					case 'F': prog = "5-6 yr"; break;
					case 'T': prog = "4 yr"; break;
					case 'R': prog = "3 yr"; break;
					case 'B': prog = "0-2 yr"; break;
					
					default:  prog = "Invalid(" + pcode + ")";
				} /*switch*/

				pcode = participant.getTopic().charAt(0);
				switch(pcode) {
					case '1': stopic = "歐小榮博士 - 認識阿兹海默症十大警訊及早期偵測的重要性!"; break;
					case '2': stopic = "郭世孝,簡艷秋 - 執子之手，與子偕老 ～ 從現代實証心理諮商看如何經營幸福婚姻"; break;
					case '3': stopic = "JNX音樂敬拜事工團隊 - 敬拜事工培訓"; break;
					case '6': stopic = "English Youth Program"; break;
					case '7': stopic = "English Adult Program"; break;
					case '8': stopic = "未定 Undecided"; break;
					case 'X': stopic = "N/A"; break;
					default:  stopic = "Invalid" + pcode;
				} /*switch*/
%>
 				    
  <TR>
  <TD align="center" valign="middle" ><%= participant.getHoc_family() %>家</TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getCname() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getLastName() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getFirstName() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getGender() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getCell() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getEmail() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%--= participant.getProgram() --%> 
  <% out.print(prog); /*bpan*/ %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%--= participant.getTopic() --%>
  <% out.print(stopic); /*bpan*/ %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getBed() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.getBus() %>
  </TD>
  <TD align="center" valign="middle" bgcolor="#FFFFFF">
  <%= participant.cost() %>
  </TD>
  </TR>
    
<%
			total_cost += participant.cost();
	
			} //if participant
		} //for i
	} //if participants
%>
  </TBODY>
</TABLE>
<TABLE width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="left">注意事項： Notes:</td>
<td align="right"><div class="cost">預估報名費用 Estimated Registration Fee: <span style="font-weight:bold; color:red;"><%=total_cost%></span></div></td>
</tr>
</TABLE>



<table width="100%" border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td valign="top">
      <div style="padding:5px; text-align:left; color:black; width:96%; height: 92px; overflow:auto; border:solid 1px; background-color:white;">
        <%
		if (participant_notes != null) {
			String pn = participant_notes.getNotes();
			pn = pn.replace("\n", "<br />");	//for browser display
			if (pn == "")
				pn = "(None)";
			out.print(pn);
		}
	  	%>
      </div></td>
    <td width="8%" rowspan="2" align="center" valign="bottom">
      <form id="ack" name="ack" method="post" action="/SubmitRegistration">
        <input type="submit" name="confirmed" id="confirmed" value="Confirm" />
      </form>
</td>
    <td width="8%" rowspan="2" align="left" valign="bottom">
  <% if (!isEmptyList) { %>  
    <form id="mod" name="mod" method="post" action="<%=mod_action%>"><!-- A&M -->
      <input type="submit" name="modify" id="modify" value="Modify" />
    </form>
  <% } //if not empty list %>
    </td>
  </tr>
  <tr>
    <td></td>
    </tr>
</table>

<p>

</p>
<p>
</p>
</div>
</fieldset>
<!--
<p><a href="index.html">回首頁 Home</a></p>
<p><a href="index-eng.html">English Home</a></p> -->
<% if (isAdmin) { %>
<p><a href="AddMod.jsp">回系統管理員首頁 Admin Home</a></p>
<% } %>

</div>
</div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
  <!-- end #mainContent -->
  </div>
  <div id="footer">
    <p>基督之家製作 Copyright 2018 , The Home of Christ Church. All rights reserved.</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>