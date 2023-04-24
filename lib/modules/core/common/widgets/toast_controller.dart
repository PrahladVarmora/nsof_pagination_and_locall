import '../../utils/common_import.dart';

/// A [ToastController] widget is a widget that describes part of the user interface by ToastController
/// * [mModelStaffMember] which contains the Toast Text
/// * [BuildContext] which contains the Toast context
/// * [bool] which contains the isSuccess or not
class ToastController {
  static showToast(String message, bool isSuccess, {int time = 2}) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      duration: Duration(seconds: time),
    );
    ScaffoldMessenger.of(NavigatorKey.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static removeToast(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
