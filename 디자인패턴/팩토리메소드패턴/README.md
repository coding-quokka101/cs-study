# 디자인 패턴 - 팩토리메소드 패턴(Factory Method Pattern)


### 개념
- **종류:** 생성 패턴
- **정의:** 객체 생성 로직을 서브클래스에 위임하여, 객체 생성과 사용을 분리하는 패턴
- **핵심:** “생성 책임을 하위 클래스에게 위임”

---

### 구조

| 역할 | 설명              |
|---|-----|
| Product | 생성될 객체의 인터페이스   |
| ConcreteProduct | 구체적인 제품 클래스     |
| Creator (Factory) | 객체 생성을 위한 인터페이스 |
| ConcreteCreator | 구체적인 팩토리 구현     |

---

### 장점 / 단점

| 장점             | 단점 |
|-----|---|
| OCP 준수 (확장 용이) | 클래스 수 증가로 복잡성 증가 |
| 객체 생성 코드 캡슐화   | 단순한 경우 오버엔지니어링 가능 |

---

### 예시 코드
```java
public abstract class RobotFactory {
    abstract Robot createRobot(String name);
}

public class SuperRobotFactory extends RobotFactory {
    @Override
    Robot createRobot(String name) {
        switch(name) {
            case "super": return new SuperRobot();
            case "power": return new PowerRobot();
        }
        return null;
    }
}
```
