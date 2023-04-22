import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:nstack_softech_practical/modules/auth/bloc/auth_bloc.dart';
import 'package:nstack_softech_practical/modules/core/api_service/preference_helper.dart';
import 'package:nstack_softech_practical/modules/core/common/widgets/app_localizations.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';
import 'package:nstack_softech_practical/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:nstack_softech_practical/modules/dashboard/repository/repository_dashboard.dart';
import 'package:provider/provider.dart';

import 'modules/auth/repository/repository_auth.dart';

/// Used by [MyApp] StatefulWidget for init of app
///[MultiProvider] A provider that merges multiple providers into a single linear widget tree.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

///[MyAppState] This class use to My App State
class MyAppState extends State<MyApp> {
  late ApiProvider apiProvider;
  late http.Client client;
  static ValueNotifier<Locale> notifier =
      ValueNotifier<Locale>(const Locale(APPStrings.languageEn));

  @override
  void initState() {
    init();

    super.initState();
  }

  void init() {
    PreferenceHelper.load().whenComplete(() {
      updateLanguage();
      apiProvider = ApiProvider();
      client = http.Client();
    });
  }

  @override
  Widget build(BuildContext context) {
    addingMobileUiStyles(context);
    return ValueListenableBuilder<Locale>(
      builder: (BuildContext context, Locale newLocale, Widget? child) {
        return MultiProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (BuildContext context) => AuthBloc(
                  apiProvider: apiProvider,
                  client: client,
                  repository: RepositoryAuth()),
            ),
            BlocProvider<DashboardBloc>(
              create: (BuildContext context) => DashboardBloc(
                  apiProvider: apiProvider,
                  client: client,
                  repository: RepositoryDashboard()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: APPStrings.appName,
            locale: newLocale,
            theme: ThemeData(
                progressIndicatorTheme: const ProgressIndicatorThemeData(
                    color: AppColors.colorPrimary)),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate
            ],
            supportedLocales: const [
              Locale(APPStrings.languageEn, ''),
            ],
            debugShowMaterialGrid: false,
            showSemanticsDebugger: false,
            showPerformanceOverlay: false,
            navigatorKey: NavigatorKey.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      },
      valueListenable: MyAppState.notifier,
    );
  }

  /// Used by [SystemChrome] of app
  void addingMobileUiStyles(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: (Theme.of(context).brightness == Brightness.light)
            ? AppColors.colorPrimary
            : AppColors.colorPrimary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));
  }

  /// It updates the language of the app.
  Future<void> updateLanguage() async {
    if (PreferenceHelper.getString(PreferenceHelper.userLanguage) != null &&
        PreferenceHelper.getString(PreferenceHelper.userLanguage)!.isNotEmpty) {
      MyAppState.notifier.value =
          PreferenceHelper.getString(PreferenceHelper.userLanguage) ==
                  APPStrings.languageEn
              ? const Locale(PreferenceHelper.userLanguage)
              //TODO: Change when add new language
              : const Locale(APPStrings.languageEn);
    }
  }
}
