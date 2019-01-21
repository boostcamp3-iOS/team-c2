# Swift Style Guide

## SwiftLint 사용

기본적으로 SwiftLint의 룰에서 `trailing_whitespace` 와 `leading_whitespace` 를 제외한 룰을 따릅니다.

1. 설치

```
brew install swiftlint
```

2. 적용
   - 프로젝트 파일 -> Targets - > Build Phases -> New Run Script Phases
   - Run Script를 열고 다음의 코드를 추가합니다.

```sh
if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

3. .swiftlint.yml 생성
   - 이 파일에서 기본 규칙에 대해 커스터마이징할 수 있고, 커스텀 룰도 만들 수 있습니다.
   - 자세한 내용은 [이곳](https://github.com/realm/SwiftLint/blob/master/README_KR.md)을 참고하세요.
   - 참고

```
disabled_rules:
- leading_whitespace
- trailing_whitespace

line_length:
  warning: 99
  error: 120
```

에러 기준을 99로 했더니 너무 빡셉니다ㅠ 경고를 최소화하는 방향으로 갑시다.

---

## StyleShare의 Swift Style Guide 따르기

[https://github.com/presto95/swift-style-guide](https://github.com/presto95/swift-style-guide)

최대한 준수해 주세요!

---

## 나머지

- 클래스 내 프로퍼티나 메소드의 순서
  1. `IBOutlet`
  2. `private` 이 아닌 프로퍼티
  3. `private` 프로퍼티
  4. Life Cycle 메소드
  5. `@objc` 메소드
  6. 나머지 메소드는 마크 주석과 익스텐션을 활용하여 잘 구분하기
  7. 프로토콜 구현부 : 익스텐션으로 빼기

등등 필요할 때마다 논의하여 추가하기