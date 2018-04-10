package guestbook;

import java.io.IOException;
//import java.util.Properties; 
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RemoveParticipantServlet
 */
public class SearchParticipantsByHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(SearchParticipantsByHomeServlet.class.getName());     
    /**
     * @see HttpServlet#HttpServlet()
     */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
				
		if (request.getSession() == null)
		{
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
				request, response);
			return; //bpan
		}
		
		String hoc = request.getParameter("HOC_Family");
		String format = request.getParameter("ResFormat");
		request.getSession().setAttribute("HOC_Family", hoc);
		request.getSession().setAttribute("ResFormat", format);
		
		//@@check: the above change happens directly inside session
		getServletContext().getRequestDispatcher("/ParticipantList.jsp").forward(request, response);
		
	} /*doGet*/

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	private ServletRequest getSession() {
		// TODO Auto-generated method stub
		return null;
	}	
}
