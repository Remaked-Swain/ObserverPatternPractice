#  Observer Pattern Practice
옵저버 패턴 학습을 위한 예제입니다.

### **옵저버 패턴이란?**
'주체'라는 객체가 '관찰자'라고 하는 객체의 의존 목록을 유지하고,
메서드 중 하나를 호출하여 상태 변경을 자동으로 알리는 소프트에어 디자인 패턴이다.
* '주체'는 공유해야할 어떠한 상태값을 가지는 객체
* '관찰자'는 주체를 관찰하면서 상태값의 변경에 대하여 각자의 행동을 하는 객체

### **옵저버 패턴으로 해결할 수 있는 문제**
옵저버 패턴은 다음과 같은 문제를 해결할 수 있다.
다시 말하면 다음의 상황에서 옵저버 패턴의 적용을 고려해볼 수 있다.
1. 연관된 객체 간의 결합도를 낮추고 코드의 유연성을 제공해야 할 때
2. 어떤 객체의 상태 변화에 대하여 다른 객체도 자동 업데이트 필요할 때
3. 한 객체의 상태 변화에 대한 여러 객체들의 반응이 필요할 때

### **옵저버 패턴의 장점과 단점**
* 장점
    * 간단한 코드로도 관찰 로직을 만들 수 있다.
    * 결합도를 느슨하게 만들 수 있다.
    * 새로운 옵저버의 추가, 삭제가 간편하다.
* 단점
    * Lapsed Listener Problem 발생을 주의하여야 한다.
    * 모델의 잦은 변경에 부하가 심할 수도 있으니 그러한 처리를 해줘야 할 수도 있다.

> 아래부터는 '주체'를 '퍼블리셔', '관찰자'를 '옵저버'로 표현한다.

## 주요 구성
옵저버 패턴을 구성하는 주요 객체와 인터페이스는 다음과 같다.

### MessagePublisherProtocol

```swift
protocol MessageUpdatable {
    // 고유의 상태 저장
    func updateMessage(to message: String)
}

protocol ObserverAddable {
    // 옵저버 등록
    func addObserver(with observer: MessageObserverProtocol)
}

protocol ObserverRemovable {
    // 옵저버 제거
    func removeObserver(with observer: MessageObserverProtocol)
}

protocol MessagePublisherProtocol: ObserverAddable, ObserverRemovable, MessageUpdatable {
    // 옵저버 의존 목록 관리
    var observers: [MessageObserverProtocol] { get }
}
```

> 퍼블리셔의 역할을 추상화

### MessageObserverProtocol

```swift
protocol MessageObservable {
    // Publisher의 상태 추적, 감시
    func observe(message: String)
}

protocol MessageObserverProtocol: MessageObservable {
    // Publisher가 자신을 식별할 수 있도록 식별자 제공
    var identifier: UUID { get }
}
``` 

> 옵저버의 역할을 추상화

### MessageBox

```swift
final class MessageBox: MessagePublisherProtocol {
    // 옵저버 의존 목록 관리
    var observers: [MessageObserverProtocol] = []
    
    // UITextField에서 작성한 메세지 보관
    private var recentMessage: String? = nil {
        didSet {
            observers.forEach { observer in
                observer.observe(message: recentMessage ?? String())
            }
        }
    }
    
    // 옵저버 등록
    func addObserver(with observer: MessageObserverProtocol) {
        observers.append(observer)
    }
    
    // 옵저버 추가
    func removeObserver(with observer: MessageObserverProtocol) {
        observers = observers.filter { $0.identifier != observer.identifier }
    }
    
    // UITextField의 메세지 수신
    func updateMessage(to message: String) {
        recentMessage = message
    }
}
```

> 퍼블리셔 역할을 수행할 실제 구현체
> UITextField의 text를 보관하고 그 값의 변경에 대하여 옵저버에게 전달함

### CustomLabel

```swift
final class CustomLabel: UILabel, MessageObserverProtocol {
    let identifier: UUID
    
    init(identifier: UUID) {
        self.identifier = identifier
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("사람살려")
    }
    
    deinit {
        print("Label #\(identifier) Deinitialized")
    }
    
    // MessageBox의 최신 메세지로 업데이트
    func observe(message: String) {
        self.text = "구독자: \(message)"
    }
}

```

> 옵저버 역할을 수행할 실제 구현체
> 퍼블리셔로부터 호출된 메서드를 통해 어떠한 일을 수행
> UILabel의 기능 중 하나인 자신의 text를 바꾸는 것으로 구현
