<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="java.util.List" %>  
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.guestbook.model.*" %>

<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HOC Retreat 2019 - Registration Page</title>
<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!-- /* specific for this page */
.oneColLiqCtrHdr #container {
	/* width: 96%;  this will create a container 80% of the browser width */
}
.oneColLiqCtrHdr #underMainHeader {
	/*text-align: right;
	font-size: x-small;*/
	margin: 0;
	padding: 0;
}
div.infoTitle {
	border-top-width: 3px;
	border-top-style: solid;
	border-top-color: #999;
	margin-left: 5pz;
}
div.ClassItem {
	margin: 0 10px 0 30px;
	text-align: left;
}
div.NotesField {
	margin:0px; 
	padding:5px; 
	text-align:center; 
	color:white; 
	font-weight:bold;
}

-->
</style>
<script type="text/javascript">
function stopRKey(evt) {
  var evt = (evt) ? evt : ((event) ? event : null);
  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;}
}
document.onkeypress = stopRKey;
</script>

<script type="text/javascript">
function programChange(selectObj,SerialN) 
{ 
 // get the index of the selected option 
 var idx = selectObj.selectedIndex;
 // get the value of the selected option 
 var which = selectObj.options[idx].value; 
  
 // clean out the topic object
 var cSelect = document.getElementById("Topic_"+SerialN); 
  // remove the current options from the country select 
 var len=cSelect.options.length; 
 while (cSelect.options.length > 0) { 
   cSelect.remove(0); 
 }
 
 //clean out the bed object
 var dSelect = document.getElementById("Bed_"+SerialN); 
  // remove the current options from the country select 
 var len=dSelect.options.length; 
 while (dSelect.options.length > 0) { 
   dSelect.remove(0); 
 }
 
 if (which == "N" || which =="S" || which =="F" || which =="T" || which =="B" || which =="R")
 {
  	 var newOption; 
  	// create new options 
  	
  	// Adjust the topic select options
  	newOption = document.createElement("option"); 
  	newOption.value = "X";  // assumes option string and value are the same 
  	newOption.text= "N/A";
  	// add the new option 
  	try { 
    	  cSelect.add(newOption);  // this will fail in DOM browsers but is needed for IE 
  	} 
  	catch (e) { 
    	cSelect.appendChild(newOption); 
    }
  	
  	var newOption1;
  	var newOption2;
  	
	// Adjust the Bed select options
  	newOption1 = document.createElement("option"); 
  	newOption1.value = "Y";  // assumes option string and value are the same 
  	newOption1.text= "Y";
  	
	// Adjust the Bed select options
  	newOption2 = document.createElement("option"); 
  	newOption2.value = "N";  // assumes option string and value are the same 
  	newOption2.text= "N";
  	
  	// add the new Bed option 
  	try 
  	{ 
  		
      if (which !="B" && which !="T")
        dSelect.add(newOption1);  // this will fail in DOM browsers but is needed for IE
       dSelect.add(newOption2);  // this will fail in DOM browsers but is needed for IE
  	} 
  	catch (e) 
  	{
  	  if (which !="B" && which !="T")
        dSelect.appendChild(newOption1); 
      dSelect.appendChild(newOption2);
    }

  }
  else
  {
	// array of possible countries in the same order as they appear in the country selection list 
	  var vList = ["盛李愛珍師母 - 國際關懷協會事工","李林靜芝師母 - 家庭與宣教","盛行楚宣教士 - 柬埔寨的挑戰","但以理/百合宣教士 - 西亞的呼聲","English Youth Program","English Adult Program","未定 Undecided", "N/A"];
	    
      // Adjust the topic select options	
	  for (var i=0; i<vList.length+1; i++) { 
		  newOption = document.createElement("option");
		  if (i>0)
		  {
		    newOption.value = i;  // assumes option string and value are the same 
		    newOption.text=vList[i-1];
		  }
		  // add the new option 
		  try { 
		  cSelect.add(newOption);  // this will fail in DOM browsers but is needed for IE 
		  } 
		  catch (e) { 
		  cSelect.appendChild(newOption); 
		  }
	  } 

      
      // Adjust the topic select options
	  newOption = document.createElement("option"); 
	  newOption.value = "Y";  // assumes option string and value are the same 
	  newOption.text= "Y";
	  	try {
	  	// add the new option 
    	  dSelect.add(newOption);  // this will fail in DOM browsers but is needed for IE
	  	} 
	  	catch (e) { 
	      dSelect.appendChild(newOption); 
	    }
  }
 }
 </script>


</head>

<body class="oneColLiqCtrHdr">
<%
	if (request.getSession().getAttribute("userId") == null) {
		response.sendRedirect(response.encodeRedirectURL("login2.jsp"));
		return;
	}
%>
<%
	UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
%>
<div id="container">
<div id="header">
<h1><strong>2019 基督之家聯合退修會報名</strong></h1>
<br />
<h3>The Home of Christ Church Joint Retreat Conference Online Registration</h3>
<!-- end #header --></div>
<div id="mainContent">

<div id="underMainHeader">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td align="left" valign="bottom" style="font-size:16px; padding-left:8px;">Welcome! <span style="color: red;"> 
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null) {
		out.println(user.getNickname());
	}
	String username = (String)request.getSession().getAttribute("userId");
	out.println(username);
%>
  </b>
  </span>
  </td>
  </tr>
  <tr>
    <td style="font-size:18px; font-weight:bold; padding-left:8px;">報名截止日期 Registration Deadline: 6/30/2019<br />
    	<span style="font-size:small; font-weight:normal;">額滿即止，請從速報名。 Space is limited, please register soon.</span></td>

    <td align="right" valign="bottom" style="font-size:x-small; padding-right:8px;"><!-- <a href="index.html">回首頁 Home</a>&nbsp;&nbsp;&nbsp;<a href="index-eng.html">English Home</a>&nbsp;&nbsp;&nbsp; --> 
<% if(upv.isAdmin()) { %>
<a href="AddMod.jsp">回系統管理員首頁 Admin Home</a>
<% } %></td>
  </tr>
</table>

  
</div>

<table width="100%" border="0" cellspacing="5" cellpadding="3">
  <tr>
    <td width="33%" align="left" valign="middle"><div id="reg-general-title"> 2019 Summer Retreat</div></td>
    <td width="34%" align="left" valign="middle"><div id="reg-chinese-title">中文課程</div></td>
    <td align="left" valign="middle"><div id="reg-english-title">English Program</div></td>
  </tr>
  <tr>
    <td valign="top"><div id="reg-general-body" class="infoBody">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="83" valign="top"><img src="images/SSU.gif" alt="" width="80" height="66" /><br /></td>
            <td valign="top"><span style="font-size:medium; font-weight:bold; color:blue;">Sonoma State University (SSU)</span><br />
              <span style="font-size:10px;">(picture from www.sonoma.edu)</span></td>
          </tr>
        </table>
            <div class="speakerName">&nbsp;<br /><span style="font-size:9px;">&nbsp;</span></div>
            <table width="100%" border="1" cellspacing="0" cellpadding="0">
              <tr>
                <td bgcolor="#CCCCCC"><div class="infoTitle">時間 Time:</div></td>
              </tr>
              <tr>
                <td>8/2 Friday 12:30AM - 
8/4 Sunday 1PM</td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><div class="infoTitle">地點 Place:</div></td>
              </tr>
              <tr>
                <td>Sonoma State University<br />
1801 E. Cotati Ave., 
Rohnert Park, CA 94928<br />
Tel: 707-664-2527 <br />
www.sonoma.edu/cec </td>
              </tr>
            </table>
            <br />
    </div></td>
    <td valign="top">
    <div id="reg-chinese-body" class="infoBody">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="83" rowspan="3" valign="top"><img src="images/pastorLee.png" alt="" width="80"/></td>
        <td valign="top">中文主題
        	</td>
        <td width="83" rowspan="3" valign="top" halign="right"><img src="images/PastorQiu.png" alt="" width="80"/></td>
      </tr>
      <tr>
        <td valign="top"><span style="font-size:large; font-weight:bold; color:blue;">更新與突破－普世宣教的省思</span></td>
      </tr>
      <tr>
      <td valign="top">主題講員：李秀全牧師 邱志健牧師</td>
      </tr>
      </table>
      <div class="speakerName">&nbsp;<br /><span style="font-size:9px;">&nbsp;</span></div>
      <table width="100%" border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td colspan="2" bgcolor="#CCCCCC"><div class="infoTitle">專題講員與題目</div></td>
          </tr>
       	<tr>
         	<td>1.</td>
         	<td><span class="ClassItem">盛李愛珍師母 - 國際關懷協會事工</span></td>
        </tr>
      	<tr>
           	<td>2.</td>
        	<td><span class="ClassItem">李林靜芝師母 - 家庭與宣教</span></td>
        </tr>  
        <tr>
          	<td>3.</td>
          	<td><span class="ClassItem">盛行楚宣教士 - 柬埔寨的挑戰</span></td>
        </tr>
        <tr>
          	<td>4.</td>
          	<td><span class="ClassItem">但以理/百合宣教士 - 西亞的呼聲</span></td>
        </tr>
      </table>
<br />
      
    </div></td>
    <td valign="top"><div id="reg-english-body" class="infoBody">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="83" rowspan="3" valign="top"><img src="images/PastorKim.png" alt="" width="80" /></td>
        <td valign="top">Theme: 
        	</td>
      </tr>
      <tr>
        <td valign="top"><span style="font-size:large; font-weight:bold; color:blue;">More to this Life</span></td>
      </tr>
      <tr>
      <td valign="top">Speaker: Pastor John Kim</td>
      </tr>
      </table>
    
			<!--
        <div class="speakerName">&nbsp;<br /><span style="font-size:9px;">&nbsp;</span></div>
      <table width="100%" border="1" cellspacing="0" cellpadding="1">
        <tr>
          <td colspan="2" bgcolor="#CCCCCC"><div class="infoTitle">Seminars:</div></td>
        </tr>
        <tr>
          <td valign="top">Workshop:</td>
          <td><span class="ClassItem">Being a Witness - Pastor Chip Kirk</span></td>
        </tr>
      </table>
			-->
<br />
    </div></td>
  </tr>
</table>

<div id="reg-fill-out-note">
  <div id="reg-fill-out-title">填寫報名表之注意事項 Notes to  fill out the registration form below</div>

  <TABLE  width=100% border="0" cellpadding="1" cellspacing="0">
    <tr>
      <td colspan="2"></td>
      </tr>
    <tr>
      <td align="left" valign="top">1. </td>
      <td>請按夫, 妻, 子女, 朋友等順序填寫，填寫在同一張報名表的人將盡量被安排在同一楝宿舍。<br />
        Everyone in this form will be likely assigned in the same apartment unit。</td>
      </tr>
    <tr>
      <td align="left" valign="top">2. </td>
      <td>除中文姓名及電子郵件外，其他欄位都必須填寫。請至少提供一個電話號碼。<br />
        All fields are required except Chinese Name and E-mail. At least one phone number is required.</td></tr>
    <tr>
      <td align="left" valign="top">3. </td>
      <td>若提供多於一個電子郵件位址，網路報名的確認郵件只會送到表格中第一個電子郵件位址。 <br />
        If more than one email address provided, the registration confirmation email will be only sent to the first email address.</td></tr>
    <tr>
      <td align="left" valign="top">4. </td>
      <td>請將瀏覽器視窗寬度加大以看見報名表的所有欄位。否則，若看到報名表<span style="color: red;">下方</span>有捲軸出現，請往右捲動並填寫所有欄位。 <br />
        Please widen browser window to see all fields in the registration form. Otherwise, scroll to the right to fill out all fields if a scroll bar shown right <span style="color: red;">under</span> the registration form.</td></tr>
  </TABLE>
</div>

<%-- <p style="color: blue">目前登入使用者：<%
	//UserService userService = UserServiceFactory.getUserService();
	//User user = userService.getCurrentUser();
	//if (user != null) {
		//out.println(user.getNickname());
%>
--%>




<p><font size="4" face="Verdana" color="red"> 
<%
 	List errors = (List) request.getSession().getAttribute("errorList");

	if (errors != null) {
		for (int i = 0; i < errors.size(); i++) {
			String errorMsg = (String) errors.get(i);
%>
<%=errorMsg%>
<%
		} //for i
	}//if errors
%> </font></p>

<div id="RegFormBlock">
<font size="1">&nbsp;<br />
</font>
<span style="font-weight:bold; font-size:24px;">2019 退修會網路報名表 Online Retreat Registration Form</span>
<FORM action="/RetreatRegistration" method="post">
<%
	String hoc_family = "";
		String noSelectionHoc = "";
		String is1 = "";
		String is2 = "";
		String is3 = "";
		String is4 = "";
		String is5 = "";
		String is6 = "";
		String is7 = "";
		
		hoc_family = (String) request.getSession().getAttribute("hoc");
   
		
		// Thomas Chang: Add default value for hoc family based on the login.
		if (hoc_family == null)
		{
			hoc_family = username.substring(3,4);
			
		}
		
%>
<%
		if ((hoc_family != null) && (hoc_family.length() != 0)) {
			int num = Integer.parseInt(hoc_family.trim());
			switch (num) {
			case 1:
				is1 = "selected=\"selected\"";
				break;
			case 2:
				is2 = "selected=\"selected\"";
				break;
			case 3:
				is3 = "selected=\"selected\"";
				break;
			case 4:
				is4 = "selected=\"selected\"";
				break;
			case 5:
				is5 = "selected=\"selected\"";
				break;
			case 6:
				is6 = "selected=\"selected\"";
				break;
			case 7:
				is7 = "selected=\"selected\"";
				break;

			default:
				noSelectionHoc = "selected=\"selected\"";
				break;
			}
		}
%>
<p style="font-size: 24px; font-weight: bold">基督之家 HOC:
  <SELECT Name="HOC_Family" size="1">
	<OPTION value="" <%=noSelectionHoc%>>Select</OPTION>
	<OPTION value="1" <%=is1%>>1</OPTION>
	<OPTION value="2" <%=is2%>>2</OPTION>
	<OPTION value="3" <%=is3%>>3</OPTION>
	<OPTION value="4" <%=is4%>>4</OPTION>
	<OPTION value="5" <%=is5%>>5</OPTION>
	<OPTION value="6" <%=is6%>>6</OPTION>
	<OPTION value="7" <%=is7%>>7</OPTION>
</SELECT> 
家</P>


<% if(upv.isAdmin()) { %>
<p>
<Font color=orange style="font-size: 24px; font-weight: bold">Admin Only: </Font> <Font color=black style="font-size: 24px;">已付費 ?  
 <SELECT Name="isPaid" size="1">
	<OPTION value="0" selected="selected">No</OPTION>
	<OPTION value="1" >Yes</OPTION>
</SELECT>
</Font> 
</p>
<%} %>
<%
	List<Participant> participants = (List<Participant>) request.getSession().getAttribute("participantList");

	Participant participant = null;
	ParticipantNotes participant_notes = (ParticipantNotes)request.getSession().getAttribute("participantNotes");
%>

<TABLE border="1" cellspacing="0"  width=100%>
	<TBODY>
		<TR>
			<TH align="center" valign="middle" width="1%"></TH>
			<TH align="center" valign="middle" width="8%">中文姓名</TH>
			<TH align="center" valign="middle" width="8%">Last Name<br/></TH>
			<TH align="center" valign="middle" width="10%">First Name<br/></TH>
			<TH align="center" valign="middle" width="4%">性別<br/>	M/F</TH>
			<TH align="center" valign="middle" width="12%">電話 Tel<br/>
			<font size="1">(至少一個  At least One)<br/>
			Format: (123)456-7890 or 1234567890</font>
			</TH>
			<TH align="center" valign="middle" width="20%">電子郵件<br />E-mail</TH>
			<TH align="center" valign="middle" width="10%">節目代碼<br />
			Program Code</TH>
			<TH align="center" valign="middle" width="15%">專題 Workshop</TH>
			<TH align="center" valign="middle" width="5%">床位<br />
			Bed?<br />
			<font size="1">(4-11yr)</font></TH>
			<TH align="center" valign="middle" width="5%">接送<br />
			Ride</TH>
		</TR>

		<%
			for (int i = 0; i < 8; i++) {
		%>

		<TR>
			<%
				participant = null;
				if (participants != null && participants.size() > i) {
					participant = (Participant) participants.get(i);
				}

				if (participant == null) {
			%>
			<TH align="center" valign="middle" width="1%"><%=i + 1%></TH>
			<TH align="center" valign="middle" width="8%"><INPUT
				type="text" name="C_Name_<%=i%>" value="" size="8%"></TH>
			<TH align="center" valign="middle" width="8%"><INPUT
				type="text" name="last_Name_<%=i%>" value="" size="8%"></TH>
			<TH align="center" valign="middle" width="10%"><INPUT
				type="text" name="first_Name_<%=i%>" value="" size="10%"></TH>
			<TH align="center" valign="middle"><SELECT Name="MF_<%=i%>"
				size="1">
				<OPTION value=""></OPTION>
				<OPTION value="M">M</OPTION>
				<OPTION value="F">F</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle" width="12%"><INPUT
				type="text" name="Cell_<%=i%>" value="" size="12%"></TH>
			<TH align="center" valign="middle" width="20%"><INPUT
				type="text" name="eMail_<%=i%>" value="" size="20%"></TH>
			<TH align="center" valign="middle"><SELECT
				Name="Program_Code_<%=i%>" size="1" onchange="programChange(this, <%=i%>);">
				<OPTION></OPTION>
				<OPTION value="M">中文成人</OPTION>
				<OPTION value="E">English Adult</OPTION>
				<OPTION value="H">Grade 9~12</OPTION>
				<OPTION value="D">Grade 6~8</OPTION>
				<OPTION value="N">9~11 yr</OPTION>
				<OPTION value="S">7~8 yr</OPTION>
				<OPTION value="F">5~6 yr</OPTION>
				<OPTION value="P">4 yr</OPTION>
				<OPTION value="T">3 yr</OPTION>
				<OPTION value="B">0~2 yr</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle"><select name="Topic_<%=i%>"
				size="1" id="Topic_<%=i%>">
			  <option></option>
			  <option value="1">盛李愛珍師母 - 國際關懷協會事工</option>		    
			  <option value="2">李林靜芝師母 - 家庭與宣教</option>
			  <option value="3">盛行楚宣教士 - 柬埔寨的挑戰</option>
			  <option value="4">但以理/百合宣教士 - 西亞的呼聲</option>
			  <option value="5">English Youth Program</option>
			  <option value="6">English Adult Program</option>
			  <option value="7">未定 Undecided</option>
			  <option value="X">N/A</option>
			  </select></TH>
        
          
			<TH align="center" valign="middle"><SELECT Name="Bed_<%=i%>"
				id="Bed_<%=i%>" size="1">
				<OPTION value=""></OPTION>
				<OPTION value="Y">Y</OPTION>
				<OPTION value="N">N</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle"><SELECT Name="Bus_<%=i%>"
				size="1">
				<OPTION value="N" selected="selected">N</OPTION>
				<OPTION value="Y">Y</OPTION>
			</SELECT></TH>
			
			<%
				} else {
			%>
			<TH align="center" valign="middle" width="1%"><%=i + 1%></TH>
			<TH align="center" valign="middle" width="8%"><INPUT
				type="text" name="C_Name_<%=i%>" value="<%=participant.getCname()%>"
				size="8%"></TH>
			<TH align="center" valign="middle" width="8%"><INPUT
				type="text" name="last_Name_<%=i%>" value="<%=participant.getLastName()%>"
				size="8%"></TH>
			<TH align="center" valign="middle" width="10%"><INPUT
				type="text" name="first_Name_<%=i%>" value="<%=participant.getFirstName()%>"
				size="10%"></TH>
			<TH align="center" valign="middle" size="1">
			<%
				String noSelection = "";
							String isM = "";
							String isF = "";
							if (participant.getGender().compareTo("M") == 0) {
								isM = "selected=\"selected\"";
							} else if (participant.getGender().compareTo("F") == 0) {
								isF = "selected=\"selected\"";
							} else {
								noSelection = "selected=\"selected\"";
							}
			%> <SELECT Name="MF_<%=i%>" size="1">
				<OPTION value="" <%=noSelection%>></OPTION>
				<OPTION value="M" <%=isM%>>M</OPTION>
				<OPTION value="F" <%=isF%>>F</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle" width="12%"><INPUT
				type="text" name="Cell_<%=i%>" value="<%=participant.getCell()%>"
				size="12%"></TH>
			<TH align="center" valign="middle" width="20%"><INPUT
				type="text" name="eMail_<%=i%>" value="<%=participant.getEmail()%>"
				size="20%"></TH>
			<TH align="center" valign="middle" size="10%">
			<%
				String noSelectionPC = "";
							String isMPC = "";
							String isEPC = "";
							String isHPC = "";
							String isDPC = "";
							String isNPC = "";
							String isSPC = "";
							String isFPC = "";
							String isTPC = "";
							String isPPC = "";
							String isBPC = "";
							if (participant.getProgram().compareTo("M") == 0) {
								isMPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("E") == 0) {
								isEPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("H") == 0) {
								isHPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("D") == 0) {
								isDPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("N") == 0) {
								isNPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("S") == 0) {
								isSPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("F") == 0) {
								isFPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("T") == 0) {
								isTPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("R") == 0) {
								isPPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("B") == 0) {
								isBPC = "selected=\"selected\"";
							} else {
								noSelectionPC = "selected=\"selected\"";
							}
			%> <SELECT Name="Program_Code_<%=i%>" size="1" onchange="programChange(this, <%=i%>);">
				<OPTION <%=noSelectionPC%>></OPTION>
				<OPTION value="M" <%=isMPC%>>中文成人</OPTION>
				<OPTION value="E" <%=isEPC%>>English Adult</OPTION>
				<OPTION value="H" <%=isHPC%>>Grade 9~12</OPTION>
				<OPTION value="D" <%=isDPC%>>Grade 6-8</OPTION>
				<OPTION value="N" <%=isNPC%>>9~11 yr</OPTION>
				<OPTION value="S" <%=isSPC%>>7~8 yr</OPTION>
				<OPTION value="F" <%=isFPC%>>5~6 yr</OPTION>
				<OPTION value="P" <%=isPPC%>>4 yr</OPTION>
				<OPTION value="T" <%=isTPC%>>3 yr</OPTION>
				<OPTION value="B" <%=isBPC%>>0~2 yr</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle" size="15%">
			
			<SELECT Name="Topic_<%=i%>" size="1" id="Topic_<%=i%>">
			<%
			
			
			    String topicSelect = participant.getTopic();
			
			    if (topicSelect.compareTo("X")==0) // If it's already "N/A", don't leave other options
			    {
%>
				  	<option value="X" selected="selected">N/A</option>
<%
				}		    	
			    else
			    {
			    	String noSelectionT = "";
					String T0 = "";
					String T1 = "";
					String T2 = "";
					String T3 = "";
					String T4 = "";
					String T5 = "";
					String T6 = "";
					String T7 = "";
					String T8 = "";

					if (participant.getTopic().compareTo("0") == 0) {
						 T0 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("1") == 0) {								
					     T1 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("2") == 0) {
						T2 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("3") == 0) {
						T3 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("4") == 0) {
						T4 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("6") == 0) {
						T6 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("7") == 0) {
						T7 = "selected=\"selected\"";
					} else if (participant.getTopic().compareTo("8") == 0) {
						T8 = "selected=\"selected\"";
					} else {
						noSelectionT = "selected=\"selected\"";
					}
	    
%>
		<OPTION <%=noSelectionT%>></OPTION>
		<OPTION value="1" <%=T1%>>盛李愛珍師母 - 國際關懷協會事工/OPTION>
		<OPTION value="2" <%=T2%>>李林靜芝師母 - 家庭與宣教</OPTION>
		<OPTION value="3" <%=T3%>>盛行楚宣教士 - 柬埔寨的挑戰</OPTION>
		<OPTION value="4" <%=T4%>>但以理/百合宣教士 - 西亞的呼聲</OPTION>
		<OPTION value="5" <%=T5%>>English Youth Program</OPTION>
	  	<option value="6" <%=T6%>>English Adult Program</option>
	  	<option value="7" <%=T7%>>未定 Undecided</option>
	  	<OPTION value="X" <%=T8%>>N/A</OPTION>
<%
				}
%>
			  	
			</SELECT></TH>
			<TH align="center" valign="middle">
			<%
				String noSelectionBed = "";
							String bed = "";
							String NoBed = "";
							if (participant.getBed().compareTo("Y") == 0) {
								bed = "selected=\"selected\"";
							} else if (participant.getBed().compareTo("N") == 0) {
								NoBed = "selected=\"selected\"";
							} else {
								noSelectionBed = "selected=\"selected\"";
							}
			%> 
			<SELECT Name="Bed_<%=i%>" size="1" id="Bed_<%=i%>">
			<%
			 if (participant.getProgram().compareTo("B") == 0 || participant.getProgram().compareTo("T") == 0) 
			 {
			%>	 
			 	<OPTION value="N" <%=NoBed%>>N</OPTION>
			<%
			 }
			 else
			 {
			%>
				<OPTION <%=noSelectionBed%>></OPTION>
				<OPTION value="Y" <%=bed%>>Y</OPTION>
				<OPTION value="N" <%=NoBed%>>N</OPTION>
			<%
			}
			%>
			</SELECT></TH>


			<TH align="center" valign="middle">
			<%
				String noSelectionBus = "";
							String bus = "";
							String nobus = "";
							if (participant.getBus().compareTo("Y") == 0) {
								bus = "selected=\"selected\"";
							} else if (participant.getBus().compareTo("N") == 0) {
								nobus = "selected=\"selected\"";
							} else {
								noSelectionBus = "selected=\"selected\"";
							}
			%> <SELECT Name="Bus_<%=i%>" size="1">
				<OPTION value="Y" <%=bus%>>Y</OPTION>
				<OPTION value="N" <%=nobus%>>N</OPTION>
			</SELECT></TH>
		</TR>
		<%
			}
		%>
		<%
			}
		%>


	</TBODY>

</TABLE>
<table width="100%" border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td width="20%" rowspan="2" align="right" bgcolor="#3399CC"><div class="NotesField">如有注意事項<br />請於右欄註明<br />
      Notes (if any)</div></td>
    <td width="70%" rowspan="2" align="left">
    <textarea name="notes" id="notes" cols="70" rows="7"><% if (participant_notes != null) { out.print(participant_notes.getNotes()); } %></textarea>
    </td>
    <td width="170" align="left"></td>
  </tr>
  <tr>
    <td width="10%" align="right" valign="bottom"><div style="padding: 10px 10px 3px 20px;"></div>
      <span style="padding: 10px 10px 3px 20px;">
      <input type="submit" name="Submit" value="Submit" />
      </span></td>
  </tr>
</table>

</FORM>
<%
	//response.sendRedirect("/login.jsp");
//	}
%>
<!-- end of FormBlock --></div>

<br/>
<div id="RegNotesArea">
<div id="RegNotesAreaTitle">其他注意事項 Other Notes：<br />
			</div>
<TABLE border="0" cellpadding="3" cellspacing="0">
		<TR>
			<TD colspan="2" align="left" valign="middle" bgcolor="#CCCCCC"></TD>
		</TR>
		<TR>
		  <TD align="left" valign="top">1.</TD>
          <td><strong>報名費用</strong>：<span lang="ZH-TW" xml:lang="ZH-TW">2019年7月15日以前未滿</span><span lang="ZH-CN" xml:lang="ZH-CN">四</span><span lang="ZH-TW" xml:lang="ZH-TW">歲者</span>免費。四歲至十一歲不佔床位者 $115；佔床位者  $170。12歲以上者 $170。各家自行設定折扣方式。預估實際支出每人$230。 報名截止日期6/30/2019，先到先得，額滿即止。 <span class="font-red"></strong></TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td><span title=""><strong>Registration Fee</strong>: Children below 4 years of age before 7/15/2019, FREE. From 4 years to 11 years but occupying a bed, $170 (not occupying a bed, $115). Twelve years and above, $170. Estimated actual expenditures per person $230. Registration deadline 6/30/2019, on a first-come, first-served basis. </span></TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">2.</TD>
          <td><strong>保險规定</strong>：未满十八歲父母未同行者，請填 Medical &amp; Liability Release Form， 與報名表，報名费一同繳上。</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td> <strong>Insurance Requirements</strong>: Those under 18 years  and unaccompanied by a parent need to fill up a <em>Medical &amp; Liability  Release Form</em> with the application., and turn it in  with the filled registration form and the registration fee together. </TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">3.</TD>
          <td>節目簡介：今年分中文堂、英文堂成人，和英文堂青少年，兒童節目由CEF老師帶領。</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td><span title="">Program tracks: </span>Chinese, English  adult, English youth, &amp; Children (taught by Child Evangelism Fellowship.)</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">4.</TD>
          <td>攜帶物品：聖經，筆，漱洗用具，日用衣物，常用藥品，游泳衣，手電筒，運動器材等。SSU提供寢具，<strong class="font-red">但不佔床位的兒童，請自備睡袋</strong>。</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td><span title="">Items to Bring: Bible, pens,   toiletries ,  casual clothes, personal medicines, bathing suits, flashlights, appropriate  recreational gear. Bedding is provided by SSU. <span class="font-red-bold">For child not 
          occupying a </span></span><span class="font-red-bold" title=""> bed, please bring sleeping bag.</span></TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">5.</TD>
          <td>會址簡介：Sonoma州立大學 (簡稱SSU)
		  位於以釀酒聞名的Sonoma山谷，風景優美，氣候宜人。校區在舊金山以北五十英哩，由南灣啟程約為二小時的車程。</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td><span title="">About the Site: Sonoma State University (SSU) is located in the Sonoma Valley which is well known for its wine,   beautiful scenery and pleasant weather. SSU is </span><span title="">50 miles north of San Francisco. It takes about 2-hour driving distance from  the South Bay</span>.</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">6.</TD>
          <td><strong>住宿規定</strong>：SSU今年提供我們最佳套房式的住宿，每層均有兩間單人房及兩間雙人房 (共可容納六人)，每間均有自用的浴廁設備。SSU會為我們準備床單、毛毯、手巾、浴巾、香皂等。每四個房間為一單元，共用客廳、餐廳、廚房及冰箱微波爐等，在報名時可將此因素考慮在內。<br />
請注意保持住處特別是廚房的清潔，若被徵收清潔費，將由各人自行負責。請遵守SSU及大會規定。</TD>
	  </TR>
		<TR>
		  <TD align="left" valign="top">&nbsp;</TD>
          <td><span title=""><strong>Residential Requirements</strong>: SSU provides quality  apartments. Generally each apartment has 2 rooms with a single bed, and 2 rooms  with two beds. Each room has its own toilet &amp; bath facilities; and linen is  provided. </span><span title="">Each apartment has a lounge, dining room, and kitchen facilities with  refrigerator and microwave. Please keep this in mind when making a group  application for 6 persons.</span><span title=""><br />
          </span><span title="">Note: </span><span title="">Each person is responsible for keeping the apartment  clean and for paying any surcharge or penalties. Please also respect SSU rules  and our own retreat rules. </span></TD>
	  </TR>
</TABLE>
&nbsp;
<!--end of RegNotes --></div>
<p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>

  
  <td align="center"><!-- <a href="index.html">回首頁 Home</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="index-eng.html">English Home</a>
    &nbsp;&nbsp;&nbsp;&nbsp; -->
    <% if(upv.isAdmin()) { %>    
    <a href="AddMod.jsp">回系統管理員首頁 Admin Home</a>
    <% } %>  
    </td></tr>
</table>
</p>
<p align="center">&nbsp;</p>



<!-- end #mainContent --></div>
<div id="footer">
<p>基督之家製作 Copyright 2019, The Home of Christ Church. All rights
reserved.</p>
<!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>


