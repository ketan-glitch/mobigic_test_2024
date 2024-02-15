import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobigic_test_2024/views/base/route_helper.dart';

import '../generated/assets.dart';
import 'question_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(getCustomRoute(child: const QuestionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              Assets.svgMobigicLogo,
              height: size.height * 0.3,
            ),
            const Spacer(),
            Text(
              "Flutter Test",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).primaryColor,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
