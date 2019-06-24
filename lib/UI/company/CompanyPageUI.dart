import 'dart:async';

import 'package:flutter/material.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:math';
import 'package:audioplayer/audioplayer.dart';

import 'package:audio_recorder2/audio_recorder2.dart';

class CompanyPage extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  CompanyPage({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  Recording _recording = new Recording();
  bool _isRecording = false;
  Random random = new Random();
  TextEditingController _controller = new TextEditingController();
  AudioPlayer audioPlugin = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Audio 录制/播放 Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: new Center(
              child: new Padding(
                padding: new EdgeInsets.all(8.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new FlatButton(
                        onPressed: _isRecording ? null : _start,
                        child: new Text("Start"),
                        color: Colors.green,
                      ),
                      new FlatButton(
                        onPressed: _isRecording ? _stop : null,
                        child: new Text("Stop"),
                        color: Colors.red,
                      ),
                      new FlatButton(
                        onPressed: (){_play();},
                        child: new Text("play"),
                        color: Colors.red,
                      ),
                      new TextField(
                        controller: _controller,
                        decoration: new InputDecoration(
                          hintText: '输入录制名字...',
                        ),
                      ),
                      
                    ]),
              ),
            )));
  }

  _start() async {
    try {
      if (await AudioRecorder2.hasPermissions) {
        if (_controller.text != null && _controller.text != "") {
          String path = _controller.text;
          if (!_controller.text.contains('/')) {
            io.Directory appDocDirectory =
                await getApplicationDocumentsDirectory();
            path = appDocDirectory.path + '/' + _controller.text;
          }
          print("Start recording: $path");
          await AudioRecorder2.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          await AudioRecorder2.start();
        }
        bool isRecording = await AudioRecorder2.isRecording;
        setState(() {
          _recording = new Recording(duration: new Duration(), path: "");
          _isRecording = isRecording;
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  String url;
  _stop() async {
    var recording = await AudioRecorder2.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder2.isRecording;
    File file = widget.localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    _controller.text = recording.path;
    url = recording.path;
  }

  _play() async {
    try {
      //播放音频
      await audioPlugin.play(url, isLocal: true);
      
    } catch (e) {
      print(e);
    }
    
  }

   
}
