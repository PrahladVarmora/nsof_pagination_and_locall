import 'package:nstack_softech_practical/modules/auth/bloc/auth_bloc.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// The ScreenOtp class is a stateful widget in Dart.
class ScreenOtp extends StatefulWidget {
  final String verificationId;

  const ScreenOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AuthLoading,
          child: SafeArea(
            child: Scaffold(
              body: Container(
                  padding: const EdgeInsets.all(Dimens.margin16),
                  child: Column(
                    children: [
                      PinCodeTextField(
                          hintCharacter: '0',
                          controller: otpController,
                          appContext: context,
                          length: 6,
                          onCompleted: (val) {
                            verifyOtpEvent(context);
                          },
                          onChanged: (val) {})
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  /// This function is used to handle the verification of OTP in a Flutter app.
  ///
  /// Args:
  ///   context (BuildContext): The context parameter in Flutter is a reference to
  /// the location of a widget within the widget tree. It is used to access various
  /// services and resources provided by the Flutter framework, such as themes,
  /// media queries, and localization. It is also used to navigate between different
  /// screens or pages in a Flutter app.
  void verifyOtpEvent(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthOTP(
        otp: otpController.text, verificationId: widget.verificationId));
  }
}
