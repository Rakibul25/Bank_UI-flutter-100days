import 'dart:async';

import 'package:bank/Screens/home_screen.dart';
import 'package:bank/Screens/login.dart';
import 'package:bank/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  static const String keylogin = "keylogin";
  @override
  void initState(){
    super.initState();
    whereToGo();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kWhiteColor,
        child: const Center(
          child: Text(
            "Welcome",
            style: TextStyle(fontSize: 30, color: kGreenColor),
          ),
        ),
      ),
    );
  }

  Future<void> whereToGo() async {
    var sharedpref = await SharedPreferences.getInstance();
    
    var isLoggedin =  sharedpref.getBool((keylogin));

    Timer(Duration(seconds: 2), (){
      if(isLoggedin!=null){
        if(isLoggedin){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const logIn()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const logIn()));
      }


    },);
  }
}
