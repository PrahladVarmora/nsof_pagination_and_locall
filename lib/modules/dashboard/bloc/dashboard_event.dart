part of 'dashboard_bloc.dart';

/// [DashboardEvent] abstract class is used Event of bloc.
/// It's an abstract class that extends Equatable and has a single property called props
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

/// [GetDashboardItems] abstract class is used Dashboard Event
class GetDashboardItems extends DashboardEvent {
  const GetDashboardItems({required this.url, required this.mPage});

  final String url;
  final int mPage;

  @override
  List<Object> get props => [
        url,
      ];
}
