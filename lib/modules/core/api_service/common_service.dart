import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/common_import.dart';

/// It takes a string and prints it out in chunks of 800 characters
///
/// Args:
///   text (String): The text to be printed.
void printWrapped(String text) {
  /// 800 is the size of each chunk
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

/// It returns the context of the navigator key
///
/// Returns:
///   The current context of the navigator key.
BuildContext getNavigatorKeyContext() {
  return NavigatorKey.navigatorKey.currentContext!;
}

///[randomImage] This method use to random Image
String randomImage() {
  var rng = Random();
  return "https://picsum.photos/500/500?random=${rng.nextInt(500)}";
}

/// A [checkConnectivity] widget is a widget that describes part of check Connectivity
Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

/// A [getFileImageSize] is a method that calculates MB from bytes
double getFileImageSize(var bytes) {
  final mb = bytes / (1024 * 1024);
  return mb;
}

/// A [isInteger] method is a check Integer value
bool isInteger(num value) => value is int || value == value.roundToDouble();

/// A [validatePhone] widget is a widget that describes part of validate Phone number
bool validatePhone(String data) =>
    RegExp(r'(^(?:[+0]9)?[0-9]{8,12}$)').hasMatch(data);

/// A [validateEmail] widget is a widget that describes part of validate Phone number
bool validateEmail(String data) => RegExp(
        r'^[a-z0-9](\.?[a-z0-9_-]){0,}@[a-z0-9-]+\.([a-z]{2,6}\.)?[a-z]{2,6}$')
    .hasMatch(data);

/// A [validatePassword] widget is a widget that describes part of validate Phone number
bool validatePassword(String data) => RegExp(
        r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$)')
    .hasMatch(data);

/// A [checkIsValidUrl] widget is a widget that describes part of validate URL
bool checkIsValidUrl(String value) {
  var isValid = false;
  if (RegExp(
          r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)")
      .hasMatch(value)) {
    isValid = true;
  }
  return isValid;
}
