package com.guestbook.dao;

import java.util.List;

import com.google.appengine.api.datastore.Key;
import com.guestbook.model.Participant;

public interface IDataPersistManager {
	public Key addEntity(Object obj);
	public void deleteEntity(Object obj);
	public<T> List<T> findEntitiesByConfId(String confId, Class<T> clazz); 
	public List<Participant> findEntitiesByHocFamily(String hocFamily);
	public Key updateEntity(Object obj);
}
