package guestbook;

import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RetreatRegistrationServlet
 */
public class LoginAuthenticationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger
			.getLogger(SubmitRegistrationServlet.class.getName());
	private static final HashMap<String, String> loginKeys = Utils
			.getHashMapFromFile("login-admin.txt", true); //bpan: exit() if file not found //login-admin.txt
	
	// To enable non-admin user login, change the above file name to login.txt

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginAuthenticationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		log.info("Entering LoginAuthenticationServlet");
		if (request.getSession() != null) //bpan
			(request.getSession()).invalidate();
		request.setCharacterEncoding("UTF-8");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-store,no-cache");
		log.info("2Entering LoginAuthenticationServlet");
		boolean error = false;
		String errorMsg = "";
		String user = request.getParameter("user");
		String password = (String) request.getParameter("password");
		log.info("user: " + user + "; password: " + password);
		log.info("Entering LoginAuthenticationServlet");
		if ((user != null) && (password != null)) {
			user = user.trim();

			//bpan debug
			//System.out.println("USER trim = " + user + 
			//		" loginKeys.containsKey(user)=" +loginKeys.containsKey(user));
			
			if (loginKeys.containsKey(user)) {
				String value = ((String) loginKeys.get(user)).trim();
				if (!password.equals(value)) {
					errorMsg = "ç”¨æˆ·å��æˆ–å¯†ç¢¼éŒ¯èª¤ã€‚"; // "é€€ä¿®ä¼šç½‘ä¸ŠæŠ¥å��å·²äºŽ6æœˆ30æ—¥æˆªæ­¢ï¼Œç›®å‰�å�ªæœ‰adminå�¯ä»¥ç™»å½•";  // "ç”¨æˆ·å��æˆ–å¯†ç¢¼éŒ¯èª¤ã€‚"; //bpan "Password does not match the one on file!";
					error = true;
				}
			} else {
				errorMsg = "ç”¨æˆ·å��æˆ–å¯†ç¢¼éŒ¯èª¤ã€‚"; //"é€€ä¿®ä¼šç½‘ä¸ŠæŠ¥å��å·²äºŽ6æœˆ30æ—¥æˆªæ­¢ï¼Œç›®å‰�å�ªæœ‰adminå�¯ä»¥ç™»å½•";  //"ç”¨æˆ·å��æˆ–å¯†ç¢¼éŒ¯èª¤ã€‚"; //bpan "User name is not correct!";
				error = true;

			}
		} else {
			errorMsg = "è«‹è¼¸å…¥ç”¨æˆ·å��å�Šå¯†ç¢¼ï¼�"; //bpan "Please type in User and Password fields!";
			error = true;

		}
		if (!error) {
			//bpan added block
			//initialize user privilege and save in session
			UserPrivilege upv = new UserPrivilege(user, password); //@@when to free UserPriviledge object??
			request.getSession(true).setAttribute("userPriv", upv);
			
			request.getSession().setAttribute("userId", user);
			request.getSession().setAttribute("reg_state", "login"); //bpan: add tentative reg state
						
			// bpan changed
			if (upv.isAdmin()) {
				System.out.println("Go to Admin Home Page");
				getServletContext().getRequestDispatcher("/AddMod.jsp")
					.forward(request, response);
			}
			else {
				System.out.println("Go to Registration Form Page");
				getServletContext().getRequestDispatcher("/RegistrationForm.jsp")
					.forward(request, response);	
			}
		} else {
			System.out.println("Go back to login page");
			request.getSession(true).setAttribute("errorMsg", errorMsg); //bpan
			getServletContext().getRequestDispatcher("/login2.jsp").forward(
					request, response);
		}

	}
}
