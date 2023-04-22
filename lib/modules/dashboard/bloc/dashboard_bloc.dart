import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';
import 'package:nstack_softech_practical/modules/dashboard/model/model_dashboard_list_item.dart';
import 'package:nstack_softech_practical/modules/dashboard/repository/repository_dashboard.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

/// Notifies the [DashboardBloc] of a new [DashboardEvent] which triggers
/// [RepositoryDashboard] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required RepositoryDashboard repository,
    required ApiProvider apiProvider,
    required http.Client client,
  })  : mRepositoryDashboard = repository,
        mApiProvider = apiProvider,
        mClient = client,
        super(DashboardInitial()) {
    on<GetDashboardItems>(_onGetDashboardItems);
  }

  final RepositoryDashboard mRepositoryDashboard;
  final ApiProvider mApiProvider;
  final http.Client mClient;

  /// This is a private asynchronous function that handles the "GetDashboardItems" event and updates the state of the dashboard accordingly.
  ///
  /// Args:
  ///   event (GetDashboardItems): The parameter "event" is of type "GetDashboardItems", which is likely a custom class or enum that represents an event
  /// or action that triggers the function. It could contain information or data related to the event, such as user input or API responses.
  ///   emit (Emitter<DashboardState>): `emit` is an instance of the `Emitter` class, which is used to emit new states to the `Bloc`'s state stream. In
  /// this context, it is used to emit a new `DashboardState` after processing the `GetDashboardItems` event.
  void _onGetDashboardItems(
      GetDashboardItems event, Emitter<DashboardState> emit) async {
    /// Emitting an DashboardLoading state.
    emit(DashboardLoading());
    try {
      /// This is a way to handle the response from the API call.
      Either<List<ModelDashboardListItem>, ModelCommonAuthorised> response =
          await mRepositoryDashboard.callGetDataAPI(event.url,
              await mApiProvider.getHeaderValue(), mApiProvider, mClient);
      response.fold(
        (success) {
          emit(DashboardResponse(mModelDashboardList: success));
        },
        (error) {
          emit(DashboardFailure(mError: error.message!));
        },
      );
    } on SocketException {
      emit(const DashboardFailure(
          mError: ValidationString.validationNoInternetFound));
    } catch (e) {
      if (e.toString().contains(ValidationString.validationXMLHttpRequest)) {
        emit(const DashboardFailure(
            mError: ValidationString.validationNoInternetFound));
      } else {
        emit(const DashboardFailure(
            mError: ValidationString.validationInternalServerIssue));
      }
    }
  }
}
