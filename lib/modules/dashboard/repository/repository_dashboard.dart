import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nstack_softech_practical/modules/dashboard/model/model_dashboard_list_item.dart';

import '../../core/utils/common_import.dart';

/// The class is named RepositoryDashboard and its purpose is not specified in the
/// provided code snippet.
class RepositoryDashboard {
  static final RepositoryDashboard _repository =
      RepositoryDashboard._internal();

  /// `RepositoryAuth()` is a factory constructor that returns a singleton instance of the
  /// `RepositoryAuth` class
  ///
  /// Returns:
  ///   The repository
  factory RepositoryDashboard() {
    return _repository;
  }

  /// A private constructor.
  RepositoryDashboard._internal();

  /// This function calls an API to retrieve data and returns either a list of dashboard items or an authorized model.
  ///
  /// Args:
  ///   url (String): The URL of the API endpoint that needs to be called to fetch data.
  ///   header (Map<String, String>): The `header` parameter is a `Map` object that contains key-value pairs of HTTP headers to be included in the API request. These headers can be used to provide additional information about the request, such as authentication tokens or content types.
  ///   mApiProvider (ApiProvider): It is a variable of type `ApiProvider` which is likely a class or an interface that provides methods for making API calls. It could contain methods for handling different types of API requests such as GET, POST, PUT, DELETE, etc.
  ///   client (http): The `client` parameter is an instance of the `http.Client` class, which is used to make HTTP requests to the API endpoint specified by the `url` parameter. It is passed as an argument to the `callGetDataAPI` function so that the function can use it to make the API
  Future<Either<List<ModelDashboardListItem>, ModelCommonAuthorised>>
      callGetDataAPI(String url, Map<String, String> header,
          ApiProvider mApiProvider, http.Client client) async {
    Either<dynamic, ModelCommonAuthorised> response =
        await mApiProvider.callGetMethod(client, url, header);
    return response.fold(
      (success) {
        List<ModelDashboardListItem> result = [];
        result = List<ModelDashboardListItem>.from(json
            .decode(success)
            .map((data) => ModelDashboardListItem.fromJson(data)));

        return left(result);
      },
      (error) => right(error),
    );
  }
}
