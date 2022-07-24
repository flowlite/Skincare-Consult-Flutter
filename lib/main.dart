import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
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
  static const String SkinAnalyzeSurveyPage = "/skinAnalyzeSurvey";
  // static const String loginPage = "/login";
  // static const String homePage = "/home";
}

Map<String, Widget Function(BuildContext)> routes = {
  // Routes.mainPage: (context) => MainPage(),
  Routes.skinAnalyzeStartPage: (context) => SkinAnalyzeStartPage(),
  Routes.SkinAnalyzeSurveyPage: (context) => SkinAnalyzeSurveyPage(),
  // Routes.loginPage: (context) => LoginPage(),
  // Routes.homePage: (context) => HomePage()
};