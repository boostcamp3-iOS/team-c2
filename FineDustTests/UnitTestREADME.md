
## 어떠한 기능에 대하여...

1. 프로토콜을 만들고 요구 메소드 및 프로퍼티 등 정의
2. 클래스는 1에서 만들어진 프로토콜을 준수하고 빌드가 가능하게끔만 구현
3. 2에서 정의한 메소드 및 프로퍼티 등을 테스트하는 테스트 함수를 만듦(test....())
4. Mock 만듦
5. 테스트 케이스 정의
6. 테스트 실패를 먼저 확인
7. 테스트가 성공하도록 2의 함수 구현 변경.

---

IntakesGenerator 테스트 클래스 만들어서 테스트하기

Mock은 유닛테스트 내부에 클래스 따로 만들어서 정의하기

coverage

비동기 메소드에 대해서는 다른 방법 적용 fulfill?

비즈니스 로직의 커버리지를 극대화.

ViewController를 Controller가 아닌 View로 바라보아, Controller에 위치한 비즈니스 로직을 Manager(Service / Helper)로 옮김
ViewModel 개념으로 생각해도 괜찮음

# heatlKit에서 나오는 에러 적어 놓겠습니다.

// 성공
HKNoError = 0

// 장치에서 제한 받음
HKErrorHealthDataUnavailable = 1

// 장치에서 제한 받음
HKErrorHealthDataRestricted = 2

// API에 유효하지 않은 인자가 들어옴
HKErrorInvalidArgument = 3

// 요청한 작업에 대한 권한을 사용자가 거부함
HKErrorAuthorizationDenied = 4

// 사용자가 권한을 결정하지 않음
HKErrorAuthorizationNotDetermined = 5

// 필요한 데이터 타입에 접근하는 권한을 사용자가 거부함
HKErrorAuthorizaionDenied = 6

// 데이터가 보호되고 있거나 장치가 잠겨있어 데이터를 이용할 수 없음
HKErrorDatabaseInaccesible = 7

// 동작 중에 사용자가 취소함
HKErrorUserCanceld = 8

// 세션이 시작될 때 다른 앱이 실행됨
HKErrorAnotherWorkoutSessionStarted = 9

// 세션이 동작하고 있는 중에 사용자가 앱을 종료함
HKErrorUserExitedWorkoutSession = 10