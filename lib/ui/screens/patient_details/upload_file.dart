import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'result_screen.dart';

Future<void> uploadVoiceFile(BuildContext context, patientId) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        File file = File(result.files.single.path!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              audioFile: file,
              patientId: patientId,
            ),
          ),
        );
      }
    }
  } catch (e) {
    print('Error selecting voice recording: $e');
  }
}
