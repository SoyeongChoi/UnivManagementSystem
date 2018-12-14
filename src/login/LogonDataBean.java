package login;
import java.sql.Timestamp;

public class LogonDataBean {
	private String id; //아이디
	private String passwd; //비밀번호
	private String name; //이름
	private String birth; //생일
	private String job; //직업
	//여기까지는 not null
	private String register;//학적
	private String major; //학생
	private String rSemester; //최근학기(학생)
	private float grade; //회占쏙옙占쏙옙占�
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
	public String getRecentSemester() {
		return rSemester;
	}
	public void setRecentSemester(String rSemester) {
		this.rSemester = rSemester;
	}
	
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public float getGrade() {
		return grade;
	}
	public void setGrade(float grade) {
		this.grade = grade;
	}


	
}
