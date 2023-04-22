import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/common_import.dart';
import '../model/model_user.dart';
import '../repository/repository_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// Notifies the [AuthBloc] of a new [AuthEvent] which triggers
/// [RepositoryAuth] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RepositoryAuth repository,
    required ApiProvider apiProvider,
    required http.Client client,
  })  : mRepositoryAuth = repository,
        mApiProvider = apiProvider,
        mClient = client,
        super(AuthInitial()) {
    on<AuthUser>(_onAuthNewUser);
  }

  final RepositoryAuth mRepositoryAuth;
  final ApiProvider mApiProvider;
  final http.Client mClient;

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
    emit(AuthLoading());
    try {
      /// This is a way to handle the response from the API call.
      Either<ModelUser, ModelCommonAuthorised> response =
          await mRepositoryAuth.callPostApi(event.url,
              await mApiProvider.getHeaderValue(), mApiProvider, mClient);
      response.fold(
        (success) {
          emit(AuthResponse(mModelUser: success));
        },
        (error) {
          emit(AuthFailure(mError: error.message!));
        },
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
}
