import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class SkinAnalyzeSurveyPage extends StatefulWidget {
  const SkinAnalyzeSurveyPage({Key? key}) : super(key: key);

  @override
  State<SkinAnalyzeSurveyPage> createState() => _SkinAnalyzeSurveyPageState();
}

class _SkinAnalyzeSurveyPageState extends State<SkinAnalyzeSurveyPage> {

  int _currentPage = 1;
  PageController _pageController = PageController();
  ScrollPhysics? _pageScrollPhysics = NeverScrollableScrollPhysics();

  int _ageRangeIndex = 0;
  List<String> _ageRangeSurveyChoicesList = [
    '18-24 Tahun',
    '25-34 Tahun',
    '35-44 Tahun',
    '45-54 Tahun',
    '55+ Tahun',
  ];

  int _skinConditionIndex = 0;
  List<String> __skinConditionSurveyChoicesList = [
    'Normal',
    'Kering',
    'Berminyak',
    'Sensitif',
    'Kombinasi',
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

                  _skinProblemSurveyPageWidget(),

                  _skinProblemSurveyPageWidget(),

                  /// placeholder
                  Container(color: Colors.white),
                  Container(color: Colors.white),
                  // Container(color: Colors.white),
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

  void _onImagePickButtonClick(){
    // _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);
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
                _onNextButtonClick();
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

  Widget _skinProblemSurveyPageWidget(){
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
            child: ChipsChoice<int>.single(
              padding: EdgeInsets.zero,
              wrapped: true,
              value: _skinConditionIndex,
              onChanged: (val) {
                setState(() {
                  _skinConditionIndex = val;
                });
                _onNextButtonClick();
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: __skinConditionSurveyChoicesList,
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


  /// WIDGETS LIST
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
    print("Go to next page");
  }
}