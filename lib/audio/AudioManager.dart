


import 'package:audioplayer/audioplayer.dart';

import 'package:audio_recorder2/audio_recorder2.dart';


const String Voice = 'Audio';

class AudioManager {

  AudioManager();

  bool _isRecording = false;
static bool isHasPermission = false;

  start() async {

    if (!_isRecording) {
      try {
        await AudioRecorder2.start();
          bool isRecording = await AudioRecorder2.isRecording;
          _isRecording = isRecording;
      } catch (e) {
        print(e);
      }
    }
  }

  String url;

  stop() async {
    if (_isRecording) {
      var recording = await AudioRecorder2.stop();
      print("Stop recording: ${recording.path}");
      bool isRecording = await AudioRecorder2.isRecording;
      _isRecording = isRecording;
      url = recording.path;
    }
    return url;
  }

  play(String url, {bool isLocal = true}) async {
    AudioPlayer audioPlugin = new AudioPlayer();
    try {
      //播放音频
      await audioPlugin.play(url, isLocal: isLocal);
    } catch (e) {
      print(e);
    }
  }
}
