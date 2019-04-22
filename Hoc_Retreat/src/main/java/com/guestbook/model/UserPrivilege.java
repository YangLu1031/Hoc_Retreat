package com.guestbook.model;

import java.io.Serializable;

public class UserPrivilege implements Serializable 
{
	private String user_id;
	private String password;
	private boolean isAdmin;
	private boolean isModify;
	
	public UserPrivilege(String userid, String psw) {
		super();
		user_id = userid;
		password = psw;
		if (userid.contains("admin"))
			isAdmin = true;
		else
			isAdmin = false;
		isModify = false;	// always start with Not modify
	}
	
	//public void ~UserPriviledge(String userid) {
		
	//}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String userId) {
		user_id = userId;
	}

	public String getPassword() {
		return password;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public boolean isModify() {
		return isModify;
	}

	public void setModify(boolean isModify) {
		this.isModify = isModify;
	}

}
