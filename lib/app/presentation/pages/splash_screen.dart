import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../resources/font_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with UiLoggy {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(title: "da splash"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: const AssetImage("assets/images/splashBackground.jpg"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.35),
              BlendMode.modulate,
            ),
            fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainSplashContent(
            loggy: loggy,
          ),
          IconCredit(loggy: loggy)
        ],
      ),
    );
  }
}

class IconCredit extends StatelessWidget {
  const IconCredit({
    super.key,
    required this.loggy,
  });

  final Loggy<UiLoggy> loggy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "icon by ",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        GestureDetector(
          onTap: () {
            loggy.debug("TAPPED ON ICONS8 link.");
            launchUrl(
                Uri.parse("https://icons8.com/icon/7I3BjCqe9rjG/flutter"));
          },
          child: Text(
            "Icons8",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeightManager.bold),
          ),
        )
      ],
    );
  }
}

class MainSplashContent extends StatelessWidget {
  const MainSplashContent({
    Key? key,
    required this.loggy,
  }) : super(key: key);

  final Loggy<UiLoggy> loggy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/icons8-flutter.png",
            height: 150,
            fit: BoxFit.cover,
          ),
          Text(
            "Offerte di lavoro Flutter!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 40,
          ),

          SleekCircularSlider(
            min: 0,
            max: 100,
            initialValue: 100,

            appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                    dotColor: Colors.transparent,
                    trackColor: Colors.transparent,
                    dynamicGradient: true,
                    progressBarColors: [
                      Colors.black,
                      Colors.blueGrey,
                    ]),
                spinnerDuration: 3000,
                animDurationMultiplier: 2,
                spinnerMode: false,
                infoProperties: InfoProperties(
                    mainLabelStyle: Theme.of(context).textTheme.headlineLarge)),
            // onChange: (double value) {
            //   loggy.debug(value);
            // },
          ),

          // const CircularProgressIndicator(),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Initializing app...',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
