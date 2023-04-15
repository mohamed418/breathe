import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/transitions.dart';
import '../../../../models/home_instructions_model.dart';
import '../../../components/patient_registration_button.dart';
import '../list_of_patients/search_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _pageController = PageController();

  // To upload image using image_picker

  List<InstructionOfHome> HomeInstructions = [
    InstructionOfHome(
        image: 'assets/images/robot_handshake.png',
        title: 'How to use the breathe app?!',
        description:
            'Just upload a clear image of the affected part and cause breathing difficulty'),
    InstructionOfHome(
        image: 'assets/images/robot_handshake.png',
        title: 'what about result ?!',
        description:
            'You will be answered with a complete diagnosis of the affected part and how to treat it'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/doctor_pic.png'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Dr-Sayed',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontSize: 16,
                            ),
                      )
                    ],
                  ),
                  const Spacer(),
                  const PatientRegistrationButton(),
                  const SizedBox(
                    width: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lotties/search.json'),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, CustomPageRoute1(child: SearchScreen()));
                    },
                    child: const Text('Search on specific patient', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ],
              )
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: HomeInstructions.length,
                itemBuilder: (context, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                        fit: FlexFit.tight,
                        child: Image.asset(HomeInstructions[i].image)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        HomeInstructions.length,
                        (f) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: f == i ? 15 : 5,
                          height: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 11.0),
                    Text(
                      HomeInstructions[i].title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontSize: 21),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      HomeInstructions[i].description,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 55,
              child: CustomButton(
                text: 'upload',
                onTap: () {
                  pickImageFromGallery(ImageSource.gallery);
                  // if you want to access camera , replace gallery with camera
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  // Image Picker Image (Logic missed!)
  File? image;

  Future pickImageFromGallery(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
