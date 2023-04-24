import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nstack_softech_practical/modules/auth/bloc/auth_bloc.dart';
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
  ValueNotifier<bool> isBiometricSupported = ValueNotifier(false);
  final LocalAuthentication localAuthentication = LocalAuthentication();

  TextEditingController phoneNumberController = TextEditingController();
  ValueNotifier<bool> mLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    initData();
    if (kDebugMode) {
      phoneNumberController.text = '+917817962735';
    }
    super.initState();
  }

  Future<void> initData() async {
    isBiometricSupported.value = await localAuthentication.isDeviceSupported();
  }

  @override
  Widget build(BuildContext context) {
    /// The function returns a widget that represents a preferred size app bar.
    PreferredSizeWidget getAppbar() {
      return AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text(APPStrings.textLogIn.translate()),
      );
    }

    Widget getLoginBody() {
      return Container(
        padding: const EdgeInsets.all(Dimens.margin16),
        child: Column(
          children: [
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: APPStrings.textEnterPhoneNumber.translate()),
            ),
            const SizedBox(height: Dimens.margin20),
            CustomButton(
              buttonText: APPStrings.textSendOtp.translate(),
              onPress: () {
                validateMobileNumber(context);
              },
            ),
            const SizedBox(height: Dimens.margin20),
            if (isBiometricSupported.value)
              TextButton(
                  onPressed: () async {
                    await localAuthentication
                        .authenticate(
                            options: const AuthenticationOptions(
                                useErrorDialogs: true,
                                sensitiveTransaction: false,
                                stickyAuth: true,
                                biometricOnly: false),
                            localizedReason: 'Login to continue in app')
                        .then((value) {
                      if (value) {
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.routesDashboard, (route) => false);
                      }
                    });
                  },
                  child:
                      Text(APPStrings.textOrContinueWithBiometric.translate()))
          ],
        ),
      );
    }

    return MultiValueListenableBuilder(
        valueListenables: [
          mLoading,
          isBiometricSupported,
        ],
        builder: (context, values, child) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: mLoading.value,
                child: Scaffold(
                  appBar: getAppbar(),
                  body: getLoginBody(),
                ),
              );
            },
          );
        });
  }

  /// This function validates a mobile number in a Flutter app.
  ///
  /// Args:
  ///   context (BuildContext): The `BuildContext` parameter is an object that
  /// represents the location of a widget within the widget tree. It is typically
  /// used to obtain a reference to the `Theme`, `Navigator`, `MediaQuery`,
  /// `Scaffold`, and other widgets that are higher up in the widget tree. It is
  /// also used
  void validateMobileNumber(BuildContext context) {
    if (phoneNumberController.text.trim().isEmpty) {
      ToastController.showToast(
          APPStrings.textEnterPhoneNumber.translate(), false);
    } else {
      mLoading.value = true;
      BlocProvider.of<AuthBloc>(context)
          .add(AuthUser(phone: phoneNumberController.text));
    }
  }
}
