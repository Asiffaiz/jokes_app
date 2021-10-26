import 'package:flutter/material.dart';
import 'package:jokes_app/views/pages/upload_joke/localWidgets/upload_joke_form.dart';

import '../../../config.dart';
import '../../widgets/hero_title.dart';

class UploadJoke extends StatefulWidget {
  const UploadJoke({Key? key}) : super(key: key);

  @override
  _UploadJokeState createState() => _UploadJokeState();
}

class _UploadJokeState extends State<UploadJoke> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            children: [
              // shows header title
              HeroTitle(
                title: 'SUBMIT A JOKE!',
                subtitle: 'Enter a funny joke...',
              ),
              SizedBox(height: Config.screenHeight! * 0.05),
              SubmitJokeForm(),
            ],
          ),
        ),
      ),
    );
  }
}
