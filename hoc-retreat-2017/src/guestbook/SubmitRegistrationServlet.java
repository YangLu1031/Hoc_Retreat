package guestbook;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.util.Properties; 
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.mail.Message; 
import javax.mail.MessagingException; 
import javax.mail.Session; 
import javax.mail.Transport; 
import javax.mail.internet.AddressException; 
import javax.mail.internet.InternetAddress; 
import javax.mail.internet.MimeMessage; 


/**
 * Servlet implementation class RetreatRegistrationServlet
 */
public class SubmitRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(SubmitRegistrationServlet.class.getName());     
	private static final String default_email = "hoc4.info@gmail.com";	//"no-reply@hoc-retreat-us.appspotmail.com"; 
								//bpan: used for google appengine login
	private static final String default_admin_email = "hoc4.info@gmail.com"; 
								//Retreat admin (same as "default_email" in RetreatRegistration Servlet 
								//in this case, default_email used for email sender and
								//default_admin_email for retreat are different

	/**
     * @see HttpServlet#HttpServlet()
     */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		log.info("Submit Servlet: Entering");
		System.out.println("Submit Servlet: Entering");
		request.setCharacterEncoding("UTF-8");

		if (request.getSession() == null
			|| request.getSession().getAttribute("reg_state") == null) //bpan: avoid from wrong user ops
		{
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
				request, response);
			return; //bpan
		}

		//bpan added: check if session already completed (i.e. it's a duplicated submission)
		if (request.getSession().getAttribute("reg_state") == "submitted") {
			getServletContext().getRequestDispatcher("/SessionExpired.jsp").forward(request, response);
			return;
		}

		//bpan added: check if admin modify => invalidate all existing entries, then save new ones
		String user_id = (String)request.getSession().getAttribute("userId");
		System.out.println("Submit: session user_id="+user_id);
		UserPrivilege upv = (UserPrivilege)request.getSession().getAttribute("userPriv");
		boolean isAdminModify = false;
		if (upv != null && upv.isAdmin() && upv.isModify()) {
			isAdminModify = true;
			log.info("Submit Servlet: Admin Modify");
			//System.out.println("Submit: Admin Modify");
		}

		//String a = "æˆ‘ä»¬";  
		List<Participant> participants = 
			(List<Participant>) request.getSession().getAttribute("participantList");
		
		//bpan added: if participants is null => re-submission (above logic seems to have done this?)
        if (participants == null ) {
        	log.warning("Submit Servlet: Re-submission by user: "+user_id);
			getServletContext().getRequestDispatcher("/SessionExpired.jsp").forward(request, response);
			return;
        }
		
		List<Participant> emptyList = null;
		
		Participant participant = null;
		// flag for error checking

        //bpan: add coworker contact info to email
		String contact_info = "";
		String[] s;
		String sc;
		String contacts = (String) request.getSession().getAttribute("contactInfo");
		if (contacts != null) {
			//contacts.replace(";", "\n");	//if multiple contacts => not working
			s = contacts.split("\\:");
			for (int i=0; i < s.length; i++) {
				contact_info = contact_info + s[i] +"\n";
			}
		}

		boolean all_removed = false;	//bpan: if all participants removed by admin
		String confirm_no = null;
		{
			//isSessionComplete = request.getSession().getAttribute("isSessionComplet");
			String confirmationNumber = (String)request.getSession().getAttribute("confirmationNumber");
			ParticipantNotes pnotes = (ParticipantNotes)request.getSession().getAttribute("participantNotes"); //bpan
			int total_cost = 0;	//bpan
			
			//bpan: support admin modify feature w/o impacting original logic
			if ((isAdminModify) || 
					(confirmationNumber == null || confirmationNumber.isEmpty()))
			{ 
				//bpan
				if (isAdminModify)
					log.info("Submit Servlet: AdminModify-invalidating then saving");
				else
					log.info("Submit Servlet: save new participant list");
				
				//String mainEmail = (String)request.getSession().getAttribute("currentUserEmail");
				String mainEmail = (String)request.getSession().getAttribute("mainEmail");
			    response.setHeader("Pragma", "no-cache");
			    response.setHeader("Cache-Control", "no-store,no-cache");
		        
		        StringBuffer msgBody = new StringBuffer(); 
		        Date date = new Date();
		        
		        //bpan added: do not modify confirmation number if admin modify
		        if (!isAdminModify) {
		  	  		String DATE_FORMAT_NOW_MS = "yyMMdd-HHmmss:SSSS";
		  	  		confirm_no = Utils.now(DATE_FORMAT_NOW_MS);						
		  	  		request.getSession().setAttribute("confirmationNumber", confirm_no);
		        } //bpan
		        else {
		        	confirm_no = confirmationNumber;	// if admin modify, use specified one
		        }
		        
		        //bpan added block: invalidate ALL existing entries
		        //NOTE: crash log "can't operate on multiple entity groups in a single transaction."
		        if (isAdminModify) {
		        	
		        	// 1. invalidating existing participant list
		    	    PersistenceManager pm = PMF.get().getPersistenceManager();
		    		try {
		    		    String query = "select from " + Participant.class.getName() + 
		    		    	" where del == false && confirmation_number == '" + confirmationNumber +"'"; 
		    		    List<Participant> partis = (List<Participant>) pm.newQuery(query).execute();
			        	int dn = 0;	//counter
		    		    for (Participant pt : partis ) {
		    		    	pt.setChangedBy(user_id);	//who made the change
		    		    	pt.setModify_time(date);	//when the change made
		    		    	pt.Delete();				//delete original Participant
		    		    	
			                pm.makePersistent(pt);

			                System.out.println("Submit: Invalidated participant: " + dn);//pt.toString());
			                dn++;
		    		    }
		    		    log.info("Submit Servlet("+confirm_no+"): AdminModifyinvalidated "
		    		    		+dn+" participants");
		    		    //@@free partis??
		    		    
		    		}
		    		catch (Exception e) {
		    	      	log.severe("Submit Servlet("+confirm_no+"): Exception while deleting " +
		    	      			"participant from database");
		    		}
		    		finally {
		    		    pm.close();
		    		}
		    		
		    		// 2. invalidating existing participant note
		    	    pm = PMF.get().getPersistenceManager();
		    		try {
		    		    // invalidate ParticipantNotes
		    		    String query = "select from " + ParticipantNotes.class.getName() + 
		    		    	" where del == false && confirmation_number == '" + confirmationNumber +"'";
		    		    List<ParticipantNotes> delnotes = 
		    		    	(List<ParticipantNotes>) pm.newQuery(query).execute();
		    		    int dn = 0;	//counter
		    		    for (ParticipantNotes dnt : delnotes) {
		    		    	dnt.setChangedBy(user_id);
		    		    	dnt.setModify_time(date);
		    		    	dnt.Delete();
		    		    	
		    		    	pm.makePersistent(dnt);
		    		    	
		    		    	System.out.println("Submit: Invalidated notes: " + dn);
		    		    	dn++;
		    		    }
		    		    log.info("Submit Servlet("+confirm_no+"): AdminModify invalidated "+dn+" notes");
		    		}
		    		catch (Exception e) {
		    	      	log.severe("Submit Servlet("+confirm_no+"): Exception while deleting notes " +
		    	      			"from database. Error: "+e);
		    		}
		    		finally {
		    		    pm.close();
		    		}
		        } //if(isAdminModify)
		        

	            if (participants != null && participants.size() > 0) //bpan 
			    {
	            	int i;
			        for ( i = 0; i < participants.size() ; i++ )
			        {
			            PersistenceManager pm = PMF.get().getPersistenceManager(); 
			            try { 
			            	participant = participants.get(i);
				        	//if ( mainEmail == null )
				        	{
				        		//mainEmail = participant.getEmail();
				        	}
				        	participant.setConfirmationNumber(confirm_no);
				        	
				        	// bpan changed
				        	if (isAdminModify) {
				        		participant.setModify_time(date);
				        	}
				        	else {
				        		participant.setTimestmap(date); // creation timestamp
				        	}
							
							//bpan added block
							System.out.println("Submit: participant "+i+" updated by "+user_id);
							participant.setChangedBy(user_id);
							total_cost += participant.cost();
							

			            	//System.out.println("Submit: message:" + participant.toString());
			                pm.makePersistent(participant); 
			            } catch (Exception e)
			            {
			            	log.severe("Submit Servlet("+confirm_no+"): Exception while storing " +
			            			"participant to database. Error: "+e.getMessage());
			            	e.printStackTrace();
			            	
			            }
			            finally { 
			                pm.close(); 
			            } 
			        	msgBody.append(participant.toString());
			        	
			        } //for each participant
			        
			        log.info("Submit Servlet("+confirm_no+"): Stored "+i+" participant(s) to database");
			        
			        //bpan: store participant notes
			        PersistenceManager pm = PMF.get().getPersistenceManager();
			        {
			        	try { 
				        	pnotes.setConfirmationNumber(confirm_no);
				        	
				        	// bpan changed
				        	if (isAdminModify)
				        		pnotes.setModify_time(date);
				        	else
				        		pnotes.setCreate_time(date);
							
							//bpan added block
							System.out.println("Submit: notes updated by "+user_id);
							pnotes.setChangedBy(user_id);
							
			            	//System.out.println("Submit: notes content:" + pnotes.toString());
			                pm.makePersistent(pnotes); 
			            } catch (Exception e)
			            {
			            	log.severe("Submit Servlet("+confirm_no+"): Exception while storing Notes " +
			            			"to database. Error: "+e.getMessage());
			            	e.printStackTrace();
			            }
			            finally { 
			                pm.close(); 
			            } 
			            
			            log.info("Submit Servlet("+confirm_no+"): Stored notes to database");
			            
			        } //store notes
			        
			        //bpan
			        msgBody.append("\n注意事项 Notes:\n"+pnotes.getNotes()+"\n");
			        
			     } //if(participants != null && size >0)
	             else {
	            	 if (isAdminModify)
	            		 all_removed = true;
	             } //else(participant list empty)
	            	 	
		        Properties props = new Properties(); 
		        Session session = Session.getDefaultInstance(props, null); 
		 
		        try { 
		        	if (mainEmail  != null && !mainEmail.isEmpty() )
		        	{
		        	  //bpan: ALWAYS send email
		        	  //if (!isAdminModify) {
			            Message msg = new MimeMessage(session);
			            
			            msg.setFrom(new InternetAddress(default_email, "Retreat Registration Admin")); 
			            
			            //bpan: note that mainEmail has been admin's if AdminModify
			            //(set in RetreatRegistration servlet)
			            msg.addRecipient(Message.RecipientType.TO, 
			                             new InternetAddress(mainEmail, "")); 
			            //bpan; send a copy to admin, too
			            if (mainEmail.compareTo(default_admin_email) != 0) {
			            	msg.addRecipient(Message.RecipientType.CC, 
		                             new InternetAddress(default_admin_email, ""));
			            }
			            
			            //bpan: distinguish "add" or "modify" (incl. deleting all) 
			            //		in Subject & message body 
			          if (!isAdminModify) {
			            msg.setSubject("Your registration has been received"); 
			          }
			          else {
			        	  if (!all_removed) 
			        		  msg.setSubject("Registration ("+confirm_no+") has been modified");
			        	  else
			        		  msg.setSubject("Registration ("+confirm_no+") has been DELETED");
			          }
			          
			            log.info("Submit Servlet: Email to: <" + mainEmail +"> with message: " + 
			            		msgBody.toString() + "\nContact: " + contact_info + "\n");

			            //msg.setText("Registration confirmation " + confirm_no + " has been received for the followings:\n" + msgBody.toString());
					      if (!isAdminModify) {
					            msg.setText("下列資料已收到。The following info has been received\n" + 
					            			"請列印本頁，並於繳費時附上，以方便同工的處理。謝謝！\n" + 
					            			"Please print out this email and bring it with payment " +
					            			"to retreat coworkers. Thank you!\n\n" + 
					            			"預估報名費用 Estimated Registration Fee: " + total_cost + "\n" +
					            			"預估報名費用僅供參考，實際費用依照各家收費規定可能不同，詳情請聯絡各家報名組同工。\n" +
					            			"Estimated Registration Fee is for reference only. " +
					            			"The actual registration fee may be different for each home church, " +
					            			"please contact retreat coworkers at your home church for details.\n" +
		           			
					            			msgBody.toString() +
					            			"\n=========================\n如有任何問題，請與以下同工聯絡：\n" +
					            			"Please contact the following coworkers if any question:\n" +
					            			contact_info + "\n");
						      }
						      else {
						    	  if (!all_removed) {
						    		  msg.setText("以下是更改後的最新報名資料。The following is the modified registration.\n" + 
						    				  	  "\n預估報名費用  Estimated Registration Fee: " + total_cost + "\n" +
						    				  	  msgBody.toString() +
						    				  	"\n=========================\n如有任何問題，請與以下同工聯絡：\n" +
						            			"Please contact the following coworkers if any question:\n" +
						            			contact_info + "\n");
						    	  }
						    	  else { 
						    		  msg.setText("資料已移除。This registration has been deleted permanently.\n");
						    	  }
						      }
				      
			            Transport.send(msg);
		        	  //} //bpan
			            
			    		//-request.getSession().setAttribute("submittedParticipantList", participants);
			    		//clear participantList to prevent re-submission
			    		//-request.getSession().setAttribute("participantList", emptyList);
			    		//request.getSession().setAttribute("isSessionComplet", true);
		        	}
		 
		        } catch (AddressException e) { 
		            // ... 
		        	log.severe("Submit Servlet("+confirm_no+"): AddressException: "+e+" ("+ mainEmail+")");
		        } catch (MessagingException e) { 
		            // ... 
		        	log.severe("Submit Servlet("+confirm_no+") : MessagingException: "+e+" ("+ mainEmail+")");
		        } catch (Exception e)
		        {
		        	log.severe("Submit Servlet("+confirm_no+") : Email Exception: "+e+" ("+ mainEmail+")");
		        }
						request.getSession().setAttribute("submittedParticipantList", participants);
			    		//clear participantList to prevent re-submission
						request.getSession().setAttribute("participantList", emptyList);
						request.getSession().setAttribute("reg_state", "submitted"); //bpan: add tentative reg state
		        log.info("Submit Servlet("+confirm_no+"): Goto Acknowledge.jsp");
						System.out.println("Submit: Go to Acknowledge Page");
						getServletContext().getRequestDispatcher("/Acknowledge.jsp").forward(request, response);
			} //if ((isAdminModify) || (confirmationNumber == null || confirmationNumber.isEmpty()))
			else //already submitted
			{
				getServletContext().getRequestDispatcher("/SessionExpired.jsp").forward(request, response);

			}
		} //open bracket
	} //doPost()

	private ServletRequest getSession() {
		// TODO Auto-generated method stub
		return null;
	}	
}
