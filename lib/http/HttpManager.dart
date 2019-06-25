import 'dart:core';

import 'package:dio/dio.dart';



enum HttpMethod {
  GET,
  POST,
}




class HttpManager{

  static const String GET = "get";
  static const String POST = "post";
  static const String baseMethod = 'get';
  static const String baseUrl = 'http://10.0.16.26:8081';

  // factory HttpManager() => _getInstance();
  // static HttpManager get instance => _getInstance();
  // static HttpManager _instance;
  // HttpManager._internal() {
  //   //初始化
  // }
  // static HttpManager _getInstance() {
  //   if (_instance == null) {
  //     _instance = new HttpManager._internal();
  //   }
  //   return _instance;
  // }

  
  //get请求
  static void Get(String path, Function callBack,{Map<String, String> params, Function errorCallBack}) async 
  {
    _request(baseUrl + path, callBack,method: GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void Post(String path, Function callBack,{Map<String, String> params, Function errorCallBack}) async 
  {
    _request(path, callBack,method: POST, params: params, errorCallBack: errorCallBack);
  }


static void _request(String url, Function callBack,{String method,Map<String, String> params,Function errorCallBack}) async 
{
    print("<net> url :<" + method + ">" + url);

    if (params != null && params.isNotEmpty) 
    {
      print("<net> params :" + params.toString());
    }

    String errorMsg = "";
    int statusCode;

    try {
      Response response;
     if (method == GET) 
     {
        //组合GET请求的参数
        if (params != null && params.isNotEmpty) 
        {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) 
          {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await Dio().get(url);
      } 
      else 
      {
        if (params != null && params.isNotEmpty) 
        {
          response = await Dio().post(url, data: params);
        } 
        else 
        {
          response = await Dio().post(url);
          print(response);
        }
      }

      statusCode = response.statusCode;

      //处理错误部分
      if (statusCode < 0) 
      {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) 
      {
        callBack(response.data.toString());
        print("<net> response data:" + response.data.toString());
      }
    } 
    catch (exception) 
    {
      _handError(errorCallBack, exception.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) 
  {
    if (errorCallback != null) 
    {
      errorCallback(errorMsg);
    }
    print("<net> errorMsg :" + errorMsg);
  }
}
