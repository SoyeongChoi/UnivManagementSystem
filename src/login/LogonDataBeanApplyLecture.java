package login;

public class LogonDataBeanApplyLecture {

   private Float grade;
   private Float midterm;
   private Float finals;
   private Float attend;
   private String studentID;
   private String subjectCode;
   private String professorID;
   private int semester;
   
   public Float getGrade() {
      return grade;
   }
   public void setGrade(Float grade) {
      this.grade = grade;
   }
   public Float getMidterm() {
      return midterm;
   }
   public void setMidterm(Float midterm) {
      this.midterm = midterm;
   }
   public Float getFinals() {
      return finals;
   }
   public void setFinals(Float finals) {
      this.finals = finals;
   }
   public Float getAttend() {
      return attend;
   }
   public void setAttend(Float attend) {
      this.attend = attend;
   }
   public String getStudentID() {
      return studentID;
   }
   public void setStudentID(String studentID) {
      this.studentID = studentID;
   }
   public String getSubjectCode() {
      return subjectCode;
   }
   public void setSubjectCode(String subjectCode) {
      this.subjectCode = subjectCode;
   }
   public String getProfessorID() {
      return professorID;
   }
   public void setProfessorID(String professorID) {
      this.professorID = professorID;
   }
   public int getSemester() {
      return semester;
   }
   public void setSemester(int semester) {
      this.semester = semester;
   }
}