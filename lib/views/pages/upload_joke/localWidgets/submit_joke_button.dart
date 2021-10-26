import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokes_app/services/database.dart';
import 'package:jokes_app/views/pages/home/home_page.dart';
import 'package:jokes_app/views/widgets/rounded_elevated_button.dart';
import '../../../../config.dart';

class JokeSubmitButtons extends StatelessWidget {
  JokeSubmitButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
  })  : _formKey = formKey,
        _nameController = nameController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RoundedElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String jokeContent = _nameController.text.trim();
              if (_nameController.text != "") {
                Database.addJoke(jokeContent, auth.currentUser!.uid)
                    .then((value) {
                  Get.off(() => HomePage());
                });
              }
            }
          },
          title: 'Submit',
          padding: EdgeInsets.symmetric(
            horizontal: Config.screenWidth! * 0.38,
            vertical: Config.screenHeight! * 0.02,
          ),
        ),
      ],
    );
  }
}
