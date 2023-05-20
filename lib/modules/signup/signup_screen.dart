import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/screens/login_screen.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../ui/components/breathe_background.dart';
import '../../ui/components/custom_button.dart';
import 'register_cubit/register_cubit.dart';
import 'register_cubit/register_states.dart';

class SignupScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpUserNameController = TextEditingController();
    final signUpEmailController = TextEditingController();
    final signUpPasswordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            if (state.signupModel.message ==
                'Congratulation!! Successfully Register') {
              navigateAndFinish(
                LoginScreen(),
                context,
              );
              MotionToast.success(
                description: const Text(
                  'Successfully Register',
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
          }
          if (state is SignUpErrorState) {
            MotionToast.error(
              description: const Text(
                'please check your inputs',
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const BreatheBackground(),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontSize: 33, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                        label: '',
                        type: TextInputType.name,
                        controller: signUpUserNameController,
                        hint: 'username',
                        prefix: Icons.person,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your user name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                        label: '',
                        type: TextInputType.emailAddress,
                        controller: signUpEmailController,
                        hint: 'Email',
                        prefix: Icons.email,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your email';
                          }
                          // if ((value.contains!('@'))) {
                          //   return 'invalid email address';
                          // }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: defaultFormField(
                        label: '',
                        type: TextInputType.visiblePassword,
                        controller: signUpPasswordController,
                        hint: 'password',
                        prefix: Icons.lock_rounded,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please add your password';
                          }
                          // if (value.length > 15) {
                          //   return 'password must be less than 15 digits';
                          // }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 55,
                        child: BuildCondition(
                          condition: state is! SignUpLoadingState,
                          builder: (context) => CustomButton(
                            text: 'Sign up',
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                debugPrint(
                                    'user name : ${signUpUserNameController.text}');
                                debugPrint(
                                    'email : ${signUpEmailController.text}');
                                debugPrint(
                                    'password : ${signUpPasswordController.text}');
                                SignUpCubit.get(context).userSignUp(
                                  username: signUpUserNameController.text,
                                  email: signUpEmailController.text,
                                  password: signUpPasswordController.text,
                                  //token: CacheHelper.getData(key: 'token') ??'',
                                  //context: context,
                                );
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Or ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18),
                        ),
                        Text(
                          'sign up with',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/google.svg',
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/images/facebook.svg',
                          height: 25,
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account ?',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
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
                            'Log in',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    )
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
