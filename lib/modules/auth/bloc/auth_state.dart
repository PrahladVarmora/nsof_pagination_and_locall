part of 'auth_bloc.dart';

/// [AuthState] abstract class is used Auth State
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// [AuthInitial] class is used Auth State Initial
class AuthInitial extends AuthState {}

/// [AuthLoading] class is used Auth State Loading
class AuthLoading extends AuthState {}

/// [AuthResponse] class is used Auth State Response
class AuthResponse extends AuthState {
  const AuthResponse();

  @override
  List<Object> get props => [];
}

/// [AuthFailure] class is used Auth State Failure
class AuthFailure extends AuthState {
  final String mError;

  const AuthFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
