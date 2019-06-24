import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'SingleMessagePage.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('WeChat(1)'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _MessageItem(index);
        },
      ),
    );
  }

  Widget _MessageItem(int index) {
    return Card(
      margin: EdgeInsets.all(5.0),
      borderOnForeground: true,
      child: GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context){
              return SingleMessagePage();
            },
           ));
        },
        child: ListTile(
          leading: Image.asset('images/wechat' + "$index" + '.jpg'),
          title: Text('消息发送者'),
          subtitle: Text(
            '[Audio]',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
