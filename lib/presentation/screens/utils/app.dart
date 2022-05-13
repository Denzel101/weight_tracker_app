import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/presentation/provider/notification_state.dart';
import 'package:weight_tracker_app/presentation/screens/auth/login_screen.dart';
import 'package:weight_tracker_app/presentation/screens/landing/landing_screen.dart';
import 'package:weight_tracker_app/presentation/screens/router/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.firebaseAuth}) : super(key: key);
  final FirebaseAuth firebaseAuth;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _decideInitialPage();
    super.initState();
  }

  String _decideInitialPage() {
    if (widget.firebaseAuth.currentUser != null) {
      return LandingScreen.id;
    } else {
      return LoginScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider<NotificationState>(
        create: (BuildContext context) => NotificationState(),
        child: MaterialApp(
          title: 'Weight Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: _decideInitialPage(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
