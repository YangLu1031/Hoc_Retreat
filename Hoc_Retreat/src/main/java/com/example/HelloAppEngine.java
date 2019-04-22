package com.example;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.guestbook.dao.DataPersistManagerImpl;
import com.guestbook.dao.IDataPersistManager;
import com.guestbook.model.Participant;
import com.guestbook.model.ParticipantNotes;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {
	private IDataPersistManager pm;
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
	  Participant p = new Participant("1",
				"hoc", 1, "5",
				"yy", "lu","yang", 
				"mail", "1234567890", 
				"yy36457@gmail.com", "event",
				"program", "bed01",
				"bus01");
	  pm.addEntity(p);
	  List<Participant> participants = pm.findEntitiesByConfId("", Participant.class);
	  List<Participant> hoc5pts = pm.findEntitiesByHocFamily("5");
	  List<ParticipantNotes> pNotes = pm.findEntitiesByConfId("", ParticipantNotes.class);
	  participants.forEach(pt -> {
		  pt.setBed("bedxxx");
		  pm.updateEntity(pt);
	  });  
    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");

    response.getWriter().print("Hello App Engine!\r\n");
  }
  
  @Override
  public void init() throws ServletException {

    // setup datastore service
	  pm = new DataPersistManagerImpl();
  }
}