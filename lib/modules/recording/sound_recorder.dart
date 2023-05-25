import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderPage extends StatefulWidget {
  @override
  _AudioRecorderPageState createState() => _AudioRecorderPageState();
}

class _AudioRecorderPageState extends State<AudioRecorderPage> {
  bool _isRecording = false;
  String _recordFilePath = '';
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final microphoneStatus = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();
    final mediaLibraryStatus = await Permission.mediaLibrary.request();

    if (microphoneStatus.isGranted &&
        storageStatus.isGranted &&
        mediaLibraryStatus.isGranted) {
      // Permissions have been granted, perform necessary actions
      // for accessing the microphone, storage, and media library.
    } else {
      // Permissions have been denied or permanently denied. Show a message or disable
      // features that require access to the microphone, storage, and media library.
      if (microphoneStatus.isPermanentlyDenied ||
          storageStatus.isPermanentlyDenied ||
          mediaLibraryStatus.isPermanentlyDenied) {
        // Permissions have been permanently denied by the user.
        // Show a dialog or prompt to allow permissions manually.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permissions Required'),
              content: Text(
                  'Please grant the necessary permissions to access the microphone, storage, and media library.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                  child: Text('Open Settings'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Handle the case where the user chooses not to open settings
                    // and provide an alternative flow or display an informative message.
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<String> _generateFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/recording.wav';
  }

  void _startRecording() async {
    final filePath = await _generateFilePath();
    setState(() {
      _isRecording = true;
      _recordFilePath = filePath;
    });
    // Start recording logic
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    // Stop recording logic
  }

  void _playRecording() {
    if (_recordFilePath.isNotEmpty) {
      dynamic uri = Uri.parse(_recordFilePath);
      _audioPlayer.play(
        uri,
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_recordFilePath.isNotEmpty) ...[
              Text('Recorded File Path: $_recordFilePath'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _playRecording,
                child: const Text('Play Recording'),
              ),
            ],
            const SizedBox(height: 20),
            _isRecording
                ? ElevatedButton(
                    onPressed: _stopRecording,
                    child: const Text('Stop Recording'),
                  )
                : ElevatedButton(
                    onPressed: _startRecording,
                    child: const Text('Start Recording'),
                  ),
          ],
        ),
      ),
    );
  }
}
