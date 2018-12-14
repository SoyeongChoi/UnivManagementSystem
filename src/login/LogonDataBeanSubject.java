package login;

public class LogonDataBeanSubject {
	private String subject_code; 
	private String subject_name; 
	private int year;//학년
	private int creditnum;//학점시수
	private String major;//학과
	private String course;//이수분야
	private String semester;//학기
	private int people_num;
	private String class_num;//분반
	private String professor_id;
	
	public String getProfessor_id() {
		return professor_id;
	}
	public void setProfessor_id(String professor_id) {
		this.professor_id = professor_id;
	}
	public String getSubject_code() {
		return subject_code;
	}
	public void setSubject_code(String subject_code) {
		this.subject_code = subject_code;
	}
	public String getSubject_name() {
		return subject_name;
	}
	public void setSubject_name(String subject_name) {
		this.subject_name = subject_name;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getCreditnum() {
		return creditnum;
	}
	public void setCreditnum(int creditnum) {
		this.creditnum = creditnum;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public int getPeople_num() {
		return people_num;
	}
	public void setPeople_num(int people_num) {
		this.people_num = people_num;
	}
	public String getClass_num() {
		return class_num;
	}
	public void setClass(String class1) {
		class_num = class1;
	}
	
}
