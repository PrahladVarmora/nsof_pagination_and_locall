import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/common_import.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Notifies the [AuthBloc] of a new [AuthEvent] which triggers
/// [RepositoryAuth] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthUser>(_onAuthNewUser);
    on<AuthOTP>(_onAuthOTP);
  }

  /// _onAuthNewUser is a function that takes an AuthUser event, an Emitter<AuthState> emit, and returns
  /// a Future<void> that emits an AuthLoading state, and then either an AuthResponse state or an
  /// AuthFailure state
  ///
  /// Args:
  ///   event (AuthUser): The event that was dispatched.
  ///   emit (Emitter<AuthState>): This is the function that you use to emit events.
  void _onAuthNewUser(
    AuthUser event,
    Emitter<AuthState> emit,
  ) async {
    /// Emitting an AuthLoading state.

    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: event.phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          ToastController.showToast(e.message.toString(), false);
          emit(AuthFailure(mError: e.message.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          printWrapped(
              'codeSent-----verificationId==$verificationId------resendToken==$resendToken');

          Navigator.pushNamed(
              getNavigatorKeyContext(), AppRoutes.routesOtpVerification,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on SocketException {
      emit(const AuthFailure(
          mError: ValidationString.validationNoInternetFound));
    } catch (e) {
      if (e.toString().contains(ValidationString.validationXMLHttpRequest)) {
        emit(const AuthFailure(
            mError: ValidationString.validationNoInternetFound));
      } else {
        emit(const AuthFailure(
            mError: ValidationString.validationInternalServerIssue));
      }
    }
  }

  void _onAuthOTP(
    AuthOTP event,
    Emitter<AuthState> emit,
  ) async {
    /// Emitting an AuthLoading state.
    emit(AuthLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.otp);

      UserCredential mUser = await auth.signInWithCredential(credential);

      if (mUser.user != null) {
        Navigator.pushNamedAndRemoveUntil(getNavigatorKeyContext(),
            AppRoutes.routesDashboard, (route) => false);
        emit(const AuthResponse());
      } else {
        emit(const AuthFailure(mError: 'Failed'));
      }
    } on SocketException {
      emit(const AuthFailure(
          mError: ValidationString.validationNoInternetFound));
    } catch (e) {
      if (e.toString().contains(ValidationString.validationXMLHttpRequest)) {
        emit(const AuthFailure(
            mError: ValidationString.validationNoInternetFound));
      } else {
        emit(const AuthFailure(
            mError: ValidationString.validationInternalServerIssue));
      }
    }
  }
}
