import 'UI/Loading/LoadingPageUI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UI/home/HomePageUI.dart';
import 'package:flutter/services.dart';



void main()
{
  final SystemUiOverlayStyle _style =SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(_style);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) { 
   
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primaryColor: Color(0xFF00C7B7),
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes:<String,WidgetBuilder>
      {
        '/':(BuildContext context) => new LoadingPage(),
        '/home':(BuildContext context) => new HomePage(),
      }        
    );
  }
}

