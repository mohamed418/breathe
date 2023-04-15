import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import '../../network/local/cache_helper.dart';
import 'custom_button.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class NewPatientRegistrationView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();

  NewPatientRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        if (state is AddNewPatientErrorState) {
          MotionToast.error(
            description: const Text(
              'please try again',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            animationType: AnimationType.fromLeft,
            //layoutOrientation: ORIENTATION.rtl,
            position: MotionToastPosition.bottom,
            width: 300,
            height: 100,
          ).show(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Add Your Info:)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
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
                        controller: genderController,
                        hint: 'gender',
                        prefix: Icons.transgender_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please add your gender';
                          } else {
                            return null;
                          }
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
                          child: BuildCondition(
                            condition: state is! AddNewPatientLoadingState,
                            builder: (context) => CustomButton(
                              text: 'submit',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  print(nameController.text);
                                  print(addressController.text);
                                  print(phoneController.text);
                                  BreatheCubit.get(context).addNewPatient(
                                    context,
                                    CacheHelper.getData(key: 'Token'),
                                    nameController.text,
                                    genderController.text,
                                    addressController.text,
                                    phoneController.text,
                                  );
                                  // DialogUtils.showProgressDialog(
                                  //     context, 'Loading...');
                                  // DialogUtils.showMessage(context,
                                  //     'patient registered Successfully ..!',
                                  //     positiveActionTitle: 'Ok',
                                  //     negativeActionTitle: 'Cancel',
                                  //     negativeAction: () {
                                  //   return;
                                  // },
                                  //     positiveAction: () {
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
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
