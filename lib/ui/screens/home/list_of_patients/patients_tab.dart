import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/screens/home/list_of_patients/search_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/transitions.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../components/custom_button.dart';
import '../../patient_details/patient_profile.dart';
import '../../patient_registeriation.dart';

class PatientsTab extends StatelessWidget {
  const PatientsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final searchController = TextEditingController();
        // Size size = MediaQuery.of(context).size;
        var cubit = BreatheCubit.get(context);
        dynamic i = 1;
        InkWell buildPatientItem(BuildContext context, name, phoneNumber,
            address, gender, i, patientId) {
          Size size = MediaQuery.of(context).size;
          return InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Lottie.asset('assets/lotties/delete.json'),
                  actions: [
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.deletePatient(
                                context,
                                CacheHelper.getData(key: 'Token'),
                                name,
                              );
                            },
                            child: shadeMask(
                              'delete',
                              const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PatientProfile(
                      name: name,
                      phoneNumber: phoneNumber,
                      address: address,
                      gender: gender,
                      patientId: patientId,
                    );
                  },
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
              height: size.height * .01,
              width: size.width * .7,
              child: Row(
                children: [
                  Text(
                    '$i-',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Center(
                      child: Text("List of Patients",
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                  ))),
                  const SizedBox(height: 15),
                  defaultFormField(
                    label: '',
                    type: TextInputType.visiblePassword,
                    controller: searchController,
                    hint: 'Search there...',
                    prefix: Icons.search,
                    onTap: () => Navigator.push(
                      context,
                      CustomPageRoute1(child: SearchScreen()),
                    ),
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
                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'add patient',
                    onTap: () {
                      BreatheCubit.get(context)
                          .getAllPatients(CacheHelper.getData(key: 'Token'));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PatientRegistrationScreen();
                          },
                        ),
                      );
                    },
                  ),
                  Center(
                    child: BuildCondition(
                      condition: state is! GetAllPatientsLoadingState,
                      builder: (context) => BuildCondition(
                        condition:
                            cubit.getAllPatientsModel!.patients.isNotEmpty,
                        builder: (context) => GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / .2,
                          crossAxisCount: 1,
                          children: List.generate(
                            cubit.getAllPatientsModel!.patients.length,
                            (index) => buildPatientItem(
                              context,
                              cubit.getAllPatientsModel!.patients[index]
                                  .fullName,
                              cubit.getAllPatientsModel!.patients[index]
                                  .mobileNumber,
                              cubit
                                  .getAllPatientsModel!.patients[index].address,
                              cubit.getAllPatientsModel!.patients[index].gender,
                              '${i + index}',
                              cubit.getAllPatientsModel!.patients[index].id,
                            ),
                          ),
                        ),
                        fallback: (context) => const Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text('no patients yet',
                              style: TextStyle(fontSize: 30)),
                        ),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
