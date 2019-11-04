<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="java.util.List" %> 
<%@ page import="com.guestbook.model.*" %>

<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate" /> 
<meta http-equiv="Pragma" content="no-cache" /> 
<title>HOC Retreat 2019 - Retrieved Registration Page</title>
<link href="stylesheets/retreat.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!-- /* specific for this page */
.oneColLiqCtrHdr #container {
	width: 96%; /* this will create a container 80% of the browser width */
}
#FormBlock {
	background-color: #eeffdd; 
	padding-top:3px 0 3px 0; 
	overflow:auto; 
	border-style: solid; 
	border-width: thin;
}
div.NotesTitle {
	margin-bottom:5px; 
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
 
 if (which == "N" || which =="S" || which =="F" || which =="T" || which =="B"|| which =="P"  )
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
	else {
		upv.setModify(true);
	}
%>

<div id="container">
<div id="header">
<h1>2019 基督之家聯合退修會報名表</h1>
<br />
<h3>The Home of Christ Church Joint Retreat Conference</h3>
<!-- end #header --></div>
<div id="mainContent">
<p align="center"><font size="6" style="color:red">系統管理員—更改報名</font><br/><font color="red" size="5">Admin - Modify Registration</font></p>

<p style="text-align:center; color:blue;">注意：請先執行所有的<u>刪除</u>動作(若有的話)，再進行其他修改；否則所有其他修改會在<u>刪除任一報名者時</u>丟失！<br />
  Note: please <u>delete</u> entries (if any)  FIRST, or  all other modifications made will be lost when <u>deleting any entry</u></p>
<p style="text-align:center; color:blue;">若要放棄任何更動，請回主頁/系統管理員首頁。 To abort any modifications, please go back to Home/Admin Home</p>

<div id="FormBlock">
<font size="1">&nbsp;<br /></font>
<span style="font-weight:bold; font-size:24px;">2019 退修會報名表 Retreat Registration Form</span>
<% 
//(String) request.getParameter("ConfirmID");
String conf_id = (String)request.getSession().getAttribute("confirmationNumber"); 

//PersistenceManager pm = PMF.get().getPersistenceManager(); 
//***** NOTE: remember to close database connection in the end
//String query = "select from " + Participant.class.getName() + " where del == false && confirmation_number == '" + conf_id +"'"; 
//List<Participant> participants = (List<Participant>) pm.newQuery(query).execute(); 
List<Participant> participants = (List<Participant>)request.getSession().getAttribute("participantList"); 

Participant participant = null;

ParticipantNotes participant_notes = null;
String hoc_family = "";
if (participants != null  && participants.size() > 0) { 
	hoc_family = ((Participant)participants.get(0)).getHoc_family();
	participant_notes = (ParticipantNotes)request.getSession().getAttribute("participantNotes");
}
%> 
    
<% 
// Note: participants could be empty because "delete" feature (come back from RemoveParticipantServlet) 
String status = (String) request.getSession().getAttribute("reg_state");
boolean isRemoved = (status == "ParticipantRemoved")? true : false;		// check if coming back from RemoveParticipantServlet

if (isRemoved ||	// always continue if coming back from RemoveParticipantServlet, keep ParticipantRemoved state intact
		(participants != null  && participants.size() > 0) ) { 

%>

<!-- display error message, if any -->
<font size="4" face="Verdana" color="red"> 
<%
 	List errors = (List) request.getSession().getAttribute("errorList");

 	if (errors != null) {
 		for (int i = 0; i < errors.size(); i++) {
 			String errorMsg = (String) errors.get(i);
%>
<p><%=errorMsg%></p>
<%
		} //for loop
	} //if errors
%> 
</font>
    
<!-- begin to display participant info in the registration table -->
<!--"participants" is the list, we will declare another var "participant" for each element in "participants" -->
<p>
<FORM action="/RetreatRegistration" method="post">
<%
		// hoc_family initialized above
		String noSelectionHoc = "";
		String is1 = "";
		String is2 = "";
		String is3 = "";
		String is4 = "";
		String is5 = "";
		String is6 = "";
		String is7 = "";

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
	<OPTION value="" <%=noSelectionHoc%>>請選擇</OPTION>
	<OPTION value="1" <%=is1%>>1</OPTION>
	<OPTION value="2" <%=is2%>>2</OPTION>
	<OPTION value="3" <%=is3%>>3</OPTION>
	<OPTION value="4" <%=is4%>>4</OPTION>
	<OPTION value="5" <%=is5%>>5</OPTION>
	<OPTION value="6" <%=is6%>>6</OPTION>
	<OPTION value="7" <%=is7%>>7</OPTION>
</SELECT> 
	家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:blue; font-size:16px;">確認號碼 Confirmation No.: <%=conf_id%></span></p>


 <% 
  String isPaid = "No";
  
  if(upv.isAdmin()) { 
  	  if (participants != null && participants.size()>0) 
	  {
		Participant participant2 = participants.get(0);
		if ( 	participant2 != null )
		{
			if (participant2.getPaid())
			{
				isPaid = "Yes";
			}
		}
	  }
 %>
<p>
<Font color=orange style="font-size: 24px; font-weight: bold">Admin Only: </Font> <Font color=black style="font-size: 24px;">已付費 ?

 <SELECT Name="isPaid" size="1">
 <%
   if (isPaid.equals("No"))
   {
%>
	<OPTION value="0" selected="selected">No</OPTION>
	<OPTION value="1" >Yes</OPTION>
<%
   }
   else
   {
%>
    <OPTION value="0" >No</OPTION>
	<OPTION value="1" selected="selected">Yes</OPTION>

<%
   }
%>
</SELECT> 
 </Font> 
</p>
<%} %>


<TABLE border="1" cellspacing="0"  width=100%>
	<TBODY>
		<TR>
			<TH align="center" valign="middle" width="1%"></TH>
			<TH align="center" valign="middle" width="8%">中文姓名</TH>
			<TH align="center" valign="middle" width="8%">Last Name<br/></TH>
			<TH align="center" valign="middle" width="10%">First Name<br/></TH>
			<TH align="center" valign="middle" width="3%">性別<br/>	M/F</TH>
			<TH align="center" valign="middle" width="11%">電話 Tel<br/>
		    <font size="1">(至少一個  At least One)<br/>
			Format: (123)456-7890 or 1234567890</font>
			</TH>
			<TH align="center" valign="middle" width="20%">電子郵件<br />
			  E-mail</TH>
			<TH align="center" valign="middle" width="10%">節目代碼<br />
			Program Code</TH>
			<TH align="center" valign="middle" width="15%">專題 No.</TH>
			<TH align="center" valign="middle" width="4%">床位<br />
			Bed<br />
			<font size="1">(4-11yrs)</font></TH>
			<TH align="center" valign="middle" width="4%">接送<br />
			Ride</TH>
            <TH align="center" valign="middle" width="32">刪除<br/>Del</TH>
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
				<OPTION value="H">Grade 9-12</OPTION>
				<OPTION value="D">Grade 6-8</OPTION>
				<OPTION value="N">9~11 yr</OPTION>
				<OPTION value="S">7~8 yr</OPTION>
				<OPTION value="F">5~6 yr</OPTION>
				<OPTION value="P">4 yr</OPTION>
				<OPTION value="T">3 yr</OPTION>
				<OPTION value="B">0~2 yr</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle"><SELECT Name="Topic_<%=i%>"  id="Topic_<%=i%>" size="1">
			  <option></option>
			  <option value="1">盛李愛珍師母 - 國際關懷協會事工</option>		    
			  <option value="2">李林靜芝師母 - 家庭與宣教</option>
			  <option value="3">盛行楚宣教士 - 柬埔寨的挑戰</option>
			  <option value="4">但以理/百合宣教士 - 西亞的呼聲</option>
			  <option value="5">English Youth Program</option>
			  <option value="6">English Adult Program</option>
			  <option value="7">未定 Undecided</option>
			  <option value="X">N/A</option>
			</SELECT></TH>
			<TH align="center" valign="middle"><SELECT Name="Bed_<%=i%>"  id="Bed_<%=i%>""
				size="1">
				<OPTION value=""></OPTION>
				<OPTION value="Y">Y</OPTION>
				<OPTION value="N">N</OPTION>
			</SELECT></TH>
			<TH align="center" valign="middle"><SELECT Name="Bus_<%=i%>"
				size="1">
				<OPTION value="N" selected="selected">N</OPTION>
				<OPTION value="Y">Y</OPTION>
			</SELECT></TH>
            <TH align="center" valign="middle">&nbsp;</TH>
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
			%>
			<SELECT Name="MF_<%=i%>" size="1">
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
							String isPPC = "";
							String isTPC = "";
							String isBPC = "";
							if (participant.getProgram().compareTo("M") == 0) {
								isMPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("E") == 0) {
								isEPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("H") == 0) {
								isHPC = "selected=\"selected\"";
							} else if (participant.getProgram().compareTo("D") == 0) {
								isDPC = "selected=\"selected\"";
							}else if (participant.getProgram().compareTo("N") == 0) {
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
				<OPTION value="H" <%=isHPC%>>Grade 9-12</OPTION>
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
							} else if (participant.getTopic().compareTo("5") == 0) {
								T5 = "selected=\"selected\"";
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
			
            <%--
				String noSelectionDel = "";
							String dels = "";
							if (participant.isDeleted()) {
								dels = "selected=\"selected\"";
							}
			--%>
            <TH align="center" valign="middle"><a href="RemoveParticipant?DEL=<%=i%>"><img src="images/button-delete.gif" width="32" height="16" border="0" /></a></TH>
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
    <td width="75" rowspan="2" align="center" valign="middle" bgcolor="#448855"><div class="NotesTitle">如有注意事項<br />請於右欄註明<br/>Notes (if any)</div></td>
    <td width="70%" rowspan="2" align="left" valign="bottom">
    <textarea name="notes" id="notes" cols="80" rows="7"><% if (participant_notes != null) { out.print(participant_notes.getNotes()); } %></textarea></td>
    <td width="170" align="left"></td>
  </tr>
  <tr>
    <td width="10%" align="right" valign="bottom"><div style="padding: 10px 10px 3px 20px;">
      <input type="submit" name="Submit2" value="Submit" />
    </div></td>
  </tr>
</table>

</FORM>
</p>
<%
	//response.sendRedirect("/login.jsp");
//	}
%>
<!--end of FormBlock --></div>

<p>
 <% 
	// end of registration table
    //pm.close(); 
%> 
  
</p>
<p>&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"> <!-- <a href="index.html">回首頁 Home</a>
    	&nbsp;&nbsp;&nbsp;&nbsp;<a href="index-eng.html">English Home</a> -->
    	&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddMod.jsp">回系統管理員首頁 Admin Home</a>
    </td>
    </tr>
</table>


<p>&nbsp;</p>
<p>

<%
} // if participants is not empty
else {
    //pm.close();  // always remember to close database connection
%>

</p>
<p class="font-red-bold-large">&nbsp;</p>
	    <p class="font-red-bold-large">確認號碼: <%=conf_id%> 不存在或沒有資料！</p>
	    <p class="font-red-bold-large">請回<a href="AddMod.jsp">系統管理員主頁</a> <!-- 或回<a href="index.html">主頁</a>重新開始。--></p>
	    <p class="font-red-bold-large">&nbsp;</p>
	    <p class="font-red-bold-large">&nbsp;</p>
	    <p class="font-red-bold-large">&nbsp;</p>
	    <p class="font-red-bold-large">&nbsp;</p>
	    <p class="font-red-bold-large">&nbsp;</p>
<p class="font-red-bold-large">&nbsp;</p>

<%
} //else participants empty
%>


<!-- end #mainContent --></div>
<div id="footer">
<p>基督之家製作 Copyright 2019, The Home of Christ Church. All rights
reserved.</p>
<!-- end #footer --></div>
<!-- end #container --></div>
</body>
</html>