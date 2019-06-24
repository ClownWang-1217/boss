import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key}) : super(key: key);

  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  ScrollController _scrollController = new ScrollController();
  List<String> _SWidget = new List<String>();
  List<String> _AddTSWidget = new List<String>();
  List<String> _AddBSWidget = new List<String>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < 10; i++) {
      _SWidget.add('moren'+i.toString());
      _AddTSWidget.add('value+++++++++');
      _AddBSWidget.add('value--------');
    }
    
    _scrollController.addListener((){
      print(_scrollController.position.pixels.toString() + '\n');
        print((_scrollController.position.maxScrollExtent).toString() + '\n');
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent )
      {
        print(_scrollController.position.pixels.toString() + '\n');
        print((_scrollController.position.maxScrollExtent).toString() + '\n');
        _GetMoreData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text(
            'C++',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        
        body:RefreshIndicator(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _SWidget.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:Card(
                    
                  child: ListTile(
                  leading: Image.asset('images/01.jpg'),
                  title: Text(_SWidget[index]) ,
                ),
                borderOnForeground: true,
                clipBehavior: Clip.hardEdge,
              )
                ),
              );
            },
            controller: _scrollController
          ),
          onRefresh: _Refresh,
        ));
  }

 
  Future<Null> _Refresh() async{
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        return _SWidget.addAll(_AddTSWidget);
      });
    });

  
  }
   Future<Null> _GetMoreData() async{
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        return _SWidget.addAll(_AddBSWidget);
      });
    });

  
  }

  
}
