import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import './MessageInfo.dart';
import '../../audio/AudioManager.dart';
import 'package:audioplayer/audioplayer.dart';


class MessageList extends StatefulWidget {
  
  final MessageInfo msgInfo;
  MessageList(this.msgInfo);
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return _singleMessage();
  }

  Widget _singleMessage() {
    Widget _widget;
    switch (widget.msgInfo.orientationType) {
      case orientation.RECV:
        {
          if (widget.msgInfo.contentType == messageContentType.TEXT) {
            _widget = Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 50.0,
                      height: 50.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/wechat2.jpg'),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      color: Colors.green[300],
                      child: Text((widget.msgInfo as TextMessage).text),
                      constraints: BoxConstraints(maxWidth: 200.0),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 200.0,
                      height: 20.0,
                    ),
                  ),
                ],
              ),
            );
          } else if (widget.msgInfo.contentType == messageContentType.VOICE) {
            _widget = Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 50.0,
                      height: 50.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/wechat2.jpg'),
                      )),
                  GestureDetector(
                    onTap: () {
                      print((widget.msgInfo as VoiceMessage));
                      AudioManager().play((widget.msgInfo as VoiceMessage).path);

                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        color: Colors.green[300],
                        child: Row(
                          //语音消息图标 + 秒数 + 语音
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.record_voice_over),
                            Text('${(widget.msgInfo as VoiceMessage).countTime}″')
                          ],
                        ),
                        width: (widget.msgInfo as VoiceMessage).countTime*1000/60,
                        constraints: BoxConstraints(maxWidth: 200.0,minWidth: 60.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 200.0,
                      height: 20.0,
                    ),
                  ),
                ],
              ),
            );
          }

          break;
        }
      case orientation.SEND:
        {
          if (widget.msgInfo.contentType == messageContentType.TEXT) {
            _widget = Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 100.0,
                      height: 20.0,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      color: Colors.white,
                      child: Text((widget.msgInfo as TextMessage).text),
                      constraints: BoxConstraints(maxWidth: 200.0),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/wechat1.jpg'),
                      )),
                ],
              ),
            );
          } else if (widget.msgInfo.contentType == messageContentType.VOICE) {
            _widget = Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 100.0,
                      height: 20.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AudioManager().play((widget.msgInfo as VoiceMessage).path);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        color: Colors.white,
                        child: Row(
                          //语音消息图标 + 秒数 + 语音
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${(widget.msgInfo as VoiceMessage).countTime}″'),
                            Icon(Icons.record_voice_over),
                          ],
                        ),
                       width: (widget.msgInfo as VoiceMessage).countTime*1000/60,
                        constraints: BoxConstraints(maxWidth: 200.0,minWidth: 60.0),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/wechat1.jpg'),
                      )),
                ],
              ),
            );
          }

          break;
        }

      default:
    }

    return _widget;
  }


  
}
