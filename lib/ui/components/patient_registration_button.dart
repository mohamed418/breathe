import 'package:flutter/material.dart';

import '../screens/patient_registeriation.dart';

class PatientRegistrationButton extends StatelessWidget {
  const PatientRegistrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PatientRegistrationScreen();
            },
          ),
        );
      },
      child: CircleAvatar(
          backgroundColor: const Color(0xFF001B48).withOpacity(0.85),
          child: const Icon(Icons.add)),
    );
  }
}
