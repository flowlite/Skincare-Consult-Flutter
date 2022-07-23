import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';

class SkinAnalyzeStartPage extends StatefulWidget {
  const SkinAnalyzeStartPage({Key? key}) : super(key: key);

  @override
  State<SkinAnalyzeStartPage> createState() => _SkinAnalyzeStartPageState();
}

class _SkinAnalyzeStartPageState extends State<SkinAnalyzeStartPage> {
  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _pageAppBar(),
      body: Stack(
        children: [
          /// background images
          Image.asset('assets/images/man_taking_selfie.png',
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
                  height: 10,
                  width: 10,
                  color: Color(Constants.colorPrimary),
                ),

                /// action buttons
                _actionWidget(),

              ],
            ),
          )
        ],
      )
    );
  }

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
          onTap: () { _goToPage(); },
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
        "Analisa Kondisi Kulit Kamu",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  _goToPage() async {
    print("Go to next page");
  }
}