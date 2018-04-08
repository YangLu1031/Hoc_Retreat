<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %> 
<%@ page import="javax.jdo.PersistenceManager" %> 
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.List" %> 

<%@ page import="guestbook.Participant" %> 
<%@ page import="guestbook.ParticipantNotes"%>
<%@ page import="guestbook.UserPrivilege" %> 
<%@ page import="guestbook.PMF" %> 

<html>
  <head>
    <!--<link type="text/css" rel="stylesheet" href="/stylesheets/retreat.css" /> -->
  </head>
  <body>
<script language="JavaScript" type="text/javascript">
<!--
   function edit( confn )
{
  document.editUser.ConfirmID.value = confn;
  document.editUser.submit() ;
}
-->
</script>
<% 
	String hoc = (String)request.getSession().getAttribute("HOC_Family");

	String format = (String)request.getSession().getAttribute("ResFormat");
%>
 
<%	
	String hocWhereString = "";
	
	if ( hoc != null && !hoc.isEmpty() )
	{
		hocWhereString = " && hoc_family == '" + hoc.trim()+"'";
	}
    PersistenceManager pm = PMF.get().getPersistenceManager(); 
    String query = "select from " + Participant.class.getName() + 
    	" where del == false" + hocWhereString + " order by hoc_family asc, paid asc";

    String notes_query = "select from " + ParticipantNotes.class.getName() + 
    	" where del == false"; 
	
    List<Participant> participants = (List<Participant>) pm.newQuery(query).execute(); 
    List<ParticipantNotes> notes = (List<ParticipantNotes>) pm.newQuery(notes_query).execute();
    if (participants == null  || participants.size() <= 0 ) { 
%> 
<p>No one register yet.</p> 
<% 
    } else { 
    	Hashtable<String,String> allNotes = new Hashtable<String,String>();
    	if ( notes.size() > 0 )
    	{
    		for (ParticipantNotes note : notes) {
    			String confNum = note.getConfirmationNumber();
    			String noteInfo = note.getNotes();
    			allNotes.put(confNum,noteInfo);
    		}
    	}
    	
%>

<%    	
    if (format.equals("1"))
    {
%>
        
     	<table border=1><tr><b>
     	<td>
     	Entry #
     	</td><td>
     	Confirmation #
     	</td><td>
     	已付費?
     	</td><td>
     	基督之家
     	</td><td>
     	序號
     	</td><td>
     	中文姓名
     	</td><td>
     	LastName
     	</td><td>
     	FirstName
     	</td><td>
     	Cell
     	</td><td>     	
     	Email
     	</td><td>     	
     	Gender
     	</td><td>     	
     	Program
     	</td><td>     	
     	Topic
     	</td><td>     	
     	Bed
     	</td><td>
     	Bus
     	</td><td>
     	Creation Time
     	</td><td>     	
     	Changed By
     	</td><td>     	
     	Modify Time
     	</td><td>
     	userNotes
     	</td></b>
    </tr>

<%
    }
    else
    {
      %>
 	  <p align="left">
      Confirmation #,
               已付費,
 	   基督之家,
 	  序號,
 	   中文姓名,
 	  LastName, 
 	  FirstName, 
 	  Cell,
 	  Email,
 	  Gender,
 	  Program,
 	  Topic,
 	  Bed,
 	  Bus,
 	  CreationTime,
 	  ChangedBy,
 	  ModifyTime,
 	  userNotes
 	  
<%    	
    }
    int j=0;
    boolean isPaid = false;
    
    for (Participant p : participants) 
    { 
    	
    	String confNum = p.getConfirmationNumber();
        String userNotes = "";
        if ( confNum != null )
        {
         if ( allNotes.get(confNum) != null )
         {
			userNotes = allNotes.get(confNum);
         }
        }
        j++;
        if (format.equals("1"))
        {
        	if ((j % 2) == 0)
        	{
        		out.println("<tr>");
        	}
        	else
        	{
        	    out.println("<tr BGCOLOR=#FFFFCC>");
        	}
%> 
   			<td>
   			<%=j %>
   			&nbsp;</td><td>
   			
   			<form name="editUser" method="post" action="/SearchConfirmation">
   		    <input name="ConfirmID" type="hidden" id="ConfirmID" value="<%=p.getConfirmationNumber()%>" /> 

            <!--  a href="javascript:edit('<%=p.getConfirmationNumber()%>')" -->
            <%=p.getConfirmationNumber()%>
            <input type="submit" value="Edit">
            
            </form>

            &nbsp;</td><td>
<%
            isPaid = p.getPaid(); 
        	if (isPaid)
        	{
          		out.print("Yes");		
        
	        }
    	    else
        	{
          		out.print("No");
	        }
%>          
            &nbsp;</td><td>
            <%=p.getHoc_family() %>
            &nbsp;</td><td>
            <%=p.getSequence_number()%>
            &nbsp;</td><td>
            <%=p.getCname()%>
            &nbsp;</td><td>
            <%=p.getLastName()%>
            &nbsp;</td><td> 
            <%=p.getFirstName()%>
            &nbsp;</td><td> 
            <%=p.getCell()%>
            &nbsp;</td><td>
            <%=p.getEmail()%>
            &nbsp;</td><td>
            <%=p.getGender()%>
            &nbsp;</td><td>
            <%=p.getProgram()%>
            &nbsp;</td><td>
            <%=p.getTopic()%>
            &nbsp;</td><td>
            <%=p.getBed()%>
            &nbsp;</td><td>
            <%=p.getBus()%>
            &nbsp;</td><td>
            <%=p.getTimestmap()%>
            &nbsp;</td><td>
            <%=p.getChangeBy() %>
            &nbsp;</td><td>
            <%=p.getModify_time() %>
            &nbsp;</td><td>
            <%= userNotes %>
            &nbsp;</td></tr>
            
 <% 
        	
        }
        else
        {
%> 
        <p align="left">
        <%=p.getConfirmationNumber()%>,
        <% 
        
        if (isPaid)
        {
          out.print("Yes");	
        
        }
        else
        {
          out.print("No");
        }
      	%>
      	,
        <%=p.getHoc_family() %>,
        <%=p.getSequence_number()%>,
        <%=p.getCname()%>,
        <%=p.getLastName()%>, 
        <%=p.getFirstName()%>, 
        <%=p.getCell()%>,
        <%=p.getEmail()%>,
        <%=p.getGender()%>,
        <%=p.getProgram()%>,
        <%=p.getTopic()%>,
        <%=p.getBed()%>,
        <%=p.getBus()%>,
        <%=p.getTimestmap()%>,
        <%=p.getChangeBy() %>,
        <%=p.getModify_time() %>,
        "<%= userNotes %>"
        </p> 
<% 
        }
    } 
   } 
   if (format.equals("1"))
   {
%>
</table>
<%

   }
   pm.close(); 
%> 
  </body>
  
  <a href="AddMod.jsp">回系統管理員首頁 Admin Home</a>
</html>
