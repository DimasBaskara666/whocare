import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:whocare/screens/home_page.dart';

import 'screens/bmi_calculator_page.dart';
import 'screens/profile_page.dart';

class RootNavigator extends StatefulWidget {
  const RootNavigator({super.key});

  @override
  State<RootNavigator> createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: GNav(
          rippleColor: Colors.blue.shade900,
          tabBackgroundColor: Colors.blue.shade500,
          hoverColor: const Color.fromRGBO(114, 192, 255, 1),
          activeColor: Colors.white,
          color: Colors.grey.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(milliseconds: 400),
          gap: 4,
          iconSize: 30,
          onTabChange: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
          selectedIndex: index,
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: "Home",
              iconSize: 22,
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            GButton(
              icon: LineIcons.weight,
              text: "BMI",
              iconSize: 22,
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            GButton(
              icon: LineIcons.user,
              text: "Profile",
              iconSize: 22,
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    switch (index) {
      case 0:
        return HomePage(); // Jadikan Dashboard sebagai halaman Home
      case 1:
        return BMICalculatorPage(); // Halaman BMI
      case 2:
        return ProfilePage(); // Halaman Profil
      default:
        return HomePage();
    }
  }
}
