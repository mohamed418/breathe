import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import '../../../bloc/cubit.dart';
import '../../../bloc/states.dart';
import '../../components/breathe_background.dart';
import '../../components/custom_button.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key, this.email}) : super(key: key);
  final dynamic email;

  @override
  Widget build(BuildContext context) {
    final newPassController = TextEditingController();
    final confirmNewPassController = TextEditingController();

    return BlocConsumer<BreatheCubit, BreatheStates>(
        listener: (context, state) {
      if (state is ResetPassErrorState) {
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
    }, builder: (context, state) {
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
                'Create new Password',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/done.png'),
              const SizedBox(
                height: 30,
              ),
              Text(
                '''Your New Password Must Be Different
From Previously Used Password
                  ''',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(5.0),
                child: defaultFormField(
                  label: '',
                  type: TextInputType.visiblePassword,
                  controller: newPassController,
                  hint: 'Password',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    if (value.length > 11) {
                      return '';
                    }
                    return null;
                  },
                  prefix: null,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(5.0),
                  child: defaultFormField(
                    hint: 'Confirm Password',
                    label: '',
                    type: TextInputType.text,
                    controller: confirmNewPassController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return '';
                      }
                      if (value.length > 11) {
                        return '';
                      }
                      return null;
                    },
                    prefix: null,
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 55,
                  child: BuildCondition(
                    condition: state is! ResetPassLoadingState,
                    builder: (context) => CustomButton(
                      text: 'Save',
                      onTap: () {
                        cubit.resetPassword(
                          newPassController.text,
                          confirmNewPassController.text,
                          email,
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
      );
    });
  }
}
