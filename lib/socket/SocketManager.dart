

import 'package:web_socket_channel/io.dart';

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
      return IOWebSocketChannel.connect('ws://10.0.0.137:8100');
    } catch (e) {
      print(e);
      throw e;
    }
    
  }

  static sendMessage(WebSocketChannel channel,{String message,String sourceId,String destId})
  {
    try {
      
      channel.sink.add(serialize(message,sourceId:sourceId,destId: destId ));
    } catch (e) {
      print('sendMessage error');
    }
    
  }
  static sendStreamMessage(WebSocketChannel channel,{Stream<dynamic> stream})
  {
    try {
      
      channel.sink.addStream(stream);
    } catch (e) {
      print('sendMessage error');
    }
    
  }
  static recvMessage(data)
  {
    try {
      return deserialize(data);
    } catch (e) {
      print('recvMessage error');
    }
    
  }
  static deserialize(data)
  {
    Map<String, dynamic> user = new Map<String, dynamic>();
    user = jsonDecode(data);
    return user;
  }
  static serialize(message,{String sourceId,String destId})
  {
    Map<String, dynamic> user = new Map<String, dynamic>();
    user.putIfAbsent("sourceId", ()=>sourceId);
    user.putIfAbsent("destId", ()=>destId);
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

