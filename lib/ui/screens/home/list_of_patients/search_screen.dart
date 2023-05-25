import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/constants/transitions.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import 'package:grad_proj_ui_test/ui/screens/patient_details/patient_profile.dart';

import '../../../../bloc/states.dart';
import '../../../../constants/components.dart';
import '../../../../models/search_patient_model.dart';
import '../../../../network/local/cache_helper.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BreatheCubit, BreatheStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final searchController = TextEditingController();
          Size size = MediaQuery.of(context).size;
          var cubit = BreatheCubit.get(context);

          // Extract the search result from the state
          SearchPatientModel? searchResult;
          String? errorMessage;
          if (state is SearchPatientsSuccessState) {
            searchResult = state.searchResult;
          } else if (state is SearchPatientsErrorState) {
            errorMessage = state.errorMessage;
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      label: '',
                      type: TextInputType.visiblePassword,
                      controller: searchController,
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
                    SizedBox(height: size.height * .1),
                    CustomButton(
                      text: 'search',
                      onTap: () {
                        print('${CacheHelper.getData(key: 'Token')}');
                        print(searchController.text);
                        cubit.searchPatients(
                          CacheHelper.getData(key: 'Token'),
                          searchController.text,
                        );
                      },
                    ),
                    if (searchResult != null) ...[
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Search Result:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              height:
                                  10), // Add spacing between the title and the first patient
                          for (var patient in searchResult.patients)
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    CustomPageRoute1(
                                      child: PatientProfile(
                                        name: patient.fullName,
                                        phoneNumber: patient.mobileNumber,
                                        address: patient.address,
                                        gender: patient.gender,
                                        patientId: patient.id,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Name: ${patient.fullName}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Gender: ${patient.gender}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Address: ${patient.address}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                              'Mobile Number: ${patient.mobileNumber}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        10), // Add spacing between each patient
                              ],
                            ),
                        ],
                      ),
                    ],
                    if (errorMessage != null) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'No patient with such name existed',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
