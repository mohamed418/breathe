import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit.dart';
import '../../../bloc/states.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BreatheCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Your Medical Records',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / .2,
                      crossAxisCount: 1,
                      children: List.generate(
                        cubit.readMedicalRecordModel!.patients.length,
                            (index) => Text(
                              cubit.readMedicalRecordModel!.patients[index].result,
                              style: const TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
