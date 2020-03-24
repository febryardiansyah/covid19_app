import 'dart:async';

import 'package:covid19/providers/version_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _durasi = Duration(seconds: 3);
    return Timer(_durasi, navigasiPage);
  }

  void navigasiPage() {
    Navigator.pushReplacementNamed(context, '/navBar');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'COVID-19',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitWave(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
