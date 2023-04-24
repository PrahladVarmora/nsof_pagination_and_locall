import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nstack_softech_practical/app.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';
import 'package:nstack_softech_practical/modules/core/utils/interpolate.dart';
import 'package:nstack_softech_practical/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:nstack_softech_practical/modules/dashboard/model/model_dashboard_list_item.dart';
import 'package:nstack_softech_practical/modules/dashboard/view/widget/row_list_item.dart';

/// The ScreenDashboard class is a stateful widget in Dart.
class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({Key? key}) : super(key: key);

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  ValueNotifier<bool> mLoading = ValueNotifier(false);
  ValueNotifier<bool> mPagination = ValueNotifier(false);

  bool isNextPage = false;
  int mNextPage = 1;

  ValueNotifier<List<ModelDashboardListItem>> mModelDashboardList =
      ValueNotifier([]);

  @override
  void initState() {
    initData();
    subscribeConnectivityStream();
    super.initState();
  }

  /// The function "initData()" is declared in Dart.
  void initData() {
    BlocProvider.of<DashboardBloc>(getNavigatorKeyContext())
        .add(GetDashboardItems(
      mPage: mNextPage,
      url: InterpolateString.interpolate(
          AppConfig.apiRepos, ['$mNextPage', AppConfig.pageLimit]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    /// The function returns a widget for the dashboard body.
    Widget getDashboardBody() {
      return BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          mLoading.value = (state is DashboardLoading && mNextPage == 1);
          mPagination.value = (state is DashboardLoading && mNextPage > 1);
          if (state is DashboardResponse) {
            if (mNextPage == 1) {
              mModelDashboardList.value = state.mModelDashboardList;
            } else {
              mModelDashboardList.value.addAll(state.mModelDashboardList);
            }
            mPagination.value = false;
            isNextPage =
                state.mModelDashboardList.length == AppConfig.pageLimitCount;
          }
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: mModelDashboardList.value.length,
          itemBuilder: (context, index) {
            if (index == (mModelDashboardList.value.length - 3)) {
              loadMoreData();
            }
            return Column(
              children: [
                RowDashboardListItem(
                    modelDashboardListItem: mModelDashboardList.value[index]),
                if (mPagination.value &&
                    mNextPage != 1 &&
                    index == (mModelDashboardList.value.length - 1))
                  Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: Dimens.margin50),
                    ],
                  ),
              ],
            );
          },
        ),
      );
    }

    /// The function returns a widget that represents a preferred size app bar.
    PreferredSizeWidget getAppbar() {
      return AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: Text(APPStrings.textJakeSGit.translate()),
      );
    }

    return MultiValueListenableBuilder(
        valueListenables: [
          mLoading,
          mPagination,
          mModelDashboardList,
        ],
        builder: (context, values, child) {
          return ModalProgressHUD(
            inAsyncCall: mLoading.value && mNextPage == 1,
            child: Scaffold(
              appBar: getAppbar(),
              body: getDashboardBody(),
            ),
          );
        });
  }

  void loadMoreData() {
    if (isNextPage && !mPagination.value) {
      // mPagination.value = true;
      mNextPage += 1;
      initData();
    }
  }

  /// This function is likely used in Dart programming to subscribe to a
  /// connectivity stream.
  Future<void> subscribeConnectivityStream() async {
    MyAppState.isConnected = await checkConnectivity();
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      if (!MyAppState.isConnected) {
        ToastController.showToast(APPStrings.textOffline.translate(), false,
            time: 4);
      }
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        ///All Ok

        ToastController.showToast(APPStrings.textBackOnline.translate(), true,
            time: 4);

        if (!MyAppState.isConnected) {
          ///Reset API when reconnect to internet
          BlocProvider.of<DashboardBloc>(getNavigatorKeyContext()).add(
              GetDashboardItems(
                  url: InterpolateString.interpolate(
                      AppConfig.apiRepos, ['1', AppConfig.pageLimit]),
                  mPage: 1));
        }
        MyAppState.isConnected = true;
      } else {
        ToastController.showToast(APPStrings.textOffline.translate(), false,
            time: 4);
        if (MyAppState.isConnected) {
          ///Get Data when internet disconnected
          BlocProvider.of<DashboardBloc>(getNavigatorKeyContext()).add(
              GetDashboardItems(
                  url: InterpolateString.interpolate(
                      AppConfig.apiRepos, ['1', AppConfig.pageLimit]),
                  mPage: 1));
        }
        MyAppState.isConnected = false;
      }
    });
  }
}
