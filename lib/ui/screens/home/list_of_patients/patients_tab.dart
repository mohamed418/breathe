import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import '../../../components/patient_label.dart';
import '../../patient_registeriation.dart';

class PatientsTab extends StatelessWidget {
  const PatientsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  PatientRegistrationScreen();
              },
            ),
          );
        },
        backgroundColor: const Color(0xFF001B48).withOpacity(0.85),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Text("List of Patients",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ))),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: defaultFormField(
                label: '',
                type: TextInputType.visiblePassword,
                controller: null,
                hint: 'Search there...',
                prefix: Icons.search,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  if (value.length > 11) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (buildContext, index) {
                    return const PatientLabel();
                  },
                  separatorBuilder: (buildContext, index) {
                    return const SizedBox(
                      width: 1,
                      height: 0.5,
                    );
                  },
                  itemCount: 20),
            )
          ],
        ),
      ),
    );
  }
}
