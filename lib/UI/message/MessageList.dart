import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

enum MessageCallType {
  send,
  recv,
}

class MessageList extends StatefulWidget {
  final MessageCallType _MessageType;
  MessageList(_MessageType)
      : this._MessageType = _MessageType ?? MessageCallType.recv;

  _MessageListState createState() => _MessageListState(_MessageType);
}

class _MessageListState extends State<MessageList> {
  final MessageCallType _MessageType;
  _MessageListState(this._MessageType);
  @override
  Widget build(BuildContext context) {
    return _SingleMessage(_MessageType);
  }

  Widget _SingleMessage(MessageCallType Type) {
    Widget _Widget;
    switch (Type) {
      case MessageCallType.recv:
        _Widget = Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                  width: 50.0,
                  height: 50.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/wechat1.jpg'),
                  )),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  color: Colors.green[300],
                  child: Text(
                      '2018年11月1日 - 我们经常说,Flutter 里面所有的东西都是 Widget,所以,布局也是 Widget。 控件Container 可以让我们设置一个控件的尺寸、背景、margin 等: class TestW...'),
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
        break;

      case MessageCallType.send:
        _Widget = Container(
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
                  child: Text('里面所有的东西都是 Widget,所以,布局也是 Widget。 控件Container '),
                  constraints: BoxConstraints(maxWidth: 200.0),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  width: 50.0,
                  height: 50.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/wechat3.jpg'),
                  )),
            ],
          ),
        );
        break;
      default:
    }

    return _Widget;
  }
}
