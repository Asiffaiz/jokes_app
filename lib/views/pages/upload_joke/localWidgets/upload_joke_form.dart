import 'package:flutter/material.dart';
import 'package:jokes_app/views/pages/upload_joke/localWidgets/submit_joke_button.dart';
import 'package:jokes_app/views/widgets/rounded_joke_text_formfield.dart';

import '../../../../config.dart';

class SubmitJokeForm extends StatefulWidget {
  SubmitJokeForm({
    Key? key,
  }) : super(key: key);

  @override
  _SubmitJokeFormState createState() => _SubmitJokeFormState();
}

class _SubmitJokeFormState extends State<SubmitJokeForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTextFormFields(),
          SizedBox(height: Config.screenHeight! * 0.05),
          JokeSubmitButtons(
            formKey: _formKey,
            nameController: nameController,
          ),
        ],
      ),
    );
  }

  Widget buildTextFormFields() {
    return RoundedJokeTextFormField(
      controller: nameController,
      hintText: 'Enter joke',
    );
  }
}
