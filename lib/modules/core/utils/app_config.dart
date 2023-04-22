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
  static const String xUserTimeZone = 'user_tz';

  static const String pageLimit = '10';
  static const int pageLimitCount = 10;

  ///API NAME
  static String apiRepos = '${baseUrl}repos?page={#}&per_page={#}';
}
