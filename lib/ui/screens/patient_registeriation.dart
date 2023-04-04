import 'package:flutter/material.dart';

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
                      backgroundImage: AssetImage('assets/images/doctor_pic.png'),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome!',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Dr-Sayed',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
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
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButton(
                      isExpanded: true,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(15),
                      iconSize: 22,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black),
                      // Initial Value
                      value: dropdownDefaultValue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        if (newValue == 'Already Existed Patient') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                          );
                        }
                        if (newValue == 'New Patient') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewPatientRegistrationView();
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //NewPatientRegistrationView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
