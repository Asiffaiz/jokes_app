import 'package:flutter/material.dart';
import 'package:jokes_app/config.dart';
import 'package:jokes_app/views/pages/setting/setting_page.dart';
import 'package:jokes_app/views/pages/submited_jokes/submited_jokes_page.dart';
import 'home/home_page.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;
  final screens = [HomePage(), SubmitedJokes(), SettingPage()];
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add_outlined), label: "Submited Jokes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
