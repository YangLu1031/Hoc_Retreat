package com.guestbook.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
//import java.util.Properties; 
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.guestbook.dao.DataPersistManagerImpl;
import com.guestbook.dao.IDataPersistManager;
import com.guestbook.model.Participant;
import com.guestbook.model.ParticipantNotes;

/**
 * Servlet implementation class SearchConfirmationServlet
 */
@WebServlet(
	    name = "SearchConfirmation",
	    urlPatterns = {"/SearchConfirmation"}
	)
public class SearchConfirmationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(SearchConfirmationServlet.class.getName());  
	private IDataPersistManager dpm;

	@Override
	public void init() throws ServletException {
	    // setup datastore service
		dpm = new DataPersistManagerImpl();
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		log.info("Search Servlet: Entering");
		System.out.println("Search Servlet: Entering");
		request.setCharacterEncoding("UTF-8");

		if (request.getSession() == null)
		{
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
				request, response);
			return; //bpan
		}
		
		//bpan added block
		String conf_id = (String) request.getParameter("ConfirmID"); //from AddMod.jsp form data
		request.getSession().setAttribute("confirmationNumber", conf_id);
		
		String user_id = (String)request.getSession().getAttribute("userId");
		
		//bpan added block, Query DATABASE for participantList and participantNotes
		List<Participant> p2 = new ArrayList<Participant>(); // Note: query results are NOT modifiable
		List<ParticipantNotes> pn2 = new ArrayList<ParticipantNotes>(); // Note: query results are NOT modifiable
		
	    try {
	    	//------- query participant list
	    	List<Participant> participants = dpm.findEntitiesByConfId(conf_id, Participant.class);
	    	//bpan added block to replace the original logic (below this block)
	    	// confirmationNumber and participantList must be set in session
	    	int cnt = 0;
	    	for (Participant pt : participants ) {
	    		Participant pt2 = pt.clone();
	    		p2.add(pt2);
	    		cnt++;
	    	}
	    	//@@free participants??
	    	request.getSession().setAttribute("participantList", p2); //whatever null or not
	    	log.info("Search Servlet("+conf_id+"): found "+cnt+" participant(s)");
	    	
	    	//------- query Notes (should have only 1 undeleted notes)
	    	List<ParticipantNotes> participant_notes = dpm.findEntitiesByConfId(conf_id, ParticipantNotes.class);
	    	cnt = 0;
	    	for (ParticipantNotes pt : participant_notes ) {
	    		ParticipantNotes pt2 = pt.clone();
	    		pn2.add(pt2);
	    		cnt++;
	    	}
	    	//@@free participant_notes??
	    	
	    	// hacking: always use the last note if multiple notes found
	    	if (cnt != 1)	// give a warning first
	    		log.warning("Search Servlet("+conf_id+"): found "+cnt+" Notes");
	    	
	    	ParticipantNotes pnotes = null;
	    	if ( (cnt = pn2.size()) > 0 ) {
	    		pnotes = pn2.get(cnt-1);	//the last notes
	    	}
	    	request.getSession().setAttribute("participantNotes", pnotes); //whatever null or not
	    }
	    catch (Exception e) {
	    	log.severe("Search Servlet("+conf_id+"): Exception while query database. Error: "+e);
	    }
	    finally {
	    	request.getSession().setAttribute("reg_state", "search"); //bpan: add tentative reg state
	    	System.out.println("Search: goto ModifyRegForm.jsp");
	    	getServletContext().getRequestDispatcher("/ModifyRegForm.jsp").forward(request, response);
	    }
	}

	private ServletRequest getSession() {
		// TODO Auto-generated method stub
		return null;
	}	
}
