import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weight_tracker_app/domain/repositories/auth/auth_repository.dart';
import 'package:weight_tracker_app/locator.dart';
import 'package:weight_tracker_app/presentation/screens/landing/landing_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'sign';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: showPinner,
      child: Container(
        padding: const EdgeInsets.only(top: 16.0),
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              showPinner = true;
            });
            await Future.delayed(const Duration(seconds: 2));
            final signedInUser =
                await locator.get<AuthRepository>().signInAnonymously();
            if (signedInUser != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LandingScreen.id, (route) => false);
            }
            setState(() {
              showPinner = false;
            });
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<StadiumBorder>(
              const StadiumBorder(),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
            backgroundColor: MaterialStateProperty.all(Colors.purple),
          ),
          child: const Text(
            'Sign in anonymously',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ));
  }
}
