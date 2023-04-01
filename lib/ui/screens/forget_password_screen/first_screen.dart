import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import '../../components/breathe_background.dart';
import 'otp_screen.dart';

class ForgetPasswordP1 extends StatelessWidget {
  const ForgetPasswordP1({Key? key}) : super(key: key);

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
              style:
                  Theme.of(context).textTheme.headline4?.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(5.0),
                child: defaultFormField(
                  label: '',
                  type: TextInputType.emailAddress,
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
                  hint: 'Email',
                  prefix: null,
                )),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 55,
                child: CustomButton(
                  text: 'Send',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const OtpScreen();
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
