import 'package:flutter/material.dart';

class BreatheBackground extends StatelessWidget {
  const BreatheBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), fit: BoxFit.fill),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(450),
          bottomRight: Radius.circular(450),
        ),
      ),
      child: Image.asset('assets/images/LOGO.png', fit: BoxFit.fill),
    );
  }
}
