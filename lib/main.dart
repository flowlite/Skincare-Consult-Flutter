import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
import 'package:skincare_consult_codetest_flutter/pages/skinAnalyzeResult/skin_analyze_result_page.dart';
import 'package:skincare_consult_codetest_flutter/pages/skinAnalyzeStart/skin_analyze_start_page.dart';
import 'package:skincare_consult_codetest_flutter/pages/skinAnalyzeSurvey/skin_analyze_survey_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// to set all app pages to portrait only
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return /*MultiProvider(
        providers: [
          Provider(create: (context) => PlacesStore(PlacesRepository())),
        ],
        child: */
      MaterialApp(
            title: 'Skincare App',
            theme: ThemeData(
              primaryColor: const Color(Constants.colorPrimary),
              // primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.skinAnalyzeStartPage,
            routes: routes
        );
    // );

  }
}

class Routes {
  // static const String mainPage = "/main";
  static const String skinAnalyzeStartPage = "/skinAnalyzeStart";
  static const String skinAnalyzeSurveyPage = "/skinAnalyzeSurvey";
  static const String skinAnalyzeResultPage = "/skinAnalyzeResult";
  // static const String loginPage = "/login";
  // static const String homePage = "/home";
}

Map<String, Widget Function(BuildContext)> routes = {
  // Routes.mainPage: (context) => MainPage(),
  Routes.skinAnalyzeStartPage: (context) => SkinAnalyzeStartPage(),
  Routes.skinAnalyzeSurveyPage: (context) => SkinAnalyzeSurveyPage(),
  Routes.skinAnalyzeResultPage: (context) => SkinAnalyzeResultPage(),
  // Routes.loginPage: (context) => LoginPage(),
  // Routes.homePage: (context) => HomePage()
};