import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/bloc/states.dart';
import 'package:grad_proj_ui_test/network/local/cache_helper.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileDataScreen extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final int yearsOfExperience;
  final String phoneNumber;
  final File? image;

  const EditProfileDataScreen({
    Key? key,
    required this.doctorName,
    required this.specialization,
    required this.yearsOfExperience,
    required this.phoneNumber,
    this.image,
  }) : super(key: key);

  @override
  _EditProfileDataScreenState createState() => _EditProfileDataScreenState();
}

class _EditProfileDataScreenState extends State<EditProfileDataScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _doctorNameController;
  late TextEditingController _specializationController;
  late TextEditingController _yearsOfExperienceController;
  late TextEditingController _phoneNumberController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _doctorNameController = TextEditingController(text: widget.doctorName);
    _specializationController =
        TextEditingController(text: widget.specialization);
    _yearsOfExperienceController =
        TextEditingController(text: widget.yearsOfExperience.toString());
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _image = widget.image;
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _specializationController.dispose();
    _yearsOfExperienceController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BreatheCubit, BreatheStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Future<void> _editProfileData() async {
          if (_formKey.currentState?.validate() ?? false) {
            final apiUrl =
                'http://ec2-13-41-193-30.eu-west-2.compute.amazonaws.com/user/profiledata/';
            final token = await CacheHelper.getData(
                key: 'Token'); // Retrieve token from cache

            try {
              final request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
              request.headers['Authorization'] = 'Bearer $token';
              request.fields['details'] = json.encode({
                'doctorname': _doctorNameController.text,
                'specialization': _specializationController.text,
                'years_of_experience':
                    int.parse(_yearsOfExperienceController.text),
                'phone_number': _phoneNumberController.text,
              });
              if (_image != null && _image!.existsSync()) {
                // Check if the image file exists
                request.files.add(await http.MultipartFile.fromPath(
                  'image_file',
                  _image!.path,
                ));
              }

              final response = await request.send();

              if (response.statusCode == 200) {
                // Success
                final responseString =
                    await response.stream.bytesToString(); // Response body
                print('Response: $responseString');
                BreatheCubit.get(context).getProfileData(context);
                Navigator.pop(context);
              } else {
                // Error
                print('Error: ${response.statusCode}');
                // Handle the error response as needed
              }
            } catch (error) {
              print('Error: $error');
              // Handle the error as needed
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile Data'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _doctorNameController,
                    decoration: InputDecoration(labelText: 'Doctor Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a doctor name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _specializationController,
                    decoration: InputDecoration(labelText: 'Specialization'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a specialization';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _yearsOfExperienceController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: 'Years of Experience'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter years of experience';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _editProfileData,
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _pickImage,
            child: const Icon(Icons.image),
          ),
        );
      },
    );
  }
}
