package guestbook;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import java.util.Properties; 
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;

/**
 * Servlet implementation class RemoveParticipantServlet
 */
public class RemoveParticipantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(RemoveParticipantServlet.class.getName());     
    /**
     * @see HttpServlet#HttpServlet()
     */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		log.info("Remove Servlet: Entering - doGet");
		System.out.println("Remove Servlet: Entering - doGet");
		request.setCharacterEncoding("UTF-8");

		if (request.getSession() == null)
		{
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
				request, response);
			return; //bpan
		}
		
		// find Participants in session
		List<Participant> participants = 
			(List<Participant>) request.getSession().getAttribute("participantList");
		
		Participant participant = null;
		
		// find which participant to be removed
		int i = Integer.parseInt(request.getParameter("DEL"));
		if (i <0 || i > 7) {
			// should not happen
			log.severe("Remove Servlet: fatal- wrong participant index: "+i);
		}
		else {
			participant = participants.get(i);
			if (participant == null) {
				// should not happen
				log.severe("Remove Servlet: fatal- participant index: "+i+" not existed");
			}
			else {
				participants.remove(i);
				log.info("Remove Servlet: removed participant (index: "+i+") remaining: "+participants.size());
				//System.out.println("RemoveParticipantServlet removed participant (index: "+i+")");
				
				// re-sequence the remaining participant(s)
				//@@ not sure if this step necessary, for it can be done when submit form??
				for (int j = 0; j < participants.size(); j++) {
					participants.get(j).setSequence_number(j);
				}
			} //else(participant exists)
		}//else(i valid)
		
		request.getSession().setAttribute("reg_state", "ParticipantRemoved");
		//@@check: the above change happens directly inside session
		log.info("Remove Servlet: go back to ModifyRegForm.jsp");
		System.out.println("go back to ModifyRegForm.jsp");
		getServletContext().getRequestDispatcher("/ModifyRegForm.jsp").forward(request, response);
		
	} /*doGet*/

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private ServletRequest getSession() {
		// TODO Auto-generated method stub
		return null;
	}	
}
