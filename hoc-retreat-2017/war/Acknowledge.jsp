<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %> 
<%@ page import="javax.jdo.PersistenceManager" %> 
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.List" %> 

<%@ page import="guestbook.Participant" %> 
<%@ page import="guestbook.ParticipantNotes"%>
<%@ page import="guestbook.UserPrivilege" %> 
<%@ page import="guestbook.PMF" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" /> 
<meta http-equiv="Pragma" content="no-cache" /> 
<title>HOC Retreat 2017 - 完成</title>
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
.notes {
	color:red;
	/×font-weight:bold;×/
	line-height: 24px;
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
    <h1>2017 基督之家聯合退修會報名表</h1><br />
    <h3>The Home of Christ Church Joint Retreat Conference</h3>
  <!-- end #header --></div>
  <div id="mainContent">
<p>&nbsp;</p>

<!-- A&M -->
<%
	UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
	boolean isAdmin = false;
	if ((upv != null) && upv.isAdmin())
		isAdmin = true;
	boolean isAdminModify = false;
	if ((upv != null) && upv.isAdmin() && upv.isModify())
		isAdminModify = true;
%>

<!-- contact info -->
<%
	String contact_info = (String) request.getSession().getAttribute("contactInfo");
%>

<% if (isAdminModify) { %>
<p align="center"><font size="6" style="color:red">系統管理員—修改資料已儲存</font><br/>
  <font color="red" size="5">Admin - Modifications have been saved</font></p>

<% } %>

<div style="background-color:#ffffff">
<fieldset>
<legend><span style="font-weight:bold">&nbsp;以下資料已收到！ The following information has been received.</span></legend>
<div style="padding-left:1%; padding-right:1%; color:#000080">

  <%
    //UserService userService = UserServiceFactory.getUserService();
    //User user = userService.getCurrentUser();
    //if (user != null) {
		//out.print(user.getNickname());
		//out.print(", "); 
    //}
%>

<!-- A&M -->
<% if (isAdminModify) { %>
<p style="font-size: 20px;">確認號碼 Confirmation Number：
<span style="color:blue; font-weight:bold;"><%= request.getSession().getAttribute("confirmationNumber") %>
</span> 的修改已完成<br />
The modifications have been completed.</p>
<p>確認的電子郵件已送至 Confirmation email has been sent to:<span style="color:blue; font-weight:bold"><u> <%=  request.getSession().getAttribute("mainEmail") %>
</u></span></p>
<p>請儲存或列印本頁作為參考。 Please save or print this page for future reference.</p>
<% } else { %>
<p>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>謝謝您使用網路登記！Thank you for using online registration.</td>
  </tr>
  <tr>
    <td>您的確認號碼是 Confirmation Number: <strong><span style="color: blue;"><%= request.getSession().getAttribute("confirmationNumber") %></span></strong></td>
  </tr>
  <tr>
    <td>確認的電子郵件已送至 Confirmation email has been sent to: <span style="color:blue; font-weight:bold"><u><%= request.getSession().getAttribute("mainEmail") %> </u></span></td>
  </tr>
  <tr>
    <td>請儲存或列印本頁作為參考。Please save or print this page for future reference.</td>
  </tr>
</table>
</p>

<p class="notes">請注意 Notes:<br />
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td valign="top" class="notes">1.</td>
    <td><span class="notes">您的報名程序必須等到繳費後才算完成。(可於主日崇拜後繳費)<br />
      The registration will not be completed until the registration fee paid (after Sunday services)</span></td>
  </tr>
  <tr>
    <td valign="top"><span class="notes">2.</span></td>
    <td><span class="notes">請列印本頁，並於繳費時一併附上，以方便同工的處理。謝謝！<br />
      Please print  this page and bring it with payment to retreat coworkers. Thank you!</span></td>
  </tr>
  <tr>
    <td valign="top"><span class="notes">3.</span></td>
    <td><span class="notes">預估報名費用僅供參考，實際費用依照各家收費規定可能有所不同，詳情請聯絡各家報名組同工。<br />
      &quot;Estimated Registration Fee&quot; is for reference only.  The actual registration fee may be different for each home church, please contact retreat coworkers at your home church for details.</span></td>
  </tr>
  </table>
</p>

<% } //else(!isAdminModify) %>

<% 
	List<Participant> participants = (List<Participant>)request.getSession().getAttribute("submittedParticipantList");
	if (participants == null) {
		out.println("<!--<span style=\"font-weight:bold; color:red\">WRONG: Read from ParticipantList in session</span>-->");
		participants = (List<Participant>)request.getSession().getAttribute("participantList"); // old implementation
	}
	else {
		out.println("<!--<span style=\"font-weight:bold; color:green\">CORRECT: Read from SubmittedParticipantList in session</span>-->");
	}
	
  	ParticipantNotes participant_notes = null;
	if (participants != null && participants.size() > 0) {
	  	participant_notes = (ParticipantNotes)request.getSession().getAttribute("participantNotes");
	}
	
	//set List to null to prevent resubmmittal
	request.getSession().setAttribute("participantList", null);
	request.getSession().setAttribute("submittedParticipantList", null);
%>
<div style="font-size: small">
<TABLE width="100%" border="1" cellspacing="0">
  <TBODY>
  <TR>
  <TH width="6%" align="center" valign="middle">基督之家</TH>
  <TH width="10%" align="center" valign="middle">中文姓名</TH>
  <TH width="10%" align="center" valign="middle">Last Name</TH>
  <TH width="10%" align="center" valign="middle">First Name</TH>
  <TH width="2%" align="center" valign="middle">性別<br />
    M/F</TH>
  <TH width="14%" align="center" valign="middle">電話<br />
    Tel</TH>
  <TH width="11%" align="center" valign="middle">電子郵件<br />
    E-mail</TH>
  <TH width="10%" align="center" valign="middle">Program Code</TH>
  <TH width="14%" align="center" valign="middle">專題 Workshop</TH>
  <TH width="2%"  align="center" valign="middle">床位<br />Bed?</TH>
  <TH width="2%" align="center" valign="middle">接送<br />
    Ride?</TH>
  <TH width="2%"  align="center" valign="middle">費用<br />
  Fee</TH>
  </TR>
<%
	int total_cost = 0;
	
	if (participants != null ) 
	{
		for ( int i = 0; i < participants.size() ; i++ )
		{
			Participant participant = participants.get(i);
		
			if ( 	participant != null )
			{
				// bpan - hard code program code and special topic
				String prog, stopic;
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
					default:  prog = "" + pcode;
				} /*switch*/
				pcode = participant.getTopic().charAt(0);
				switch(pcode) {
					case '1': stopic = "為耶路撒冷求平安!"; break;
					case '2': stopic = "家庭婚姻专题：在主爱中成长 ，在盼望中合一"; break;
					case '3': stopic = "基督徒职场生活"; break;
					case '4': stopic = "財經講座:天國投資"; break;
					// case '5': stopic = "English Youth Program"; break;
					case '6': stopic = "English Youth Program"; break;
					case '7': stopic = "English Adult Program"; break;
					case '8': stopic = "未定 Undecided"; break;
					case 'X': stopic = "N/A"; break;
					default:  stopic = "" + pcode;
				} /*switch*/
%> 

<TR>
<TD align="center" valign="middle" >
<%= participant.getHoc_family() %>家</TD>
<TD align="center" valign="middle">
<%= participant.getCname() %>
</TD>
<TD align="center" valign="middle" bgcolor="#FFFFFF">
<%= participant.getLastName() %>
</TD>
<TD align="center" valign="middle" bgcolor="#FFFFFF">
<%= participant.getFirstName() %>
</TD>
<TD align="center" valign="middle">
<%= participant.getGender() %>
</TD>
<TD align="center" valign="middle">
<%= participant.getCell() %>
</TD>
<TD align="center" valign="middle">
<%= participant.getEmail() %>
</TD>
<TD align="center" valign="middle">
<%--= participant.getProgram() --%>
<% out.print(prog); /*bpan*/ %>
</TD>
<TD align="center" valign="middle">
<%--= participant.getTopic() --%>
<% out.print(stopic); /*bpan*/ %>
</TD>
<TD align="center" valign="middle">
<%= participant.getBed() %>
</TD>
<TD align="center" valign="middle">
<%= participant.getBus() %>
</TD>
<TD align="center" valign="middle">
<%= participant.cost() %>
</TD>
</TR>

<%
			total_cost += participant.cost();
			
			} //if participant
		} //for i
	} //if participants
%>

<%--@@do we invalidate session here?? --%>
<% 
	/*if (!isAdmin) {
		request.getSession().invalidate();
	}*/
	// clear modify flag
	upv.setModify(false);
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
    <td valign="top"><div style="padding:5px; text-align:left; color:black; width:96%; height: 92px; overflow:auto; border:solid 1px; background-color:white;">
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
    <td width="8%" rowspan="2" align="center" valign="bottom"></td>
    <td width="8%" rowspan="2" align="left" valign="bottom"></td>
  </tr>
  <tr>
    <td></td>
    </tr>
</table>

</div>
</div>
</fieldset>
</div>
<p>&nbsp;</p>
  <%--
	// do not duplicate with above one's
    //UserService userService = UserServiceFactory.getUserService();
    //User user = userService.getCurrentUser();
    //if (user != null) {
		//out.print(user.getNickname());
		//out.print(", ");
	//}
--%>
  <%--= user.getNickname() --%>
 <p>
<%-- obsoleted
		//response.sendRedirect("/login.jsp");
    }
--%>
</p>
<!--
<p><a href="index.html">回首頁 Home</a></p>
<p><a href="index-eng.html">English Home</a></p> -->
<% if (isAdmin) { %>
<p><a href="AddMod.jsp">回系統管理員首頁 Admin Home</a></p>
<% } %>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
  <!-- end #mainContent -->
  </div>
  <div id="footer">
    <p>基督之家製作 Copyright 2016, The Home of Christ Church. All rights reserved.</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>