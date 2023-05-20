import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/constants/transitions.dart';
import 'package:grad_proj_ui_test/ui/screens/login_screen.dart';
import 'package:grad_proj_ui_test/ui/screens/profile_data/edit_profile_data.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/cubit.dart';
import '../../../../bloc/states.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        // if (state is EditProfileDataSuccessState) {
        //   buildSnackBar('your is successfully updated:)', context, 2);
        // }
      },
      builder: (context, state) {
        var cubit = BreatheCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xFFD6E8EE),
          body: BuildCondition(
            condition: state is! GetProfileDataLoadingState,
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/lotties/doctor.json'),
                      Text(
                        "Name",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          cubit.getProfileDataModel!.profiledata.doctorname,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "Specialization",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          cubit.getProfileDataModel!.profiledata.specialization,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "Phone Number",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          cubit.getProfileDataModel!.profiledata.phoneNumber,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "Nnumber of patients",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          cubit
                              .getProfileDataModel!.profiledata.numberOfPatients
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Logout",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                          fontSize: 25,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.logout,
                                size: 35,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute1(
                                          child: EditProfileDataScreen(
                                        doctorName: cubit.getProfileDataModel!
                                            .profiledata.doctorname,
                                        specialization: cubit
                                            .getProfileDataModel!
                                            .profiledata
                                            .specialization,
                                        yearsOfExperience: cubit
                                            .getProfileDataModel!
                                            .profiledata
                                            .yearsOfExperience,
                                        phoneNumber: cubit.getProfileDataModel!
                                            .profiledata.phoneNumber,
                                      )));
                                },
                                child: Text(
                                  "Edit",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                          fontSize: 25,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.edit,
                                size: 35,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
