package test.example2;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import test.mypac.Weapon;


public class MainClass {
	public static void main(String[] args) {
		// init.xml 문서를 해석해서 bean 을 생성한다.
		ApplicationContext context=
				new ClassPathXmlApplicationContext("test/example2/init.xml");//로딩할 xml 문서의 위치를 알려주는 것
		//스프링이 관리하고 있는 객체중에서 "myWeapon" 이라는 이름의 객체의
		//참조값을 가지고 와서 Weapon type 으로 casting 해서 변수에 담는다.(우리가 알고 있는 타입(interface 타입)으로 캐스팅해서 사용)
		Weapon w1=(Weapon)context.getBean("myWeapon");//리턴되는것은 object 타입(부모타입으로 리턴해줌)
		//Weapon type 객체를 이용해서 원하는 동작을 한다.
		useWeapon(w1);
	}
	public static void useWeapon(Weapon w) {
		w.attack();
	}
}
