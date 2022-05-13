import 'dart:async';

import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final GlobalKey<FormState> formKey;
  final bool loadingState;
  final VoidCallback removeFocusNodes;
  final FutureOr Function()? callBack;

  const SubmitButton(
      {Key? key,
      required this.label,
      required this.formKey,
      this.loadingState = false,
      required this.removeFocusNodes,
      required this.callBack})
      : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool loadingState = false;
  // TODO: Refactor this widget (eg. use switch statements; do away with Text widget duplication)
  Widget _setUpButtonChild() {
    Text _defaultText = Text(
      widget.label,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'CustomIcons',
      ),
    );

    if (loadingState == true) {
      // TODO: disable the signup button in this state (to prevent user making multiple requests to the server)
      return const SizedBox(
        width: 15.0,
        height: 15.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return _defaultText;
    }
  }

  Future<void> _handleSubmit() async {
    final form = widget.formKey.currentState!;
    // validate will return true if form is valid, otherwise false is returned
    if (form.validate()) {
      // Process datasources
      form.save();

      // remove focus
      widget.removeFocusNodes;
      setState(() {
        loadingState = true;
      });
      // call function
      await widget.callBack?.call();
      setState(() {
        loadingState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
        textStyle:
            MaterialStateProperty.all(const TextStyle(color: Colors.white)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.5),
        ),
      ),
      child: _setUpButtonChild(),
      onPressed: _handleSubmit,
    );
  }
}
