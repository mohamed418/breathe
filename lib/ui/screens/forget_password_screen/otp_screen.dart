import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../components/breathe_background.dart';
import '../../components/custom_button.dart';
import 'create_new_password_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

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
              style:
                  Theme.of(context).textTheme.headline4?.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(5.0),
              child: OtpTextField(
                fillColor: Theme.of(context).primaryColor,
                textStyle: Theme.of(context).textTheme.headline6,
                numberOfFields: 4,
                borderColor: Theme.of(context).primaryColor,
                focusedBorderColor: Theme.of(context).primaryColor,
                //styles: otpTextStyles,
                showFieldAsBox: false,
                borderWidth: 4.0,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here if necessary
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {},
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 55,
                child: CustomButton(
                    text: 'Verify',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CreateNewPasswordScreen();
                          },
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
