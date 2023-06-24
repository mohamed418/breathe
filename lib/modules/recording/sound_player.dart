import 'package:flutter/material.dart';
import 'package:grad_proj_ui_test/constants/components.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

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
      body: Container(
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

  Widget buildPlaybackButton() {
    final isAudioAvailable = _recordedFilePath != null;
    // return FloatingActionButton(onPressed: isAudioAvailable ? _playRecordedAudio : null,);
    return ElevatedButton(
      onPressed: isAudioAvailable ? _playRecordedAudio : null,
      child: Text('Play Recorded Audio'),
    );
  }
}