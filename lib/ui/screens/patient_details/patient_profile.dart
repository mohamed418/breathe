import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/network/local/cache_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:grad_proj_ui_test/ui/components/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class PatientProfile extends StatefulWidget {
  final dynamic name;
  final dynamic phoneNumber;
  final dynamic address;
  final dynamic gender;

  const PatientProfile({
    super.key,
    required this.name,
    this.phoneNumber,
    this.address,
    this.gender,
  });

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
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
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8EE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset('assets/lotties/patient_details.json'),
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.name}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  "Gender",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.gender}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.phoneNumber}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  "address",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '${widget.address}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 55,
                    child: CustomButton(
                      text: 'upload',
                      onTap: () {
                        // pickImageFromGallery(ImageSource.gallery);
                        BreatheCubit.get(context).readMedicalRecord(
                          '10',
                          CacheHelper.getData(key: 'Token'),
                        );
                        // if you want to access camera , replace gallery with camera
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
