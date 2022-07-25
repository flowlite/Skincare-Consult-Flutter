import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
import 'package:skincare_consult_codetest_flutter/main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkinAnalyzeResultPage extends StatefulWidget {
  const SkinAnalyzeResultPage({Key? key}) : super(key: key);

  @override
  State<SkinAnalyzeResultPage> createState() => _SkinAnalyzeResultPageState();
}

class _SkinAnalyzeResultPageState extends State<SkinAnalyzeResultPage> {
  int _currentPage = 2;

  String _photoPath = "";

  @override
  Widget build(BuildContext context) {

    _getPhotoPath();

    File _photoFile = File("");
    if (_photoPath != null && _photoPath.isNotEmpty) {
      _photoFile = File(_photoPath);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _pageAppBar(),
      body: Stack(
        children: [
          /// background images
          Image.file(_photoFile,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.srcOver,
            color: Colors.black.withOpacity(0.65),
          ),

          /// texts slider and base buttons
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// texts slider
                Column(
                  children: [
                    Text(
                      "Analisa Kondisi Kulit Kamu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 6.0),

                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),

                /// slider indicator
                Container(
                  margin: EdgeInsets.only(bottom: 40.0, top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8, width: 8,
                        decoration: BoxDecoration(
                          color: Color(Constants.colorWhite93),
                          shape: BoxShape.circle
                        ),
                      ),

                      SizedBox(width: 12),

                      Container(
                        height: 8, width: 8,
                        decoration: BoxDecoration(
                          color: Color(Constants.colorPrimary),
                          shape: BoxShape.circle
                        ),
                      ),

                      SizedBox(width: 12),

                      Container(
                        height: 8, width: 8,
                        decoration: BoxDecoration(
                          color: Color(Constants.colorWhite93),
                          shape: BoxShape.circle
                        ),
                      )
                    ],
                  ),
                ),

                /// slider indicator
                // Container(
                //   margin: EdgeInsets.only(bottom: 40.0, top: 30.0),
                //   child: StepProgressIndicator(
                //
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     padding: 4.0,
                //     currentStep: _currentPage.toInt(),
                //     totalSteps: 3,
                //     size: 10,
                //     unselectedColor: Color(Constants.colorWhite93),
                //     selectedColor: Color(Constants.colorPrimary),
                //     customStep: (index, color, _) {
                //       return Container(
                //         decoration: BoxDecoration(
                //             color: color,
                //             shape: BoxShape.circle
                //         ),
                //       );
                //     },
                //   ),
                // )

                /// action buttons
                _actionWidget(),

              ],
            ),
          )
        ],
      )
    );
  }

  /// TASKS
  _getPhotoPath() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey(Constants.photoPath)){
      _photoPath = pref.getString(Constants.photoPath) ?? "";
    }
  }

  /// WIDGETS
  Widget _actionWidget(){

    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)
            )
      ),
      child: Material(
          color: Color(Constants.colorPrimary),
          borderRadius: BorderRadius.all(
              Radius.circular(6.0)),
          child: InkWell(
          onTap: () { _goToAnalzyaSurveyPage(); },
          child: _actionButton(),
        ),
      ),
    );
  }

  Widget _actionButton(){
    double _containerBorder = 6.0;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      // decoration: BoxDecoration(
      //     color: Color(Constants.colorPrimary),
      //     borderRadius: BorderRadius.all(
      //         Radius.circular(_containerBorder))
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.face, color: Colors.white),

          SizedBox(width: 10.0),

          Text(
            "Mulai Sekarang",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  AppBar _pageAppBar(){
    return AppBar(
      toolbarHeight: 106.0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close, color: Colors.white),
      ),
      centerTitle: true,
      title: Text(
        "Skin Analyzer",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }


  /// ROUTES
  _goToAnalzyaSurveyPage() async {
    Navigator.pushNamed(context, Routes.skinAnalyzeSurveyPage);
    print("Go to next page");
  }
}