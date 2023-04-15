import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import 'package:grad_proj_ui_test/ui/screens/patient_registeriation.dart';
import 'package:grad_proj_ui_test/modules/signup/signup_screen.dart';
import '../../constants/components.dart';
import '../../network/local/cache_helper.dart';
import '../components/breathe_background.dart';
import 'forget_password_screen/first_screen.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class LoginScreen extends StatelessWidget {
  var formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.message == 'Successfull Login') {
            navigateAndFinish(
              PatientRegistrationScreen(),
              context,
            );
          }
        }
        if (state is LoginErrorState) {
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
      builder: (context, state){
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formLoginKey,
              child: Column(
                children: [
                  const BreatheBackground(),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 33, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                      label: '',
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      hint: 'email',
                      prefix: Icons.email_outlined,
                      validate: (value) {
                        if (value == null) {
                          return 'please add your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultFormField(
                      label: '',
                      type: TextInputType.visiblePassword,
                      controller: passwordController,
                      hint: 'password',
                      prefix: Icons.lock_rounded,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please add your password';
                        }
                        if (value.length > 15) {
                          return 'password must be less than 15 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgetPasswordP1();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Your Password ?  ',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 55,
                      child: BuildCondition(
                        condition: state is! LoginLoadingState,
                        builder: (context) => CustomButton(
                          text: 'Log in',
                          onTap: () {
                            BreatheCubit.get(context).getAllPatients(CacheHelper.getData(key: 'Token'));
                            if (formLoginKey.currentState!
                                .validate()) {
                              FocusScope.of(context).unfocus();
                              debugPrint('email : ${emailController.text}');
                              debugPrint('password : ${passwordController.text}');
                              BreatheCubit.get(context).login1(
                                emailController.text,
                                passwordController.text,
                                //token: CacheHelper.getData(key: 'token') ??'',
                                //context: context,
                              );
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          },
                        ),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator()),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or ',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Theme.of(context).primaryColor, fontSize: 18),
                      ),
                      Text(
                        'log in with',
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
                    height: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontSize: 16, color: Theme.of(context).primaryColor),
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
    );
  }
}
