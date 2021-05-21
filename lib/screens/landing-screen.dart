import 'package:flutter/material.dart';
import 'package:likee_clone/screens/account-screen.dart';
import 'package:likee_clone/screens/discover-screen.dart';
import 'package:likee_clone/screens/home-screen.dart';
import 'package:likee_clone/screens/inbox-screen.dart';
import 'package:likee_clone/screens/upload-screen.dart';
import 'package:likee_clone/utils/size-config.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int bottomNavCurrentIndex = 0;
  bool isLoggedIn = false;

  void _onItemTapped(int index) {
    setState(() {
      bottomNavCurrentIndex = index;
    });
  }

  bottomNavigationCallPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return DiscoverScreen();
      case 2:
        return UploadScreen();
      case 3:
        return InboxScreen();
      case 4:
        return AccountScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var block = SizeConfig.block;
    return Scaffold(
      body: bottomNavigationCallPage(bottomNavCurrentIndex),
      bottomNavigationBar: SizedBox(
        height: block * 13.5,
        child: BottomNavigationBar(
          elevation: 1,
          onTap: _onItemTapped,
          currentIndex: bottomNavCurrentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedFontSize: block * 3,
          unselectedFontSize: block * 3,
          selectedItemColor: Colors.pink,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Upload'),
            BottomNavigationBarItem(icon: Icon(Icons.sms_outlined), label: 'Inbox'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
