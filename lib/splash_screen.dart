
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  var data = "";
  SplashScreen(this.data);
  @override
  State<SplashScreen> createState() => _SplashScreenState(data);
}

class _SplashScreenState extends State<SplashScreen> {
  var data = "";
  _SplashScreenState(this.data);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Splash Screen"),),
        body: Center(child: Text("$data", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
      );
  }
}