# 디자인 패턴 - 어댑터패턴(Adapter Pattern)

## 개념
- **종류:** 구조 패턴
- **정의:** 서로 **호환되지 않는 인터페이스**를 가진 클래스들을 연결하기 위한 변환기 역할의 패턴
- **비유:** “아이폰 충전 어댑터” — 다른 규격의 플러그를 맞춰주는 중간 변환기

---

### 구조 구성도

| 역할 | 설명 |
|------|------|
| **Client** | Target 인터페이스를 통해 요청 |
| **Target (Interface)** | 클라이언트가 기대하는 인터페이스 |
| **Adapter** | Adaptee를 Target 인터페이스 형태로 변환 |
| **Adaptee** | 기존 클래스 (호환되지 않음) |

---

### 장점 / 단점

| 장점 | 단점 |
|------|------|
| 기존 코드 수정 없이 재사용 가능 | 코드 복잡도 증가 |
| 결합도 감소 | 성능 약간 저하 |

---

### 코드 예시 (객체 어댑터)

```java
public interface UsbTypeC {
    void transferData(String data);
}

public class MicroUsb {
    public void microUsbTransfer(String data) {
        System.out.println("MicroUSB 전송: " + data);
    }
}

public class MicroUsbToTypeCAdapter implements UsbTypeC {
    private final MicroUsb microUsb;

    public MicroUsbToTypeCAdapter(MicroUsb microUsb) {
        this.microUsb = microUsb;
    }

    @Override
    public void transferData(String data) {
        microUsb.microUsbTransfer(data);
    }
}
```