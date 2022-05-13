import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker_app/presentation/screens/home/home_screen.dart';

import '../../constants/constants.dart';
import '../history/history_screen.dart';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int bottomNavigationBaritemIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavyBar(
          backgroundColor: Colors.grey[900],
          selectedIndex: bottomNavigationBaritemIndex,
          showElevation: true,
          iconSize: 25.0,
          onItemSelected: (index) {
            setState(() => bottomNavigationBaritemIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              title: const Text(
                'Dashboard',
                textAlign: TextAlign.center,
                style: kBottomNavBarStyle,
              ),
              icon: const Icon(Icons.dashboard),
              activeColor: Colors.grey,
              inactiveColor: Colors.grey,
            ),
            BottomNavyBarItem(
              title: const Text(
                'History',
                textAlign: TextAlign.center,
                style: kBottomNavBarStyle,
              ),
              icon: const Icon(Icons.history),
              activeColor: Colors.grey,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => bottomNavigationBaritemIndex = index);
          },
          children: const [
            HomeScreen(),
            HistoryScreen(),
          ],
        ),
      ),
    );
  }
}
