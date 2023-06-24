import 'dart:io';

import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio_example.aac';

class SoundRecorder{

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init()async{
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException('Microphone Permission is denied');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  Future dispose()async{
    if(!_isRecorderInitialised)return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record()async{
    if(!_isRecorderInitialised)return;
    final filePath = await getFilePath();
    _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }
  Future _stop()async{
    if(!_isRecorderInitialised)return;
    _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async{
    if(_audioRecorder!.isStopped){
      await _record();
    }else{
      await _stop();
    }
  }

  Future<String> getRecordedFilePath() async {
    if (!_isRecorderInitialised) return '';

    final filePath = await getFilePath();
    final file = File(filePath);
    if (await file.exists()) {
      return filePath;
    } else {
      return '';
    }
  }


  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$pathToSaveAudio';
  }
}
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// final pathToSaveAudio = 'audio_example.aac';
//
// class SoundRecorder{
//
//   FlutterSoundRecorder? _audioRecorder;
//   bool _isRecorderInitialised = false;
//
//   bool get isRecording => _audioRecorder!.isRecording;
//
//   Future init()async{
//     _audioRecorder = FlutterSoundRecorder();
//
//     final status = await Permission.microphone.request();
//     if(status != PermissionStatus.granted){
//       throw RecordingPermissionException('Microphone Permission is denied');
//     }
//
//     await _audioRecorder!.openAudioSession();
//     _isRecorderInitialised = true;
//   }
//
//   Future dispose()async{
//     if(!_isRecorderInitialised)return;
//     _audioRecorder!.closeAudioSession();
//     _audioRecorder = null;
//     _isRecorderInitialised = false;
//   }
//
//   Future _record()async{
//     if(!_isRecorderInitialised)return;
//     _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
//   }
//   Future _stop()async{
//     if(!_isRecorderInitialised)return;
//     _audioRecorder!.stopRecorder();
//   }
//
//   Future toggleRecoding() async{
//     if(_audioRecorder!.isStopped){
//       await _record();
//     }else{
//       await _stop();
//     }
//   }
// }
