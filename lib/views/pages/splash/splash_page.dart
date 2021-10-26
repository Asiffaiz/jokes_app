import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokes_app/config.dart';
import 'package:jokes_app/utils/prefs.dart';
import 'package:jokes_app/views/pages/root.dart';
import 'package:jokes_app/views/pages/sign_in/sign_in.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Prefs.init();

    Timer(Duration(seconds: 5), () {
      showNextMain();
    });
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        'assets/images/wepik-2021926-11836.png',
        // width: 270,
      )),
    );
  }

  void showNextMain() {
    var cheker = Prefs.isUserLoggedIn();
    if (cheker) {
      Get.offAll(Root());
    } else {
      Get.offAll(SignIn());
    }
  }
}
