part of 'dashboard_bloc.dart';

/// [DashboardState] abstract class is used Dashboard State
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

/// [DashboardInitial] class is used Dashboard State Initial
class DashboardInitial extends DashboardState {}

/// [DashboardLoading] class is used Dashboard State Loading
class DashboardLoading extends DashboardState {}

/// [DashboardResponse] class is used Dashboard State Response
class DashboardResponse extends DashboardState {
  final List<ModelDashboardListItem> mModelDashboardList;

  const DashboardResponse({required this.mModelDashboardList});

  @override
  List<Object> get props => [mModelDashboardList];
}

/// [DashboardFailure] class is used Dashboard State Failure
class DashboardFailure extends DashboardState {
  final String mError;

  const DashboardFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
