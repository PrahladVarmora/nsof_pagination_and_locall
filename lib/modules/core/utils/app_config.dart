/// It's a Dart class that has a single static method called `fromJson` that takes a `Map<String,
/// dynamic>` and returns an instance of the class
class AppConfig {
  static const String baseUrl = 'https://api.github.com/users/JakeWharton/';

  ///Header Key and Value
  static const String xContentType = 'Content-Type';
  static const String xApplicationJson = 'application/json';
  static const String xAcceptDeviceType = 'accept-device-type';
  static const String xAcceptAppVersion = 'accept-version';
  static const String xAcceptType = 'Accept-type';
  static const String xAcceptDeviceIOS = '1';
  static const String xAcceptDeviceAndroid = '2';

  static const String pageLimit = '15';
  static const int pageLimitCount = 15;

  ///API NAME
  static String apiRepos = '${baseUrl}repos?page={#}&per_page={#}';

  ///Data base
  static const String tableDashboardList = 'dashboard_list';
  static const String dashboardListId = 'id';
  static const String dashboardListName = 'name';
  static const String dashboardListAvatarUrl = 'avatar_url';
  static const String dashboardListDescription = 'description';
  static const String dashboardListWatchersCount = 'watchers_count';
  static const String dashboardListLanguage = 'language';
  static const String dashboardListHasIssues = 'has_issues';
  static const String dashboardListOpenIssuesCount = 'open_issues_count';
}
