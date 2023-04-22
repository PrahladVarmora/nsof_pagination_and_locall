import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/common_import.dart';
import '../model/model_user.dart';

/// This class used to API and bloc connection
/// This class is used to call the post api and return the response in the form of ModelUser
class RepositoryAuth {
  static final RepositoryAuth _repository = RepositoryAuth._internal();

  /// `RepositoryAuth()` is a factory constructor that returns a singleton instance of the
  /// `RepositoryAuth` class
  ///
  /// Returns:
  ///   The repository
  factory RepositoryAuth() {
    return _repository;
  }

  /// A private constructor.
  RepositoryAuth._internal();

  /// It calls the post method of the ApiProvider class and returns the response as a ModelUser object
  ///
  /// Args:
  ///   url (String): The url of the api
  ///   body (Map<String, dynamic>): The body of the request.
  ///   header (Map<String, String>): This is the header of the request.
  ///   mApiProvider (ApiProvider): This is the ApiProvider class that we created earlier.
  ///   client (http): http.Client object
  ///
  /// Returns:
  ///   Either<ModelUser, ModelCommonAuthorised>
  Future<Either<ModelUser, ModelCommonAuthorised>> callPostApi(
      String url,
      Map<String, String> header,
      ApiProvider mApiProvider,
      http.Client client) async {
    Either<dynamic, ModelCommonAuthorised> response =
        await mApiProvider.callGetMethod(client, url, header);
    return response.fold(
      (success) {
        ModelUser result = ModelUser.fromJson(jsonDecode(success));
        return left(result);
      },
      (error) => right(error),
    );
  }
}
