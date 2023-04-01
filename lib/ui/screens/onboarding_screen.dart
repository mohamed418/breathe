import 'package:flutter/material.dart';

import '../../models/onboarding_model.dart';
import '../components/breathe_background.dart';
import '../components/custom_button.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final _pageController = PageController();

  List<Instruction> onBoardingInstructions = [
    Instruction(
        image: 'assets/images/onboarding_1.jpg',
        content:
            'People with respiratory conditions, usually need to breathe freely'),
    Instruction(
        image: 'assets/images/onboarding_2.jpg',
        content:
            'using this application , you will know Disease and the way to cure it'),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const BreatheBackground(),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: onBoardingInstructions.length,
                itemBuilder: (context, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(child: Image.asset(onBoardingInstructions[i].image)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingInstructions.length,
                        (f) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: f == i ? 15 : 5,
                          height: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 11.0),
                    Text(
                      onBoardingInstructions[i].content,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontSize: 21),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8),
                child: CustomButton(
                  text: 'lets start',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
