
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Functions/SubFunctions/isFirstlunche.dart';
import 'LoginPage.dart'; 
import 'package:flutter_application_1/Pages/HomePage.dart';  

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  _checkFirstTime() async {
    await Future.delayed(Duration(seconds: 5), () {});
    final showLogin = await isFirstLaunch();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => showLogin ? loginpage() : HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child:  Image.asset('assets/images/logo-ibn-Zohr-1.png',width: 100,height: 100) 
      ),
    );
  }
}
