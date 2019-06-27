import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../http/HttpManager.dart';
import 'dart:convert';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController _scrollController = new ScrollController();
  List<String> sWidget = new List<String>();
  List<String> sWidgetImg = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels.toString() + '\n');
      // print((_scrollController.position.maxScrollExtent).toString() + '\n');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //print(_scrollController.position.pixels.toString() + '\n');
        // print((_scrollController.position.maxScrollExtent).toString() + '\n');
        _GetMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sWidget.length > 0) {
      return new Scaffold(
          appBar: new AppBar(
            title: Text(
              'C++',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: RefreshIndicator(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: sWidgetImg.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: ListTile(
                            leading: Image.asset('images/${sWidgetImg[index]}'),
                            title: Text(sWidget[index]),
                          ),
                          borderOnForeground: true,
                          clipBehavior: Clip.hardEdge,
                        )),
                  );
                },
                controller: _scrollController),
            onRefresh: _refresh,
          ));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: Text(
              'C++',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Center(
            child: RaisedButton(
              onPressed: () {
                _refresh();
              },
            ),
          ));
    }
  }

  Response response;
  Future<Null> _refresh() async {
    HttpManager.Get('/Post', (data) {
      final responseJson = json.decode(data);
      List<dynamic> newData = responseJson;
      newData.forEach((value) {
        Map<dynamic, dynamic> tMap = value;
        tMap.forEach((k, v) {
          sWidget.insert(0, k);
          sWidgetImg.insert(0, v);
        });
      });
      setState(() {});
    }, errorCallBack: (errorMsg1) {
      print('error:' + errorMsg1);
    });
  }

  Future<Null> _GetMoreData() async {}
}
