import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokes_app/controllers/auth_controller/auth_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("we are working on it!"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _authController.signout();
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
