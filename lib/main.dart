import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker_app/firebase_options.dart';
import 'package:weight_tracker_app/locator.dart';
import 'package:weight_tracker_app/presentation/screens/utils/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpLocator();
  runApp(MyApp(
    firebaseAuth: FirebaseAuth.instance,
  ));
}
