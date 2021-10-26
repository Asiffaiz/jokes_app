import 'package:flutter/material.dart';
import 'package:jokes_app/views/pages/sign_in/localWidgets/sign_in_buttons.dart';
import 'package:jokes_app/views/widgets/rounded_text_formfield.dart';
import '../../../config.dart';
import '../../widgets/hero_title.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // shows header title
                HeroTitle(
                  title: 'Welcome!',
                  subtitle: 'Enter email and password to login...',
                ),
                SizedBox(height: Config.screenHeight! * 0.03),
                // // // shows image
                Container(
                    height: 200,
                    child:
                        Image.asset("assets/images/monkey-with-glasses.png")),
                SizedBox(height: Config.screenHeight! * 0.06),
                // shows textfields and buttons
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextFormFields(),
                      SignInButtons(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      children: [
        RoundedTextFormField(
          controller: _emailController,
          hintText: 'Email',
          validator: (value) {
            bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (!_isEmailValid) {
              return 'Invalid email.';
            }
            return null;
          },
        ),
        SizedBox(height: Config.screenHeight! * 0.01),
        RoundedTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obsecureText: true,
          validator: (value) {
            if (value.toString().length < 6) {
              return 'Password should be longer or equal to 6 characters.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
