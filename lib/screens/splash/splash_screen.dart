import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';
import '../../constants/screens.dart';
import '../../data/di/di.dart';
import '../../styles/colors.dart';
import '../../widgets/default_rich_text.dart';
import '../../widgets/default_text_span.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..forward();

    if (sl<MySharedPref>().getString(key: MySharedKeys.apiToken).isNotEmpty) {
      Timer(const Duration(milliseconds: 4000), () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      });
    } else {
      Timer(const Duration(milliseconds: 4000), () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(loginRoute, (route) => false);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultAppColor3,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: DefaultRichText(
                    text: defaultTextSpan(children: [
              defaultTextSpan(text: 'T', color: defaultAppColor2),
              defaultTextSpan(text: 'rans', color: defaultAppColor),
              defaultTextSpan(text: 'V', color: defaultAppColor2),
              defaultTextSpan(text: 'irtual', color: defaultAppColor),
            ]))),
          ],
        ),
      ),
    );
  }
}
