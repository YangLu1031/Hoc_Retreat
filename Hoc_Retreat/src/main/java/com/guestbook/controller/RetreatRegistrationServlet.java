package com.guestbook.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.guestbook.model.Participant;
import com.guestbook.model.ParticipantNotes;
import com.guestbook.model.UserPrivilege;
import com.guestbook.utils.Utils;

/**
 * Servlet implementation class RetreatRegistrationServlet
 */
@WebServlet(
	    name = "RetreatRegistration",
	    urlPatterns = {"/RetreatRegistration"}
	)
public class RetreatRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(RetreatRegistrationServlet.class.getName());     
	private static final String default_email = "hocjointevents@gmail.com";
	private static final HashMap<String, String> ContactList = Utils
		.getHashMapFromFile("CoworkerContact.txt", false); //bpan: for contact info used in email

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetreatRegistrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		log.info("Retreat Servlet: Entering");
		System.out.println("Retreat Servlet: Entering");
		request.setCharacterEncoding("UTF-8");
		if (request.getSession() == null 
			|| request.getSession().getAttribute("reg_state") == null) //bpan: avoid from wrong user ops
		{
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
				request, response);
			return;
		}
		
		boolean isFirsttime;
		String isPaid = (String) request.getParameter("isPaid");

		
				
		//bpan added: check if session already completed (i.e. it's a duplicated submission)
		if (request.getSession().getAttribute("reg_state") == "submitted") {
			getServletContext().getRequestDispatcher("/SessionExpired.jsp").forward(request, response);
			return;
		}
		
		//bpan added: check if admin modify => goto different page
		UserPrivilege upv = (UserPrivilege)request.getSession(false).getAttribute("userPriv");
		String conf_id = null;
		boolean isAdminModify = false;
		if (upv != null && upv.isAdmin() && upv.isModify()) {
			conf_id = (String) request.getSession().getAttribute("confirmationNumber");
			isAdminModify = true;
			log.info("Retreat Servlet: Admin Modify");
			//System.out.println("Retreat: Admin Modify");
		}

		//String a = "我们";  
		List<Participant> participants = 
			(List<Participant>) request.getSession().getAttribute("participantList");
		if(participants == null)
		{
			participants = new ArrayList<Participant>();
			log.info("Retreat Servlet: Create a new particiant list");
			isFirsttime = true;
		}
		else
		{
			participants.clear();
			log.info("Retreat Servlet: Clean the particiant list");
			isFirsttime = false;
		}
		
		List<String> errorList = (List<String>)request.getSession().getAttribute("errorList");
		if(errorList == null)
		{
			errorList = new ArrayList<String>();
			log.info("Retreat Servlet: Create a new error list");
		} 
		else
		{
			//System.out.println("Retreat: content of error: " + errorList.toString());
			errorList.clear();
		}
		
	    //UserService userService = UserServiceFactory.getUserService();
	    //User user = userService.getCurrentUser();
	    //String userEmail = user.getEmail();
	    //log.info("Retreat Servlet: Email for current user is " + userEmail);
		
		Participant participant = null;
		// flag for error checking
		boolean error = false;
		boolean isEmpty = true;
		int cellcount = 0;
		int namecount = 0;
		String hoc = request.getParameter("HOC_Family");
		System.out.println("Retreat: HOC Family: " + hoc);
		
		//if (( hoc == null || hoc.isEmpty()) && !isFirsttime)
		if (( hoc == null || hoc.isEmpty()) )
		{
			error = true;
			//errorList.add("Hoc # is needed.");
			errorList.add("請選擇基督之家第幾家. Hoc # is needed.");
		}
		
		//String familyKey = null;
		String familyKey = "";
		String mainEmail = null; //bpan: make the first participant's email the default_email;
		
		for ( int i = 0; i< 8 ; i++) {		
			String c_name = request.getParameter("C_Name_"+ i);
			if (c_name != null) {c_name = c_name.trim();}
			String last_name = request.getParameter("last_Name_"+ i);
			if (last_name != null) {last_name = last_name.trim();}
			String first_name = request.getParameter("first_Name_"+ i);
			if (first_name != null) {first_name = first_name.trim();}
			String name = "";
			String gender = request.getParameter("MF_"+ i);
			String cell_input = request.getParameter("Cell_"+ i);
			if (cell_input != null) 
			{
				cell_input = cell_input.trim();
			}
			else
			{	
				cell_input = "";
			}
			String cell = ""; //formatted cell number
			String email = request.getParameter("eMail_"+ i);
			if (email != null) 
			{
				email = email.trim();
			}
			else
			{	
				email = "";
			}
			String pc = request.getParameter("Program_Code_"+ i);
			String topic = request.getParameter("Topic_"+ i);
			String bed = request.getParameter("Bed_"+ i);
			String bus = request.getParameter("Bus_"+ i);
			boolean isEmptyRow = true;
	
			//System.out.println("Retreat: C_Name_" + i + ": " + c_name);
			//System.out.println("Retreat: E_Name_" + i + ": " + e_name);
			
			//if( (c_name != null && !c_name.isEmpty()) || (last_name !=null && !last_name.isEmpty())|| (first_name !=null && !first_name.isEmpty()) )
			//if( (last_name !=null && !last_name.isEmpty())|| (first_name !=null && !first_name.isEmpty()) )
			if( (bus !=null && !bus.isEmpty()) )
			{
				isEmpty = false;
				if( (c_name != null && !c_name.isEmpty()) || (last_name !=null && !last_name.isEmpty())|| (first_name !=null && !first_name.isEmpty()) 
						|| (gender!=null && !gender.isEmpty()) || (pc!=null && !pc.isEmpty()) || (topic!=null && !topic.isEmpty())
						|| (bed !=null && !bed.isEmpty()) || (email!=null && !email.isEmpty()) || (cell_input!=null && !cell_input.isEmpty()))
				{
					isEmptyRow = false;
				}
				
				if ( email != null && !email.isEmpty())
				{
					if (mainEmail == null) //bpan
						mainEmail = email;
				}
				
				if ( c_name != null && !c_name.isEmpty())
				{
					name = c_name;
				}
				
				if ( first_name != null && !first_name.isEmpty())
				{
					name = first_name;
					Pattern p=Pattern.compile("^[a-zA-Z.-]+$");
					Matcher m=p.matcher(first_name);
					boolean b=m.matches();
					if(b==false)
					{
						errorList.add(name + "的英文名有誤. English first name is invalid");
						error = true;
					}
				}
				
				if ( last_name != null && !last_name.isEmpty())
				{
					name = last_name;
					Pattern p=Pattern.compile("^[a-zA-Z.-]+$");
					Matcher m=p.matcher(last_name);
					boolean b=m.matches();
					if(b==false)
					{
						errorList.add(name + "的英文姓有誤. English last name is invalid");
						error = true;
					}
				}
				
				if((last_name == null || last_name.isEmpty() || first_name == null || first_name.isEmpty()))
				{
					if( !isEmptyRow)
					{
						errorList.add(name + "的英文全名不能空白. English full name is required");
						error = true;
					}
				} else {
					namecount++;
					name = last_name+", "+first_name;
				}

				if (!isEmptyRow && (gender != null && gender.isEmpty()) )
				{
					//errorList.add("Gender information for " + name + " is blank.");
					errorList.add(name + "的性別欄空白. Gender information is blank.");
					error = true;
				}
							
				/*
				* Check if the input phone number is valid
				* Matches following phone numbers: (123)456-7890, 123-456-7890, 1234567890, (123)-456-7890
				*/

				//String phoneNumberExpression = "^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$";
			    String phoneNumberExpression = "^(\\(?(\\d{3})\\)?)?[- ]?(\\d{3})[- ]?(\\d{4})$";
				Pattern pattern = Pattern.compile(phoneNumberExpression);
				Matcher matcher = pattern.matcher(cell_input);
				boolean isAPhone=matcher.matches();
				if(isAPhone==false)
				{
					if (!isEmptyRow && (cell_input!= null && !cell_input.isEmpty()) )
					{
						//System.out.println("Retreat: InValid Phone number");
						//errorList.add("Phone number for " + name + " is invalid.");
						errorList.add(name + "的電話不對. Phone number is invalid.");
						error = true;
					}
					cell = cell_input;
				}
				else
				{
					cell_input = cell_input.replaceAll("-", "");
					cell_input = cell_input.replaceAll("\\(", "");
					cell_input = cell_input.replaceAll("\\)", "");
					if (cell_input.length() == 7)
					{
						cell_input = "408" + cell_input;
					}
					cell = "(" + cell_input.substring(0,3) + ")" + cell_input.substring(3,6) + "-"
						+ cell_input.substring(6);
					cellcount++;
				}
				
				//check for valid email address regular expressions
				//Pattern p=Pattern.compile("[a-zA-Z]*[0-9]*@[a-zA-Z]*.[a-zA-Z]*");
				Pattern p=Pattern.compile("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}");
				Matcher m=p.matcher(email);
				boolean b=m.matches();
				if(b==false)
				{
					if (!isEmptyRow && (email!= null && !email.isEmpty()))
					{
						//System.out.println("Retreat: InValid Email ID");
						//errorList.add("Email address for " + name + " is invalid.");
						errorList.add(name + "的電郵地址不對. Email address is invalid.");
						error = true;
					}
				}

				if (!isEmptyRow && (pc != null && pc.isEmpty()) )
				{
					//errorList.add("Program Code for " + name + " is blank.");
					errorList.add(name + "的節目代碼欄空白. Program Code is blank.");
					error = true;
				}
				
				if (!isEmptyRow && (topic != null && topic.isEmpty()) )
				{
					//errorList.add("Workshop Code for " + name + " is blank.");
					errorList.add(name + "的專題欄空白. Workshop Code is blank.");
					error = true;
				}
							
				if (!isEmptyRow && (bed != null && bed.isEmpty()) )
				{
					//errorList.add("Bed Code for " + name + " is blank.");
					errorList.add(name + "的床位欄空白. Bed Code is blank.");
					error = true;
				}
				
				if (participants != null && participants.size() > i)
				{
					participant = participants.get(i);
					participant.update("", familyKey, i, hoc ,c_name, last_name, first_name, gender, cell, email, topic, pc, bed, bus);
					log.info("Retreat Servlet: Updated a participant\n");

				}
				else
				{
					if (!isEmptyRow)
					{
						if ( i == 0 )
						{
							//if (user != null) {
								//familyKey = user.getNickname();
							//}
						}
						participant = new Participant("", familyKey, i, hoc, c_name, last_name, first_name, gender, cell, email, topic, pc, bed, bus);
						
						if (isPaid != null)
						{
							if (isPaid.equals("1"))
							{
								participant.setPaid(true);
								
							}
							else
							{
								participant.setPaid(false);
								
							}
						}
						else
						{
							log.info(" step 2 isPaid is NULL");							
						}

						participants.add(participant);
						log.info("Retreat Servlet: Added a new participant<" + familyKey + ">.  Total count: " + participants.size());
					}
				}
			}
/*
			else
			{
				if ((gender!=null && !gender.isEmpty()) || (pc!=null && !pc.isEmpty()) || (topic!=null && !topic.isEmpty())
						|| (email!=null && !email.isEmpty()) || (cell_input!=null && !cell_input.isEmpty()))
				{
					int registrant_no = i + 1;
					//errorList.add("Chinese and English names for registrant #" + registrant_no + " cannot be both blank.");
					errorList.add("第" + registrant_no +"位報名人的中英文姓名不能全空白.");
					error = true;
				}
			}
*/
		}
		
		if ( (namecount == 0) && (!isFirsttime))
		{
			//errorList.add("At least one name is needed.");
			errorList.add("請提供至少一個報名人的英文全名. At least one English full name is required.");
			error = true;
		}
			
		if ( !isEmpty && cellcount == 0 )
		{
			//errorList.add("At least one phone number is needed.");
			errorList.add("請提供至少一個以上電話. At least one phone number is needed.");
			error = true;
		}
		
		// bpan added: handle textarea named "notes"
		String notes = (String)(String)request.getParameter("notes");
		if ( ((String) request.getSession().getAttribute("reg_state") == "ParticipantRemoved" &&
	    		participants.size() == 0)) {
			log.info("Retreat Servlet("+conf_id+"): Clear Notes when ALL participants deleted");
			notes = "";	// special case: all participant deleted => clear out notes too
		}
		ParticipantNotes pn = (ParticipantNotes)request.getSession().getAttribute("participantNotes");
		if (pn == null) {
			log.info("Retreat Servlet("+conf_id+"): Create a new Participant Notes object");
			String user_id = (String)request.getSession().getAttribute("userId");
			pn = new ParticipantNotes("", "", user_id);
		}
		pn.setNotes(notes);
		//@@when to free resource??
		request.getSession().setAttribute("participantNotes", pn);
		//System.out.println("Retreat: Notes: "+notes);
		
        //bpan: add coworker contact info
		String contact_info = null;		
        if (ContactList != null) {
        	contact_info = (String) ContactList.get(hoc);
        	if (contact_info != null)	//when DELETE ALL, hoc will be null, hence this null
        		contact_info = contact_info.trim();
        }
        request.getSession().setAttribute("contactInfo", contact_info);
		
		request.getSession().setAttribute("participantList", participants);
		request.getSession().setAttribute("errorList", errorList);
		if (mainEmail == null || isAdminModify)	//bpan: if no email entered, or isAdminModify
			mainEmail = default_email;	//bpan
		request.getSession().setAttribute("mainEmail", mainEmail);
		request.getSession().setAttribute("hoc", hoc);
	    //request.getSession().setAttribute("currentUserEmail", userEmail);

	    response.setHeader("Pragma", "no-cache");
	    response.setHeader("Cache-Control", "no-store,no-cache");
	    
	    //bpan added: to support admin "delete all"
	    String reg_state = (String) request.getSession().getAttribute("reg_state");
	   if (reg_state.compareTo("ParticipantRemoved") == 0 && participants.size() == 0) {
		   
		    log.info("Retreat Servlet("+conf_id+") All participants removed!");
	    	System.out.println("Retreat: Go to Confirmation Page");
			getServletContext().getRequestDispatcher("/Confirmation.jsp").forward(request, response);
	   }
	   else {
	    if (!isEmpty && !error)
		{
		    System.out.println("Retreat: Go to Confirmation Page");
			getServletContext().getRequestDispatcher("/Confirmation.jsp").forward(request, response); 
	    }
		else
		{
			//bpan added block to support Modify
			//System.out.println("Retreat: isEmpty="+isEmpty+", error="+error+", #participants="+participants.size());
		    if (isAdminModify) {
		    	log.info("Retreat Servlet("+conf_id+"): Go to ModifyRegForm.jsp");
				System.out.println("Retreat: Go to ModifyRegForm.jsp");
				getServletContext().getRequestDispatcher("/ModifyRegForm.jsp").forward(request, response);
		    }
		    else {
		    	log.info("Retreat Servlet("+conf_id+"): Go to RegistrationForm.jsp");
		    	System.out.println("Retreat: Go to Registration Form page");
		    	getServletContext().getRequestDispatcher("/RegistrationForm.jsp").forward(request, response);
		    }//bpan
		}
	   } //else(not delete all)
	}	
}
