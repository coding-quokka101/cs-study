# 디자인 패턴 - 템플릿 메소드 패턴(Template Method Pattern)

### 개념
- **종류:** 행위 패턴
- **정의:** 알고리즘의 전체 구조를 상위 클래스에 정의하고, 일부 단계를 하위 클래스에서 재정의하는 패턴
- **비유:** “피자 만들기” – 반죽/굽기 방식은 동일, 토핑만 다름

---

### 구조

| 역할 | 설명 |
|----|----|
| AbstractClass | 알고리즘의 틀(템플릿) 정의 |
| ConcreteClass | 구체적인 단계 구현 |
| Client | 템플릿 메소드 호출 |


---

### 장점 / 단점

| 장점 | 단점  |
|---- |-----|
| 중복 코드 제거, 구조 일관성 유지 | 상속 구조로 유연성 낮음 |
| 유지보수 용이 | 자식 클래스 복잡성 증가 |

---

### 예시 코드
```java
abstract class Pizza {
    protected void 반죽() { System.out.println("반죽!"); }
    abstract void 토핑();
    protected void 굽기() { System.out.println("굽기!"); }

    final void makePizza() { // 수정 불가
        반죽();
        토핑();
        굽기();
    }
}

class PotatoPizza extends Pizza {
    @Override
    void 토핑() { System.out.println("감자 토핑!"); }
}
```