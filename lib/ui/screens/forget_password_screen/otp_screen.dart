import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import '../../../constants/components.dart';
import '../../components/breathe_background.dart';
import '../../components/custom_button.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key, this.email}) : super(key: key);
  final dynamic email;

  @override
  Widget build(BuildContext context) {
    final verifyController = TextEditingController();

    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        if (state is VerifyCodeErrorState) {
          MotionToast.error(
            description: const Text(
              'please check your email and the code',
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
            child: Column(
              children: [
                const BreatheBackground(),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Verify your email',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset('assets/images/verify.png'),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '''Please Enter The 4 Digits Code
 Sent To Your Email.
                  ''',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(5.0),
                  // child: OtpTextField(
                  //   fillColor: Theme.of(context).primaryColor,
                  //   textStyle: Theme.of(context).textTheme.headline6,
                  //   numberOfFields: 4,
                  //   borderColor: Theme.of(context).primaryColor,
                  //   focusedBorderColor: Theme.of(context).primaryColor,
                  //   //styles: otpTextStyles,
                  //   showFieldAsBox: false,
                  //   borderWidth: 4.0,
                  //   //runs when a code is typed in
                  //   onCodeChanged: (String code) {
                  //   },
                  //   //runs when every textfield is filled
                  //   onSubmit: (String verificationCode) {},
                  // ),
                  child:defaultFormField(
                    controller: verifyController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value == null) {
                        return 'please add your code';
                      }
                      return null;
                    },
                    label: 'code',
                    prefix: Icons.code,
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 55,
                  child: BuildCondition(
                    condition: state is! VerifyCodeLoadingState,
                    builder: (context) => CustomButton(
                      text: 'Verify',
                      onTap: () {
                        cubit.verifyCode(
                          '${verifyController.text}',
                          email,
                          context,
                        );
                      },
                    ),
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
