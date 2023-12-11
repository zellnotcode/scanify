import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scanify/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/scanify_logo.png",
              width: 279,
            ),
          ),
          const SizedBox(
            height: 232,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
            ),
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 2500,
              lineHeight: 11,
              percent: 1,
              progressColor: redColor,
              barRadius: const Radius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
