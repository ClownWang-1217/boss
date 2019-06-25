import 'dart:core';

import 'package:dio/dio.dart';
import 'HttpManager.dart';

//http模块组件



class HttpMoudle
{
  factory HttpMoudle() => _getInstance();
  static HttpMoudle get instance => _getInstance();
  static HttpMoudle _instance;
  HttpMoudle._internal()
  {
    //初始化
  }
  static HttpMoudle _getInstance()
  {
    if (_instance == null) 
    {
      _instance = new HttpMoudle._internal();
    }
    return _instance;
  }

}



