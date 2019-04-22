package com.guestbook.dao;

import java.util.ArrayList;
import java.util.List;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.CompositeFilter;
import com.google.appengine.api.datastore.Query.CompositeFilterOperator;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.guestbook.model.Participant;
import com.guestbook.model.ParticipantNotes;

public class DataPersistManagerImpl implements IDataPersistManager {
	private DatastoreService datastore;
	
	public DataPersistManagerImpl() {
		this.datastore = DatastoreServiceFactory.getDatastoreService();
	}
	
	private Entity convertToEntity(Object obj){
		Entity entity = null;
		if(obj instanceof Participant){
			entity = ((Participant)obj).toEntity();
		} else {
			entity = ((ParticipantNotes)obj).toEntity();
		}
		return entity;
	}

	@Override
	public Key addEntity(Object obj) {
		Entity entity = convertToEntity(obj);
		return datastore.put(entity);
	}

	@Override
	public void deleteEntity(Object obj) {
		Entity entity = convertToEntity(obj);
		datastore.delete(entity.getKey());
	}

	@Override
	public <T> List<T> findEntitiesByConfId(String confId, Class<T> clazz){
		// TODO Auto-generated method stub
		List<T> result = new ArrayList<>();
		FilterPredicate delFilter = new FilterPredicate("del", FilterOperator.EQUAL, false);
		Query q = new Query(clazz.getSimpleName());
		if(confId != null && !confId.isEmpty()){
			FilterPredicate confNumFilter = new FilterPredicate("confirmation_number", FilterOperator.EQUAL, confId);
			CompositeFilter confNumAndDelFilter = CompositeFilterOperator.and(confNumFilter, delFilter);
			q.setFilter(confNumAndDelFilter);
		} else {
			q.setFilter(delFilter);
		}
		if(clazz == Participant.class){
			q.addSort("sequence_number", SortDirection.ASCENDING);
		}
		PreparedQuery pq = datastore.prepare(q);
		pq.asIterable().forEach(entity -> {
			try {
				result.add(clazz.getConstructor(Entity.class).newInstance(entity));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
		return result;
	}
	
	@Override
	public List<Participant> findEntitiesByHocFamily(String hocFamily){
		List<Participant> result = new ArrayList<>();
		FilterPredicate delFilter = new FilterPredicate("del", FilterOperator.EQUAL, false);
		Query q = new Query(Participant.class.getSimpleName())
				.addSort("hoc_family", SortDirection.ASCENDING)
				.addSort("paid", SortDirection.ASCENDING);
		if(hocFamily != null && !hocFamily.isEmpty()){
			FilterPredicate hocFamilyFilter = new FilterPredicate("hoc_family", FilterOperator.EQUAL, hocFamily);
			CompositeFilter hocFamilyAndDelFilter = CompositeFilterOperator.and(hocFamilyFilter, delFilter);
			q.setFilter(hocFamilyAndDelFilter);
		} else {
			q.setFilter(delFilter);
		}
		PreparedQuery pq = datastore.prepare(q);
		pq.asIterable().forEach(entity -> {
				result.add(new Participant(entity));
		});
		return result;
	}

	@Override
	public Key updateEntity(Object obj) {
		Entity entity = convertToEntity(obj);
		return datastore.put(entity);
	}

}
