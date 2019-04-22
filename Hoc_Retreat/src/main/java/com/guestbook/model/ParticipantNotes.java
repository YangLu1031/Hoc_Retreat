package com.guestbook.model;

import java.io.Serializable;
import java.util.Date;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;

public class ParticipantNotes implements Serializable
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L; 
	private Key key;
	private String confirmation_number;
	private String notes;
    private String created_by;
    private String changed_by = null;
    private boolean del = false;
	private Date create_time = null;
	private Date modify_time = null;
    // Note: whenever a new variable added, please add it to clone() method, too.
	
    public ParticipantNotes(Entity pNotes){
    	this.key = pNotes.getKey();
    	this.confirmation_number = (String) pNotes.getProperty("confirmation_number");
    	this.notes = (String) pNotes.getProperty("notes");
    	this.created_by = (String) pNotes.getProperty("created_by");
    	this.changed_by = (String) pNotes.getProperty("changed_by");
    	this.del = (boolean) pNotes.getProperty("del");
    	this.create_time = (Date) pNotes.getProperty("create_time");
    	this.modify_time = (Date) pNotes.getProperty("modify_time");
    }
    
	public ParticipantNotes(String confirm_no, String p_notes, String user_id)
	{
		confirmation_number = confirm_no;
		notes = p_notes;
		created_by = user_id;
	}

	public void update(String confirm_no, String p_notes, String user_id)
	{
		confirmation_number = confirm_no;
		notes = p_notes;
		changed_by = user_id;
	}


	public String getConfirmationNumber() {
		return confirmation_number;
	}
	
	public void setConfirmationNumber(String confirm_no) {
		this.confirmation_number = confirm_no;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getCreatedBy() {
		return created_by;
	}

	public String getChangeBy() {
		return changed_by;
	}
	
	public void setChangedBy(String user_id) {
		this.changed_by = user_id;
	}
	
	public void Delete() {
		del = true;
	}
	public boolean isDeleted() {
		return del;
	}
	
	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date createTime) {
		create_time = createTime;
	}

	public Date getModify_time() {
		return modify_time;
	}

	public void setModify_time(Date modifyTime) {
		modify_time = modifyTime;
	}

	public ParticipantNotes clone() {
		ParticipantNotes dst = new ParticipantNotes(confirmation_number, 
				notes, created_by);

		// must clone other fields, too 
		// NOTE: whenever a new field added, remember to add it here
		dst.changed_by = changed_by;
		dst.del = del;
		dst.create_time = create_time;
		dst.modify_time = modify_time;
		return dst;
	}
	

	public String toString()
	{
		String deleted = del? "Delete":"";
		String all = "\n確認號碼 confirmation number: " + confirmation_number + ",\n" +
		 "注意事項 Notes: " + notes + ",\n" +
		 "Created by:" + created_by + "" + " at " + create_time + ",\n" +
		 "Modified by: " + changed_by + "" + " at " + modify_time + ",\n" +
		 deleted;

		return all;
	}
	
	public static ParticipantNotes cast(Entity entity){
		return new ParticipantNotes(entity);
	}
	
	public Entity toEntity(){
		Entity pNotes = new Entity("ParticipantNotes", this.confirmation_number);
		pNotes.setProperty("confirmation_number", this.confirmation_number);
		pNotes.setProperty("notes", this.notes);
		pNotes.setProperty("created_by", this.created_by);
		pNotes.setProperty("changed_by", this.changed_by);
		pNotes.setProperty("del", this.del);
		pNotes.setProperty("create_time", this.create_time);
		pNotes.setProperty("modify_time", this.modify_time);
		return pNotes;
	}

	public Key getKey() {
		return key;
	}

	public void setKey(Key key) {
		this.key = key;
	}
}
