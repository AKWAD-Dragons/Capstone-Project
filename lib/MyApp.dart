import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:load/load.dart';
import 'package:sercl/provider/shared_prefrence_provider.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/resources/themes.dart';
import 'package:sercl/support/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';
import 'dialog_provider/dialog_manager.dart';
import 'main.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetIt getit = GetIt.instance;
  String BUILDNUMBER = "build";
  String locale = AppStrings.de_code;
  @override
  void initState() {
    getInfo();
    initData();
    onLangUpdate();
    super.initState();
  }

  void onLangUpdate(){
    AppStrings.langChangedSubject.listen((String locale){
      SharedPreferencesProvider.instance().setLocale(locale);
      setState(() {
        this.locale = locale;
      });
    });
  }

  Future<void> getInfo() async {
    AppStrings.printUnTranslatedString();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final SharedPreferencesProvider sharedPrefs =
        SharedPreferencesProvider.instance();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print("App name is $appName");
    print("Package name is $packageName");
    print("Version is $version");
    print("Build number is $buildNumber");
    String cachedBuild = await SharedPreferencesProvider.instance().getBuildNumber(BUILDNUMBER);
    if (cachedBuild == null ||
        int.parse(buildNumber) > int.parse(cachedBuild)) {
      clearCache();
      sharedPrefs.setBuildNumber(buildNumber);
    }
  }

  void clearCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale(AppStrings.de_code),
          const Locale(AppStrings.en_code),
        ],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MainRouter.onGenerateRoute,
        initialRoute: MainRouter.splashScreen,
        theme: AppThemes.appTheme,
        navigatorKey: MainRouter.navigatorKey,
        builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: LoadingProvider(
            child: Navigator(
              onGenerateRoute: (setting) => MaterialPageRoute(
                  builder: (context) => DialogManager(child: child)),
            ),
          ),
        );
      },
      ),
    );
  }
}
