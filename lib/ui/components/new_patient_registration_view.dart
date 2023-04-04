import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'custom_button.dart';

class NewPatientRegistrationView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  NewPatientRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: BackButton(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      label: '',
                      type: TextInputType.name,
                      controller: nameController,
                      hint: 'full name',
                      prefix: Icons.person,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please add your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    defaultFormField(
                      label: '',
                      type: TextInputType.phone,
                      controller: phoneController,
                      hint: 'mobile number',
                      prefix: Icons.phone,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field required';
                        }
                        if (value.length > 11) {
                          return 'invalid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    defaultFormField(
                      label: '',
                      type: TextInputType.text,
                      controller: addressController,
                      hint: 'Address',
                      prefix: Icons.location_city_outlined,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 55,
                        child: CustomButton(
                          text: 'submit',
                          onTap: () {

                            if (formKey.currentState!.validate()) {
                              print(nameController.text);
                              print(addressController.text);
                              print(phoneController.text);
                              BreatheCubit.get(context).addNewPatient(
                                full_name: nameController.text,
                                gender: 'string',
                                address: addressController.text,
                                mobile_number: phoneController.text,
                                // full_name: 'string',
                                // gender: 'string',
                                // address: 'string',
                                // mobile_number: '01112870010',
                                context: context,
                              );
                              // DialogUtils.showProgressDialog(context, 'Loading...');
                              // DialogUtils.showMessage(
                              //     context, 'patient registered Successfully ..!',
                              //     positiveActionTitle: 'Ok',
                              //     negativeActionTitle: 'Cancel', negativeAction: () {
                              //   return;
                              // }, positiveAction: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) {
                              //         return HomeScreen();
                              //       },
                              //     ),
                              //   );
                              // });
                            }
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
