package vo;

//# VO (Value Object) 클래스
//Database를 통해 가져오고자 하는 정보들을 하나로 묶어서 저장하는 클래스를 VO라고한다.
public class PersonVO {
	private String name;
	private int age;
	private String tel;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
}
