// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// 알 수 없는 에러가 발생했습니다.
  internal static let anUnknownErrorHasOccurred = L10n.tr("Localizable", "An unknown error has occurred.")
  /// 나쁨
  internal static let bad = L10n.tr("Localizable", "Bad")
  /// 즐겨찾기순
  internal static let byBookmark = L10n.tr("Localizable", "by Bookmark")
  /// 최신순
  internal static let byRecent = L10n.tr("Localizable", "by Recent")
  /// 제목순
  internal static let byTitle = L10n.tr("Localizable", "by Title")
  /// 취소
  internal static let cancel = L10n.tr("Localizable", "Cancel")
  /// 현재 걸음 수
  internal static let currentSteps = L10n.tr("Localizable", "Current steps")
  /// 현재 걸은 거리
  internal static let currentWalkingDistance = L10n.tr("Localizable", "Current walking distance")
  /// 건강 App 권한이 없습니다.
  internal static let doNotHaveHealthAppPrivileges = L10n.tr("Localizable", "Do not have Health App privileges.")
  /// 정보가 표시되지 않나요?
  internal static let donTYouHaveAnyInformation = L10n.tr("Localizable", "Don't you have any information?")
  /// 오늘 마신
  internal static let drunkTodayS = L10n.tr("Localizable", "drunk today's")
  /// 내안의먼지
  internal static let dustInsideMe = L10n.tr("Localizable", "Dust inside me")
  /// query문 실행이 실패했습니다.
  internal static let executionOfQueryStatementFailed = L10n.tr("Localizable", "Execution of query statement failed.")
  /// 미세먼지
  internal static let fineDust = L10n.tr("Localizable", "Fine dust")
  /// 전체 목록
  internal static let fullList = L10n.tr("Localizable", "Full list")
  /// 좋음
  internal static let good = L10n.tr("Localizable", "Good")
  /// 건강 App
  internal static let healthApp = L10n.tr("Localizable", "Health App")
  /// 건강 App 권한이 아직 설정되지 않았습니다.
  internal static let healthAppPermissionsNotYetSet = L10n.tr("Localizable", "Health App permissions not yet set.")
  /// 정보
  internal static let info = L10n.tr("Localizable", "Info")
  /// 위치 권한
  internal static let location = L10n.tr("Localizable", "Location")
  /// 메인
  internal static let main = L10n.tr("Localizable", "Main")
  /// 보통
  internal static let normal = L10n.tr("Localizable", "Normal")
  /// 맞춤 정보 추천
  internal static let optimizedInformation = L10n.tr("Localizable", "Optimized information")
  /// 네트워크 연결을 확인해 주세요.
  internal static let pleaseCheckYourNetworkConnection = L10n.tr("Localizable", "Please check your network connection.")
  /// 미세먼지 관련 정보를 어떤 순서로 정렬할까요?
  internal static let pleaseChooseHowToSortInformation = L10n.tr("Localizable", "Please choose how to sort information.")
  /// 위치 권한을 확인해 주세요.
  internal static let pleaseVerifyYourLocationPermissions = L10n.tr("Localizable", "Please verify your location permissions.")
  /// 정렬 방식 선택
  internal static let sortingMethod = L10n.tr("Localizable", "Sorting method")
  /// 통계
  internal static let stats = L10n.tr("Localizable", "Stats")
  /// 걸음
  internal static let steps = L10n.tr("Localizable", "steps")
  /// 오늘
  internal static let today = L10n.tr("Localizable", "Today")
  /// 초미세먼지
  internal static let ultrafineDust = L10n.tr("Localizable", "Ultrafine dust")
  /// 알 수 없음
  internal static let unknown = L10n.tr("Localizable", "Unknown")
  /// 매우 나쁨
  internal static let veryBad = L10n.tr("Localizable", "Very bad")
  /// 일주일\n평균
  internal static let weeklyAverage = L10n.tr("Localizable", "Weekly\naverage")
  /// 주간 흡입량
  internal static let weeklyInhalationDose = L10n.tr("Localizable", "Weekly inhalation dose")
  /// 주간 흡입량 비율
  internal static let weeklyRateOfInhalation = L10n.tr("Localizable", "Weekly rate of inhalation")
  /// 정보를 확인하려면 건강 앱 및 위치에 대한 권한을 허용해야 합니다.
  internal static let youMustAllowPermissionForHealthAppAndLocationToViewInformation = L10n.tr("Localizable", "You must allow permission for health app and location to view information.")

  internal enum DustInsideMeNeedAuthorityToTheHealthApp {
    /// '내안의먼지'는 건강 App에 대한 권한이 필요합니다. 건강 App -> 데이터소스 -> 내안의먼지 -> 모든 쓰기, 읽기 권한을 허용해주세요.
    internal static let healthAppDataSourcesDustInsideMeAllowAllWriteAndReadPermissions = L10n.tr("Localizable", "'Dust inside me' need authority to the Health App. Health App -> Data Sources -> Dust inside me -> Allow all write and read permissions.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
