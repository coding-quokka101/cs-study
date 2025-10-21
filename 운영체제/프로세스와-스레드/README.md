# 운영체제 - 프로세스와 스레드

## 키워드

**프로세스(Process)**

- 실행 중인 프로그램 단위
  - 코드, 데이터, 스택, 힙 등 메모리 자원을 가짐
  - 독립적인 주소 공간을 가짐

**스레드(Thread)**

- 프로세스 내 실행 단위
  - 코드, 데이터, 힙은 공유
  - 스택은 개별적으로 가짐

**멀티프로세스(Multi-Process)**

- 여러 프로세스가 독립적으로 실행됨
  - 각 프로세스는 자체 주소 공간과 자원을 가짐
  - 안전성 높음
  - 실행 속도 상대적으로 느림
  - 프로세스 간 통신(IPC, Inter-Process Communication)이 필요

**멀티스레드(Multi-Thread)**

- 한 프로세스 내에서 여러 스레드가 실행됨
  - 코드, 데이터, 힙 공유
  - 스택은 개별적
  - 실행 속도 빠름
  - race condition 등 동기화 문제 발생 가능
  - 동기화 기법(Critical Section, Mutex 등) 필요

**Context Switching(문맥 교환)**

- CPU가 한 프로세스/스레드에서 다른 것으로 전환하는 과정

  - 실행 상태 저장 및 복원
  - 비용 발생, 성능에 영향

## 질문과 답변

### 1. 프로세스와 스레드의 차이점(용도, 자원 공유 방식 등)

- **프로세스**
  - 독립적인 메모리 공간을 갖는다.
  - 다른 프로세스와 자원을 공유하지 않는다.
  - 생성/종료 비용이 크다.
  - 서로 완전히 독립된 프로그램 실행
    - ex) 브라우저, 워드, 게임 등 각각의 앱
  - 안정성이 중요할 때 사용
- **스레드**
  - 같은 프로세스 내에서 메모리를 공유한다.
  - 힙, 데이터, 코드 영역을 공유한다.
  - 스택 영역만 독립적으로 갖는다.
  - 생성/종료 비용이 작다.
  - 병렬 처리, 동시성 작업
    - ex) 웹브라우저 → 각 탭이 스레드로 동작
    - ex) 워드 프로세서 → UI 스레드, 저장 스레드, 자동 저장 스레드
  - 성능이 중요할 때, 자원 공유가 필요할 때 사용

### 2. 프로세스 끼리 어떻게 통신하는가?

- **IPC(Inter-Process Communication) 방식**

  - 운영체제에서 제공하는 방식
  - 파이프(Pipe)
    - 단방향 통신(한쪽은 쓰기, 다른 쪽은 읽기)
    - 부모-자식 프로세스 관계에서 주로 사용됨
    - ex) `ls | grep txt` 같은 리눅스 파이프 명령어
  - 메시지 큐(Message Queue)
    - 운영체제 커널이 관리하는 큐 구조
    - 여러 프로세스가 메시지를 큐에 넣고, 다른 프로세스가 꺼내는 방식
    - 동기/비동기 모두 가능, 우선순위 메시지 처리 지원
  - 공유 메모리(Shared Memory)
    - 프로세스들이 특정 메모리 영역을 함께 공유
    - 가장 빠른 IPC 방식
    - 동기화 문제 있음
  - 소켓 (Socket)
    - 네트워크 통신에 사용되지만, 같은 PC 내에서도 IPC 가능
    - TCP/UDP 기반
    - 서버-클라이언트 모델에 적합

### 3. Race Condition이란?

- 여러 프로세스/스레드가 공유 자원에 동시 접근할 때 발생하는 문제 상황
- 임계 구역(Critical section)

  - 공유 자원 접근 순서에 따라 실행 결과가 달라지는 프로그램의 코드 영역
  - 임계 구역 안에서 Race condition이 발생

- ex) 두 스레드가 같은 변수에 동시에 접근하여 값을 증가시킬 때

  ```
  x = 0

  1. 스레드 A: x 읽음 (0)
  2. 스레드 B: x 읽음 (0)
  3. A: x+1=1 저장

  x = 1

  4. B: x+1=1 저장 (A의 결과 덮어씀)

  x = 1 (예상 값 x = 2)
  ```

  - 실행 순서에 따라 결과가 달라진다.
  - 데이터 일관성이 깨진다.

### 4. Race Condition을 막는 방법

- 동기화(Synchronization)를 통해 자원 접근을 제어해야 함

- 어셈블리 언어 수준의 자원 동기화 방식

  - 뮤텍스 락(Mutex Lock, 상호 배제)

    - 동시에 하나의 스레드만 접근 가능
    - 단순하고 안전하지만 락을 얻기 위한 대기 시간으로 성능 저하 가능
    - Java의 `synchronized`: 락 획득/해제 자동 처리

      ```java
      class Account {
      private int balance = 100;

          public synchronized void deposit(int amount) {
              balance += amount; // Critical Section
          }

          public synchronized void withdraw(int amount) {
              balance -= amount; // Critical Section
          }

          public int getBalance() { return balance; }

      }
      ```

    - Java의 `ReentrantLock`: 락 획득/해제를 프로그래머가 직접 관리

      ```java
      Lock lock = new ReentrantLock();

      lock.lock();
      try {
          // critical section
      } finally {
          lock.unlock();
      }
      ```

  - 세마포어(Semaphore)
    - 여러 스레드가 동시에 접근 가능 (제한된 수)
    - 여러 개의 공유 자원을 동시에 관리

- 고급 언어에서의 자원 동기화 방식
  - 모니터
    - 객체 단위 임계 구역 보호
    - 조건에 따른 스레드 대기/신호 가능

### 5. 다중 CPU일 때 동시 처리 가능한 것은 프로세스 수인가, 스레드 수인가?

- 프로세스도 메인 스레드를 가지므로 둘 다 가능함
- 궁극적으로 **스레드 수**이다.
  - CPU 코어마다 하나의 스레드가 동시 실행
  - 프로세스는 스레드의 집합
  - 4코어 CPU에서는 최대 4개의 스레드가 동시 실행 가능

### 6. 멀티스레드를 사용하는 이유는 무엇인가?

- 성능 향상

  - 병렬 처리로 작업 속도가 빨라진다.
  - CPU 활용도가 높아진다.
  - 컨텍스트 스위칭 비용이 프로세스보다 적다.
    - 컨텍스트 스위칭: 운영체제가 CPU에서 실행 중인 작업(프로세스나 스레드)을 다른 작업으로 교체하는 과정
    - 스레드에서는 같은 주소 공간을 공유
    - 교체가 필요 없거나 적음

- 자원 공유
  - Heap 영역을 이용하여 데이터를 주고받을 수 있다.
  - 프로세스 간 통신보다 빠르다.
- 응답성 향상
  - UI 스레드와 작업 스레드를 분리할 경우 반응성이 좋아진다.

### 7. 멀티스레드에서 Critical Section 동기화 기법이란 무엇인가?

- Critical Section
  - 병렬적 실행에서, 프로세스 코드 중 공유 data에 접근하는 부분
- 동기화는 공유 자원에 접근하는 프로세스를 제어하여 안정성을 보장하는 기법이다.
- 어떤 타이밍에 Critical Section의 코드를 실행중인 프로세스는 단 하나뿐이어야한다.
- 만약 두 개 이상의 프로세스가 Critical Section의 코드를 실행중이라면 Race Condition(경쟁 조건) 이 발생한다.

### 8. 프로세스 스케줄링이란?

- CPU를 할당하는 방법(CPU 스케줄링)
  - CPU가 여러 프로세스 중 어떤 것을 언제 실행할지 순서를 결정
  - 목표
    - 처리량(Throughput) 증가
    - 응답 시간(Response Time) 최소화
    - 공정성 보장

### 9. 프로세스 스케줄링 방식

- **선점형(Preemptive) 스케줄링**

  - CPU를 이미 실행 중인 프로세스에서 강제로 빼앗아 다른 프로세스에게 할당 가능
  - 장점
    - 높은 우선순위를 가진 프로세스들이 빠른 처리를 요구하는 시스템에서 유용함
    - 응답시간이 비교적 빠르다.
    - 대화식 시스템에 적합하다.
  - 단점
    - 나중에 들어오는 프로세스들이 높은 우선순위를 가지는 경우, 잦은 context switching으로 인한 오버헤드 발생
  - 대표 알고리즘
    - **SRT (Shortest Remaining Time First)**
      - SJF의 선점형 방식
      - 남은 CPU 처리 시간이 가장 짧은 프로세스가 우선 실행
      - CPU 처리 시간이 긴 프로세스인 경우, 기아 상태 발생 가능
    - **라운드 로빈(RR: Round Robin)**
      - 시간 단위(Time Quantum)로 CPU를 할당하여 응답 시간 예측 가능
      - Time Quantum 길면 FCFS와 유사, 짧으면 Context Switching 오버헤드 증가
      - Ready Queue는 원형 큐로 동작

- **비선점형(Non-Preemptive) 스케줄링**

  - 프로세스가 자발적으로 CPU를 반납할 때까지 실행
  - Aging 기법
    - Ready Queue에 머무르는 시간에 따라 우선순위를 높여주면 우선순위가 낮은 프로세스의 기아 상태를 방지할 수 있다.
  - 장점
    - 응답시간을 예상할 수 있다.
    - 모든 프로세스에 대한 요구를 공정하게 처리한다.
  - 단점
    - 짧은 작업을 수행하는 프로세스 앞에 긴 작업을 수행하는 프로세스가 있는 경우 평균 대기시간이 길어짐
  - 대표 알고리즘

    - **FCFS (First Come First Served)**
      - CPU를 먼저 요청한 순서대로 할당(FIFO)
      - 긴 CPU 처리 시간을 가진 프로세스가 CPU를 독점하면, 평균 대기시간이 길어짐
    - **SJF (Shortest Job First)**
      - CPU 처리 시간이 짧은 프로세스를 우선 실행
      - 평균 대기시간이 짧아짐
      - CPU 처리 시간이 긴 프로세스인 경우, 기아 상태 발생 가능
    - **Priority Scheduling**
      - 우선순위가 높은 프로세스 우선 실행
      - 우선순위 동일 시 선입선처리(FCFS)
      - 우선순위가 낮은 프로세스인 경우, 기아 상태 발생 가능(예: 대화형은 RR, 배치형은 FCFS)

  - 큐 사용
    - **Multi-Level Queue (MLQ, 다단계 큐)**
      - 프로세스를 여러 큐로 나눠 관리 (예: 상호작용형 > 배치형 > 시스템 프로세스)
      - 큐 간 우선순위가 고정
      - 각 큐 마다 다른 스케줄링 알고리즘 적용 가능
    - **Multi-Level Feedback Queue (MLFQ, 다단계 피드백 큐)**
      - 프로세스의 실행 시간/행동에 따라 동적으로 큐를 옮김
      - 짧은 작업은 빨리 끝내고, 긴 작업은 점점 낮은 큐로 밀려남
      - 각 큐 마다 다른 스케줄링 알고리즘 적용 가능(예: 상위 큐는 선점형 RR, 하위 큐는 FCFS)

### 10. Context Switching이 이루어지는 과정

- PCB에 현재 프로세스 상태 저장
  - PCB(Process Control Block): 운영체제가 각 프로세스의 상태와 정보를 관리하기 위해 사용하는 자료 구조
  - 레지스터, 프로그램 카운터, 스택 포인터 저장
- 새 프로세스의 상태를 PCB에 복원
  - 프로그램 카운터 세팅 후 실행 재개

### 11. 스레드를 사용하는 JAVA 코드의 예시

```
// 1. Thread 클래스 상속으로 스레드 사용
class MyThread extends Thread {
    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println(Thread.currentThread().getName() + ": " + i);
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

...

// Thread 클래스 사용
MyThread thread1 = new MyThread();
thread1.start();

```

- Thread 클래스를 상속하고 `run()`을 오버라이드
- `start()` 호출 시 새로운 스레드에서 `run()` 실행
- 간단하지만 다른 클래스를 상속할 수 없음

```
// 2. Runnable 인터페이스 구현으로 스레드 사용
class MyRunnable implements Runnable {
    @Override
    public void run() {
        for (int i = 0; i < 5; i++) {
            System.out.println(Thread.currentThread().getName() + ": " + i);
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

...

// Runnable 인터페이스 사용
Thread thread2 = new Thread(new MyRunnable());
thread2.start();

```

- Runnable 인터페이스를 구현하고 `run()` 작성
- `start()` 호출 시 현재 스레드에서 `run()` 실행
- 다중 상속 가능, 스레드 로직과 객체 분리 가능

```
public class ThreadExample {
    public static void main(String[] args) {
        // 동기화 예제
        Counter counter = new Counter();
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });
        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Final count: " + counter.getCount());
    }
}

// 동기화된 카운터 클래스
class Counter {
    private int count = 0;

    public synchronized void increment() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}

```

- `start()`
    - 새로운 스레드 실행 시작
    - `t1.start();`
        - run() 메서드를 새로운 스레드에서 실행하도록 스케줄러에 등록
- `join()`
    - 다른 스레드가 끝날 때까지 기다림
    - `t1.join();`, `t2.join();`
        - main 스레드는 t1과 t2가 완료될 때까지 대기
- `synchronized`
    - 동시 접근으로 인한 Race Condition 방지

```
class MyThread extends Thread {
    public void run() {
        System.out.println("Thread running: " + Thread.currentThread().getName());
    }

    public static void main(String[] args) {
        MyThread t1 = new MyThread();
        MyThread t2 = new MyThread();
        t1.start();  // 새로운 스레드 시작
        t2.start();
    }
}

```

- start() → OS가 스레드 생성 요청
- run() → 실제 스레드가 실행하는 코드

```
class MyThread extends Thread {
    public void run() {
        System.out.println("Thread 실행 중");
    }
}

public class Main {
    public static void main(String[] args) {
        MyThread t1 = new MyThread();
        t1.start();
    }
}

```
