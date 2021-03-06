# Spring Bean
- [1. 스프링 빈 설정](#1-스프링-빈-설정)
  + [1-1. 스프링 빈 상속](#1-1-스프링-빈-상속)
  + [1-2. 빈에 Collection 타입 지정하기](#1-2-빈에-collection-타입-지정하기)
- [2. 스프링 빈 스키마 사용](#2-스프링-빈-스키마-사용)
  + [2-1. c-이름공간과 p-이름공간](#2-1-c이름공간과-p이름공간)
  + [2-2. util 스키마](#2-2-util-스키마)
- [3. 빈 설정 모듈화](#3-빈-설정-)
  

----------------------
### 1. 스프링 빈 설정

#### 1-1. 스프링 빈 상속
자바 클래스에서 자식 클래스가 부모 클래스를 상속받는 것과 마찬가지로 자바 빈에서도 빈끼리의 상속이 가능하다.  
주로 Bean들의 정의가 중복될 때 공통적인 속성을 모아 정의한 부모 Bean을 상속받는 형태로 쓰인다.

<b>추상 Bean</b> : 다른 Bean 정의의 부모 역할을 하는 Bean을 추상 Bean형태로 구현할 수 있다. 추상 Bean은 정의할 수 없는 형태로 프로퍼티나 생성자 인수로 주입은 불가능하다. 프로퍼티, 생성자 인수, 메서드 오버라이드, 초기화와 정리 메서드, 팩토리 메서드를 상속할 수 있다.

다음과 같이 abstract 속성이 true인 경우 추상 Bean이며 parent속성을 통해 부모 빈을 상속받는다.
```
	<bean id="serviceTemplate" abstract="true">
		<property name="dao" ref="dao"/>
		<property name="serviceType" value="fruit"/>
	</bean>
	
	<!-- serviceTemplate Bean의 정의를 상속받는 자식 Bean -->
	<bean id="serviceBean" class="service.BoardServiceImpl" parent="serviceTemplate">
		<property name="message" value="service1"></property> 
	</bean>		 
```

추상 Bean이 아닌 경우에도 상속할 수 있다.

다음과 같이 personService(자식 Bean)는 personServiceTemplet(부모 Bean)을 상속받는다. 이 경우 자식 Bean 클래스에서는 부모 Bean 클래스가 정의하고 있는 프로퍼티에 대한 setter 메서드를 반드시 정의해야 한다. 즉 service.PersonServiceImpl에 이를 정의하거나 service.PersonServiceImpl를 service.PersonServiceTemplate를 상속시켜 사용해야 한다.

```
	<bean id="person_dao" class="dao.PersonDaoImpl"></bean>
	
	<bean id="personServiceTemplet" class="service.PersonServiceTemplate">
		<property name="dao" ref="person_dao"></property>
		<property name="serviceType" value="person"></property>
	</bean>
	
	<bean id="personService" class="service.PersonServiceImpl" parent="personServiceTemplet">
		<property name="message" value="person-service"></property>
	</bean>
```
----------
#### 1-2. 빈에 Collection 타입 지정하기
빈의 Collection 타입의 프로퍼티나 생성자 인수를 설정하려면
property나 constructor-arg 엘리먼트의 &lt;list>, &lt;map>, &lt;set> 하위 엘리먼트를 각각 사용해야 한다.

다음은 Set타입을 프로퍼티나 생성자 인수로 주입시키는 경우이다. &lt;value>를 통해 원소를 지정할 수 있다.
```
	<!-- Set을 setter를 통해 주입시킨 mySetBean -->
	<bean id="mySetBean" class="ex.MySet">
		<property name="set">
			<set>
				<value>set1-1</value>
				<value>set1-2</value>
				<value>set1-3</value>
			</set>
		</property>
	</bean>
	
	<!-- Set을 생성자를 통해 주입시킨 mySetBean2 -->
	<bean id="mySetBean2" class="ex.MySet">
		<constructor-arg>
			<set>
				<value>set2-1</value>
				<value>set2-2</value>
				<value>set2-3</value>
			</set>
		</constructor-arg>
	</bean>
```

다음은 Map 타입을 프로퍼티로 주입시키는 경우이다.   
&lt;map>의 하위 엘리먼트로 &lt;entry>를 선언하여 그 안의 &lt;key>를 통해 key값을 설정하고 그에 따른 value를 설정할 수 있다.  
 컬렉션의 원소들은 &lt;ref bean="">을 통해 bean을 참조할 수 있으며 bean의 id또한 &lt;idref bean="">를 통해 참조 가능하다.   
 또한 &lt;null>을 통해 null로 설정또한 가능하다.
```
	<!-- 다음과 같이 컬렉션 타입에 빈 참조와 참조하는 빈의 id, null을 넣을 수 있다. -->
	<bean id="str1" class="java.lang.String"><constructor-arg value = "key1"></constructor-arg></bean>
	<bean id="str2" class="java.lang.String"><constructor-arg value = "value2"></constructor-arg></bean>
	<bean id="key3" class="java.lang.String"><constructor-arg value = "value3"></constructor-arg></bean>
	
	<bean id="myMapBean2" class="ex.MyMap">
		<property name="map">
			<map>
				<entry>
					<key><ref bean="str1"/></key>	<!-- 빈을 참조함 -->
					<value>value1</value>
				</entry>
				<entry>
					<key><value>key2</value></key>
					<ref bean="str2"/>	<!-- 빈을 참조함 -->
				</entry>
				<entry>
					<key><idref bean="key3"></idref></key>	<!-- <idref>를 통해 빈의 id를 참조함 -->
					<ref bean="key3"/>	<!-- 빈의 value를 참조함 -->
				</entry>
				<entry>
					<key><value>key3</value></key>
					<null/>	<!-- null 사용 -->
				</entry>
			</map>
		</property>
	</bean>
```
---------------

### 2. 스프링 빈 스키마 

다음과 같이 bean의 xmlns 속성을 통하여 스키마를 사용함을 설정한다. 이를 통해 스키마들을 사용할 수 있다.
```
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:c="http://www.springframework.org/schema/c"
	xmlns:util="http://www.springframework.org/schema/util"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd">
```
#### 2-1. c-이름공간과 p-이름공간

Consturctor-arg와 Property를 대체하여 Bean 설정을 간결하게 할 수 있다.    
다음과 같이 빈을 참조할 경우에는 <property-name>-ref=<bean-reference>의 형태로 명시한다.

```
	<bean id="dao_message" class="java.lang.String">
	  <constructor-arg value = "this is dao value"/>
	</bean>
	
	<!-- c-이름공간을 통해 constructor-arg 사용하기 -->
	<bean id="board_dao" class="dao.BoardDaoImpl"
		c:dao_message-ref="dao_message"/>
		
	<!-- p-이름공간을 통해 property 사용하기 -->
	<bean id="board_service" class="service.BoardServiceImpl"
		p:message="this is message" p:dao-ref="board_dao"/>
```
#### 2-2. util 스키마

util 스키마를 이용하면 여러가지 엘리먼트들을 설정하기 용이하다.    
&lt;list>,&lt;map>,&lt;set>,&lt;constant>,&lt;properties>등의 빈 인스턴스를 생성할 수 있다.

```
	<util:list id="list_type" list-class="java.util.ArrayList">
		<value>List value1</value>
		<value>List value2</value>
	</util:list>
	
	<util:map id="map_type" map-class="java.util.HashMap">
		<entry key="map key 1" value = "map value 1"/>
		<entry key="map key 2" value = "map value 2"/>
	</util:map>
	
	<util:set id="set_type" set-class="java.util.HashSet">
		<value>Set value1</value>
		<value>Set value2</value>
	</util:set>
	
	<util:constant id="boolTrue" static-field="java.lang.Boolean.TRUE"/> 
```
--------
### 3. 빈 설정 모듈화

```
<import resource="util_schema.xml"/>
```
다음과 같이 xml파일에서 다른 xml파일을 import시킬 수 있다. 이를 통하여 기능별로 빈 설정파일의 모듈화가 가능해지며 의존관계의 설정이 용이해진다.
