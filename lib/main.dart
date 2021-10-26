import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jokes_app/config.dart';
import 'package:jokes_app/controllerBindings.dart';

import 'package:jokes_app/views/pages/splash/splash_page.dart';

void main() async {
  // Firebase init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // bind our app with the  Getx Controller
      initialBinding: ControllerBindings(),

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.amaranthTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: kPrimaryColor),
      home: SplashPage(),
    );
  }
}
