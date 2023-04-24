part of 'auth_bloc.dart';

/// [AuthEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// [AuthUser] abstract class is used Auth Event
class AuthUser extends AuthEvent {
  const AuthUser({required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

/// [AuthUser] abstract class is used Auth Event
class AuthOTP extends AuthEvent {
  const AuthOTP({required this.verificationId, required this.otp});

  final String otp;
  final String verificationId;

  @override
  List<Object> get props => [otp];
}
