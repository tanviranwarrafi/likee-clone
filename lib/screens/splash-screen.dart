import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:likee_clone/controllers/home-controller.dart';
import 'package:likee_clone/screens/landing-screen.dart';
import 'package:likee_clone/utils/constraints.dart';
import 'package:likee_clone/utils/size-config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HomeController controller = HomeController();
  HomeController value = HomeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initController();
    });
    Timer(
      Duration(seconds: 2),
      () => Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen())),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = Provider.of<HomeController>(context, listen: false);
    value = Provider.of<HomeController>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/app-logo/likee.png', height: width / 2.6, width: width / 2.6),
                  Text('Utech Likee', style: TextStyle(color: black, fontSize: block * 8, fontWeight: FontWeight.bold)),
                  Text('Let you shine', style: TextStyle(color: grey, fontSize: block * 4.4)),
                ],
              ),
            ),
          ),
          Positioned(
            left: -block * 10,
            top: -block * 10,
            child: Container(
              height: block * 50,
              width: block * 50,
              decoration: BoxDecoration(color: Color(0xFFF61E6C), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: -block * 25,
            top: width / 3,
            child: Container(
              height: block * 50,
              width: block * 50,
              decoration: BoxDecoration(color: Color(0xFF6700CF), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: -block * 15,
            bottom: -block * 15,
            child: Container(
              height: block * 50,
              width: block * 50,
              decoration: BoxDecoration(color: Color(0xFFF61E6C), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: -block * 5,
            bottom: block * 35,
            child: Container(
              height: block * 20,
              width: block * 20,
              decoration: BoxDecoration(color: Color(0xFFF61E6C), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: block * 18,
            bottom: block * 30,
            child: Container(
              height: block * 12,
              width: block * 12,
              decoration: BoxDecoration(color: amber, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: block * 45,
            left: block * 10,
            child: Container(height: block * 12, width: block * 12, decoration: BoxDecoration(color: amber, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}
