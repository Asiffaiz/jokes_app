import 'package:flutter/material.dart';

import '../../config.dart';

class RoundedJokeTextFormField extends StatelessWidget {
  RoundedJokeTextFormField({
    Key? key,
    this.controller,
    this.obsecureText = false,
    @required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode jokeDataFocusnode = FocusNode();
  final bool? obsecureText;
  final String? hintText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText!,
      maxLines: 15,
      onFieldSubmitted: (val) {
        jokeDataFocusnode.unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText!,
        focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: kErrorColor),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: kErrorColor),
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
        ),
      ),
      // validator: validator,
    );
  }
}
