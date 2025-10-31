# 디자인 패턴 - 싱글톤 패턴(Singleton Pattern)

### 개념
- **종류:** 생성 패턴
- **정의:** 클래스의 인스턴스를 **오직 하나만 생성**하도록 보장하고, **전역적으로 접근**할 수 있게 하는 패턴
- **활용 예시:** 로그 관리, DB 연결, 스레드 풀 등 시스템 전역에서 동일한 자원을 공유해야 할 때 사용

---

### 장점 / 단점

| 장점 | 단점 |
|------|------|
| 메모리 절약 (인스턴스 1개만 생성) | 테스트 어려움 (전역 상태로 인한 의존성) |
| 전역 접근 가능 (편리한 참조) | 결합도 증가, 유연성 저하 |
| 상태 공유 용이 | 멀티스레드 환경에서 동기화 필요 |

---

### 구현 방식

#### 1. Lazy Initialization (지연 초기화)
- 인스턴스가 **처음 필요할 때 생성**하는 방식
- 단일 스레드 환경에서는 간단하지만, 멀티스레드에서는 **Thread-Safe하지 않음**

```java
public class LazySingleton {
    private static LazySingleton instance;

    private LazySingleton() {}

    public static LazySingleton getInstance() {
        if (instance == null) {
            instance = new LazySingleton();
        }
        return instance;
    }
}
```
#### 2. Double-Checked Locking (이중 검사 잠금)
- 멀티스레드 환경에서도 안전하게 인스턴스를 한 번만 생성
- volatile 키워드를 통해 CPU 캐시 동기화 문제 해결

``` java
public class ThreadSafeSingleton {
    private static volatile ThreadSafeSingleton instance;

    private ThreadSafeSingleton() {}

    public static ThreadSafeSingleton getInstance() {
        if (instance == null) {
            synchronized (ThreadSafeSingleton.class) {
                if (instance == null) {
                    instance = new ThreadSafeSingleton();
                }
            }
        }
        return instance;
    }
}
```

#### 3. Holder Pattern (가장 권장되는 방법)
- JVM의 클래스 로딩 시점을 이용한 Lazy Initialization 방식
- 동기화 코드가 없어도 Thread-Safe하며, 가장 간결하고 효율적

```java
public class Singleton {
    private Singleton() {}

    private static class Holder {
        private static final Singleton INSTANCE = new Singleton();
    }

    public static Singleton getInstance() {
        return Holder.INSTANCE;
    }
}
```
