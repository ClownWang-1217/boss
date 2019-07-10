import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'MessageList.dart';
import './MessageInfo.dart';
import '../../socket/SocketManager.dart';
import '../../audio/AudioManager.dart';
import 'dart:async';
import 'dart:io';

// 9宫格：https://www.jianshu.com/p/9012bc9e2feb
class SingleMessagePage extends StatefulWidget {
  SingleMessagePage({Key key}) : super(key: key);

  _SingleMessagePageState createState() =>
      _SingleMessagePageState(SocketManager.createWebSocketConnect());
}

class _SingleMessagePageState extends State<SingleMessagePage> {
  final WebSocketChannel channel;
  AudioManager audioManager = new AudioManager();
  final TextEditingController _controller = new TextEditingController();
  ScrollController scrollController = ScrollController();
  String msg;
  int contentType;
  int orientationType;
  String url;
  String content;
  _SingleMessagePageState(this.channel);
  List<MessageInfo> msgList = new List<MessageInfo>();

  save(List<int> data,String url) async
  {
    File file = new File(url);
    await file.writeAsBytes(data);
    file.delete();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel.stream.listen((data) {
      setState(() {
        Map<String, dynamic> mapData = SocketManager.recvMessage(data);

        if(mapData.containsKey('contentType'))
        {
          MessageInfo msgInfo;
          contentType = mapData['contentType'];
           if (contentType == 1) //语音
          {
            url = mapData['url'];
            Map<String, dynamic> data = mapData['data'];
            List<int> newdata = new List<int>();
            double second = data['data'].length/1600;
            for (var i = 0; i < data['data'].length; i++) {
              newdata.add(data['data'][i]);
            }
            save(newdata,url);
            msgInfo =
                VoiceMessage(messageContentType.VOICE, orientation.RECV, url,countTime: second.toInt());
          } else if (contentType == 0) //文字
          {
            content = mapData['message'];
            msgInfo =
                TextMessage(messageContentType.TEXT, orientation.RECV, content);
          }
          msgList.insert(0, msgInfo);
        }
        
      });
    });

    scrollController.addListener(() {
      // print(scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }
  //0:发送文字状态 1：发送语音状态

  int status = 0;
  bool recoding = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('谈天说地'),
        ),
        body: new Column(children: <Widget>[
          new Flexible(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                color: Colors.black12,
                child: new ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (context, int index) {
                    return MessageList(msgList[index]);
                  },
                  itemCount: msgList.length,
                )),
          )),
          //new Divider(height: 20.0),
          status == 0 //文字消息
              ? Card(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.keyboard_voice),
                        onPressed: () async {
                          //_neverSatisfied();
                          //语音录制
                          setState(() {
                                      status = 1;
                                    });
                        },
                      ),
                      Flexible(
                        child: Container(
                          width: 300.0,
                          child: TextField(
                            controller: _controller,
                            decoration: new InputDecoration(
                              hintText: 'Type something',
                            ),
                            onTap: () {
                              scrollController.animateTo(
                                0.0,
                                curve: Curves.linearToEaseOut,
                                duration: const Duration(milliseconds: 300),
                              );
                              print(scrollController.position.maxScrollExtent);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          //
                          if (_controller.text.isEmpty) return;
                          setState(() {
                            SocketManager.sendMessage(channel,
                                message: _controller.text,
                                sourceId: '001',
                                destId: '002');
                            MessageInfo msgInfo = TextMessage(
                                messageContentType.TEXT,
                                orientation.SEND,
                                _controller.text);
                            msgList.insert(0, msgInfo);
                            _controller.clear();
                          });
                        },
                      )
                    ],
                  ),
                )
              : Card(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.keyboard),
                        onPressed: () {
                          //_neverSatisfied();
                          //文字录制

                          setState(() {
                            status = 0;
                          });
                        },
                      ),
                      Flexible(
                        child: Container(
                            //width: 300.0,
                            child: GestureDetector(
                                onTapDown: (details) async {
                                  //按下开始录音
                                  audioManager.start();
                                  print('onTapDown');
                                  recoding = true;
                                },
                                onTapUp: (details) async {
                                  //松开保存本地并且发送

                                  print('onTapUp');
                                  String url = await audioManager.stop();
                                  if (url != null) {
                                    File file = new File(url);
                                    Stream<List<int>> inputStream = file.openRead();

                                    
                                    
                                    List<int> _url =  Utf8Encoder().convert(url);
                                    
                                    
            
                                    List<int> fileList = await file.readAsBytes();
                                   
                                    var list = new List<int>();
                                 
                                    list.add(_url.length);
                                    for (var i = 0; i < _url.length; i++) {
                                      var temp = _url.elementAt(i);
                                      list.add(temp);
                                    }
                                    for (var i = 0; i < fileList.length; i++) {
                                      var temp = fileList.elementAt(i);
                                      list.add(temp);
                                    }
                                   // Uint8List countListUint8 = new Uint8List(fileListUint8.length + encodedListUint8.length);
                                 
                                    
                                    List<List<int>> count = new List<List<int>>();
                                    //count.add(Uint8List.fromList(_urlLength) );
                                    count.add(Uint8List.fromList(list));
                                   // count.add(Uint8List.fromList(_fileListLength));
                                    //count.add(fileList);
                                    double second = fileList.length/1600;
                                    var stream = new Stream.fromIterable(count);
                                    Map<String,dynamic> mapList = new Map<String,dynamic>();
                                    mapList.putIfAbsent('message', ()=>inputStream);
                                    
                                    SocketManager.sendStreamMessage(channel,
                                        stream: stream);
                                        //SocketManager.sendMessage(channel,message:jsonEncode());
                                    MessageInfo msgInfo = VoiceMessage(
                                        messageContentType.VOICE,
                                        orientation.SEND,
                                        url,
                                        countTime: second.toInt());
                                    setState(() {
                                      msgList.insert(0, msgInfo);
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Hold to talk'),
                                ))),
                      ),
                    ],
                  ),
                )
        ]));
  }


  handle(String url) async {
    File file = new File(url);
    List<int> dataBuff = await file.readAsBytes();
    String a = '';
    var code = utf8.encode(a);

    var readBuff =
        ReadBuffer(new ByteData.view((dataBuff as Uint8List).buffer));
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
