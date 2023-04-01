import 'package:flutter/material.dart';

import '../screens/patient_details/patient_profile.dart';

class PatientLabel extends StatelessWidget {
  const PatientLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PatientProfile();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          color: Colors.transparent,
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/patient1.png'),
              ),
              const SizedBox(
                width: 9,
              ),
              Text(
                "Patient ....",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 19, fontWeight: FontWeight.w400),
              ),
              const Spacer(
                flex: 1,
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
