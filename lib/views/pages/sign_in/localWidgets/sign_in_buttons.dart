import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jokes_app/controllers/auth_controller/auth_controller.dart';
import 'package:jokes_app/views/pages/sign_up/sign_up.dart';
import 'package:jokes_app/views/widgets/rounded_elevated_button.dart';
import 'package:jokes_app/views/widgets/text_with_textbutton.dart';
import '../../../../config.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {},
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
              ),
            ),
          ),
        ),
        RoundedElevatedButton(
          title: 'Sign in',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String email = _emailController.text.trim();
              String password = _passwordController.text;

              _authController.signIn(email, password);
            }
          },
          padding: EdgeInsets.symmetric(
            horizontal: Config.screenWidth! * 0.4,
            vertical: Config.screenHeight! * 0.02,
          ),
        ),
        TextWithTextButton(
          text: 'Don\'t have an account?',
          textButtonText: 'Sign up',
          onPressed: () => Get.to(() => SignUp()),
        ),
      ],
    );
  }
}
