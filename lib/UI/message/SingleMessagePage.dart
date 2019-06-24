import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'MessageList.dart';

class SingleMessagePage extends StatefulWidget {
  SingleMessagePage({Key key}) : super(key: key);

  _SingleMessagePageState createState() => _SingleMessagePageState();
}

class _SingleMessagePageState extends State<SingleMessagePage> {
  final TextEditingController _controller = new TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener((){
     // print(scrollController.position.maxScrollExtent);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('谈天说地'),
        ),
        body: new Column(children: <Widget>[
          new Flexible(
            
            child:GestureDetector(
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
                    return index % 2 == 0
                        ? MessageList(MessageCallType.recv)
                        : MessageList(MessageCallType.send);
                  },
                  itemCount: 10,
                )),
          )),
          //new Divider(height: 20.0),
          Card(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.keyboard_voice),
                  onPressed: () {
                    //_neverSatisfied();
                    //语音录制
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
                      onTap: (){
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
                  },
                )
              ],
            ),
          )
        ]));
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
