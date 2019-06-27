
import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
//处理聊天模块网络数据传输

class SocketManager
{
  
  static String hostName = '10.0.16.26';
  static String port = '8100';
  static String url = hostName + ':' + port;
  static createWebSocketConnect()
  {
    try {
      return IOWebSocketChannel.connect(url);
    } catch (e) {
      print(e);
      throw e;
    }
    
  }

  static sendMessage(WebSocketChannel channel,{String message,String userId,String otherId})
  {
    try {
      channel.sink.add(_serialize(message,userId:userId,otherId: otherId ));
    } catch (e) {
      print('sendMessage error');
    }
    
  }
  static recvMessage(WebSocketChannel channel)
  {
    try {
      return _deserialize(channel.stream.toString());
    } catch (e) {
      print('recvMessage error');
    }
    
  }
  static _deserialize(data)
  {
    Map<String, dynamic> user = new Map<String, dynamic>();
    user = jsonDecode(data);
    return user;
  }
  static _serialize(message,{String userId,String otherId})
  {
    Map<String, dynamic> user = new Map<String, dynamic>();
    user.putIfAbsent("userId", ()=>userId);
    user.putIfAbsent("otherId", ()=>otherId);
    user.putIfAbsent("message", ()=>message);
    
    // var json = '';
    // if(message.toString().isNotEmpty)
    // {
    //    json = '{"userId":$userId,"otherId":$otherId,"message":$message}';
      
    // }
    
    return jsonEncode(user);
  }

  static closeWebSocket(WebSocketChannel channel)
  {
    channel.sink.close();
  }
}

