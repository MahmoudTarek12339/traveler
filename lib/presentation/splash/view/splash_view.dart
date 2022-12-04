import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:traveler/presentation/home/view/main_view.dart';
import 'package:traveler/presentation/resources/constants_manager.dart';
import 'package:traveler/presentation/resources/strings_manager.dart';
import 'package:traveler/presentation/resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _ballDropped = false;
  bool _containerVisibility = false;
  bool _containerAnimation = false;
  bool _textAnimation = false;
  bool _navigate = false;

  @override
  void initState() {
    super.initState();
    _initTimers();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _navigate ? 900 : 2500),
              curve: _navigate ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _navigate ? 0 : _ballDropped ? h / 2 : 20,
              width: AppSize.s20
            ),
            AnimatedContainer(
              duration: Duration(seconds: _navigate? 1 : _containerAnimation ? 2 : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _navigate ? h : _containerAnimation ? 80 : 20,
              width: _navigate ? w : _containerAnimation ? 200 : 20,
              decoration: BoxDecoration(
                  color: _navigate
                      ? Colors.white
                      : _containerVisibility
                          ? Colors.black
                          : Colors.transparent,
                  borderRadius: _navigate ? null : BorderRadius.circular(AppSize.s30)),
              child: Center(
                child: _textAnimation
                    ? AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                        FadeAnimatedText(AppStrings.traveler,
                            duration: const Duration(milliseconds: 1700),
                            textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white))
                      ])
                    : const SizedBox(),
              ),
            ),
          ])));
  }

  _initTimers() {
    //timer till ball dropped and change container visibility
    Timer(const Duration(milliseconds: AppConstants.droppedBallAnimation), () {
      setState(() {
        _ballDropped = true;
        _containerVisibility = true;
      });
    });
    //timer for container expand animation
    Timer(const Duration(milliseconds: AppConstants.expandContainerAnimation),
        () {
      setState(() {
        _containerAnimation = true;
      });
    });
    //timer for text animation
    Timer(const Duration(milliseconds: AppConstants.textAnimation), () {
      setState(() {
        _textAnimation = true;
      });
    });
    //timer for fade transition
    Timer(const Duration(milliseconds: AppConstants.navigateAnimation), () {
      setState(() {
        _navigate = true;
      });
    });
    //timer to navigate to main page
    Timer(const Duration(milliseconds: AppConstants.changeScreenAnimation), () {
      openHomePage();
    });
  }

  void openHomePage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: const MainView(),
          );
        },
      ),
    );
  }
}
