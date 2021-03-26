part of "model.dart";

class Chat{
  String uid;
  String senderUID;
  String message;
  String dateTime;

  Chat({required this.uid, required this.senderUID, required this.message, required this.dateTime}){
    this.uid = uid;
    this.senderUID = senderUID;
    this.message = message;
    this.dateTime = dateTime;
  }
}


