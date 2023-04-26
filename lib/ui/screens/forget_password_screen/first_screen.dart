import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import '../../components/breathe_background.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
class ForgetPasswordP1 extends StatelessWidget {
  var passKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final passController = TextEditingController();

    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        if (state is ForgetPasswordErrorState) {
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
        var cubit = BreatheCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: passKey,
              child: Column(
                children: [
                  const BreatheBackground(),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Forget Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset('assets/images/lock.png'),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '''Please Enter Your Email Address To
Recieve a Verification Code
                    ''',
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(5.0),
                    child: defaultFormField(
                      controller: passController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value == null) {
                          return 'please add your email';
                        }
                        return null;
                      },
                      label: 'email',
                      prefix: Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 55,
                      child: BuildCondition(
                        condition: state is! ForgetPasswordLoadingState,
                        builder: (context) => CustomButton(
                          text: 'Send',
                          onTap: () {
                            print('objectobjectobjectobjectobject ${passController.text}');
                            cubit.forgetPassword(
                              passController.text,
                              context,
                            );

                          },
                        ),
                        fallback: (context) => const Center(
                            child: CircularProgressIndicator()),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
