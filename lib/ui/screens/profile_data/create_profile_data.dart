// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/network/local/cache_helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../bloc/cubit.dart';
import '../../../constants/components.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({Key? key}) : super(key: key);

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  File? image;

  Future pickImage2(ImageSource source) async {
    try {
      final productImage = await ImagePicker().pickImage(source: source);
      if (productImage == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImage2(productImage.path);
      setState(() => image = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<File> saveImage2(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final productImage = File('${directory.path}/$name');
    return File(imagePath).copy(productImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {
        if (state is CreateProfileDataSuccessState) {
          BreatheCubit.get(context).getProfileData(context);
        }
      },
      builder: (context, state) {
        var cubit = BreatheCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BuildCondition(
                  condition: state is! GetProfileDataLoadingState,
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Add your data',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            buildCameraDialog2(context);
                          },
                          child: SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: image == null
                                ? Lottie.asset('assets/lotties/image.json')
                                : Image(
                                    fit: BoxFit.fill,
                                    image: FileImage(image!),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                          controller: doctorNameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter doctor name';
                            }
                            return null;
                          },
                          label: 'Doctor Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        defaultFormField(
                          controller: specializationController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter specialization';
                            }
                            return null;
                          },
                          label: 'Specialization',
                          prefix: Icons.label,
                        ),
                        const SizedBox(height: 10),
                        defaultFormField(
                          controller: yearsOfExperienceController,
                          type: TextInputType.number,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter years of experience';
                            }
                            return null;
                          },
                          label: 'Years of Experience',
                          prefix: Icons.calendar_today,
                        ),
                        const SizedBox(height: 10),
                        defaultFormField(
                          controller: phoneNumberController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        BuildCondition(
                          condition: state is! CreateProfileDataLoadingState,
                          builder: (context) => TextButton(
                              onPressed: () async {
                                if (image == null) {
                                  debugPrint(
                                      'tokeeeeeeeeeeeeeeeeeeeeeeeeeeeen : ${CacheHelper.getData(key: 'Token')}');
                                  MotionToast.error(
                                    description: const Text(
                                      'add an image',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    animationType: AnimationType.fromLeft,
                                    //layoutOrientation: ORIENTATION.rtl,
                                    position: MotionToastPosition.bottom,
                                    width: 300,
                                    height: 100,
                                  ).show(context);
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    cubit.emit(CreateProfileDataLoadingState());
                                    final token =
                                        await CacheHelper.getData(key: 'Token');
                                    const apiUrl =
                                        'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/profiledata';

                                    try {
                                      final request = http.MultipartRequest(
                                          'POST', Uri.parse(apiUrl));
                                      request.headers['Authorization'] =
                                          'Bearer $token';
                                      request.fields['details'] = json.encode({
                                        'doctorname': doctorNameController.text,
                                        'specialization':
                                            specializationController.text,
                                        'years_of_experience':
                                            yearsOfExperienceController.text,
                                        'phone_number':
                                            phoneNumberController.text,
                                      });
                                      request.files.add(
                                          await http.MultipartFile.fromPath(
                                              'image_file', image!.path));

                                      final response = await request.send();

                                      if (response.statusCode == 200) {
                                        // Success
                                        cubit.emit(
                                            CreateProfileDataSuccessState());
                                        final responseString = await response
                                            .stream
                                            .bytesToString();
                                        debugPrint('Response: $responseString');
                                      } else if (response.statusCode == 400) {
                                        cubit.emit(CreateProfileDataErrorState(
                                            'Error occurred:'));
                                        MotionToast.error(
                                          description: const Text(
                                            'ProfileData already exists for this user',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          animationType: AnimationType.fromLeft,
                                          //layoutOrientation: ORIENTATION.rtl,
                                          position: MotionToastPosition.bottom,
                                          width: 300,
                                          height: 100,
                                        ).show(context);
                                      } else {
                                        // Error
                                        debugPrint(
                                            'Error: ${response.statusCode}');
                                      }
                                    } catch (error) {
                                      debugPrint('Error: $error');
                                    }
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              },
                              child: Container(
                                width: 260,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10000),
                                    bottomRight: Radius.circular(10000),
                                    bottomLeft: Radius.circular(10000),
                                  ),
                                  color: image == null
                                      ? Colors.blueGrey
                                      : defaultColor.withOpacity(.4),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'add',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void buildCameraDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Lottie.asset('assets/lotties/image.json'),
        actions: [
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      pickImage2(ImageSource.camera);
                      Navigator.pop(context);
                    });
                  },
                  child: shadeMask(
                    'Camera',
                    const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 120),
                TextButton(
                  onPressed: () {
                    setState(() {
                      pickImage2(ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                  child: shadeMask(
                    'Gallery',
                    const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
