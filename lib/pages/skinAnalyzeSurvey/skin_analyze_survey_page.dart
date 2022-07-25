import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
import 'package:skincare_consult_codetest_flutter/main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkinAnalyzeSurveyPage extends StatefulWidget {
  const SkinAnalyzeSurveyPage({Key? key}) : super(key: key);

  @override
  State<SkinAnalyzeSurveyPage> createState() => _SkinAnalyzeSurveyPageState();
}

class _SkinAnalyzeSurveyPageState extends State<SkinAnalyzeSurveyPage> {

  int _currentPage = 1;
  PageController _pageController = PageController();
  ScrollPhysics? _pageScrollPhysics = NeverScrollableScrollPhysics();

  String? _photoPath;

  int _ageRangeIndex = 0;
  List<String> _ageRangeSurveyChoicesList = [
    '18-24 Tahun',
    '25-34 Tahun',
    '35-44 Tahun',
    '45-54 Tahun',
    '55+ Tahun',
  ];

  List<int> _skinConditionIndex = [0];
  List<String> _skinConditionSurveyChoicesList = [
    'Normal',
    'Kering',
    'Berminyak',
    'Sensitif',
    'Kombinasi',
  ];

  List<int> _skinProblemIndex = [0];
  List<String> _skinProblemSurveyChoicesList = [
    'Garis halus & kerutan',
    'Kulit kusam',
    'Kemerahan',
    'Pori-pori besar',
    'Pigmentasi',
    'Kulit Mengendur',
    'Noda kulit',
    'Mata bengkak',
    'Dark spots',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /// blank space
            SizedBox(height: 100),

            /// slider indicator
            Container(
              margin: EdgeInsets.only(bottom: 25.0),
              child: StepProgressIndicator(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                padding: 4.0,
                currentStep: _currentPage.toInt(),
                totalSteps: 5,
                size: 6,
                unselectedColor: Color(Constants.colorWhite93),
                selectedColor: Color(Constants.colorPrimary),
                customStep: (index, color, _) {
                  return Container(
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                    ),
                  );
                },
              ),
            ),

            /// Page view
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: _pageScrollPhysics,
                onPageChanged: (index){
                  setState(() {
                    _currentPage = index + 1;
                  });
                },
                children: [
                  _ageSurveyPageWidget(),

                  _skinConditionSurveyPageWidget(),

                  _skinProblemSurveyPageWidget(),

                  _dailyLocationSurveyPageWidget(),

                  _getPhotosSurveyPageWidget(),
                ],
              ),
            ),

            /// action buttons
            _actionWidgets(),

          ],
        ),
      )
    );
  }

  /// TASKS
  void _onPreviousButtonClick() async {
    if (_currentPage <= 1) {
      _goToPreviousPage();
    } else {
      await _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void _onNextButtonClick() async {
    await _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void _onImagePickButtonClick() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (await File(photo?.path ?? "").exists()){
      _photoPath = photo?.path;

      _saveImagePath();
      _goToNextPage();
    }

    //  todo: (NEXT) LANJUT LAGI DISINI
  }

  _saveImagePath() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey(Constants.photoPath)){
      pref.setString(_photoPath ?? "", "");
    }
  }

  /// PAGE VIEW CHILDS WIDGETS
  Widget _ageSurveyPageWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Berapa Umur Kamu?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ChipsChoice<int>.single(
              padding: EdgeInsets.zero,
              wrapped: true,
              value: _ageRangeIndex,
              onChanged: (val) {
                setState(() {
                  _ageRangeIndex = val;
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: _ageRangeSurveyChoicesList,
                value: (index, value) => index,
                label: (index, value) => value,
              ),
              choiceActiveStyle: C2ChoiceStyle(
                color: Colors.white,
                backgroundColor: Color(Constants.colorPrimary),
                borderColor: Color(Constants.colorPrimary),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              choiceStyle: C2ChoiceStyle(
                color: Color(Constants.colorPrimary),
                backgroundColor: Colors.transparent,
                borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    side: BorderSide(color: Color(Constants.colorPrimary))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skinConditionSurveyPageWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Bagaimana kondisi kulit kamu?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ChipsChoice<int>.multiple(
              padding: EdgeInsets.zero,
              wrapped: true,
              value: _skinConditionIndex,
              onChanged: (val) {
                setState(() {
                  _skinConditionIndex = val;
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: _skinConditionSurveyChoicesList,
                value: (index, value) => index,
                label: (index, value) => value,
              ),
              choiceActiveStyle: C2ChoiceStyle(
                color: Colors.white,
                backgroundColor: Color(Constants.colorPrimary),
                borderColor: Color(Constants.colorPrimary),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              choiceStyle: C2ChoiceStyle(
                color: Color(Constants.colorPrimary),
                backgroundColor: Colors.transparent,
                borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    side: BorderSide(color: Color(Constants.colorPrimary))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skinProblemSurveyPageWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Apa masalah utama kulit kamu?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ChipsChoice<int>.multiple(
              padding: EdgeInsets.zero,
              wrapped: true,
              value: _skinProblemIndex,
              onChanged: (val) {
                setState(() {
                  _skinProblemIndex = val;
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: _skinProblemSurveyChoicesList,
                value: (index, value) => index,
                label: (index, value) => value,
              ),
              choiceActiveStyle: C2ChoiceStyle(
                color: Colors.white,
                backgroundColor: Color(Constants.colorPrimary),
                borderColor: Color(Constants.colorPrimary),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              choiceStyle: C2ChoiceStyle(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                color: Color(Constants.colorPrimary),
                backgroundColor: Colors.transparent,
                borderShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    side: BorderSide(color: Color(Constants.colorPrimary))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyLocationSurveyPageWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Dimana lokasi anda sering menghabiskan waktu?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),

          /// Location form dropdown
          _locationWidget(),

          /// location weather datas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _weatherStatusWidget("UV Index 15", "assets/icons/icon-water-drops-yellow.png"),
              _weatherStatusWidget("Humidity 20%", "assets/icons/icon-co2-cloud-yellow.png"),
              _weatherStatusWidget("Pollution 20", "assets/icons/icon-brightness-yellow.png"),
            ],
          )
        ],
      ),
    );
  }

  //  todo: (NEXT) need to readjust widgets he
  Widget _getPhotosSurveyPageWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Ambil foto selfie anda",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center
          ),

          SizedBox(height: 10),

          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            style: TextStyle(
              color: Colors.black,
              // fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center
          ),

          SizedBox(height: 15),

          /// take photo illustration
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 50),
            child: Image.asset("assets/images/img_camera_flatline1.png",
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),

          /// additional notice text
          Text(
            "Untuk hasil yang maksimal pastikan anda berada di tempat dengan pencahayaan yang cukup.",
            style: TextStyle(
              color: Colors.black,
              // fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }


  /// WIDGETS LIST

  Widget _locationWidget(){
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.location_on_rounded, color: Color(Constants.colorGrey74))
          ),

          Expanded(
            child: Text(
              "Bandung, Jawa Barat",
              style: TextStyle(
                color: Color(Constants.colorGrey42),
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _weatherStatusWidget(String content, String imagePath){
    return Container(
      child: Column(
        children: [
          // Icon(Icons.brightness_7_rounded, color: Colors.amber, size: 36,),

          Image.asset(imagePath,
            height: 34.0,
            width: 34.0,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 15),

          Text(
            "${content}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),

        ],
      ),
    );
  }

  Widget _actionWidgets(){

    return Container(
        padding: EdgeInsets.only(bottom: 30, top: 20),
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(25.0),
      //           topRight: Radius.circular(25.0)
      //       )
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// back / cancel button
          Expanded(
            child: Material(
              // color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: InkWell(
                onTap: () {
                  _onPreviousButtonClick();
                },
                child: _previousButton(
                    title: _currentPage <= 1 ? "Batalkan" : null),
              ),
            ),
          ),


          /// spacer
          SizedBox(width: 20),

          /// next button
          if (_currentPage < 5)
          Expanded(
            child: Material(
              color: Color(Constants.colorPrimary),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: InkWell(
                onTap: () {
                  _onNextButtonClick();
                  },
                child: _nextButton(),
              ),
            ),
          ),

          if (_currentPage >= 5)
          Expanded(
            child: Material(
              color: Color(Constants.colorPrimary),
              borderRadius: BorderRadius.all(
                  Radius.circular(6.0)),
              child: InkWell(
                onTap: () {
                  _onImagePickButtonClick();
                },
                child: _imagePickerButton(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _previousButton({String? title}){
    double _containerBorder = 6.0;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      // decoration: BoxDecoration(
      //     color: Color(Constants.colorPrimary),
      //     borderRadius: BorderRadius.all(
      //         Radius.circular(_containerBorder))
      // ),
      child: Text(
        title ?? "Kembali",
        style: TextStyle(
          color: Color(Constants.colorPrimary),
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _nextButton(){
    double _containerBorder = 6.0;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      // decoration: BoxDecoration(
      //     color: Color(Constants.colorPrimary),
      //     borderRadius: BorderRadius.all(
      //         Radius.circular(_containerBorder))
      // ),
      child: Text(
        "Lanjutkan",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _imagePickerButton(){
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 16.5, top: 16.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, color: Colors.white),

          SizedBox(width: 10.0),

          Text(
            "Ambil Foto",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }


  /// ROUTES
  _goToPreviousPage() async {
    Navigator.pop(context);
  }

  _goToNextPage() async {
    Navigator.pushNamed(context, Routes.skinAnalyzeResultPage);
  }
}