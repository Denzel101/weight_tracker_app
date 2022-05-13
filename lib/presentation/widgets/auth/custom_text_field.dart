import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextInputType keyBoard;
  final FocusNode mFocusNode;
  final TextEditingController textEditingController;
  final TextCapitalization textCapitalization;
  final FormFieldValidator mValidation;
  final mOnSaved;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.obscure,
    required this.keyBoard,
    required this.mFocusNode,
    required this.textCapitalization,
    required this.mValidation,
    this.mOnSaved,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // TODO: remove client-side validation errors when user enters the corrected info
      style: const TextStyle(
        height: 1.0,
        color: Colors.grey,
      ),

      textCapitalization: textCapitalization,
      focusNode: mFocusNode,
      controller: textEditingController,
      obscureText: obscure,
      keyboardType: keyBoard,
      cursorColor: Colors.grey[900],
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, letterSpacing: 1),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        suffixText: 'kg',
        suffixStyle: const TextStyle(
          color: Colors.grey,
        ),
        // contentPadding: EdgeInsets.all(15.0),
      ),
      validator: mValidation,
      onSaved: (String? value) {
        // save input value
        mOnSaved(value);
      },
    );
  }
}
