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
  File? _photoFile;


  @override
  Widget build(BuildContext context) {

    _getPhotoPath();
    var _photoExist = _photoFile?.existsSync();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _pageAppBar(),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),

          /// background images
          if(_photoExist == true)
          Container(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(),

                Image.file(_photoFile!,
                  // height: double.infinity,
                  // width: double.infinity,
                  fit: BoxFit.contain,

                  // colorBlendMode: BlendMode.srcOver,
                  // color: Colors.black,
                )
              ],
            ),
          ),

          /// texts slider and base buttons
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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

    if (_photoPath != null && _photoPath.isNotEmpty) {
      setState(() {
        _photoFile = File(_photoPath);
        print(":: PHOTO PATH :: ${_photoPath}");
      });
    }
  }

  //  todo: (NEXT) set this to automatically assigned without button press
  _showModalBottomDialog(){
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            child: Column(
                children: [
                  _bottomDialogHeader(75, Color(Constants.colorScoreGood)),

                  /// result grid view
                  Expanded(
                    child: _skinSurveyGridView())
                ]
            ),
          ),
        );
      },
    );
  }

  /// WIDGETS
  Widget _scoreWidget(int score, Color scoreColor, {double? progressSize, double? textSize, double? stepSize}){
    double _defaultProgressSize = 55;
    double _defaultTextSize = 20.0;
    double _defaultStepSize = 10.0;

    return CircularStepProgressIndicator(
      // stepSize: 10,
      totalSteps: 100,
      currentStep: score,
      selectedColor: scoreColor,
      unselectedColor: Colors.transparent,
      height: progressSize ?? _defaultProgressSize,
      width: progressSize ?? _defaultProgressSize,
      stepSize: stepSize ?? _defaultStepSize,
      child: Center(
        child: Text(
            "$score",
            style: TextStyle(
              color: scoreColor,
              fontSize: textSize ?? _defaultTextSize,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center
        ),
      ),
    );
  }

  Widget _textScoreWidget(Color scoreColor, String scoreText, {String? valueName, double? textSize}){
    double _defaultTextSize = 18.0;
    String _valueName = "";

    if (valueName != null){
      _valueName = " ${valueName} ";
    }

    return Text.rich(
      TextSpan(
          text: "Your${_valueName}Score is ",
          style: TextStyle(
            color: Colors.black,
            fontSize: textSize ?? _defaultTextSize,
            fontWeight: FontWeight.w800,
          ),
          children: [
            TextSpan(
              text: scoreText,
              style: TextStyle(
                color: scoreColor,
              ),
            )
          ]
      ),
      maxLines: 3,
    );
  }

  Widget _dataTextScoreWidget(Color scoreColor, String scoreText, {String? valueName, double? textSize}){
    double _defaultTextSize = 18.0;
    String _valueName = "";

    if (valueName != null){
      _valueName = " ${valueName} ";
    }

    return Text.rich(
      TextSpan(
          text: "Your${_valueName}Score is ",
          style: TextStyle(
            color: Colors.black,
            fontSize: textSize ?? _defaultTextSize,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: scoreText,
              style: TextStyle(
                color: scoreColor,
              ),
            )
          ]
      ),
      maxLines: 3,
      textAlign: TextAlign.center,
    );
  }

  Widget _skinSurveyWidget(String valueName, int score, Color scoreColor){
    String scoreText = "-";

    if(score >= 100) {
      scoreText = "Perfect";
    } else if(score >= 35) {
      scoreText = "Good";
    } else {
      scoreText = "Bad";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 25, top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: _scoreWidget(score, scoreColor),
            ),

            Flexible(
              fit: FlexFit.loose,
              child: _dataTextScoreWidget(scoreColor, scoreText,
                  valueName: "${valueName}"),
            )
          ],
        ),
      ),
    );
  }

  Widget _skinSurveyGridView(){
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: 0.96
        ),
        children: [
          _skinSurveyWidget("Uneven Skintone Skin", 25, Color(Constants.colorScoreBad)),
          _skinSurveyWidget("Smoothness Skin", 75, Color(Constants.colorScoreGood)),
          _skinSurveyWidget("Radiance Skin", 75, Color(Constants.colorScoreGood)),
          _skinSurveyWidget("Shine Skin", 100, Color(Constants.colorScorePerfect)),
          _skinSurveyWidget("Radiance Skin", 75, Color(Constants.colorScoreGood)),
        ]
    );
  }



  Widget _bottomDialogHeader(int score, Color scoreColor){
    String scoreText = "-";

    if(score >= 100) {
      scoreText = "Perfect";
    } else if(score >= 35) {
      scoreText = "Good";
    } else {
      scoreText = "Bad";
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      elevation: 1.0,
      child: Container(
        padding: EdgeInsets.only(left: 18, right: 18, bottom: 18, top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 23),
              child: _scoreWidget(score, scoreColor, progressSize: 80, textSize: 26.0, stepSize: 14),
            ),

            Flexible(
              fit: FlexFit.loose,
              child: _textScoreWidget(scoreColor, scoreText,
                  valueName: "Overall Skin", textSize: 22.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionWidget(){

    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
        decoration: BoxDecoration(
          //  todo: (NEXT) remove decoration after automatic bottomsheet popup
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
          onTap: () { _showDialogBottom(); },
          child: _actionButton(),
        ),
      ),
    );
  }

  Widget _actionButton(){
    double _containerBorder = 6.0;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      decoration: BoxDecoration(
          color: Color(Constants.colorPrimary),
          borderRadius: BorderRadius.all(
              Radius.circular(_containerBorder))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.assignment, color: Colors.white),

          SizedBox(width: 10.0),

          Text(
            "Tampilkan hasil",
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

  //  todo: (NEXT) modify for more accurate app bar widgets positioning
  AppBar _pageAppBar(){
    return AppBar(
      toolbarHeight: 106.0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leadingWidth: 40,
      leading: Container(
        // decoration: BoxDecoration(
        //     color: Colors.grey[600],
        //     shape: BoxShape.circle
        // ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left_outlined, color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) {
              return route.settings.name == Routes.skinAnalyzeStartPage;
            },);
          },
          icon: Icon(Icons.share, color: Colors.white),
        )
      ],
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
  _showDialogBottom() {
    _showModalBottomDialog();
  }
}