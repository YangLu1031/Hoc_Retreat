package guestbook;

import java.io.Serializable;
import java.sql.*;
 
import java.util.Date; 

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable 
public class Participant implements Serializable
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	@PrimaryKey 
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY) 
    private Key key; 
 

    @Persistent 
	private String confirmation_number;
    @Persistent 
	private String family_id;
    @Persistent 
	private int sequence_number;
    @Persistent 
	private String hoc_family;
    @Persistent 
 	private String cname;
    @Persistent 
 	private String last_name;
    @Persistent 
	private String first_name;
    @Persistent 
 	private String email;
    @Persistent 
 	private String gender;
    @Persistent 
	private String cell;
    @Persistent 
	private String program;
    @Persistent 
	private String topic;
    @Persistent 
 	private String bed;
    @Persistent 
 	private String bus;
    @Persistent
    private boolean paid;
    @Persistent
    private String building;
    @Persistent
    private String room_number;
    @Persistent
    private String changed_by;
    @Persistent
    private boolean del = false;
    @Persistent 
	private Date timestmap;
    @Persistent 
	private Date modify_time;
    // Note: whenever a new variable added, please add it to clone() method, too.
	
	public Participant( String confirm_no,
			String family, int seq_no, String hocfamily,
			String c_name, String last_name,String first_name, 
			String gender_in, String cellphone, 
			String email_add, String topic_in,
			String program_in, String bed_in,
			String bus_in)
	{
		confirmation_number = confirm_no;
		family_id = family;
		sequence_number = seq_no;
		hoc_family = hocfamily;
		cname = c_name;
		this.last_name = last_name;
		this.first_name = first_name;
		this.email = email_add;
		gender = gender_in;
		cell = cellphone;
		program = program_in;
		topic = topic_in;
		bed = bed_in;
		bus = bus_in;

		// null for later use
		paid = false;
		building = null;
		room_number = null;
		//addToDB();
	}

	public void update(
			String confirm_no,
			String family, int seq_no, String hocfamily,
			String c_name, String last_name, String first_name, 
			String gender_in, String cellphone, 
			String email_add, String topic_in,
			String program_in, String bed_in, 
			String bus_in)
	{
		confirmation_number = confirm_no;
		family_id = family;
		sequence_number = seq_no;
		hoc_family = hocfamily;
		cname = c_name;
		this.last_name = last_name;
		this.first_name = first_name;
		email = email_add;
		gender = gender_in;
		cell = cellphone;
		program = program_in;
		topic = topic_in;
		bed = bed_in;
		bus = bus_in;
		//bpan modify_time = Utils.currentTimestamp();
		//addToDB();
	}


	public Date getModify_time() {
		return modify_time;
	}

	public void setModify_time(Date modifyTime) { //bpan Timestamp
		modify_time = modifyTime;
	}

	public int cost(){
		return Utils.listCost(getProgram(), getBed(), "Y");
	}
	
	public String getFamily_id() {
		return family_id;
	}

	public void setFamily_id(String familyId) {
		family_id = familyId;
	}

	public int getSequence_number() {
		return sequence_number;
	}
	
	public void setSequence_number(int seq_no) {
		sequence_number = seq_no;
	}

	public String getHoc_family() {
		return hoc_family;
	}

	public void setHoc_family(String hocFamily) {
		hoc_family = hocFamily;
	}

	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getLastName() {
		return last_name;
	}
	public void setLastName(String _name) {
		this.last_name = _name;
	}
	
	public String getFirstName() {
		return first_name;
	}
	public void setFirstName(String _name) {
		this.first_name = _name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getTimestmap() {
		return timestmap;
	}
	public void setTimestmap(Date timestmap) {
		this.timestmap = timestmap;
	}

	public String getConfirmationNumber() {
		return confirmation_number;
	}
	
	public void setConfirmationNumber(String confirm_no) {
		this.confirmation_number = confirm_no;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCell() {
		return cell;
	}

	public void setCell(String cell) {
		this.cell = cell;
	}

	public String getProgram() {
		return program;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getBed() {
		return bed;
	}

	public void setBed(String bed) {
		this.bed = bed;
	}

	
	public String getBus() {
		return bus;
	}

	public void setBus(String bus) {
		this.bus = bus;
	}

	public boolean getPaid() {
		return paid;
	}
	public void setPaid(boolean paid) {
		this.paid = paid;
	}

	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}

	public String getRoomNumber() {
		return room_number;
	}
	public void setRoomNumber(String room_number) {
		this.room_number = room_number;
	}
	
	public void Delete() {
		del = true;
	}
	public boolean isDeleted() {
		return del;
	}
	
	public String getChangeBy() {
		return changed_by;
	}
	public void setChangedBy(String changed_by) {
		this.changed_by = changed_by;
	}
	
	
	//bpan added
	public Participant clone() {
		Participant newp = new Participant(confirmation_number, 
				family_id, sequence_number, hoc_family,
				cname, last_name, first_name, 
				gender, cell, 
				email, topic,
				program, bed,
				bus);

		// must clone other fields, too 
		// NOTE: whenever a new field added, remember to add it here
		newp.paid = paid;
		newp.building = building;
	    newp.room_number= room_number;
	    newp.changed_by= changed_by;
	    newp.del = del;
	    newp.timestmap= timestmap;
	    newp.modify_time= modify_time;
	    
		return newp;
	}
	 

	public String toString()
	{
		int registrant_number = sequence_number + 1;

		String all = "\n確認號碼 confirmation number: \t" + confirmation_number + "\n" +
				 "基督之家 HOC:\t\t\t" + hoc_family + "\n" +
				 "報名順序 registrant\t\t#" + registrant_number + "\n" +
				 "中文姓名 Chinese Name:\t" + cname + "\n" +
				 "英文姓 Last Name:\t\t\t" + last_name + "\n" +
				 "英文名 First Name:\t\t" + first_name + "\n" +
				 "性別 M/F:\t\t\t\t" + Utils.isGender(gender) + "\n" +
				 "電話 phone:\t\t\t\t" + cell + "\n" +
				 "電子郵件 email:\t\t\t" + email + "\n" +
				 "節目代碼 program:\t\t" + Utils.isProg_Code(program) + "\n" +
				 "專題 topic:\t\t\t\t" + Utils.isTop(topic) + "\n" +
				 "床位 bed:\t\t\t\t" + Utils.isBed(bed) + "\n" +
				 "接送 bus:\t\t\t\t" + Utils.isRide(bus) + "\n";

		return all;
	}
	
	public static void main(String[] args) 
	{
		//Participant p = new Participant("C_name", "E_Name", "Email Address");
		
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public Key getKey() {
		return key;
	}

	
}
