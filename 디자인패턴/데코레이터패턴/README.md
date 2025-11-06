# 데코레이터(Decorator) 패턴

## 개념

- 구조 패턴
- 객체에 추가적인 기능을 **동적으로 부여**할 수 있도록 설계
- 상속보다 유연하게 기능을 확장할 수 있음
- 원본 객체를 감싸(wrap) 새로운 기능을 덧붙이는 구조

## 구조

- **Component**: 기본 인터페이스나 추상 클래스
- **ConcreteComponent**: 실제 기능을 수행하는 객체
- **Decorator**: Component를 상속받아, 감쌀 객체의 참조를 가짐
- **ConcreteDecorator**: 추가 기능을 정의하는 클래스

## 예시 코드 (Java)

```java
interface Coffee {
    String getDescription();
    int cost();
}

class BasicCoffee implements Coffee {
    public String getDescription() { return "Basic Coffee"; }
    public int cost() { return 3000; }
}

class MilkDecorator implements Coffee {
    private Coffee coffee;
    public MilkDecorator(Coffee coffee) { this.coffee = coffee; }
    public String getDescription() { return coffee.getDescription() + ", Milk"; }
    public int cost() { return coffee.cost() + 500; }
}

public class Main {
    public static void main(String[] args) {
        Coffee coffee = new MilkDecorator(new BasicCoffee());
        System.out.println(coffee.getDescription() + " : " + coffee.cost());
    }
}
```
