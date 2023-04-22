import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

/// `ScreenLogin` is a `StatefulWidget` that creates a `ScreenLoginState` object
class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  ScreenLoginState createState() => ScreenLoginState();
}

/// This class is used to show the login screen
/// `ScreenLoginState` is a `State` class that is used to show the login screen.
class ScreenLoginState extends State<ScreenLogin> {
  ValueNotifier<bool> mLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
