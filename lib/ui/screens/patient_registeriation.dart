import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:lottie/lottie.dart';

import '../components/new_patient_registration_view.dart';
import 'home/home_screen.dart';

class PatientRegistrationScreen extends StatelessWidget {
  // Initial Selected Value
  String dropdownDefaultValue = 'New Patient';

  // List of items in our dropdown menu
  var items = [
    'Already Existed Patient',
    'New Patient',
  ];

  PatientRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/doctor_pic.png'),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome!',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Dr-Sayed',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontSize: 16,
                                  ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'select your state',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Lottie.asset('assets/lotties/newOld.json',
                    height: size.height * .1),
                buildContainer(
                  size,
                  'New Patient',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NewPatientRegistrationView();
                      },
                    ),
                  ),
                ),
                buildContainer(
                  size,
                  'Already Existed Patient',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildContainer(Size size, text, function) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            function();
          },
          child: Container(
            height: size.height * .2,
            width: size.width * .9,
            decoration: BoxDecoration(
              gradient: gradient,
              //color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(size.width * .1)),
            ),
            child: Center(
              child: Text(
                '$text',
                style: const TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * .02),
      ],
    );
  }
}
