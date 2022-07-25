import 'package:flutter/material.dart';
import 'package:skincare_consult_codetest_flutter/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {

    _getSavedCredentials();
    //  set delay before redirect to page
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pop(context);
      _goToPage();
    });

    return Scaffold(
        backgroundColor: Colors.grey[600],
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Icon(Icons.people_alt_outlined, size: 48.0, color: Colors.white),
              ),

              Container(
                child: const Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }

  _getSavedCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //
    // if(pref.containsKey(Constants.loggedEmail)
    //     && pref.containsKey(Constants.password)){
    //   email = pref.getString(Constants.loggedEmail) ?? "";
    //   password = pref.getString(Constants.password) ?? "";
    // }
  }

  _goToPage() async {

    // if (email.isNotEmpty && password.isNotEmpty){
    //   await Navigator.pushNamed(context, Routes.homePage);
    // }
    // else {
    //   await Navigator.pushNamed(context, Routes.loginPage);
    // }

  }
}