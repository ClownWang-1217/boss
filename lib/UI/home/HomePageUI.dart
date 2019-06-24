import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../message/MessagePageUI.dart';
import 'package:flutter/widgets.dart';
import '../post/PostPageUI.dart';
import '../company/CompanyPageUI.dart';


enum Elab
{
  post,//职位
  company,//公司
  message,//消息
  personal,//我的

}
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _CurrentIndex = 0;
  List<Widget> _Widgets = new List<Widget>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Widgets.add(PostPage());
    _Widgets.add(CompanyPage());
    _Widgets.add(MessagePage());
    _Widgets.add(CompanyPage());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: 
          [
           _BottomNavigationBarItem(Elab.post),
           _BottomNavigationBarItem(Elab.company),
           _BottomNavigationBarItem(Elab.message),
           _BottomNavigationBarItem(Elab.personal),
          ],
          currentIndex: _CurrentIndex,
          selectedFontSize:12.0,
          onTap: (int index)
          {
            
            setState(() {
              _CurrentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: _Widgets[_CurrentIndex]
    );
  }


  BottomNavigationBarItem _BottomNavigationBarItem(Elab lab)
  {
    BottomNavigationBarItem _BottomNavigationBarItem = null;
    String _TitleName = '';
    Icon _Icon = null;
    switch (lab) {
      case Elab.post:
        _TitleName = '职位';
        _Icon = Icon(Icons.account_box,
              color: _CurrentIndex == 0? Theme.of(context).primaryColor : Colors.black38);
        break;
        case Elab.company:
        _TitleName = '公司';
        _Icon = Icon(Icons.location_city,
              color: _CurrentIndex == 1? Theme.of(context).primaryColor : Colors.black38);
        break;
        case Elab.message:
        _TitleName = '消息';
        _Icon = Icon(Icons.message,
              color: _CurrentIndex == 2? Theme.of(context).primaryColor : Colors.black38);
        
        break;
        case Elab.personal:
        _TitleName = '我的';
        _Icon = Icon(Icons.person_outline,
              color: _CurrentIndex == 3? Theme.of(context).primaryColor : Colors.black38);
        
        break;
      default:
      _TitleName = '职位';
      _Icon = Icon(Icons.access_alarm,
              color: _CurrentIndex == 0? Theme.of(context).primaryColor : Colors.black38);
      break;
    }
    _BottomNavigationBarItem = BottomNavigationBarItem(
              icon:_Icon,
              title: Text(_TitleName),
            );
    return _BottomNavigationBarItem;
  }


}
