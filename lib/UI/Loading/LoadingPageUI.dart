import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../home/HomePageUI.dart';

import 'dart:async';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds:3), (){
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
        builder: (context) => new HomePage(),
      ),  (route)=>false,);
  
    });
    return Container(
        color: Color(0xFF00C7B7),
        padding: EdgeInsets.fromLTRB(0, 200.0, 0, 0),
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'BOSS直聘',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                '互联网招聘神器',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 20.0,
                    fontFamily: 'China'
                    ),
              ),
            )
          ],
        ));
  }
}
