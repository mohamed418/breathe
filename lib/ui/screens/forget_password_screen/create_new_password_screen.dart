import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/screens/onboarding_screen.dart';
import '../../components/breathe_background.dart';
import '../../components/custom_button.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style:
                  Theme.of(context).textTheme.headline4?.copyWith(fontSize: 18),
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
                  controller: null,
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
                )),
            Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(5.0),
                child: defaultFormField(
                  hint: 'Confirm Password',
                  label: '',
                  type: TextInputType.text,
                  controller: null,
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
                child: CustomButton(
                  text: 'Save',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return OnboardingScreen();
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
