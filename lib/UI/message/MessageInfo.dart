
enum messageContentType {
  TEXT,
  VOICE,
  VIDEO,
}
enum orientation {
  RECV,
  SEND,
}

abstract class MessageInfo {

  MessageInfo(this.contentType,this.orientationType);
  //消息类别
  final messageContentType contentType;
  //消息来源
  final orientation orientationType;
}

class VoiceMessage extends MessageInfo
{
  
  VoiceMessage( messageContentType contentType,orientation orientationType,this.path,{this.countTime = 10}):super(contentType,orientationType);
  final String path;
  final int countTime;
  @override
  // TODO: implement contentType
  messageContentType get contentType => super.contentType;

  @override
  // TODO: implement orientationType
  orientation get orientationType => super.orientationType;
}

class TextMessage extends MessageInfo
{
  
  final String text;
  
  TextMessage(messageContentType contentType, orientation orientationType,this.text) : super(contentType, orientationType);
  @override
  // TODO: implement contentType
  messageContentType get contentType => super.contentType;
  @override
  // TODO: implement orientationType
  orientation get orientationType => super.orientationType;
}
