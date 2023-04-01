import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, this.onTap});

  VoidCallback? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF001B48).withOpacity(0.85),
          borderRadius: BorderRadius.circular(18),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
