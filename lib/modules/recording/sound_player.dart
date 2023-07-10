import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/bloc/cubit.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../network/local/cache_helper.dart';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path/path.dart' as path;


late String result;

// Define the states
abstract class PredictResultState {}

class PredictResultLoadingState extends PredictResultState {}

class PredictResultSuccessState extends PredictResultState {
  final String result;

  PredictResultSuccessState(this.result);
}

class PredictResultErrorState extends PredictResultState {
  final String error;

  PredictResultErrorState(this.error);
}

// Define the cubit
class PredictResultCubit extends Cubit<PredictResultState> {
  final Dio dio = Dio();
  final String baseUrl = 'https://dolphin-app-9u8lj.ondigitalocean.app/predict';

  PredictResultCubit() : super(PredictResultLoadingState());

  Future<String> convertToWav(String inputFilePath) async {
    final outputFilePath = path.basenameWithoutExtension(inputFilePath) + '.wav';

    final ffmpegCommand = '-i $inputFilePath -acodec pcm_s16le -ac 1 -ar 16000 $outputFilePath';

    final FFmpegSession rc = await FFmpegKit.executeAsync(ffmpegCommand);

    if (ReturnCode.isSuccess(rc as ReturnCode?)) {
      return outputFilePath;
    } else {
      throw Exception('Audio conversion failed');
    }
  }


  void predictAudio(File audioFile, context, patientId) async {
    // Convert audio file to WAV format
    final wavFilePath = await convertToWav(audioFile.path);

    // Create FormData with the WAV file
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(wavFilePath),
    });
    emit(PredictResultLoadingState());
    buildSnackBar('Please wait for seconds', context, 2);

    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(audioFile.path),
      });

      Response response = await dio.post(baseUrl, data: formData);

      if (response.statusCode == 200) {
        result = response.data['result'];

        emit(PredictResultSuccessState(result));
        debugPrint('patientId: $patientId');
      } else {
        emit(PredictResultErrorState('Error occurred during prediction.'));
      }
    } catch (error) {
      emit(PredictResultErrorState('Error occurred: $error'));
      print(error);
    }
  }

}

class SoundPlayerScreen extends StatefulWidget {
  SoundPlayerScreen({Key? key}) : super(key: key);

  @override
  State<SoundPlayerScreen> createState() => _SoundPlayerScreenState();
}

class _SoundPlayerScreenState extends State<SoundPlayerScreen> {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone Permission is denied');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  Future<void> _disposeRecorder() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;
    final appDir = await getApplicationDocumentsDirectory();
    final audioPath = appDir.path + '/audio_recording.aac';
    await _audioRecorder!.startRecorder(toFile: audioPath);
    setState(() {
      _isRecording = true;
      _recordedFilePath = null;
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized) return;
    final recordedFilePath = await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      _recordedFilePath = recordedFilePath;
    });
  }

  // Future<void> _playRecordedAudio() async {
  //   if (_recordedFilePath == null) return;
  //   final audioPlayer = FlutterSoundPlayer();
  //   await audioPlayer.openAudioSession();
  //   await audioPlayer.startPlayer(
  //     fromURI: _recordedFilePath!,
  //     codec: Codec.aacADTS,
  //   );
  //   await audioPlayer.isStopped;
  //   await audioPlayer.closeAudioSession();
  // }

  Future<void> _playRecordedAudio() async {
    if (_recordedFilePath == null) return;
    final audioPlayer = FlutterSoundPlayer();
    await audioPlayer.openAudioSession();
    await audioPlayer.startPlayer(
      fromURI: _recordedFilePath!,
      codec: Codec.aacADTS,
      whenFinished: () {
        audioPlayer.closeAudioSession();
      },
    );
  }



  @override
  void dispose() {
    _disposeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => PredictResultCubit(),
        child: BlocConsumer<PredictResultCubit, PredictResultState>(
            listener: (context, state) {
              if (state is PredictResultSuccessState) {
                // Display the success result
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Prediction Result'),
                    content: Text(state.result),
                    actions: [
                      TextButton(
                        onPressed: () {
                          BreatheCubit.get(context).createMedicalRecord(
                            context,
                            CacheHelper.getData(key: 'Token'),
                            result,
                            "87",
                          );
                        },
                        child: const Text('Create Medical Record'),
                      ),
                    ],
                  ),
                );
              } else if (state is PredictResultErrorState) {
                // Display the error message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.error),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              Widget buildPlaybackButton() {
                final isAudioAvailable = _recordedFilePath != null;
                return ElevatedButton(
                  onPressed: isAudioAvailable ? () {
                    final audioFile = File(_recordedFilePath!);
                    print('recorded file : ${audioFile}');
                    final predictResultCubit = BlocProvider.of<PredictResultCubit>(context);
                    predictResultCubit.predictAudio(audioFile, context, "87"); // Replace "87" with the appropriate patient ID

                    // Start playing the recorded audio after the prediction
                    _playRecordedAudio();
                  } : null,
                  child: Text('Play and Predict'),
                );
              }

              return Container(
                color: Colors.white,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 10,
                                child: Text(
                                  'don\'t forget to use the doctor stethoscope',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: defaultColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(flex: 5,child: Lottie.asset('assets/lotties/mic.json')),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 100,bottom: 50),
                            child: buildStartButton(),
                          ),
                          const SizedBox(height: 20),
                          buildPlaybackButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              );}
        ),
      ),
    );
  }

  Widget buildStartButton() {
    final icon = _isRecording ? Icons.stop : Icons.mic;
    final text = _isRecording ? 'Stop Recording' : 'Start Recording';
    final containerColor = _isRecording ? Colors.red : defaultColor;
    final textColor = _isRecording ? Colors.white : Colors.white;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(20)),
      height: _isRecording ? 100 : 80,
      child: TextButton(
        onPressed: _isRecording ? _stopRecording : _startRecording,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
            _isRecording
                ? Lottie.asset(
              'assets/lotties/rec.json',
            )
                : Icon(icon, color: textColor),
          ],
        ),
      ),
    );
  }

// Widget buildPlaybackButton() {
//   final isAudioAvailable = _recordedFilePath != null;
//   // return FloatingActionButton(onPressed: isAudioAvailable ? _playRecordedAudio : null,);
//   return ElevatedButton(
//     onPressed: isAudioAvailable ? _playRecordedAudio : null,
//     child: Text('Play Recorded Audio'),
//   );
// }




// Widget buildUploadFileButton() {
//   final isAudioAvailable = _recordedFilePath != null;
//   // return FloatingActionButton(onPressed: isAudioAvailable ? _playRecordedAudio : null,);
//   return BlocProvider(
//     create: ,
//     child: ElevatedButton(
//       onPressed: isAudioAvailable ? predictAudio() : null,
//       child: Text('Play Recorded Audio'),
//     ),
//   );
// }
}

//
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:grad_proj_ui_test/bloc/cubit.dart';
// import 'package:grad_proj_ui_test/constants/components.dart';
// import 'package:lottie/lottie.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../network/local/cache_helper.dart';
//
// late String result;
//
// // Define the states
// abstract class PredictResultState {}
//
// class PredictResultLoadingState extends PredictResultState {}
//
// class PredictResultSuccessState extends PredictResultState {
//   final String result;
//
//   PredictResultSuccessState(this.result);
// }
//
// class PredictResultErrorState extends PredictResultState {
//   final String error;
//
//   PredictResultErrorState(this.error);
// }
//
// // Define the cubit
// class PredictResultCubit extends Cubit<PredictResultState> {
//   final Dio dio = Dio();
//   final String baseUrl = 'https://dolphin-app-9u8lj.ondigitalocean.app/predict';
//
//   PredictResultCubit() : super(PredictResultLoadingState());
//
//   Future<String> convertToWav(String inputFilePath) async {
//     final outputFilePath = path.basenameWithoutExtension(inputFilePath) + '.wav';
//
//     final ffmpegCommand = '-i $inputFilePath -acodec pcm_s16le -ac 1 -ar 16000 $outputFilePath';
//
//     final FFmpegSession returnCode = await FFmpegKit.executeAsync(ffmpegCommand);
//
//     if (returnCode == ReturnCode.success) {
//       return outputFilePath;
//     } else {
//       throw Exception('Audio conversion failed');
//     }
//   }
//
//
//
//
//
//   void predictAudio(File audioFile, context, patientId) async {
// // Convert audio file to WAV format
//     final wavFilePath = await convertToWav(audioFile.path);
// // Create FormData with the WAV file
//     FormData formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile(wavFilePath),
//     });
//
//     emit(PredictResultLoadingState());
//     buildSnackBar('Please wait for seconds', context, 2);
//
//     try {
//       Response response = await dio.post(baseUrl, data: formData);
//
//       if (response.statusCode == 200) {
//         result = response.data['result'];
//
//         emit(PredictResultSuccessState(result));
//         debugPrint('patientId: $patientId');
//       } else {
//         emit(PredictResultErrorState('Error occurred during prediction.'));
//       }
//     } catch (error) {
//       emit(PredictResultErrorState('Error occurred: $error'));
//       print(error);
//     }
//   }
// }
//
// class SoundPlayerScreen extends StatefulWidget {
//   SoundPlayerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SoundPlayerScreen> createState() => _SoundPlayerScreenState();
// }
//
// class _SoundPlayerScreenState extends State<SoundPlayerScreen> {
//   FlutterSoundRecorder? _audioRecorder;
//   bool _isRecorderInitialized = false;
//   bool _isRecording = false;
//   String? _recordedFilePath;
//
//   @override
//   void initState() {
//     super.initState();
//     _initRecorder();
//   }
//
//   Future<void> _initRecorder() async {
//     _audioRecorder = FlutterSoundRecorder();
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Microphone Permission is denied');
//     }
//
//     await _audioRecorder!.openAudioSession();
//     _isRecorderInitialized = true;
//   }
//
//   Future<void> _disposeRecorder() async {
//     if (!_isRecorderInitialized) return;
//     await _audioRecorder!.closeAudioSession();
//     _audioRecorder = null;
//     _isRecorderInitialized = false;
//   }
//
//   Future<void> _startRecording() async {
//     if (!_isRecorderInitialized) return;
//     final appDir = await getApplicationDocumentsDirectory();
//     final audioPath = appDir.path + '/audio_recording.aac';
//     await _audioRecorder!.startRecorder(toFile: audioPath);
//     setState(() {
//       _isRecording = true;
//       _recordedFilePath = null;
//     });
//   }
//
//   Future<void> _stopRecording() async {
//     if (!_isRecorderInitialized) return;
//     final recordedFilePath = await _audioRecorder!.stopRecorder();
//     setState(() {
//       _isRecording = false;
//       _recordedFilePath = recordedFilePath;
//     });
//   }
//
//   Future<void> _playRecordedAudio() async {
//     if (_recordedFilePath == null) return;
//     final audioPlayer = FlutterSoundPlayer();
//     await audioPlayer.openAudioSession();
//     await audioPlayer.startPlayer(
//       fromURI: _recordedFilePath!,
//       codec: Codec.aacADTS,
//       whenFinished: () {
//         audioPlayer.closeAudioSession();
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _disposeRecorder();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (_) => PredictResultCubit(),
//         child: BlocConsumer<PredictResultCubit, PredictResultState>(
//           listener: (context, state) {
//             if (state is PredictResultSuccessState) {
// // Display the success result
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Prediction Result'),
//                   content: Text(state.result),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         BreatheCubit.get(context).createMedicalRecord(
//                           context,
//                           CacheHelper.getData(key: 'Token'),
//                           result,
//                           "87",
//                         );
//                       },
//                       child: const Text('Create Medical Record'),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is PredictResultErrorState) {
// // Display the error message
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Error'),
//                   content: Text(state.error),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             Widget buildPlaybackButton() {
//               final isAudioAvailable = _recordedFilePath != null;
//               return ElevatedButton(
//                 onPressed: isAudioAvailable
//                     ? () async {
//                   final audioFile = File(_recordedFilePath!);
//                   final predictResultCubit =
//                   BlocProvider.of<PredictResultCubit>(context);
//                   // Convert audio file to WAV format
//                   final wavFilePath =
//                   await predictResultCubit.convertToWav(audioFile.path);
//
//                   // Create FormData with the WAV file
//                   FormData formData = FormData.fromMap({
//                     'file': await MultipartFile.fromFile(wavFilePath),
//                   });
//
//                   // Predict audio with converted WAV file
//                   predictResultCubit.predictAudio(
//                       audioFile, context, "87"); // Replace "87" with the appropriate patient ID
//
//                   // Start playing the recorded audio after the prediction
//                   _playRecordedAudio();
//                 }
//                     : null,
//                 child: Text('Play and Predict'),
//               );
//             }
//
//             return Container(
//               color: Colors.white,
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 10,
//                               child: Text(
//                                 'don\'t forget to use the doctor stethoscope',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: defaultColor,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 5,
//                               child: Lottie.asset('assets/lotties/mic.json'),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 100, bottom: 50),
//                           child: buildStartButton(),
//                         ),
//                         const SizedBox(height: 20),
//                         buildPlaybackButton(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget buildStartButton() {
//     final icon = _isRecording ? Icons.stop : Icons.mic;
//     final text = _isRecording ? 'Stop Recording' : 'Start Recording';
//     final containerColor = _isRecording ? Colors.red : defaultColor;
//     final textColor = _isRecording ? Colors.white : Colors.white;
//     return AnimatedContainer(
//       duration: const Duration(seconds: 1),
//       decoration: BoxDecoration(
//         color: containerColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       height: _isRecording ? 100 : 80,
//       child: TextButton(
//         onPressed: _isRecording ? _stopRecording : _startRecording,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(
//               text,
//               style: TextStyle(color: textColor),
//             ),
//             _isRecording
//                 ? Lottie.asset(
//               'assets/lotties/rec.json',
//             )
//                 : Icon(icon, color: textColor),
//           ],
//         ),
//       ),
//     );
//   }
// }